use v6.c;

use Method::Also;
use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::PrintSettings;
use GTK::Raw::Types;

use GTK::Roles::Types;

class GTK::PrintSettings {
  also does GTK::Roles::Types;

  has GtkPrintSettings $!prnset;

  submethod BUILD(:$settings) {
    $!prnset = $settings;
  }

  method new {
    my $settings = gtk_print_settings_new();
    self.bless(:$settings);
  }

  method new_from_file (
    Str() $filename,
    GError $error = GError
  ) is also<new-from-file> {
    gtk_print_settings_new_from_file($filename, $error);
  }

  method new_from_gvariant(GVariant $v)  is also<new-from-gvariant> {
    my $settings = gtk_print_settings_new_from_gvariant($v);
    self.bless(:$settings);
  }

  method new_from_key_file (
    Str() $keyfile,
    Str() $group_name,
    GError $error = GError
  ) is also<new-from-key-file> {
    my $settings = gtk_print_settings_new_from_key_file(
      $keyfile,
      $group_name,
      $error
    );
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
        gtk_print_settings_get_duplex($!prnset);
      },
      STORE => sub ($, $duplex is copy) {
        gtk_print_settings_set_duplex($!prnset, $duplex);
      }
    );
  }

  method finishings is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_print_settings_get_finishings($!prnset);
      },
      STORE => sub ($, $finishings is copy) {
        gtk_print_settings_set_finishings($!prnset, $finishings);
      }
    );
  }

  method media_type is rw is also<media-type> {
    Proxy.new(
      FETCH => sub ($) {
        gtk_print_settings_get_media_type($!prnset);
      },
      STORE => sub ($, $media_type is copy) {
        gtk_print_settings_set_media_type($!prnset, $media_type);
      }
    );
  }

  method n_copies is rw is also<n-copies> {
    Proxy.new(
      FETCH => sub ($) {
        gtk_print_settings_get_n_copies($!prnset);
      },
      STORE => sub ($, $num_copies is copy) {
        gtk_print_settings_set_n_copies($!prnset, $num_copies);
      }
    );
  }

  method number_up is rw is also<number-up> {
    Proxy.new(
      FETCH => sub ($) {
        gtk_print_settings_get_number_up($!prnset);
      },
      STORE => sub ($, $number_up is copy) {
        gtk_print_settings_set_number_up($!prnset, $number_up);
      }
    );
  }

  method number_up_layout is rw is also<number-up-layout> {
    Proxy.new(
      FETCH => sub ($) {
        gtk_print_settings_get_number_up_layout($!prnset);
      },
      STORE => sub ($, $number_up_layout is copy) {
        gtk_print_settings_set_number_up_layout($!prnset, $number_up_layout);
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
      STORE => sub ($, $output_bin is copy) {
        gtk_print_settings_set_output_bin($!prnset, $output_bin);
      }
    );
  }

  method page_set is rw is also<page-set> {
    Proxy.new(
      FETCH => sub ($) {
        gtk_print_settings_get_page_set($!prnset);
      },
      STORE => sub ($, $page_set is copy) {
        gtk_print_settings_set_page_set($!prnset, $page_set);
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
        gtk_print_settings_get_print_pages($!prnset);
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
      STORE => sub ($, $lpi is copy) {
        gtk_print_settings_set_printer_lpi($!prnset, $lpi);
      }
    );
  }

  method quality is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_print_settings_get_quality($!prnset);
      },
      STORE => sub ($, $quality is copy) {
        gtk_print_settings_set_quality($!prnset, $quality);
      }
    );
  }

  method resolution is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_print_settings_get_resolution($!prnset);
      },
      STORE => sub ($, $resolution is copy) {
        gtk_print_settings_set_resolution($!prnset, $resolution);
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

  method get_double_with_default (Str() $key, Num() $def) is also<get-double-with-default> {
    my gdouble $d = $def;
    gtk_print_settings_get_double_with_default($!prnset, $key, $d);
  }

  method get_int (Str() $key) is also<get-int> {
    gtk_print_settings_get_int($!prnset, $key);
  }

  method get_int_with_default (Str() $key, Int() $def) is also<get-int-with-default> {
    my gint $d = self.RESOLVE-INT($def);
    gtk_print_settings_get_int_with_default($!prnset, $key, $d);
  }

  method get_length (
    Str() $key,
    Int() $unit                # GtkUnit $unit
  ) is also<get-length> {
    my guint $u = self.RESOLVE-UINT($unit);
    gtk_print_settings_get_length($!prnset, $key, $u);
  }

  method get_page_ranges (Int() $num_ranges) is also<get-page-ranges> {
    my gint $nr = self.RESOLVE-INT($num_ranges);
    gtk_print_settings_get_page_ranges($!prnset, $nr);
  }

  method get_paper_height (
    Int() $unit                # GtkUnit $unit
  ) is also<get-paper-height> {
    my guint $u = self.RESOLVE-UINT($unit);
    gtk_print_settings_get_paper_height($!prnset, $u);
  }

  method get_paper_width (
    Int() $unit                # GtkUnit $unit
  ) is also<get-paper-width> {
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
    GError $error = GError
  ) is also<load-file> {
    gtk_print_settings_load_file($!prnset, $file_name, $error);
  }

  method load_key_file (
    GKeyFile() $key_file,
    Str() $group_name,
    GError $error = GError
  ) is also<load-key-file> {
    gtk_print_settings_load_key_file($!prnset, $key_file, $group_name, $error);
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
  ) is also<set-length> {
    my guint $u = self.RESOLVE-UINT($unit);
    my gdouble $v = $value;
    gtk_print_settings_set_length($!prnset, $key, $v, $u);
  }

  method set_page_ranges (GtkPageRange $page_ranges, Int() $num_ranges) is also<set-page-ranges> {
    my gint $nr = self.RESOLVE-INT($num_ranges);
    gtk_print_settings_set_page_ranges($!prnset, $page_ranges, $nr);
  }

  method set_paper_height (
    gdouble $height,
    Int() $unit                # GtkUnit $unit
  ) is also<set-paper-height> {
    my guint $u = self.RESOLVE-UINT($unit);
    gtk_print_settings_set_paper_height($!prnset, $height, $u);
  }

  method set_paper_width (
    gdouble $width,
    Int() $unit                # GtkUnit $unit
  ) is also<set-paper-width> {
    my guint $u = self.RESOLVE-UINT($unit);
    gtk_print_settings_set_paper_width($!prnset, $width, $u);
  }

  method set_resolution_xy (Int() $resolution_x, Int() $resolution_y) is also<set-resolution-xy> {
    my @i = ($resolution_x, $resolution_y);
    my gint ($rx, $ry) = self.RESOLVE-INT(@i);
    gtk_print_settings_set_resolution_xy($!prnset, $resolution_x, $resolution_y);
  }

  method to_file (
    Str() $file_name,
    GError $error = GError
  ) is also<to-file> {
    gtk_print_settings_to_file($!prnset, $file_name, $error);
  }

  method to_gvariant is also<to-gvariant> {
    gtk_print_settings_to_gvariant($!prnset);
  }

  method to_key_file (
    GKeyFile() $key_file,
    Str() $group_name
  ) is also<to-key-file> {
    gtk_print_settings_to_key_file($!prnset, $key_file, $group_name);
  }

  method unset (Str() $key) {
    gtk_print_settings_unset($!prnset, $key);
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}

