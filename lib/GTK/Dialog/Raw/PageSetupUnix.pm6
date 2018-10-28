use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::Types;

unit package GTK::Dialog::Raw::PageSetupUnix;

sub gtk_page_setup_unix_dialog_get_type ()
  returns GType
  is native(gtk)
  is export
  { * }

sub gtk_page_setup_unix_dialog_new (gchar $title, GtkWindow $parent)
  returns GtkWidget
  is native(gtk)
  is export
  { * }

sub gtk_page_setup_unix_dialog_get_print_settings (
  GtkPageSetupUnixDialog $dialog
)
  returns GtkPrintSettings
  is native(gtk)
  is export
  { * }

sub gtk_page_setup_unix_dialog_get_page_setup (
  GtkPageSetupUnixDialog $dialog
)
  returns GtkPageSetup
  is native(gtk)
  is export
  { * }

sub gtk_page_setup_unix_dialog_set_print_settings (
  GtkPageSetupUnixDialog $dialog,
  GtkPrintSettings $print_settings
)
  is native(gtk)
  is export
  { * }

sub gtk_page_setup_unix_dialog_set_page_setup (
  GtkPageSetupUnixDialog $dialog,
  GtkPageSetup $page_setup
)
  is native(gtk)
  is export
  { * }