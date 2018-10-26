use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::Types;

unit package GTK::Raw::PrintSettings;

sub gtk_print_settings_copy (GtkPrintSettings $other)
  returns GtkPrintSettings
  is native('gtk-3')
  is export
  { * }

sub gtk_print_settings_foreach (
  GtkPrintSettings $settings,
  GtkPrintSettingsFunc $func,
  gpointer $user_data
)
  is native('gtk-3')
  is export
  { * }

sub gtk_print_settings_get (
  GtkPrintSettings $settings,
  gchar $key
)
  returns Str
  is native('gtk-3')
  is export
  { * }

sub gtk_print_settings_get_bool (
  GtkPrintSettings $settings,
  gchar $key
)
  returns uint32
  is native('gtk-3')
  is export
  { * }

sub gtk_print_settings_get_double (
  GtkPrintSettings $settings,
  gchar $key
)
  returns gdouble
  is native('gtk-3')
  is export
  { * }

sub gtk_print_settings_get_double_with_default (
  GtkPrintSettings $settings,
  gchar $key,
  gdouble $def
)
  returns gdouble
  is native('gtk-3')
  is export
  { * }

sub gtk_print_settings_get_int (
  GtkPrintSettings $settings,
  gchar $key
)
  returns gint
  is native('gtk-3')
  is export
  { * }

sub gtk_print_settings_get_int_with_default (
  GtkPrintSettings $settings,
  gchar $key,
  gint $def
)
  returns gint
  is native('gtk-3')
  is export
  { * }

sub gtk_print_settings_get_length (
  GtkPrintSettings $settings,
  gchar $key,
  uint32 $unit                # GtkUnit $unit
)
  returns gdouble
  is native('gtk-3')
  is export
  { * }

sub gtk_print_settings_get_page_ranges (
  GtkPrintSettings $settings,
  gint $num_ranges
)
  returns GtkPageRange
  is native('gtk-3')
  is export
  { * }

sub gtk_print_settings_get_paper_height (
  GtkPrintSettings $settings,
  uint32 $unit               # GtkUnit $unit
)
  returns gdouble
  is native('gtk-3')
  is export
  { * }

sub gtk_print_settings_get_paper_width (
  GtkPrintSettings $settings,
  uint32 $unit                # GtkUnit $unit
)
  returns gdouble
  is native('gtk-3')
  is export
  { * }

sub gtk_print_settings_get_resolution_x (
  GtkPrintSettings $settings
)
  returns gint
  is native('gtk-3')
  is export
  { * }

sub gtk_print_settings_get_resolution_y (
  GtkPrintSettings $settings
)
  returns gint
  is native('gtk-3')
  is export
  { * }

sub gtk_print_settings_get_type ()
  returns GType
  is native('gtk-3')
  is export
  { * }

sub gtk_print_settings_has_key (
  GtkPrintSettings $settings,
  gchar $key
)
  returns uint32
  is native('gtk-3')
  is export
  { * }

sub gtk_print_settings_load_file (
  GtkPrintSettings $settings,
  gchar $file_name,
  GError $error
)
  returns uint32
  is native('gtk-3')
  is export
  { * }

sub gtk_print_settings_load_key_file (
  GtkPrintSettings $settings,
  GKeyFile $key_file,
  gchar $group_name,
  GError $error
)
  returns uint32
  is native('gtk-3')
  is export
  { * }

sub gtk_print_settings_new ()
  returns GtkPrintSettings
  is native('gtk-3')
  is export
  { * }

sub gtk_print_settings_new_from_file (
  gchar $file_name,
  GError $error
)
  returns GtkPrintSettings
  is native('gtk-3')
  is export
  { * }

sub gtk_print_settings_new_from_gvariant (GVariant $variant)
  returns GtkPrintSettings
  is native('gtk-3')
  is export
  { * }

sub gtk_print_settings_new_from_key_file (
  GKeyFile $key_file,
  gchar $group_name,
  GError $error
)
  returns GtkPrintSettings
  is native('gtk-3')
  is export
  { * }

sub gtk_print_settings_set (
  GtkPrintSettings $settings,
  gchar $key,
  gchar $value
)
  is native('gtk-3')
  is export
  { * }

sub gtk_print_settings_set_bool (
  GtkPrintSettings $settings,
  gchar $key,
  gboolean $value
)
  is native('gtk-3')
  is export
  { * }

