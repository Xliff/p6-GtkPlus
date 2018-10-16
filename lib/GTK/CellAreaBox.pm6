use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::CellAreaBox;
use GTK::Raw::Types;

use GTK::CellArea;

use GTK::Roles::Orientable;
use GTK::Roles::CellLayout;

my subset Ancestry
  where GtkCellAreaBox | GtkCellArea | GtkOrientable | GtkCellLayout | GtkWidget;

class GTK::CellAreaBox is GTK::CellArea {
  also does GTK::Roles::Orientable;

  has GtkCellAreaBox $!cab;

  method bless(*%attrinit) {
    my $o = self.CREATE.BUILDALL(Empty, %attrinit);
    $o.setType('GTK::CellAreaBox');
    $o;
  }

  submethod BUILD(:$cellbox) {
    my $to-parent;
    given $cellbox {
      when Ancestry {
        $!cab = do {
          when GtkWidget | GtkCellArea {
            $to-parent = $_;
            nativecast(GtkCellAreaBox, $_);
          }
          when GtkOrientable {
            $!or = $_;                          # GTK::Roles::Orientable
            $to-parent = nativecast(GtkCellArea, $_);
            nativecast(GtkCellAreaBox, $_);
          }
          when GtkCellLayout {
            $!cl = $_;                          # GTK::Roles::CellLayout
            $to-parent = nativecast(GtkCellArea, $_);
            nativecast(GtkCellAreaBox, $_);
          }
          when GtkCellAreaBox {
            $to-parent = nativecast(GtkCellArea, $_);
            $_;
          }
        }
        self.setCellArea($to-parent);
      }
      when GTK::CellAreaBox {
      }
      default {
      }
    }
    $!cl //= nativecast(GtkCellLayout, $!cab);  # GTK::Roles::CellLayout
    $!or //= nativecast(GtkOrientable, $!cab);  # GTK::Roles::Orientable
  }

  submethod DESTROY {
    self.disconnect-all(%!signals-ca);
  }

  multi method new {
    my $cellbox = gtk_cell_area_box_new();
    self.bless(:$cellbox);
  }
  multi method new (Ancestry $cellbox) {
    self.bless(:$cellbox);
  }

  method GTK::Raw::Types::GtkCellArea {
    $!cab;
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
  method get_type {
    gtk_cell_area_box_get_type();
  }

  method pack_end (
    GtkCellRenderer() $renderer,
    Int() $expand,
    Int() $align,
    Int() $fixed
  ) {
    my @b = ($expand, $align, $fixed);
    my gboolean ($e, $a, $f) = self.RESOLVE-BOOL(@b);
    gtk_cell_area_box_pack_end($!cab, $renderer, $e, $a, $f);
  }

  method pack_start (
    GtkCellRenderer() $renderer,
    Int() $expand,
    Int() $align,
    Int() $fixed
  ) {
    my @b = ($expand, $align, $fixed);
    my gboolean ($e, $a, $f) = self.RESOLVE-BOOL(@b);
    gtk_cell_area_box_pack_start($!cab, $renderer, $e, $a, $f);
  }

  # ↑↑↑↑ METHODS ↑↑↑↑

}
