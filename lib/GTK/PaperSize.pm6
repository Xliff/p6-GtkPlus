use v6.c;

use Method::Also;
use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::PaperSize;
use GTK::Raw::Types;

class GTK::PaperSize {
  has GtkPaperSize $!ps;

  submethod BUILD(:$size) {
    $!ps = $size;
  }

  method GTK::Raw::Types::GtkPaperSize {
    $!ps;
  }

  method new(Str() $name) {
    my $size = gtk_paper_size_new($name);
    self.bless(:$size);
  }

  method new_custom (
    Str() $name,
    Str() $display_name,
    Num() $width,
    Num() $height,
    Int() $unit
  ) is also<new-custom> {
    my guint $u = self.RESOLVE-UINT($unit);			# GtkUnit
    my $size = gtk_paper_size_new_custom(
      $name,
      $display_name,
      $width,
      $height,
      $u
    );
    self.bless(:$size);
  }

  method new_from_gvariant(GVariant $v) is also<new-from-gvariant> {
    my $size = gtk_paper_size_new_from_gvariant($v);
    self.bless(:$size);
  }

  method new_from_ipp (Str() $name, Num() $width, Num() $height) is also<new-from-ipp> {
    gtk_paper_size_new_from_ipp($name, $width, $height);
  }

  method new_from_key_file (
    GKeyFile() $key_file,
    Str() $group_name,
    GError $error = GError
  ) is also<new-from-key-file> {
    gtk_paper_size_new_from_key_file($key_file, $group_name, $error);
  }

  method new_from_ppd (
    Str() $name,
    Str() $ppd_display_name,
    Num() $width,
    Num() $height
  ) is also<new-from-ppd> {
    gtk_paper_size_new_from_ppd($name, $ppd_display_name, $width, $height);
  }

  method set_size (Num() $width, Num() $height, Int() $unit) is also<set-size> {
    my guint $u = self.RESOLVE-UINT($unit);			# GtkUnit
    gtk_paper_size_set_size($!ps, $width, $height, $u);
  }

  # ↓↓↓↓ SIGNALS ↓↓↓↓
  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ PROPERTIES ↓↓↓↓
  # ↑↑↑↑ PROPERTIES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  method copy {
    gtk_paper_size_copy($!ps);
  }

  method free {
    gtk_paper_size_free($!ps);
  }

  method get_default is also<get-default> {
    gtk_paper_size_get_default();
  }

  method get_default_bottom_margin (Int() $unit) is also<get-default-bottom-margin> {
    my guint $u = self.RESOLVE-UINT($unit);			# GtkUnit
    gtk_paper_size_get_default_bottom_margin($!ps, $u);
  }

  method get_default_left_margin (Int() $unit) is also<get-default-left-margin> {
    my guint $u = self.RESOLVE-UINT($unit);			# GtkUnit
    gtk_paper_size_get_default_left_margin($!ps, $u);
  }

  method get_default_right_margin (Int() $unit) is also<get-default-right-margin> {
    my guint $u = self.RESOLVE-UINT($unit);			# GtkUnit
    gtk_paper_size_get_default_right_margin($!ps, $u);
  }

  method get_default_top_margin (Int() $unit) is also<get-default-top-margin> {
    my guint $u = self.RESOLVE-UINT($unit);			# GtkUnit
    gtk_paper_size_get_default_top_margin($!ps, $u);
  }

  method get_display_name is also<get-display-name> {
    gtk_paper_size_get_display_name($!ps);
  }

  method get_height (Int() $unit) is also<get-height> {
    my guint $u = self.RESOLVE-UINT($unit);			# GtkUnit
    gtk_paper_size_get_height($!ps, $u);
  }

  method get_name is also<get-name> {
    gtk_paper_size_get_name($!ps);
  }

  method get_paper_sizes is also<get-paper-sizes> {
    gtk_paper_size_get_paper_sizes($!ps);
  }

  method get_ppd_name is also<get-ppd-name> {
    gtk_paper_size_get_ppd_name($!ps);
  }

  method get_type is also<get-type> {
    gtk_paper_size_get_type();
  }

  method get_width (Int() $unit) is also<get-width> {
    my guint $u = self.RESOLVE-UINT($unit);			# GtkUnit
    gtk_paper_size_get_width($!ps, $u);
  }

  method is_custom is also<is-custom> {
    gtk_paper_size_is_custom($!ps);
  }

  method is_equal (GtkPaperSize() $size2) is also<is-equal> {
    gtk_paper_size_is_equal($!ps, $size2);
  }

  method is_ipp is also<is-ipp> {
    gtk_paper_size_is_ipp($!ps);
  }

  method to_gvariant is also<to-gvariant> {
    gtk_paper_size_to_gvariant($!ps);
  }

  method to_key_file (GKeyFile() $key_file, Str() $group_name) is also<to-key-file> {
    gtk_paper_size_to_key_file($!ps, $key_file, $group_name);
  }

  # ↑↑↑↑ METHODS ↑↑↑↑

}

