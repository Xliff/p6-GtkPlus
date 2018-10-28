use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::Types;

unit package GTK::Raw::TextTag;

sub gtk_text_tag_changed (GtkTextTag $tag, gboolean $size_changed)
  is native($LIBGTK)
  is export
  { * }

sub gtk_text_tag_event (
  GtkTextTag $tag,
  GObject $event_object,
  GdkEvent $event,
  GtkTextIter $iter
)
  returns uint32
  is native($LIBGTK)
  is export
  { * }

sub gtk_text_tag_get_type ()
  returns GType
  is native($LIBGTK)
  is export
  { * }

sub gtk_text_tag_new (gchar $name)
  returns GtkTextTag
  is native($LIBGTK)
  is export
  { * }

sub gtk_text_tag_get_priority (GtkTextTag $tag)
  returns gint
  is native($LIBGTK)
  is export
  { * }

sub gtk_text_tag_set_priority (GtkTextTag $tag, gint $priority)
  is native($LIBGTK)
  is export
  { * }