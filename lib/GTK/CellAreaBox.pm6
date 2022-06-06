use v6.c;

use Method::Also;

use GTK::Raw::CellAreaBox:ver<3.0.1146>;
use GTK::Raw::Types:ver<3.0.1146>;

use GTK::CellArea:ver<3.0.1146>;

use GTK::Roles::Orientable:ver<3.0.1146>;

our subset CellAreaBoxAncestry
  where GtkCellAreaBox | GtkOrientable | CellAreaAncestry;

class GTK::CellAreaBox:ver<3.0.1146> is GTK::CellArea {
  also does GTK::Roles::Orientable;

  has GtkCellAreaBox $!cab is implementor;

  method bless(*%attrinit) {
    my $o = self.CREATE.BUILDALL(Empty, %attrinit);
    $o.setType($o.^name);
    $o;
  }

  submethod BUILD(:$cellbox) {
    my $to-parent;
    given $cellbox {
      when CellAreaBoxAncestry {
        $!cab = do {
          when GtkCellAreaBox {
            $to-parent = cast(GtkCellArea, $_);
            $_;
          }
          when GtkOrientable {
            $!or = $_;                          # GTK::Roles::Orientable
            $to-parent = cast(GtkCellArea, $_);
            cast(GtkCellAreaBox, $_);
          }
          default {
            cast(GtkCellAreaBox, $to-parent = $_);
          }
        }
        self.setCellArea($to-parent);
      }
      when GTK::CellAreaBox {
      }
      default {
      }
    }
    $!or //= cast(GtkOrientable, $!cab);  # GTK::Roles::Orientable
  }

  submethod DESTROY {
    self.disconnect-cellarea-signals;
  }

  method GTK::Raw::Definitions::GtkCellAreaBox
    is also<
      CellAreaBox
      GtkCellAreaBox
    >
  { $!cab }

  multi method new (CellAreaBoxAncestry $cellbox) {
    $cellbox ?? self.bless(:$cellbox) !! Nil
  }
  multi method new {
    my $cellbox = gtk_cell_area_box_new();

    $cellbox ?? self.bless(:$cellbox) !! Nil
  }


  # ↓↓↓↓ SIGNALS ↓↓↓↓
  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  method spacing is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_cell_area_box_get_spacing($!cab);
      },
      STORE => sub ($, Int() $spacing is copy) {
        my gint $s = $spacing;

        gtk_cell_area_box_set_spacing($!cab, $spacing);
      }
    );
  }
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gtk_cell_area_box_get_type, $n, $t );
  }

  method pack_end (
    GtkCellRenderer() $renderer,
    Int() $expand,
    Int() $align,
    Int() $fixed
  )
    is also<pack-end>
  {
    my gboolean ($e, $a, $f) = ($expand, $align, $fixed).map( *.so.Int );

    gtk_cell_area_box_pack_end($!cab, $renderer, $e, $a, $f);
  }

  method pack_start (
    GtkCellRenderer() $renderer,
    Int() $expand,
    Int() $align,
    Int() $fixed
  )
    is also<pack-start>
  {
    my gboolean ($e, $a, $f) = ($expand, $align, $fixed).map( *.so.Int );

    gtk_cell_area_box_pack_start($!cab, $renderer, $e, $a, $f);
  }

  # ↑↑↑↑ METHODS ↑↑↑↑

}
