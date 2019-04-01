use v6.c;

use Method::Also;
use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::PageSetup;
use GTK::Raw::Types;

use GTK::PaperSize;

# BOXED TYPE

class GTK::PageSetup {
  has GtkPageSetup $!ps;

  submethod BUILD(:$page) {
    $!ps = $page;
  }

  method GTK::Raw::Types::GtkPageSetup is also<PageSetup> { $!ps }

  multi method new (GtkPageSetup $page) {
    self.bless(:$page);
  }
  multi method new {
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

  method paper_size is rw is also<paper-size> {
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

  method get_bottom_margin (Int() $unit) is also<get-bottom-margin> {
    gtk_page_setup_get_bottom_margin($!ps, $unit);
  }

  method get_left_margin (Int() $unit) is also<get-left-margin> {
    gtk_page_setup_get_left_margin($!ps, $unit);
  }

  method get_page_height (Int() $unit) is also<get-page-height> {
    gtk_page_setup_get_page_height($!ps, $unit);
  }

  method get_page_width (Int() $unit) is also<get-page-width> {
    gtk_page_setup_get_page_width($!ps, $unit);
  }

  method get_paper_height (Int() $unit) is also<get-paper-height> {
    gtk_page_setup_get_paper_height($!ps, $unit);
  }

  method get_paper_width (Int() $unit) is also<get-paper-width> {
    gtk_page_setup_get_paper_width($!ps, $unit);
  }

  method get_right_margin (Int() $unit) is also<get-right-margin> {
    gtk_page_setup_get_right_margin($!ps, $unit);
  }

  method get_top_margin (Int() $unit) is also<get-top-margin> {
    gtk_page_setup_get_top_margin($!ps, $unit);
  }

  method get_type is also<get-type> {
    gtk_page_setup_get_type();
  }

  method load_file (
    Str() $file_name,
    CArray[Pointer[GError]] $error = gerror()
  )
    is also<load-file>
  {
    clear_error;
    my $rc = gtk_page_setup_load_file($!ps, $file_name, $error);
    $ERROR = $error[0] with $error[0];
    $rc;
  }

  method load_key_file (
    GKeyFile $key_file,
    Str() $group_name,
    CArray[Pointer[GError]] $error = gerror();
  )
    is also<load-key-file>
  {
    clear_error;
    my $rc = gtk_page_setup_load_key_file(
      $!ps, 
      $key_file, 
      $group_name, 
      $error
    );
    $ERROR = $error[0] with $error[0];
    $rc;
  }

  method new_from_file (Str() $filename, GError $error = GError)
    is also<new-from-file>
  {
    gtk_page_setup_new_from_file($filename, $error);
  }

  method new_from_gvariant(GVariant() $v) is also<new-from-gvariant> {
    gtk_page_setup_new_from_gvariant($v);
  }

  method new_from_key_file (
    Str() $filename,
    Str() $group_name,
    CArray[Pointer[GError]] $error = gerror()
  )
    is also<new-from-key-file>
  {
    clear_error;
    my $rc = gtk_page_setup_new_from_key_file(
      $filename, 
      $group_name, 
      $error
    );
    $ERROR = $error[0] with $error[0];
    $rc;
  }

  method set_bottom_margin (Num() $margin, Int() $unit)
    is also<set-bottom-margin>
  {
    my gdouble $m = $margin;
    gtk_page_setup_set_bottom_margin($!ps, $margin, $unit);
  }

  method set_left_margin (Num() $margin, Int() $unit)
    is also<set-left-margin>
  {
    my gdouble $m = $margin;
    gtk_page_setup_set_left_margin($!ps, $margin, $unit);
  }

  method set_paper_size_and_default_margins (GtkPaperSize() $size)
    is also<set-paper-size-and-default-margins>
  {
    gtk_page_setup_set_paper_size_and_default_margins($!ps, $size);
  }

  method set_right_margin (Num() $margin, Int() $unit)
    is also<set-right-margin>
  {
    my gdouble $m = $margin;
    gtk_page_setup_set_right_margin($!ps, $margin, $unit);
  }

  method set_top_margin (Num() $margin, Int() $unit)
    is also<set-top-margin>
  {
    my gdouble $m = $margin;
    gtk_page_setup_set_top_margin($!ps, $margin, $unit);
  }

  method to_file (Str() $file_name, GError $error) is also<to-file> {
    gtk_page_setup_to_file($!ps, $file_name, $error);
  }

  method to_gvariant is also<to-gvariant> {
    gtk_page_setup_to_gvariant($!ps);
  }

  method to_key_file (GKeyFile() $key_file, Str() $group_name)
    is also<to-key-file>
  {
    gtk_page_setup_to_key_file($!ps, $key_file, $group_name);
  }

  # ↑↑↑↑ METHODS ↑↑↑↑

}
