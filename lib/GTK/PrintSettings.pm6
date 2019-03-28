use v6.c;

use Method::Also;
use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::PrintSettings;
use GTK::Raw::Types;

use GTK::Roles::Types;
use GTK::Compat::Roles::Object;

class GTK::PrintSettings {
  also does GTK::Roles::Types;
  also does GTK::Compat::Roles::Object;

  has GtkPrintSettings $!prnset;

  submethod BUILD(:$settings) {
    self!setObject($!prnset = $settings);
  }

  method GTK::Raw::Types::GtkPrintSettings 
    is also<PrintSettings> 
    { $!prnset }

  multi method new (GtkPrintSettings $settings) {
    self.bless(:$settings);
  }
  multi method new {
    my $settings = gtk_print_settings_new();
    self.bless(:$settings);
  }

  method new_from_file (
    Str() $filename,
    CArray[Pointer[GError]] $error = gerror()
  ) 
    is also<new-from-file> 
  {
    $ERROR = Nil;
    my $rc = gtk_print_settings_new_from_file($filename, $error);
    $ERROR = $error[0] with $error[0];
    $rc;
  }

  method new_from_gvariant(GVariant $v) is also<new-from-gvariant> {
    my $settings = gtk_print_settings_new_from_gvariant($v);
    self.bless(:$settings);
  }

  method new_from_key_file (
    Str() $keyfile,
    Str() $group_name,
    CArray[Pointer[GError]] $error = gerror()
  ) 
    is also<new-from-key-file> 
  {
    $ERROR = Nil;
    my $settings = gtk_print_settings_new_from_key_file(
      $keyfile,
      $group_name,
      $error
    );
    $ERROR = $error[0] with $error[0];
    # Should throw exception if $ERROR
    self.bless(:$settings);
  }

  # ↓↓↓↓ SIGNALS ↓↓↓↓
  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  method collate is rw {
    Proxy.new(
      FETCH => sub ($) {
        so gtk_print_settings_get_collate($!prnset);
      },
      STORE => sub ($, Int() $collate is copy) {
        my gboolean $c = self.RESOLVE-BOOL($collate);
        gtk_print_settings_set_collate($!prnset, $c);
      }
    );
  }

  method default_source is rw is also<default-source> {
    Proxy.new(
      FETCH => sub ($) {
        gtk_print_settings_get_default_source($!prnset);
      },
      STORE => sub ($, Str() $default_source is copy) {
        gtk_print_settings_set_default_source($!prnset, $default_source);
      }
    );
  }

