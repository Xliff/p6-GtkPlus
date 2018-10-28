use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::TextTagTable;
use GTK::Raw::Types;

use GTK::Roles::Buildable;

class GTK::TextTagTable {
  also does GTK::Roles::Buildable;

  has GtkTextTagTable $!ttt;

  submethod BUILD(:$table) {
    $!ttt = $table;
    $!b = nativecast(GtkBuildable, $!ttt);    # GTK::Roles::Buildable
  }

  multi method new {
    my $table = gtk_text_tag_table_new();
    self.bless(:$table);
  }
  multi method new (GtkTextTagTable $table) {
    self.bless(:$table);
  }


  # ↓↓↓↓ SIGNALS ↓↓↓↓
  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ PROPERTIES ↓↓↓↓
  # ↑↑↑↑ PROPERTIES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  method add (GtkTextTag() $tag) {
    gtk_text_tag_table_add($!ttt, $tag);
  }

  method foreach (GtkTextTagTableForeach $func, gpointer $data) {
    gtk_text_tag_table_foreach($!ttt, $func, $data);
  }

  method get_size {
    gtk_text_tag_table_get_size($!ttt);
  }

  method get_type {
    gtk_text_tag_table_get_type();
  }

  method lookup (Str() $name) {
    gtk_text_tag_table_lookup($!ttt, $name);
  }

  method remove (GtkTextTag() $tag) {
    gtk_text_tag_table_remove($!ttt, $tag);
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
