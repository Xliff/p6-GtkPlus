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
  method attach (
    GtkWidget() $child,
    Int() $left,
    Int() $top,
    Int() $width,
    Int() $height
  ) {
    my @i = ($left, $top, $width, $height);
    my gint ($l, $t, $w, $h) = self.RESOLVE-INT(@i);
    gtk_grid_attach($!g, $child, $l, $t, $w, $h);
  }

  method attach_next_to (
    GtkWidget() $child,
    GtkWidget() $sibling,
    GtkPositionType $side,
    gint $width,
    gint $height
  )
    is also<attach-next-to>
  {
    my $s = self.RESOLVE-UINT($side);
    my @i = ($width, $height);
    my gint ($w, $h) = self.RESOLVE-INT(@i);
    gtk_grid_attach_next_to($!g, $child, $sibling, $s, $w, $h);
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
    gtk_grid_remove_column($!g, $p);
  }

  method remove_row (Int() $position) is also<remove-row> {
    my gint $p = self.RESOLVE-INT($position);
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
