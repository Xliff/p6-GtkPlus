use v6.c;

use NativeCall;


use GTK::Raw::Types:ver<3.0.1146>;

unit package GTK::Raw::Dialog:ver<3.0.1146>;

sub gtk_dialog_add_action_widget (
  GtkDialog $dialog,
  GtkWidget $child,
  gint $response_id
)
  is native(gtk)
  is export
  { * }

sub gtk_dialog_add_button (
  GtkDialog $dialog,
  gchar $button_text,
  gint $response_id
)
  returns GtkWidget
  is native(gtk)
  is export
  { * }

sub gtk_dialog_get_action_area (GtkDialog $dialog)
  returns GtkWidget
  is native(gtk)
  is export
  { * }

sub gtk_dialog_get_content_area (GtkDialog $dialog)
  returns GtkWidget
  is native(gtk)
  is export
  { * }

sub gtk_dialog_get_header_bar (GtkDialog $dialog)
  returns GtkWidget
  is native(gtk)
  is export
  { * }

sub gtk_dialog_get_response_for_widget (
  GtkDialog $dialog,
  GtkWidget $widget
)
  returns gint
  is native(gtk)
  is export
  { * }

sub gtk_dialog_get_type ()
  returns GType
  is native(gtk)
  is export
  { * }

sub gtk_dialog_get_widget_for_response (
  GtkDialog $dialog,
  gint $response_id
)
  returns GtkWidget
  is native(gtk)
  is export
  { * }

sub gtk_alternative_dialog_button_order (GdkScreen $screen)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_dialog_new ()
  returns GtkWidget
  is native(gtk)
  is export
  { * }

sub gtk_dialog_response (GtkDialog $dialog, gint $response_id)
  is native(gtk)
  is export
  { * }

sub gtk_dialog_run (GtkDialog $dialog)
  returns gint
  is native(gtk)
  is export
  { * }

sub gtk_dialog_set_alternative_button_order_from_array (
  GtkDialog $dialog,
  gint $n_params,
  CArray[gint] $new_order
)
  is native(gtk)
  is export
  { * }

sub gtk_dialog_set_default_response (
  GtkDialog $dialog,
  gint $response_id
)
  is native(gtk)
  is export
  { * }

sub gtk_dialog_set_response_sensitive (
  GtkDialog $dialog,
  gint $response_id,
  gboolean $setting
)
  is native(gtk)
  is export
  { * }

sub gtk_dialog_new_with_buttons(
  Str $title,
  GtkWindow $parent,
  uint32 $flags,                # GtkDialogFlags flags,
  Str $first_button_text,
  gint $first_response_id,
  Str
)
  returns GtkWidget
  is native(gtk)
  is export
  { * }