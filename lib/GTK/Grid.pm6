use v6.c;

use Method::Also;

use GTK::Raw::Grid:ver<3.0.1146>;
use GTK::Raw::Types:ver<3.0.1146>;

use GTK::Container:ver<3.0.1146>;
use GTK::Widget:ver<3.0.1146>;

use GTK::Roles::Orientable:ver<3.0.1146>;

our subset GridAncestry is export
  where GtkGrid | GtkOrientable | ContainerAncestry;

our constant GtkGridAncestry is export = GridAncestry;

class GTK::Grid:ver<3.0.1146> is GTK::Container {
  also does GTK::Roles::Orientable;

  has GtkGrid $!g is implementor;

  has @!grid;
  has %!obj-track;
  has %!obj-manifest;

  submethod BUILD(:$grid) {
    self.setGrid($grid) if $grid;
  }

  method setGrid (GridAncestry $_) is also<setGtkGrid> {
    my $to-parent;
    $!g = do {
      when GtkGrid  {
        $to-parent = cast(GtkContainer, $_);
        $_;
      }

      when GtkOrientable {
        $!or = $_;                                # GTK::Roles::Orientable
        $to-parent = cast(GtkContainer, $_);
        cast(GtkGrid, $_);
      }

      default {
        $to-parent = $_;
        cast(GtkGrid, $_);
      }
    }
    $!or //= cast(GtkOrientable, $!g);      # GTK::Roles::Orientable
    self.setContainer($to-parent);
  }

  method GTK::Raw::Definitions::GtkGrid
    is also<
      Grid
      GtkGrid
    >
  { $!g }

  proto method new(|)
  { * }

  multi method new (GridAncestry $grid, :$ref = False) {
    return Nil unless $grid;

    my $o = self.bless(:$grid);
    $o.ref if $ref;
    $o;
  }
  multi method new ( *%a ) {
    my $grid = gtk_grid_new();

    my $o = $grid ?? self.bless(:$grid) !! Nil;
    $o.setAttributes(%a) if $o && +%a;
    $o;
  }
  multi method new ( :v(:ver(:vert(:$vertical))) is required ) {
    ::?CLASS.new-vgrid;
  }
  multi method new ( :h(:hor(:horiz(:$horizontal))) is required ) {
    ::?CLASS.new-hgrid;
  }

  method new-vgrid (Int() $spacing = 2) {
    my $o = GTK::Grid.new;

    return Nil unless $o;

    $o.orientation = GTK_ORIENTATION_VERTICAL;
    $o.spacing = $spacing;
    $o;
  }

  method new-hgrid (Int() $spacing = 2) {
    my $o = GTK::Grid.new;

    return Nil unless $o;

    $o.orientation = GTK_ORIENTATION_HORIZONTAL;
    $o.spacing = $spacing;
    $o;
  }

