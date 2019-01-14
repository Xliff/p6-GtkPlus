use v6.c;

use Method::Also;
use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::Grid;
use GTK::Raw::Types;

use GTK::Container;

use GTK::Roles::Orientable;

my subset Ancestry
  where GtkGrid | GtkOrientable | GtkContainer | GtkBuildable | GtkWidget;


class GTK::Grid is GTK::Container {
  also does GTK::Roles::Orientable;

  has GtkGrid $!g;

  has @!grid;
  has %!obj-track;
  has %!obj-manifest;

  # XXX
  # As a container, it is imperative that there be proper storage for widgets.
  # As things are right now, we have only @!start and @!end. We could reuse these,
  # but that will make it problematic for ease of retrieval.
  #
  # A method built on hash references is preferrable.
  #
  # This NEEDS to be done prior to release, so that widgets created outside of
  # this scope are preserved.

  method bless(*%attrinit) {
    my $o = self.CREATE.BUILDALL(Empty, %attrinit);
    $o.setType('GTK::Grid');
    $o;
  }

  submethod BUILD(:$grid) {
    my $to-parent;
    given $grid {
      when Ancestry {
        $!g = do {
          when GtkWidget {
            $to-parent = $_;
            nativecast(GtkGrid, $_);
          }
          when GtkOrientable {
            $!or = $_;                                # GTK::Roles::Orientable
            $to-parent = nativecast(GtkContainer, $_);
            nativecast(GtkGrid, $_);
          }
          when GtkGrid  {
            $to-parent = nativecast(GtkContainer, $_);
            $_;
          }
        }
        self.setContainer($to-parent);
        $!or //= nativecast(GtkOrientable, $grid);    # GTK::Roles::Orientable
      }
      when GTK::Grid {
      }
      default {
      }
    }
    # For GTK::Roles::GtkOrientable
    $!or = nativecast(GtkOrientable, $!g);
  }

  multi method new (Ancestry $grid) {
    my $o = self.bless(:$grid);
    $o.upref;
    $o;
  }
  multi method new {
    my $grid = gtk_grid_new();
    self.bless(:$grid);
  }

  my subset WidgetPointer of Mu where GTK::Widget | Pointer;
  method !add-child-at (
    WidgetPointer $child,
    Int $left,
    Int $top,
    Int $width,
    Int $height
  ) {
    my $c = do given $child {
      when GTK::Widget { +.widget.p }
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
      for $left..$left+$width -> $col {
        @!grid[$row] //= [];
        @!grid[$row][$col] = %!obj-track{$child}
      }
    }
  }
  method !add-child-at-with-sib (
    WidgetPointer $child,
    WidgetPointer $sib,
    Int $side,
    Int $width,
    Int $height
  ) {
    my $s = do given $sib {
      when GTK::Widget { +.widget.p }
      when GtkWidget   { +.p        }
    }
    my ($l, $t, $w, $h) = %!obj-track{$s}<l t w h>;
    given GtkPositionType($side) {
      when GTK_POS_LEFT      { --$l             }
      when GTK_POS_RIGHT     { $l = $l + $w + 1 }
      when GTK_POS_TOP       { --$t             }
      when GTK_POS_BOTTOM    { $t = $t + $h + 1 }
    }
    samewith($child, $l, $t, $width, $height)
  }

  method !grid-remove-col($col) {
    my @to-del = %!obj-track.pairs.grep( *.value<l> == $col );
    for @to-del {
      %!obj-track{ .value<c> }:delete;
      %!obj-manifest{ .value<c> }:delete;
    }
    .value<w>-- for %!obj-track.pairs.grep({
      .value<l> <= $col <= .value<l> + .value<w>
    });
    .value<l>-- for %!obj-track.pairs.grep({ .value<l> > $col });
    for @!grid.kv -> $rk, $rv {
      next without $rv;
      for $rv.list.kv -> $ck, $cv {
        $cv = Nil unless %!obj-manifest{$cv<w>}:exists;
      }
      $rv.splice($col, 1);
    }
  }

  method !grid-remove-row($row) {
    my @to-del = %!obj-track.pairs.grep( *.value<t> == $row );
    for @to-del {
      %!obj-track{ .value<c> }:delete;
      %!obj-manifest{ .value<c> }:delete;
    }
    .value<h>-- for %!obj-track.pairs.grep({
      .value<t> <= $row <= .value<t> + .value<h>
    });
    .value<t>-- for %!obj-track.pairs.grep({ .value<t> > $row });
    @!grid.splice($row, 1);
  }

