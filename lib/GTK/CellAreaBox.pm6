use v6.c;

use Method::Also;
use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::CellAreaBox;
use GTK::Raw::Types;

use GTK::CellArea;

use GTK::Roles::Orientable;

our subset CellAreaBoxAncestry
  where GtkCellAreaBox | GtkOrientable | CellAreaAncestry;

class GTK::CellAreaBox is GTK::CellArea {
  also does GTK::Roles::Orientable;

  has GtkCellAreaBox $!cab is implementor;

  method bless(*%attrinit) {
    my $o = self.CREATE.BUILDALL(Empty, %attrinit);
    $o.setType('GTK::CellAreaBox');
    $o;
  }

  submethod BUILD(:$cellbox) {
    my $to-parent;
    given $cellbox {
      when CellAreaBoxAncestry {
        $!cab = do {
          when GtkCellAreaBox {
            $to-parent = nativecast(GtkCellArea, $_);
            $_;
          }
          when GtkOrientable {
            $!or = $_;                          # GTK::Roles::Orientable
            $to-parent = nativecast(GtkCellArea, $_);
            nativecast(GtkCellAreaBox, $_);
          }
          default {
            nativecast(GtkCellAreaBox, $to-parent = $_);
          }
        }
        self.setCellArea($to-parent);
      }
      when GTK::CellAreaBox {
      }
      default {
      }
    }
    $!or //= nativecast(GtkOrientable, $!cab);  # GTK::Roles::Orientable
  }

  submethod DESTROY {
    self.disconnect-cellarea-signals;
  }
  
  method GTK::Raw::Types::GtkCellAreaBox is also<CellAreaBox> { $!cab }

  multi method new {
    my $cellbox = gtk_cell_area_box_new();
    self.bless(:$cellbox);
  }
  multi method new (CellAreaBoxAncestry $cellbox) {
    self.bless(:$cellbox);
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
        my gint $s = self.RESOLVE-INT($spacing);
        gtk_cell_area_box_set_spacing($!cab, $spacing);
      }
    );
  }
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  method get_type is also<get-type> {
    gtk_cell_area_box_get_type();
  }

  method pack_end (
    GtkCellRenderer() $renderer,
    Int() $expand,
    Int() $align,
    Int() $fixed
  ) 
    is also<pack-end> 
  {
    my @b = ($expand, $align, $fixed);
    my gboolean ($e, $a, $f) = self.RESOLVE-BOOL(@b);
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
    my @b = ($expand, $align, $fixed);
    my gboolean ($e, $a, $f) = self.RESOLVE-BOOL(@b);
    gtk_cell_area_box_pack_start($!cab, $renderer, $e, $a, $f);
  }

  # ↑↑↑↑ METHODS ↑↑↑↑

}