sub gtk_print_settings_set_double (
  GtkPrintSettings $settings,
  gchar $key,
  gdouble $value
)
  is native('gtk-3')
  is export
  { * }

sub gtk_print_settings_set_int (
  GtkPrintSettings $settings,
  gchar $key,
  gint $value
)
  is native('gtk-3')
  is export
  { * }

sub gtk_print_settings_set_length (
  GtkPrintSettings $settings,
  gchar $key,
  gdouble $value,
  uint32 $unit                # GtkUnit $unit
)
  is native('gtk-3')
  is export
  { * }

sub gtk_print_settings_set_page_ranges (
  GtkPrintSettings $settings,
  GtkPageRange $page_ranges,
  gint $num_ranges
)
  is native('gtk-3')
  is export
  { * }

sub gtk_print_settings_set_paper_height (
  GtkPrintSettings $settings,
  gdouble $height,
  uint32 $unit                # GtkUnit $unit
)
  is native('gtk-3')
  is export
  { * }

sub gtk_print_settings_set_paper_width (
  GtkPrintSettings $settings,
  gdouble $width,
  uint32 $unit                # GtkUnit $unit
)
  is native('gtk-3')
  is export
  { * }

sub gtk_print_settings_set_resolution_xy (
  GtkPrintSettings $settings,
  gint $resolution_x,
  gint $resolution_y
)
  is native('gtk-3')
  is export
  { * }

sub gtk_print_settings_to_file (
  GtkPrintSettings $settings,
  gchar $file_name,
  GError $error
)
  returns uint32
  is native('gtk-3')
  is export
  { * }

sub gtk_print_settings_to_gvariant (GtkPrintSettings $settings)
  returns GVariant
  is native('gtk-3')
  is export
  { * }

sub gtk_print_settings_to_key_file (
  GtkPrintSettings $settings,
  GKeyFile $key_file,
  gchar $group_name
)
  is native('gtk-3')
  is export
  { * }

sub gtk_print_settings_unset (
  GtkPrintSettings $settings,
  gchar $key
)
  is native('gtk-3')
  is export
  { * }

sub gtk_print_settings_get_reverse (GtkPrintSettings $settings)
  returns uint32
  is native('gtk-3')
  is export
  { * }

sub gtk_print_settings_get_print_pages (GtkPrintSettings $settings)
  returns uint32 # GtkPrintPages
  is native('gtk-3')
  is export
  { * }

sub gtk_print_settings_get_output_bin (GtkPrintSettings $settings)
  returns Str
  is native('gtk-3')
  is export
  { * }

sub gtk_print_settings_get_finishings (GtkPrintSettings $settings)
  returns Str
  is native('gtk-3')
  is export
  { * }

sub gtk_print_settings_get_duplex (GtkPrintSettings $settings)
  returns uint32 # GtkPrintDuplex
  is native('gtk-3')
  is export
  { * }

sub gtk_print_settings_get_n_copies (GtkPrintSettings $settings)
  returns gint
  is native('gtk-3')
  is export
  { * }

sub gtk_print_settings_get_collate (GtkPrintSettings $settings)
  returns uint32
  is native('gtk-3')
  is export
  { * }

sub gtk_print_settings_get_dither (GtkPrintSettings $settings)
  returns Str
  is native('gtk-3')
  is export
  { * }

sub gtk_print_settings_get_media_type (GtkPrintSettings $settings)
  returns Str
  is native('gtk-3')
  is export
  { * }

sub gtk_print_settings_get_number_up_layout (
  GtkPrintSettings $settings
)
  returns uint32 # GtkNumberUpLayout
  is native('gtk-3')
  is export
  { * }

sub gtk_print_settings_get_use_color (GtkPrintSettings $settings)
  returns uint32
  is native('gtk-3')
  is export
  { * }

sub gtk_print_settings_get_printer_lpi (GtkPrintSettings $settings)
  returns gdouble
  is native('gtk-3')
  is export
  { * }

sub gtk_print_settings_get_paper_size (GtkPrintSettings $settings)
  returns uint32 # GtkPaperSize
  is native('gtk-3')
  is export
  { * }

sub gtk_print_settings_get_quality (GtkPrintSettings $settings)
  returns uint32 # GtkPrintQuality
  is native('gtk-3')
  is export
  { * }

sub gtk_print_settings_get_scale (GtkPrintSettings $settings)
  returns gdouble
  is native('gtk-3')
  is export
  { * }

sub gtk_print_settings_get_printer (GtkPrintSettings $settings)
  returns Str
  is native('gtk-3')
  is export
  { * }

