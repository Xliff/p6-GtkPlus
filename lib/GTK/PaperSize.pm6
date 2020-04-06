use v6.c;

use Method::Also;
use NativeCall;

use GLib::Roles::Object;
use GTK::Raw::PaperSize;
use GTK::Raw::Types;

# BOXED TYPE

class GTK::PaperSize {
  also does GLib::Roles::Object;

  has GtkPaperSize $!ps is implementor;

  submethod BUILD(:$size) {
    self!setObject($!ps = $size);
  }

  method GTK::Raw::Definitions::GtkPaperSize
    is also<
      PaperSize
      GtkPaperSize
    >
  { $!ps }

  method new(Str() $name) {
    my $size = gtk_paper_size_new($name);

    $size ?? self.bless(:$size) !! Nil;
  }

  method new_custom (
    Str() $name,
    Str() $display_name,
    Num() $width,
    Num() $height,
    Int() $unit
  )
    is also<new-custom>
  {
    my guint $u = $unit;			# GtkUnit
    my $size = gtk_paper_size_new_custom(
      $name,
      $display_name,
      $width,
      $height,
      $u
    );

    $size ?? self.bless(:$size) !! Nil;
  }

  method new_from_gvariant(GVariant $v) is also<new-from-gvariant> {
    my $size = gtk_paper_size_new_from_gvariant($v);

    $size ?? self.bless(:$size) !! Nil;
  }

  method new_from_ipp (Str() $name, Num() $width, Num() $height)
    is also<new-from-ipp>
  {
    gtk_paper_size_new_from_ipp($name, $width, $height);
  }

  method new_from_key_file (
    GKeyFile() $key_file,
    Str() $group_name,
    CArray[Pointer[GError]] $error = gerror
  )
    is also<new-from-key-file>
  {
    clear_error;
    my $rc = gtk_paper_size_new_from_key_file(
      $key_file,
      $group_name,
      $error
    );
    set_error($error);
    $rc;
  }

  method new_from_ppd (
    Str() $name,
    Str() $ppd_display_name,
    Num() $width,
    Num() $height
  )
    is also<new-from-ppd>
  {
    gtk_paper_size_new_from_ppd($name, $ppd_display_name, $width, $height);
  }

  method set_size (Num() $width, Num() $height, Int() $unit)
    is also<set-size>
  {
    my guint $u = $unit;			          # GtkUnit

    gtk_paper_size_set_size($!ps, $width, $height, $u);
  }

  # ↓↓↓↓ SIGNALS ↓↓↓↓
  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ PROPERTIES ↓↓↓↓
  # ↑↑↑↑ PROPERTIES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  method copy (:$raw = False) {
    my $ps = gtk_paper_size_copy($!ps);

    $ps ??
      ( $raw ?? $ps !! GTK::PaperSize.new($ps) )
      !!
      Nil;
  }

  method free {
    gtk_paper_size_free($!ps);
  }

  method get_default is also<get-default> {
    gtk_paper_size_get_default();
  }

  method get_default_bottom_margin (Int() $unit)
    is also<get-default-bottom-margin>
  {
    my guint $u = $unit;			          # GtkUnit

    gtk_paper_size_get_default_bottom_margin($!ps, $u);
  }

  method get_default_left_margin (Int() $unit)
    is also<get-default-left-margin>
  {
    my guint $u = $unit;			          # GtkUnit

    gtk_paper_size_get_default_left_margin($!ps, $u);
  }

  method get_default_right_margin (Int() $unit)
    is also<get-default-right-margin>
  {
    my guint $u = $unit;			          # GtkUnit

    gtk_paper_size_get_default_right_margin($!ps, $u);
  }

  method get_default_top_margin (Int() $unit)
    is also<get-default-top-margin>
  {
    my guint $u = $unit;			          # GtkUnit

    gtk_paper_size_get_default_top_margin($!ps, $u);
  }

  method get_display_name is also<get-display-name> {
    gtk_paper_size_get_display_name($!ps);
  }

  method get_height (Int() $unit) is also<get-height> {
    my guint $u = $unit;		           	# GtkUnit

    gtk_paper_size_get_height($!ps, $u);
  }

  method get_name is also<get-name> {
    gtk_paper_size_get_name($!ps);
  }

  method get_paper_sizes (:$glist = False) is also<get-paper-sizes> {
    my $psl = gtk_paper_size_get_paper_sizes($!ps);

    return Nil unless $psl;
    return $psl if $glist;

    $psl = GLib::GList.new($psl) but GLib::Roles::ListData[GtkPaperSize];
    $psl.Array;
  }

  method get_ppd_name is also<get-ppd-name> {
    gtk_paper_size_get_ppd_name($!ps);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gtk_paper_size_get_type, $n, $t );
  }

  method get_width (Int() $unit) is also<get-width> {
    my guint $u = $unit;			          # GtkUnit

    gtk_paper_size_get_width($!ps, $u);
  }

  method is_custom is also<is-custom> {
    so gtk_paper_size_is_custom($!ps);
  }

  method is_equal (GtkPaperSize() $size2) is also<is-equal> {
    so gtk_paper_size_is_equal($!ps, $size2);
  }

  method is_ipp is also<is-ipp> {
    so gtk_paper_size_is_ipp($!ps);
  }

  method to_gvariant (:$raw = False) is also<to-gvariant> {
    my $v = gtk_paper_size_to_gvariant($!ps);

    $v ??
      ( $raw ?? $v !! GLib::Variant.new($v) )
      !!
      Nil;
  }

  method to_key_file (GKeyFile() $key_file, Str() $group_name, :$raw = False)
    is also<to-key-file>
  {
    my $kf = gtk_paper_size_to_key_file($!ps, $key_file, $group_name);

    $kf ??
      ( $raw ?? $kf !! GLib::KeyFile.new($kf) )
      !!
      Nil;
  }

  # ↑↑↑↑ METHODS ↑↑↑↑

}
