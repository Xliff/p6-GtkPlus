use v6.c;

use NativeCall;


use GTK::Raw::Types;

unit package GTK::Raw::PageSetup;

sub gtk_page_setup_copy (GtkPageSetup $other)
  returns GtkPageSetup
  is native(gtk)
  is export
  { * }

sub gtk_page_setup_get_bottom_margin (
  GtkPageSetup $setup,
  uint32 $unit                    # GtkUnit $unit
)
  returns gdouble
  is native(gtk)
  is export
  { * }

sub gtk_page_setup_get_left_margin (
  GtkPageSetup $setup,
  uint32 $unit                    # GtkUnit $unit
)
  returns gdouble
  is native(gtk)
  is export
  { * }

sub gtk_page_setup_get_page_height (
  GtkPageSetup $setup,
  uint32 $unit                    # GtkUnit $unit
)
  returns gdouble
  is native(gtk)
  is export
  { * }

sub gtk_page_setup_get_page_width (
  GtkPageSetup $setup,
  uint32 $unit                    # GtkUnit $unit
)
  returns gdouble
  is native(gtk)
  is export
  { * }

sub gtk_page_setup_get_paper_height (
  GtkPageSetup $setup,
  uint32 $unit                    # GtkUnit $unit
)
  returns gdouble
  is native(gtk)
  is export
  { * }

sub gtk_page_setup_get_paper_width (
  GtkPageSetup $setup,
  uint32 $unit                    # GtkUnit $unit
)
  returns gdouble
  is native(gtk)
  is export
  { * }

sub gtk_page_setup_get_right_margin (
  GtkPageSetup $setup,
  uint32 $unit                    # GtkUnit $unit
)
  returns gdouble
  is native(gtk)
  is export
  { * }

sub gtk_page_setup_get_top_margin (
  GtkPageSetup $setup,
  uint32 $unit                    # GtkUnit $unit
)
  returns gdouble
  is native(gtk)
  is export
  { * }

sub gtk_page_setup_get_type ()
  returns GType
  is native(gtk)
  is export
  { * }

sub gtk_page_setup_load_file (
  GtkPageSetup $setup,
  gchar $file_name,
  GError $error
)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_page_setup_load_key_file (
  GtkPageSetup $setup,
  GKeyFile $key_file,
  gchar $group_name,
  GError $error
)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_page_setup_new ()
  returns GtkPageSetup
  is native(gtk)
  is export
  { * }

sub gtk_page_setup_new_from_file (gchar $file_name, GError $error)
  returns GtkPageSetup
  is native(gtk)
  is export
  { * }

sub gtk_page_setup_new_from_gvariant (GVariant $variant)
  returns GtkPageSetup
  is native(gtk)
  is export
  { * }

sub gtk_page_setup_new_from_key_file (
  GKeyFile $key_file,
  gchar $group_name,
  GError $error
)
  returns GtkPageSetup
  is native(gtk)
  is export
  { * }

sub gtk_page_setup_set_bottom_margin (
  GtkPageSetup $setup,
  gdouble $margin,
  uint32 $unit                    # GtkUnit $unit
)
  is native(gtk)
  is export
  { * }

sub gtk_page_setup_set_left_margin (
  GtkPageSetup $setup,
  gdouble $margin,
  uint32 $unit                    # GtkUnit $unit
)
  is native(gtk)
  is export
  { * }

sub gtk_page_setup_set_paper_size_and_default_margins (
  GtkPageSetup $setup,
  GtkPaperSize $size
)
  is native(gtk)
  is export
  { * }

sub gtk_page_setup_set_right_margin (
  GtkPageSetup $setup,
  gdouble $margin,
  uint32 $uint                    # GtkUnit $unit
)
  is native(gtk)
  is export
  { * }

sub gtk_page_setup_set_top_margin (
  GtkPageSetup $setup,
  gdouble $margin,
  uint32                          # GtkUnit $unit
)
  is native(gtk)
  is export
  { * }

sub gtk_page_setup_to_file (
  GtkPageSetup $setup,
  gchar $file_name,
  GError $error
)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_page_setup_to_gvariant (GtkPageSetup $setup)
  returns GVariant
  is native(gtk)
  is export
  { * }

sub gtk_page_setup_to_key_file (
  GtkPageSetup $setup,
  GKeyFile $key_file,
  gchar $group_name
)
  is native(gtk)
  is export
  { * }

sub gtk_page_setup_get_paper_size (GtkPageSetup $setup)
  returns GtkPaperSize
  is native(gtk)
  is export
  { * }

sub gtk_page_setup_get_orientation (GtkPageSetup $setup)
  returns uint32 # GtkPageOrientation
  is native(gtk)
  is export
  { * }

sub gtk_page_setup_set_paper_size (GtkPageSetup $setup, GtkPaperSize $size)
  is native(gtk)
  is export
  { * }

sub gtk_page_setup_set_orientation (
  GtkPageSetup $setup,
  uint32 $orientation             # GtkPageOrientation $orientation
)
  is native(gtk)
  is export
  { * }