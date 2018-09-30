use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::Grid;
use GTK::Raw::Types;

use GTK::Container;

class GTK::Grid is GTK::Container {
  has GtkGrid $!g;

  method bless(*%attrinit) {
    use nqp;
    my $o = nqp::create(self).BUILDALL(Empty, %attrinit);
    $o.setType('GTK::Grid');
    $o;
  }

  submethod BUILD(:$grid) {
    my $to-parent;
    given $grid {
      when GtkGrid | GtkWidget {
        $!g = do {
          when GtkWidget {
            $to-parent = $_;
            nativecast(GtkGrid, $_);
          }
          when GtkGrid  {
            $to-parent = nativecast(GtkContainer, $_);
            $_;
          }
        }
        self.setContainer($to-parent);
      }
      when GTK::Grid {
      }
      default {
      }
    }
  }

  multi method new {
    my $grid = gtk_grid_new();
    self.bless(:$grid);
  }
  multi method new (GtkWidget $grid) {
    self.bless(:$grid);
  }

  # ↓↓↓↓ SIGNALS ↓↓↓↓
  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  method baseline_row is rw {
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

  method column_homogeneous is rw {
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

  method column_spacing is rw {
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

  method row_homogeneous is rw {
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

  method row_spacing is rw {
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
  ) {
    my $s = self.RESOLVE-UINT($side);
    my @i = ($width, $height);
    my gint ($w, $h) = self.RESOLVE-INT(@i);
    gtk_grid_attach_next_to($!g, $child, $sibling, $s, $w, $h);
  }

  method get_child_at (Int() $left, Int() $top) {
    my @i = ($left, $top);
    my gint ($l, $t) = self.RESOLVE-INT(@i);
    gtk_grid_get_child_at($!g, $l, $t);
  }

  method get_row_baseline_position (Int() $row) {
    my gint $r = self.RESOLVE-INT($row);
    gtk_grid_get_row_baseline_position($!g, $row);
  }

  method get_type () {
    gtk_grid_get_type();
  }

  method insert_column (Int() $position) {
    my gint $p = self.RESOLVE-INT($position);
    gtk_grid_insert_column($!g, $p);
  }

  method insert_next_to (
    GtkWidget() $sibling,
    Int() $side                     # GtkPositionType $side
  ) {
    my uint32 $s = self.RESOLVE-UINT($side);
    gtk_grid_insert_next_to($!g, $sibling, $s);
  }

  method insert_row (Int() $position) {
    my gint $p = self.RESOLVE-INT($position);
    gtk_grid_insert_row($!g, $p);
  }

  method remove_column (Int() $position) {
    my gint $p = self.RESOLVE-INT($position);
    gtk_grid_remove_column($!g, $p);
  }

  method remove_row (Int() $position) {
    my gint $p = self.RESOLVE-INT($position);
    gtk_grid_remove_row($!g, $p);
  }

  multi method set_row_baseline_position (
    Int() $row,                   # gint $row,
    Int() $pos                    # GtkBaselinePosition $pos
  ) {
    my gint $r =  self.RESOLVE-INT($row);
    my uint32 $p = self.RESOLVE-UINT($pos);
    gtk_grid_set_row_baseline_position($!g, $r, $p);
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
