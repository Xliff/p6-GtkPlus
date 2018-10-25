use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::PageSetup;
use GTK::Raw::Types;

#use GTK::PaperSize;

class GTK::PageSetup {
  has GtkPageSetup $!ps;

  submethod BUILD(:$page) {
    $!ps = $page;
  }

  method new {
    my $page = gtk_page_setup_new();
    self.bless(:$page);
  }

  # ↓↓↓↓ SIGNALS ↓↓↓↓
  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  method orientation is rw {
    Proxy.new(
      FETCH => sub ($) {
        GtkPageOrientation( gtk_page_setup_get_orientation($!ps) );
      },
      STORE => sub ($, uint32 $orientation is copy) {
        my guint $o = self.RESOLVE-UINT($orientation);
        gtk_page_setup_set_orientation($!ps, $o);
      }
    );
  }

  method paper_size is rw {
    Proxy.new(
      FETCH => sub ($) {
        GTK::PaperSize.new( gtk_page_setup_get_paper_size($!ps) );
      },
      STORE => sub ($, GtkPaperSize() $size is copy) {
        gtk_page_setup_set_paper_size($!ps, $size);
      }
    );
  }
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ PROPERTIES ↓↓↓↓
  # ↑↑↑↑ PROPERTIES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  method copy {
    gtk_page_setup_copy($!ps);
  }

  method get_bottom_margin (Int() $unit) {
    gtk_page_setup_get_bottom_margin($!ps, $unit);
  }

  method get_left_margin (Int() $unit) {
    gtk_page_setup_get_left_margin($!ps, $unit);
  }

  method get_page_height (Int() $unit) {
    gtk_page_setup_get_page_height($!ps, $unit);
  }

  method get_page_width (Int() $unit) {
    gtk_page_setup_get_page_width($!ps, $unit);
  }

  method get_paper_height (Int() $unit) {
    gtk_page_setup_get_paper_height($!ps, $unit);
  }

  method get_paper_width (Int() $unit) {
    gtk_page_setup_get_paper_width($!ps, $unit);
  }

  method get_right_margin (Int() $unit) {
    gtk_page_setup_get_right_margin($!ps, $unit);
  }

  method get_top_margin (Int() $unit) {
    gtk_page_setup_get_top_margin($!ps, $unit);
  }

  method get_type {
    gtk_page_setup_get_type();
  }

  method load_file (
    Str() $file_name,
    GError $error = GError
  ) {
    gtk_page_setup_load_file($!ps, $file_name, $error);
  }

  method load_key_file (
    GKeyFile $key_file,
    Str() $group_name,
    GError $error = GError
  ) {
    gtk_page_setup_load_key_file($!ps, $key_file, $group_name, $error);
  }

  method new_from_file (Str() $filename, GError $error = GError) {
    gtk_page_setup_new_from_file($filename, $error);
  }

  method new_from_gvariant(GVariant() $v) {
    gtk_page_setup_new_from_gvariant($v);
  }

  method new_from_key_file (
    Str() $filename,
    Str() $group_name,
    GError $error = GError
  ) {
    gtk_page_setup_new_from_key_file($filename, $group_name, $error);
  }

  method set_bottom_margin (gdouble $margin, Int() $unit) {
    gtk_page_setup_set_bottom_margin($!ps, $margin, $unit);
  }

  method set_left_margin (gdouble $margin, Int() $unit) {
    gtk_page_setup_set_left_margin($!ps, $margin, $unit);
  }

  method set_paper_size_and_default_margins (GtkPaperSize() $size) {
    gtk_page_setup_set_paper_size_and_default_margins($!ps, $size);
  }

  method set_right_margin (gdouble $margin, Int() $unit) {
    gtk_page_setup_set_right_margin($!ps, $margin, $unit);
  }

  method set_top_margin (gdouble $margin, Int() $unit) {
    gtk_page_setup_set_top_margin($!ps, $margin, $unit);
  }

  method to_file (Str() $file_name, GError $error) {
    gtk_page_setup_to_file($!ps, $file_name, $error);
  }

  method to_gvariant {
    gtk_page_setup_to_gvariant($!ps);
  }

  method to_key_file (GKeyFile() $key_file, Str() $group_name) {
    gtk_page_setup_to_key_file($!ps, $key_file, $group_name);
  }

  # ↑↑↑↑ METHODS ↑↑↑↑

}
