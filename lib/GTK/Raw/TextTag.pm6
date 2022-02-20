use v6.c;

use NativeCall;


use GTK::Raw::Types:ver<3.0.1146>;

unit package GTK::Raw::TextTag:ver<3.0.1146>;

sub gtk_text_tag_changed (GtkTextTag $tag, gboolean $size_changed)
  is native(gtk)
  is export
  { * }

sub gtk_text_tag_event (
  GtkTextTag $tag,
  GObject $event_object,
  GdkEvent $event,
  GtkTextIter $iter
)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_text_tag_get_type ()
  returns GType
  is native(gtk)
  is export
  { * }

sub gtk_text_tag_new (gchar $name)
  returns GtkTextTag
  is native(gtk)
  is export
  { * }

sub gtk_text_tag_get_priority (GtkTextTag $tag)
  returns gint
  is native(gtk)
  is export
  { * }

sub gtk_text_tag_set_priority (GtkTextTag $tag, gint $priority)
  is native(gtk)
  is export
  { * }