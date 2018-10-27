use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::Types;

unit package GTK::Dialog::Raw::PrintUnix;

sub gtk_print_unix_dialog_add_custom_tab (
  GtkPrintUnixDialog $dialog,
  GtkWidget $child,
  GtkWidget $tab_label
)
  is native('gtk-3')
  is export
  { * }

sub gtk_print_unix_dialog_get_page_setup_set (GtkPrintUnixDialog $dialog)
  returns uint32
  is native('gtk-3')
  is export
  { * }

sub gtk_print_unix_dialog_get_selected_printer (GtkPrintUnixDialog $dialog)
  returns GtkPrinter
  is native('gtk-3')
  is export
  { * }

sub gtk_print_unix_dialog_get_type ()
  returns GType
  is native('gtk-3')
  is export
  { * }

sub gtk_print_unix_dialog_new (gchar $title, GtkWindow $parent)
  returns GtkWidget
  is native('gtk-3')
  is export
  { * }

sub gtk_print_unix_dialog_get_embed_page_setup (
  GtkPrintUnixDialog $dialog
)
  returns uint32
  is native('gtk-3')
  is export
  { * }

sub gtk_print_unix_dialog_get_support_selection (
  GtkPrintUnixDialog $dialog
)
  returns uint32
  is native('gtk-3')
  is export
  { * }

sub gtk_print_unix_dialog_get_settings (GtkPrintUnixDialog $dialog)
  returns GtkPrintSettings
  is native('gtk-3')
  is export
  { * }

sub gtk_print_unix_dialog_get_has_selection (GtkPrintUnixDialog $dialog)
  returns uint32
  is native('gtk-3')
  is export
  { * }

sub gtk_print_unix_dialog_get_current_page (GtkPrintUnixDialog $dialog)
  returns gint
  is native('gtk-3')
  is export
  { * }

sub gtk_print_unix_dialog_get_manual_capabilities (
  GtkPrintUnixDialog $dialog
)
  returns uint32 # GtkPrintCapabilities
  is native('gtk-3')
  is export
  { * }

sub gtk_print_unix_dialog_get_page_setup (GtkPrintUnixDialog $dialog)
  returns GtkPageSetup
  is native('gtk-3')
  is export
  { * }

sub gtk_print_unix_dialog_set_embed_page_setup (
  GtkPrintUnixDialog $dialog,
  gboolean $embed
)
  is native('gtk-3')
  is export
  { * }

sub gtk_print_unix_dialog_set_support_selection (
  GtkPrintUnixDialog $dialog,
  gboolean $support_selection
)
  is native('gtk-3')
  is export
  { * }

sub gtk_print_unix_dialog_set_settings (
  GtkPrintUnixDialog $dialog,
  GtkPrintSettings $settings
)
  is native('gtk-3')
  is export
  { * }

sub gtk_print_unix_dialog_set_has_selection (
  GtkPrintUnixDialog $dialog,
  gboolean $has_selection
)
  is native('gtk-3')
  is export
  { * }

sub gtk_print_unix_dialog_set_current_page (
  GtkPrintUnixDialog $dialog,
  gint $current_page
)
  is native('gtk-3')
  is export
  { * }

sub gtk_print_unix_dialog_set_manual_capabilities (
  GtkPrintUnixDialog $dialog,
  uint32 $caps                # GtkPrintCapabilities $capabilities
)
  is native('gtk-3')
  is export
  { * }

sub gtk_print_unix_dialog_set_page_setup (
  GtkPrintUnixDialog $dialog,
  GtkPageSetup $page_setup
)
  is native('gtk-3')
  is export
  { * }
