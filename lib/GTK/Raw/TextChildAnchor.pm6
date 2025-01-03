use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Structs;
use GTK::Raw::Definitions:ver<3.0.1146>;
use GTK::Raw::Structs:ver<3.0.1146>;

unit package GTK::Raw::TextAnchor:ver<3.0.1146>;

sub gtk_text_child_anchor_get_deleted (GtkTextChildAnchor $anchor)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_text_child_anchor_get_type ()
  returns GType
  is native(gtk)
  is export
  { * }

sub gtk_text_child_anchor_get_widgets (GtkTextChildAnchor $anchor)
  returns GList
  is native(gtk)
  is export
  { * }

sub gtk_text_child_anchor_new ()
  returns GtkTextChildAnchor
  is native(gtk)
  is export
  { * }