sub gtk_print_settings_get_orientation (GtkPrintSettings $settings)
  returns uint32 # GtkPageOrientation
  is native('gtk-3')
  is export
  { * }

sub gtk_print_settings_get_resolution (GtkPrintSettings $settings)
  returns gint
  is native('gtk-3')
  is export
  { * }

sub gtk_print_settings_get_default_source (
  GtkPrintSettings $settings
)
  returns Str
  is native('gtk-3')
  is export
  { * }

sub gtk_print_settings_get_page_set (GtkPrintSettings $settings)
  returns uint32 # GtkPageSet
  is native('gtk-3')
  is export
  { * }

sub gtk_print_settings_get_number_up (GtkPrintSettings $settings)
  returns gint
  is native('gtk-3')
  is export
  { * }

sub gtk_print_settings_set_reverse (
  GtkPrintSettings $settings,
  gboolean $reverse
)
  is native('gtk-3')
  is export
  { * }

sub gtk_print_settings_set_print_pages (
  GtkPrintSettings $settings,
  uint32 $pages               # GtkPrintPages $pages
)
  is native('gtk-3')
  is export
  { * }

sub gtk_print_settings_set_output_bin (
  GtkPrintSettings $settings,
  gchar $output_bin
)
  is native('gtk-3')
  is export
  { * }

sub gtk_print_settings_set_finishings (
  GtkPrintSettings $settings,
  gchar $finishings
)
  is native('gtk-3')
  is export
  { * }

sub gtk_print_settings_set_duplex (
  GtkPrintSettings $settings,
  uint32 $duplex              # GtkPrintDuplex $duplex
)
  is native('gtk-3')
  is export
  { * }

sub gtk_print_settings_set_n_copies (
  GtkPrintSettings $settings,
  gint $num_copies
)
  is native('gtk-3')
  is export
  { * }

sub gtk_print_settings_set_collate (
  GtkPrintSettings $settings,
  gboolean $collate
)
  is native('gtk-3')
  is export
  { * }

sub gtk_print_settings_set_dither (
  GtkPrintSettings $settings,
  gchar $dither
)
  is native('gtk-3')
  is export
  { * }

sub gtk_print_settings_set_media_type (
  GtkPrintSettings $settings,
  gchar $media_type
)
  is native('gtk-3')
  is export
  { * }

sub gtk_print_settings_set_number_up_layout (
  GtkPrintSettings $settings,
  uint32 $nul                 # GtkNumberUpLayout $nul
)
  is native('gtk-3')
  is export
  { * }

sub gtk_print_settings_set_use_color (
  GtkPrintSettings $settings,
  gboolean $use_color
)
  is native('gtk-3')
  is export
  { * }

sub gtk_print_settings_set_printer_lpi (
  GtkPrintSettings $settings,
  gdouble $lpi
)
  is native('gtk-3')
  is export
  { * }

sub gtk_print_settings_set_paper_size (
  GtkPrintSettings $settings,
  GtkPaperSize $paper_size
)
  is native('gtk-3')
  is export
  { * }

sub gtk_print_settings_set_quality (
  GtkPrintSettings $settings,
  uint32 $quality             # GtkPrintQuality $quality
)
  is native('gtk-3')
  is export
  { * }

sub gtk_print_settings_set_scale (
  GtkPrintSettings $settings,
  gdouble $scale
)
  is native('gtk-3')
  is export
  { * }

sub gtk_print_settings_set_printer (
  GtkPrintSettings $settings,
  gchar $printer
)
  is native('gtk-3')
  is export
  { * }

sub gtk_print_settings_set_orientation (
  GtkPrintSettings $settings,
  uint32 $o                   # GtkPageOrientation $orientation
)
  is native('gtk-3')
  is export
  { * }

sub gtk_print_settings_set_resolution (
  GtkPrintSettings $settings,
  gint $resolution
)
  is native('gtk-3')
  is export
  { * }

sub gtk_print_settings_set_default_source (
  GtkPrintSettings $settings,
  gchar $default_source
)
  is native('gtk-3')
  is export
  { * }

sub gtk_print_settings_set_page_set (
  GtkPrintSettings $settings,
  uint32 $ps                  # GtkPageSet $page_set
)
  is native('gtk-3')
  is export
  { * }

sub gtk_print_settings_set_number_up (
  GtkPrintSettings $settings,
  gint $number_up
)
  is native('gtk-3')
  is export
  { * }