  method !add-child-at (
    $child,
    Int() $left,
    Int() $top,
    Int() $width,
    Int() $height
  ) {
    die "Invalid type for \$child: { .^name }"
      unless [||](
        $child ~~ GTK::Widget,
        ($child.REPR // '') eq 'CPointer'
      );
    my $c = do given $child {
      when GTK::Widget { +.Widget.p }
      when GtkWidget   { +.p        }
    }
    %!obj-manifest{$c} = $child;
    %!obj-track{$c} = {
      c => $c,
      l => $left,
      t => $top,
      w => $width,
      h => $height
    };

    for $top..$top+$height -> $row {
      # @!grid[$row] //= [];
      for $left..$left+$width -> $col {
        @!grid[$row][$col] = %!obj-track{$child}
      }
    }
  }
  method !add-child-at-with-sib (
    $child,
    $sib,
    Int() $side,
    Int() $width,
    Int() $height
  ) {
    for $child, $sib {
      die "Invalid type for \$child: { .^name }"
        unless [||](
          $_ ~~ GTK::Widget,
          (.REPR // '') eq 'CPointer'
        );
    }
    my $s = do given $sib {
      when GTK::Widget { +.Widget.p }
      when GtkWidget   { +.p        }
    }
    my ($l, $t, $w, $h) = %!obj-track{$s}<l t w h> »//» 0;
    given GtkPositionTypeEnum($side) {
      when GTK_POS_LEFT      { --$l     }
      when GTK_POS_RIGHT     { $l += $w }
      when GTK_POS_TOP       { --$t     }
      when GTK_POS_BOTTOM    { $t += $h }
    }
    die "Cannot add child with negative index: top={$t}, left={$l}"
      unless $t >= 0 && $l >= 0;
    self!add-child-at($child, $l, $t, $width, $height)
  }

  # method !grid-remove-col($col) {
  #   my @to-del = %!obj-track.pairs.grep( *.value<l> == $col );
  #   for @to-del {
  #     %!obj-track{ .value<c> }:delete;
  #     %!obj-manifest{ .value<c> }:delete;
  #   }
  #   .value<w>-- for %!obj-track.pairs.grep({
  #     .value<l> <= $col <= .value<l> + .value<w>
  #   });
  #   .value<l>-- for %!obj-track.pairs.grep({ .value<l> > $col });
  #   for @!grid.kv -> $rk, $rv {
  #     next without $rv;
  #     $rv.splice($col, 1);
  #     for $rv.list.kv -> $ck, $cv {
  #       $cv = Nil unless %!obj-manifest{$cv<w>}:exists;
  #     }
  #   }
  # }
  #
  # method !grid-add-col($col is copy, :$push = False) {
  #   unless $push {
  #     .value<w>++ for %!obj-track.pairs.grep({
  #       .value<l> <= $col <= .value<l> + .value<w>
  #     })
  #   }
  #   .value<l>++ for %!obj-track.pairs.grep({
  #     $col-- if $push;
  #     .value<l> > $col
  #   });
  # }
  #
  # method !grid-remove-row($row) {
  #   my @to-del = %!obj-track.pairs.grep( *.value<t> == $row );
  #   for @to-del {
  #     %!obj-track{ .value<c> }:delete;
  #     %!obj-manifest{ .value<c> }:delete;
  #   }
  #   .value<h>-- for %!obj-track.pairs.grep({
  #     .value<t> <= $row <= .value<t> + .value<h>
  #   });
  #   .value<t>-- for %!obj-track.pairs.grep({ .value<t> > $row });
  #   @!grid.splice($row, 1);
  #   for @!grid.kv -> $rk, $rv {
  #     next without $rv;
  #     for $rv.list.kv -> $ck, $cv {
  #       $cv = Nil unless %!obj-manifest{$cv<w>}:exists;
  #     }
  #   }
  # }
  #
  # method !grid-add-row($row is copy, :$push = False) {
  #   unless $push {
  #     .value<h>++ for %!obj-track.pairs.grep({
  #       .value<t> <= $row <= .value<t> + .value<h>
  #     })
  #   }
  #   .value<t>++ for %!obj-track.pairs.grep({
  #     $row-- if $push;
  #     .value<t> > $row;
  #   });
  # }

  method get-children {
    %!obj-manifest{
      %!obj-track.pairs.sort({ [||](
        $^a.value<t> <=> $^b.value<t>,
        $^a.value<l> <=> $^b.value<l>
      )}).map( *.key )
    }
  }

  # Leave undocumented for now, but caveat-emptor!
  # This information is NOT ACCURATE!
  method get_child_info(GtkWidget() $w) is also<get-child-info>  {
    my $t = %!obj-track{+$w.p};
    $t<c>:delete;
    $t;
  }

  # ↓↓↓↓ SIGNALS ↓↓↓↓
  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  method baseline_row is rw is also<baseline-row> {
    Proxy.new(
      FETCH => sub ($) {
        gtk_grid_get_baseline_row($!g);
      },
      STORE => sub ($, Int() $row is copy) {
        my gint $r = $row;

        gtk_grid_set_baseline_row($!g, $r);
      }
    );
  }

  method column_homogeneous is rw is also<column-homogeneous> {
    Proxy.new(
      FETCH => sub ($) {
        gtk_grid_get_column_homogeneous($!g);
      },
      STORE => sub ($, Int() $homogeneous is copy) {
        my gboolean $h = $homogeneous.so.Int;

        gtk_grid_set_column_homogeneous($!g, $h);
      }
    );
  }

  method column_spacing is rw is also<column-spacing> {
    Proxy.new(
      FETCH => sub ($) {
        gtk_grid_get_column_spacing($!g);
      },
      STORE => sub ($, Int() $spacing is copy) {
        my gint $s = $spacing;

        gtk_grid_set_column_spacing($!g, $s);
      }
    );
  }

  method row_homogeneous is rw is also<row-homogeneous> {
    Proxy.new(
      FETCH => sub ($) {
        Bool( gtk_grid_get_row_homogeneous($!g) );
      },
      STORE => sub ($, Int() $homogeneous is copy) {
        my gboolean $h = $homogeneous.so.Int;

        gtk_grid_set_row_homogeneous($!g, $h);
      }
    );
  }

  method row_spacing is rw is also<row-spacing> {
    Proxy.new(
      FETCH => sub ($) {
        gtk_grid_get_row_spacing($!g);
      },
      STORE => sub ($, Int() $spacing is copy) {
        my gint $s = $spacing;

        gtk_grid_set_row_spacing($!g, $s);
      }
    );
  }

  method spacing is rw {
    Proxy.new:
      FETCH => -> $ {
        (self.row_spacing, self.column_spacing)
      },
      STORE => -> $, $val is copy {
        $val = $val xx 2 if $val ~~ Int;

        (self.row_spacing, self.column_spacing) = $val;
      };
  }
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  multi method attach (
    GTK::Widget $child,
    Int() $left,
    Int() $top,
    Int() $width  = 1,
    Int() $height = 1
  ) {
    self.SET-LATCH;
    self!add-child-at($child, $left, $top, $width, $height);
    samewith($child.Widget, $left, $top, $width, $height);
  }
  multi method attach (
    GtkWidget $child,
    Int() $left,
    Int() $top,
    Int() $width  = 1,
    Int() $height = 1
  ) {
    my gint ($l, $t, $w, $h) = ($left, $top, $width, $height);
    self!add-child-at($child.Widget, $left, $top, $width, $height)
      unless self.IS-LATCHED;
    self.UNSET-LATCH;
    gtk_grid_attach($!g, $child, $l, $t, $w, $h);
  }

  # Alternate method with a more sensible ordering...
  method attach_adjacent_to ($sibling, $child, $side, $width, $height)
    is also<
      attach-adjacent-to
      attach_adj_to
      attach-adj-to
    >
  {
    self.attach_next_to($child, $sibling, $side, $width, $height);
  }


  proto method attach_next_to (|)
    is also<attach-next-to>
    { * }

  multi method attach_next_to (
     $child,
     $sibling,
     $width    = 1,
     $height   = 1,

    :r(:$right) is required
  ) {
    samewith($child, $sibling, GTK_POS_RIGHT, $width, $height);
  }
  multi method attach_next_to (
     $child,
     $sibling,
     $width    = 1,
     $height   = 1,

    :l(:$left) is required
  ) {
    samewith($child, $sibling, GTK_POS_LEFT, $width, $height);
  }
  multi method attach_next_to (
     $child,
     $sibling,
     $width    = 1,
     $height   = 1,

    :t(:u(:up(:$top))) is required
  ) {
    samewith($child, $sibling, GTK_POS_TOP, $width, $height);
  }
  multi method attach_next_to (
     $child,
     $sibling,
     $width    = 1,
     $height   = 1,

    :b(:d(:down(:$bottom))) is required
  ) {
    samewith($child, $sibling, GTK_POS_BOTTOM, $width, $height);
  }
  multi method attach_next_to (
    GTK::Widget $child,
    GTK::Widget $sibling,
    Int() $side,                  # GtkPositionType $side,
    Int() $width,
    Int() $height
  ) {
    self.SET-LATCH;
    self!add-child-at-with-sib(
      $child,
      $sibling,
      $side,
      $width,
      $height
    );
    samewith($child.Widget, $sibling.Widget, $side, $width, $height);
  }
  multi method attach_next_to (
    GtkWidget() $child,
    GtkWidget() $sibling,
    Int() $side,                  # GtkPositionType $side,
    Int() $width,
    Int() $height
  ) {
    my $s = $side;
    my gint ($ww, $hh) = ($width, $height);
    self!add-child-at-with-sib($child, $sibling, $side, $width, $height)
      unless self.IS-LATCHED;
    self.UNSET-LATCH;

    # Is this an implied insert? If so:
    # my ($l, $t, $w, $h) = %!obj-track{ +$sibling.p }<l t w h>;
    # given GtkPositionTypeEnum($side) {
    #   when GTK_POS_TOP    { self!grid-add-row($t,      :push) }
    #   when GTK_POS_BOTTOM { self!grid-add-row($t + $h, :push) }
    #   when GTK_POS_LEFT   { self!grid-add-col($l,      :push) }
    #   when GTK_POS_RIGHT  { self!grid-add-col($l + $w, :push) }
    # }

    gtk_grid_attach_next_to($!g, $child, $sibling, $s, $ww, $hh);
  }

  method get_widget_at(Int() $left, Int() $top)
    is also<get-widget-at>
  {
    do given %!obj-manifest{ @!grid[$top][$left]<c> } {
      when GTK::Widget { $_ }

      when GtkWidget {
        GTK::Widget.new($_).getType.starts-with('GTK::') ??
          GTK::Widget.CreateObject($_)
          !!
          $_;
      }

      default {
        die "GTK::Grid.get_widget_at does not know how to handle { .^name }";
      }
    }
  }

  method get_child_at (Int() $left, Int() $top)
    is also<get-child-at>
  {
    my gint ($l, $t) = ($left, $top);

    gtk_grid_get_child_at($!g, $l, $t);
  }

  method get_row_baseline_position (Int() $row)
    is also<get-row-baseline-position>
  {
    my gint $r = $row;

    gtk_grid_get_row_baseline_position($!g, $row);
  }

  method get_type () is also<get-type> {
    state ($n, $t);

    GTK::Widget.unstable_get_type( &gtk_grid_get_type, $n, $t );
  }

  method insert_column (Int() $position) is also<insert-column> {
    my gint $p = $position;
    #self!grid-add-col($position);
    gtk_grid_insert_column($!g, $p);
  }

  method insert_next_to (
    GtkWidget() $sibling,
    Int() $side                     # GtkPositionType $side
  )
    is also<insert-next-to>
  {
    my uint32 $s = $side;
    die '$sibling not found in grid!'
      unless %!obj-manifest{+$sibling.p}:exists;
    # my ($l, $t) = %!obj-track{+$sibling.p}<l t>;
    # given GtkPositionTypeEnum($side) {
      #Check rules. Do these follow normal insert if they are within the grid?
      # when GTK_POS_LEFT      { $l-- if $l > 0; self!grid-add-col($l, :push) }
      # when GTK_POS_RIGHT     { $l++; self!grid-add-col($l)                  }
      # when GTK_POS_TOP       { $t-- if $t > 0; self!grid-add-row($t, :push) }
      # when GTK_POS_BOTTOM    { $t++; self!grid-add-row($t)                  }
    # }
    gtk_grid_insert_next_to($!g, $sibling, $s);
  }

  method insert_row (Int() $position) is also<insert-row> {
    my gint $p = $position;
    #self!grid-add-row($position);
    gtk_grid_insert_row($!g, $p);
  }

  method remove_column (Int() $position) is also<remove-column> {
    my gint $p = $position;
    #self!grid-remove-col($position);
    gtk_grid_remove_column($!g, $p);
  }

  method remove_row (Int() $position) is also<remove-row> {
    my gint $p = $position;
    #self!grid-remove-row($position);
    gtk_grid_remove_row($!g, $p);
  }

  multi method set_row_baseline_position (
    Int() $row,                   # gint $row,
    Int() $pos                    # GtkBaselinePosition $pos
  )
    is also<set-row-baseline-position>
  {
    my gint $r =  $row;
    my uint32 $p = $pos;

    gtk_grid_set_row_baseline_position($!g, $r, $p);
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

  method child-set(GtkWidget() $c, *@propval) {
    my @notfound;
    @notfound = gather for @propval -> $p, $v {
      given $p {
        when 'height'      |
             'left-attach' |
             'top-attach'  |
             'width'       { self.child-set-uint($c, $p, $v) }

        default            { take $p; take $v;               }
      }
    }
    nextwith($c, @notfound) if +@notfound;
  }
}
