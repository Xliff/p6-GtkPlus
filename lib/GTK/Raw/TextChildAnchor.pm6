use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::Types;

unit package GTK::Raw::TextAnchor;

sub gtk_text_child_anchor_get_deleted (GtkTextChildAnchor $anchor)
  returns uint32
  is native('gtk-3')
  is export
  { * }

sub gtk_text_child_anchor_get_type ()
  returns GType
  is native('gtk-3')
  is export
  { * }

sub gtk_text_child_anchor_get_widgets (GtkTextChildAnchor $anchor)
  returns GList
  is native('gtk-3')
  is export
  { * }

sub gtk_text_child_anchor_new ()
  returns GtkTextChildAnchor
  is native('gtk-3')
  is export
  { * }
