use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Structs;
use GTK::Raw::Definitions:ver<3.0.1146>;
use GTK::Raw::Structs:ver<3.0.1146>;

unit package GTK::Raw::TextMark:ver<3.0.1146>;

sub gtk_text_mark_get_buffer (GtkTextMark $mark)
  returns GtkTextBuffer
  is native(gtk)
  is export
  { * }

sub gtk_text_mark_get_deleted (GtkTextMark $mark)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_text_mark_get_left_gravity (GtkTextMark $mark)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_text_mark_get_name (GtkTextMark $mark)
  returns Str
  is native(gtk)
  is export
  { * }

sub gtk_text_mark_get_type ()
  returns GType
  is native(gtk)
  is export
  { * }

sub gtk_text_mark_new (Str $name, gboolean $left_gravity)
  returns GtkTextMark
  is native(gtk)
  is export
  { * }

sub gtk_text_mark_get_visible (GtkTextMark $mark)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_text_mark_set_visible (GtkTextMark $mark, gboolean $setting)
  is native(gtk)
  is export
  { * }