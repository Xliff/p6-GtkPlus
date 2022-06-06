use v6.c;

use Method::Also;
use NativeCall;

use GTK::Raw::PageSetup:ver<3.0.1146>;
use GTK::Raw::Types:ver<3.0.1146>;

use GTK::PaperSize:ver<3.0.1146>;

# BOXED TYPE

class GTK::PageSetup:ver<3.0.1146> {
  has GtkPageSetup $!ps is implementor;

  submethod BUILD(:$page) {
    $!ps = $page;
  }

  method GTK::Raw::Definitions::GtkPageSetup
    is also<
      PageSetup
      GtkPageSetup
    >
  { $!ps }

  multi method new (GtkPageSetup $page) {
    $page ?? self.bless(:$page) !! Nil;
  }
  multi method new {
    my $page = gtk_page_setup_new();

    $page ?? self.bless(:$page) !! Nil;
  }

  # ↓↓↓↓ SIGNALS ↓↓↓↓
  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  method orientation is rw {
    Proxy.new(
      FETCH => sub ($) {
        GtkPageOrientationEnum( gtk_page_setup_get_orientation($!ps) );
      },
      STORE => sub ($, Int() $orientation is copy) {
        my guint $o = $orientation;

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
  method copy (:$raw = False) {
    my $ps = gtk_page_setup_copy($!ps);

    $ps ??
      ( $raw ?? $ps !! GTK::PageSetup.new($ps, :!ref) )
      !!
      Nil;
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
    state ($n, $t);

    unstable_get_type( self.^name, gtk_page_setup_get_type, $n, $t );
  }

  method load_file (
    Str() $file_name,
    CArray[Pointer[GError]] $error = gerror()
  )
    is also<load-file>
  {
    clear_error;
    my $rc = gtk_page_setup_load_file($!ps, $file_name, $error);
    set_error($error);
    $rc;
  }

  method load_key_file (
    GKeyFile() $key_file,
    Str() $group_name,
    CArray[Pointer[GError]] $error = gerror
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
    set_error($error);
    $rc;
  }

  method new_from_file (
    Str() $filename,
    CArray[Pointer[GError]] $error = gerror
  )
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
    set_error($error);
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

  method to_file (
    Str() $file_name,
    CArray[Pointer[GError]] $error = gerror
  )
    is also<to-file>
  {
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
