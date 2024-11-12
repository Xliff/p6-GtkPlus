use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Structs;
use GTK::Raw::Definitions:ver<3.0.1146>;
use GTK::Raw::Structs:ver<3.0.1146>;

unit package GTK::Raw::TextTagTable:ver<3.0.1146>;

sub gtk_text_tag_table_add (GtkTextTagTable $table, GtkTextTag $tag)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_text_tag_table_foreach (
  GtkTextTagTable $table,
  &func (GtkTextTag, Pointer), 
  gpointer $data
)
  is native(gtk)
  is export
  { * }

sub gtk_text_tag_table_get_size (GtkTextTagTable $table)
  returns gint
  is native(gtk)
  is export
  { * }

sub gtk_text_tag_table_get_type ()
  returns GType
  is native(gtk)
  is export
  { * }

sub gtk_text_tag_table_lookup (GtkTextTagTable $table, Str $name)
  returns GtkTextTag
  is native(gtk)
  is export
  { * }

sub gtk_text_tag_table_new ()
  returns GtkTextTagTable
  is native(gtk)
  is export
  { * }

sub gtk_text_tag_table_remove (GtkTextTagTable $table, GtkTextTag $tag)
  is native(gtk)
  is export
  { * }