  method get-children {
    my %seen;
    gather for @!grid.kv -> $rk, $rv {
      next without $rv;
      for $rv.list.kv -> $ck, $cv {
        next without $cv;
        unless %seen{$cv<c>} {
          take %!obj-manifest{$cv<c>};
          %seen{$cv<c>} = 1;
        }
      }
    }
  }

  # ↓↓↓↓ SIGNALS ↓↓↓↓
  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  method baseline_row is rw is also<baseline-row> {
    Proxy.new(
      FETCH => sub ($) {
        gtk_grid_get_baseline_row($!g);
      },
      STORE => sub ($, $row is copy) {
        my gint $r = self.RESOLVE-INT($row);
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
        my gboolean $h = self.RESOLVE-BOOL($homogeneous);
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
        my gint $s = self.RESOLVE-INT($spacing);
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
        my gboolean $h = self.RESOLVE-BOOL($homogeneous);
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
        my gint $s = self.RESOLVE-INT($spacing);
        gtk_grid_set_row_spacing($!g, $s);
      }
    );
  }
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  multi method attach (
    GTK::Widget $child,
    Int() $left,
    Int() $top,
    Int() $width,
    Int() $height
  ) {
    self.SET-LATCH;
    my $rc = samewith($child, $left, $top, $width, $height);
    self!add-child-at($child, $left, $top, $width, $height);
    $rc;
  }
  multi method attach (
    GtkWidget $child,
    Int() $left,
    Int() $top,
    Int() $width,
    Int() $height
  ) {
    my @i = ($left, $top, $width, $height);
    my gint ($l, $t, $w, $h) = self.RESOLVE-INT(@i);
    my $rc = gtk_grid_attach($!g, $child, $l, $t, $w, $h);
    self!add-child-at($child.widget, $left, $top, $width, $height)
      unless self.IS-LATCHED;
    self.UNSET-LATCH;
    $rc;
  }

  proto method attach_next_to (|)
    is also<attach-next-to>
    { * }

  multi method attach_next_to (
    GTK::Widget $child,
    GTK::Widget $sibling,
    Int() $side,                  # GtkPositionType $side,
    Int() $width,
    Int() $height
  ) {
    self.SET-LATCH;
    my $rc = samewith($child.widget, $sibling.widget, $side, $width, $height);
    self!add-child-at-with-sib(
      $child.widget, $sibling.widget, $side, $width, $height
    );
  }
  multi method attach_next_to (
    GtkWidget() $child,
    GtkWidget() $sibling,
    Int() $side,                  # GtkPositionType $side,
    Int() $width,
    Int() $height
  ) {
    my $s = self.RESOLVE-UINT($side);
    my @i = ($width, $height);
    my gint ($w, $h) = self.RESOLVE-INT(@i);
    my $rc = gtk_grid_attach_next_to($!g, $child, $sibling, $s, $w, $h);
    self!add-child-at-with-sib($child, $sibling, $side, $width, $height)
      unless self.IS-LATCHED;
    self.UNSET-LATCH;
    $rc;
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
    my @i = ($left, $top);
    my gint ($l, $t) = self.RESOLVE-INT(@i);
    gtk_grid_get_child_at($!g, $l, $t);
  }

  method get_row_baseline_position (Int() $row)
    is also<get-row-baseline-position>
  {
    my gint $r = self.RESOLVE-INT($row);
    gtk_grid_get_row_baseline_position($!g, $row);
  }

  method get_type () is also<get-type> {
    gtk_grid_get_type();
  }

  method insert_column (Int() $position) is also<insert-column> {
    my gint $p = self.RESOLVE-INT($position);
    gtk_grid_insert_column($!g, $p);
  }

  method insert_next_to (
    GtkWidget() $sibling,
    Int() $side                     # GtkPositionType $side
  ) is also<insert-next-to> {
    my uint32 $s = self.RESOLVE-UINT($side);
    gtk_grid_insert_next_to($!g, $sibling, $s);
  }

  method insert_row (Int() $position) is also<insert-row> {
    my gint $p = self.RESOLVE-INT($position);
    gtk_grid_insert_row($!g, $p);
  }

  method remove_column (Int() $position) is also<remove-column> {
    my gint $p = self.RESOLVE-INT($position);
    self!grid-remove-col($position);
    gtk_grid_remove_column($!g, $p);
  }

  method remove_row (Int() $position) is also<remove-row> {
    my gint $p = self.RESOLVE-INT($position);
    self!grid-remove-row($position);
    gtk_grid_remove_row($!g, $p);
  }

  multi method set_row_baseline_position (
    Int() $row,                   # gint $row,
    Int() $pos                    # GtkBaselinePosition $pos
  )
    is also<set-row-baseline-position>
  {
    my gint $r =  self.RESOLVE-INT($row);
    my uint32 $p = self.RESOLVE-UINT($pos);
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
