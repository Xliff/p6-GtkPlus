use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::Types;

unit package GTK::Raw::InfoBar;

sub gtk_info_bar_add_action_widget (GtkInfoBar $info_bar, GtkWidget $child, gint $response_id)
  is native($LIBGTK)
  is export
  { * }

sub gtk_info_bar_add_button (GtkInfoBar $info_bar, gchar $button_text, gint $response_id)
  returns GtkWidget
  is native($LIBGTK)
  is export
  { * }

sub gtk_info_bar_get_action_area (GtkInfoBar $info_bar)
  returns GtkWidget
  is native($LIBGTK)
  is export
  { * }

sub gtk_info_bar_get_content_area (GtkInfoBar $info_bar)
  returns GtkWidget
  is native($LIBGTK)
  is export
  { * }

sub gtk_info_bar_get_type ()
  returns GType
  is native($LIBGTK)
  is export
  { * }

sub gtk_info_bar_new ()
  returns GtkWidget
  is native($LIBGTK)
  is export
  { * }

sub gtk_info_bar_response (GtkInfoBar $info_bar, gint $response_id)
  is native($LIBGTK)
  is export
  { * }

sub gtk_info_bar_set_default_response (GtkInfoBar $info_bar, gint $response_id)
  is native($LIBGTK)
  is export
  { * }

sub gtk_info_bar_set_response_sensitive (GtkInfoBar $info_bar, gint $response_id, gboolean $setting)
  is native($LIBGTK)
  is export
  { * }

sub gtk_info_bar_get_message_type (GtkInfoBar $info_bar)
  returns uint32 # GtkMessageType
  is native($LIBGTK)
  is export
  { * }

sub gtk_info_bar_get_revealed (GtkInfoBar $info_bar)
  returns uint32
  is native($LIBGTK)
  is export
  { * }

sub gtk_info_bar_get_show_close_button (GtkInfoBar $info_bar)
  returns uint32
  is native($LIBGTK)
  is export
  { * }

# (GtkInfoBar $info_bar, GtkMessageType $message_type)
sub gtk_info_bar_set_message_type (GtkInfoBar $info_bar, uint32 $message_type)
  is native($LIBGTK)
  is export
  { * }

sub gtk_info_bar_set_revealed (GtkInfoBar $info_bar, gboolean $revealed)
  is native($LIBGTK)
  is export
  { * }

sub gtk_info_bar_set_show_close_button (GtkInfoBar $info_bar, gboolean $setting)
  is native($LIBGTK)
  is export
  { * }