  method dither is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_print_settings_get_dither($!prnset);
      },
      STORE => sub ($, Str() $dither is copy) {
        gtk_print_settings_set_dither($!prnset, $dither);
      }
    );
  }

  method duplex is rw {
    Proxy.new(
      FETCH => sub ($) {
        GtkPrintDuplex( gtk_print_settings_get_duplex($!prnset) );
      },
      STORE => sub ($, Int() $duplex is copy) {
        my guint $d = self.RESOLVE-UINT($duplex);
        gtk_print_settings_set_duplex($!prnset, $d);
      }
    );
  }

  method finishings is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_print_settings_get_finishings($!prnset);
      },
      STORE => sub ($, Str() $finishings is copy) {
        gtk_print_settings_set_finishings($!prnset, $finishings);
      }
    );
  }

  method media_type is rw is also<media-type> {
    Proxy.new(
      FETCH => sub ($) {
        gtk_print_settings_get_media_type($!prnset);
      },
      STORE => sub ($, Str() $media_type is copy) {
        gtk_print_settings_set_media_type($!prnset, $media_type);
      }
    );
  }

  method n_copies is rw is also<n-copies> {
    Proxy.new(
      FETCH => sub ($) {
        gtk_print_settings_get_n_copies($!prnset);
      },
      STORE => sub ($, Int() $num_copies is copy) {
        my gint $nc = self.RESOLVE-INT($num_copies);
        gtk_print_settings_set_n_copies($!prnset, $nc);
      }
    );
  }

  method number_up is rw is also<number-up> {
    Proxy.new(
      FETCH => sub ($) {
        gtk_print_settings_get_number_up($!prnset);
      },
      STORE => sub ($, Int() $number_up is copy) {
        my gint $nu = self.RESOLVE-INT($number_up);
        gtk_print_settings_set_number_up($!prnset, $nu);
      }
    );
  }

  method number_up_layout is rw is also<number-up-layout> {
    Proxy.new(
      FETCH => sub ($) {
        GtkNumberUpLayout(
          gtk_print_settings_get_number_up_layout($!prnset)
        );
      },
      STORE => sub ($, Int() $number_up_layout is copy) {
        my guint $nul = self.RESOLVE-UINT($number_up_layout);
        gtk_print_settings_set_number_up_layout($!prnset, $nul);
      }
    );
  }

  method orientation is rw {
    Proxy.new(
      FETCH => sub ($) {
        GtkPageOrientation( gtk_print_settings_get_orientation($!prnset) );
      },
      STORE => sub ($, Int() $orientation is copy) {
        my guint $o = self.RESOLVE-UINT($orientation);
        gtk_print_settings_set_orientation($!prnset, $o);
      }
    );
  }

  method output_bin is rw is also<output-bin> {
    Proxy.new(
      FETCH => sub ($) {
        gtk_print_settings_get_output_bin($!prnset);
      },
      STORE => sub ($, Str() $output_bin is copy) {
        gtk_print_settings_set_output_bin($!prnset, $output_bin);
      }
    );
  }

  method page_set is rw is also<page-set> {
    Proxy.new(
      FETCH => sub ($) {
        GtkPageSet( gtk_print_settings_get_page_set($!prnset) );
      },
      STORE => sub ($, $page_set is copy) {
        my guint $ps = self.RESOLVE-UINT($page_set);
        gtk_print_settings_set_page_set($!prnset, $ps);
      }
    );
  }

  method paper_size is rw is also<paper-size> {
    Proxy.new(
      FETCH => sub ($) {
        GTK::PaperSize.new( gtk_print_settings_get_paper_size($!prnset) );
      },
      STORE => sub ($, GtkPaperSize() $paper_size is copy) {
        gtk_print_settings_set_paper_size($!prnset, $paper_size);
      }
    );
  }

  method print_pages is rw is also<print-pages> {
    Proxy.new(
      FETCH => sub ($) {
        GtkPrintPages( gtk_print_settings_get_print_pages($!prnset) );
      },
      STORE => sub ($, Int() $pages is copy) {
        my guint $p = self.RESOLVE-UINT($pages);
        gtk_print_settings_set_print_pages($!prnset, $p);
      }
    );
  }

  method printer is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_print_settings_get_printer($!prnset);
      },
      STORE => sub ($, Str() $printer is copy) {
        gtk_print_settings_set_printer($!prnset, $printer);
      }
    );
  }

  method printer_lpi is rw is also<printer-lpi> {
    Proxy.new(
      FETCH => sub ($) {
        gtk_print_settings_get_printer_lpi($!prnset);
      },
      STORE => sub ($, Num() $lpi is copy) {
        gtk_print_settings_set_printer_lpi($!prnset, $lpi);
      }
    );
  }

  method quality is rw {
    Proxy.new(
      FETCH => sub ($) {
        GtkPrintQuality( gtk_print_settings_get_quality($!prnset) );
      },
      STORE => sub ($, $quality is copy) {
        my guint $q = self.RESOLVE-UINT($quality);
        gtk_print_settings_set_quality($!prnset, $q);
      }
    );
  }

  method resolution is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_print_settings_get_resolution($!prnset);
      },
      STORE => sub ($, Int() $resolution is copy) {
        my gint $r = self.RESOLVE-INT($resolution);
        gtk_print_settings_set_resolution($!prnset, $r);
      }
    );
  }

  method reverse is rw {
    Proxy.new(
      FETCH => sub ($) {
        so gtk_print_settings_get_reverse($!prnset);
      },
      STORE => sub ($, Int() $reverse is copy) {
        my gboolean $r = self.RESOLVE-BOOL($reverse);
        gtk_print_settings_set_reverse($!prnset, $r);
      }
    );
  }

  method scale is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_print_settings_get_scale($!prnset);
      },
      STORE => sub ($, Num() $scale is copy) {
        my gdouble $s = $scale;
        gtk_print_settings_set_scale($!prnset, $s);
      }
    );
  }

  method use_color is rw is also<use-color> {
    Proxy.new(
      FETCH => sub ($) {
        so gtk_print_settings_get_use_color($!prnset);
      },
      STORE => sub ($, Int() $use_color is copy) {
        my gboolean $uc = self.RESOLVE-BOOL($use_color);
        gtk_print_settings_set_use_color($!prnset, $uc);
      }
    );
  }
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ PROPERTIES ↓↓↓↓
  # ↑↑↑↑ PROPERTIES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  method copy {
    gtk_print_settings_copy($!prnset);
  }

  method foreach (GtkPrintSettingsFunc $func, gpointer $user_data) {
    gtk_print_settings_foreach($!prnset, $func, $user_data);
  }

  method get (Str() $key) {
    gtk_print_settings_get($!prnset, $key);
  }

  method get_bool (Str() $key) is also<get-bool> {
    so gtk_print_settings_get_bool($!prnset, $key);
  }

  method get_double (Str() $key) is also<get-double> {
    gtk_print_settings_get_double($!prnset, $key);
  }

  method get_double_with_default (Str() $key, Num() $def)
    is also<get-double-with-default>
  {
    my gdouble $d = $def;
    gtk_print_settings_get_double_with_default($!prnset, $key, $d);
  }

  method get_int (Str() $key) is also<get-int> {
    gtk_print_settings_get_int($!prnset, $key);
  }

  method get_int_with_default (Str() $key, Int() $def)
    is also<get-int-with-default>
  {
    my gint $d = self.RESOLVE-INT($def);
    gtk_print_settings_get_int_with_default($!prnset, $key, $d);
  }

  method get_length (
    Str() $key,
    Int() $unit                # GtkUnit $unit
  )
    is also<get-length>
  {
    my guint $u = self.RESOLVE-UINT($unit);
    gtk_print_settings_get_length($!prnset, $key, $u);
  }

  method get_page_ranges (Int() $num_ranges) is also<get-page-ranges> {
    my gint $nr = self.RESOLVE-INT($num_ranges);
    gtk_print_settings_get_page_ranges($!prnset, $nr);
  }

  method get_paper_height (
    Int() $unit                # GtkUnit $unit
  )
    is also<get-paper-height>
  {
    my guint $u = self.RESOLVE-UINT($unit);
    gtk_print_settings_get_paper_height($!prnset, $u);
  }

  method get_paper_width (
    Int() $unit                # GtkUnit $unit
  )
    is also<get-paper-width>
  {
    my guint $u = self.RESOLVE-UINT($unit);
    gtk_print_settings_get_paper_width($!prnset, $u);
  }

  method get_resolution_x is also<get-resolution-x> {
    gtk_print_settings_get_resolution_x($!prnset);
  }

  method get_resolution_y is also<get-resolution-y> {
    gtk_print_settings_get_resolution_y($!prnset);
  }

  method get_type is also<get-type> {
    gtk_print_settings_get_type();
  }

  method has_key (Str() $key) is also<has-key> {
    gtk_print_settings_has_key($!prnset, $key);
  }

  method load_file (
    Str() $file_name,
    CArray[Pointer[GError]] $error = gerror()
  )
    is also<load-file>
  {
    $ERROR = Nil;
    my $rc = gtk_print_settings_load_file($!prnset, $file_name, $error);
    $ERROR = $error[0] with $error[0];
    $rc;
  }

  method load_key_file (
    GKeyFile() $key_file,
    Str() $group_name,
    CArray[Pointer[GError]] $error = gerror()
  )
    is also<load-key-file>
  {
    $ERROR = Nil;
    my $rc = gtk_print_settings_load_key_file(
      $!prnset,
      $key_file,
      $group_name,
      $error
    );
    $ERROR = $error[0] with $error[0];
    $rc;
  }

  method set (Str() $key, Str() $value) {
    gtk_print_settings_set($!prnset, $key, $value);
  }

  method set_bool (Str() $key, Int() $value) is also<set-bool> {
    my gboolean $v = self.RESOLVE-BOOL($value);
    gtk_print_settings_set_bool($!prnset, $key, $v);
  }

  method set_double (Str() $key, Num() $value) is also<set-double> {
    my gdouble $v = $value;
    gtk_print_settings_set_double($!prnset, $key, $v);
  }

  method set_int (Str() $key, Int() $value) is also<set-int> {
    my gint $v = self.RESOLVE-INT($value);
    gtk_print_settings_set_int($!prnset, $key, $v);
  }

  method set_length (
    Str() $key,
    Num() $value,
    Int() $unit                # GtkUnit $unit
  )
    is also<set-length>
  {
    my guint $u = self.RESOLVE-UINT($unit);
    my gdouble $v = $value;
    gtk_print_settings_set_length($!prnset, $key, $v, $u);
  }

  # NOTE - Can only provide ONE ELEMENT since NativeCall
  #        does not yet support arrays of structs.
  # TODO - NEED ARRAY OF CSTRUCTS
  method set_page_ranges (
    GtkPageRange $page_ranges, 
    Int() $num_ranges
  )
    is also<set-page-ranges>
  {
    my gint $nr = self.RESOLVE-INT($num_ranges);
    gtk_print_settings_set_page_ranges($!prnset, $page_ranges, $nr);
  }

  method set_paper_height (
    Num() $height,
    Int() $unit                # GtkUnit $unit
  )
    is also<set-paper-height>
  {
    my guint $u = self.RESOLVE-UINT($unit);
    my gdouble $h = $height;
    gtk_print_settings_set_paper_height($!prnset, $h, $u);
  }

  method set_paper_width (
    Num() $width,
    Int() $unit                # GtkUnit $unit
  )
    is also<set-paper-width>
  {
    my guint $u = self.RESOLVE-UINT($unit);
    my gdouble $w = $width;
    gtk_print_settings_set_paper_width($!prnset, $w, $u);
  }

  method set_resolution_xy (Int() $resolution_x, Int() $resolution_y)
    is also<set-resolution-xy>
  {
    my @i = ($resolution_x, $resolution_y);
    my gint ($rx, $ry) = self.RESOLVE-INT(@i);
    gtk_print_settings_set_resolution_xy(
      $!prnset, 
      $resolution_x, 
      $resolution_y
    );
  }

  method to_file (
    Str() $file_name,
    CArray[Pointer[GError]] $error = gerror()
  )
    is also<to-file>
  {
    $ERROR = Nil;
    my $rc = gtk_print_settings_to_file($!prnset, $file_name, $error);
    $ERROR = $error[0] with $error[0];
    $rc;
  }

  method to_gvariant is also<to-gvariant> {
    gtk_print_settings_to_gvariant($!prnset);
  }

  method to_key_file (
    GKeyFile() $key_file,
    Str() $group_name
  )
    is also<to-key-file>
  {
    gtk_print_settings_to_key_file($!prnset, $key_file, $group_name);
  }

  method unset (Str() $key) {
    gtk_print_settings_unset($!prnset, $key);
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
