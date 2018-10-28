use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::Types;

unit package GTK::Raw::TextTagTable;

sub gtk_text_tag_table_add (GtkTextTagTable $table, GtkTextTag $tag)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_text_tag_table_foreach (GtkTextTagTable $table, GtkTextTagTableForeach $func, gpointer $data)
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

sub gtk_text_tag_table_lookup (GtkTextTagTable $table, gchar $name)
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