use v6.c;

use Method::Also;
use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::TextTagTable;
use GTK::Raw::Types;

use GTK::Roles::Buildable;
use GTK::Roles::Signals::TextTagTable;

class GTK::TextTagTable {
  also does GTK::Roles::Buildable;
  also does GTK::Roles::Signals::TextTagTable;

  has GtkTextTagTable $!ttt;

  submethod BUILD(:$table) {
    $!ttt = $table;
    $!b = nativecast(GtkBuildable, $!ttt);    # GTK::Roles::Buildable
  }

  submethod DESTROY {
    self.disconnect-all($_) for %!signals-ttt;
  }

  method GTK::Raw::Types::GtkTextTagTable {
    $!ttt;
  }

  multi method new {
    my $table = gtk_text_tag_table_new();
    self.bless(:$table);
  }
  multi method new (GtkTextTagTable $table) {
    self.bless(:$table);
  }


  # ↓↓↓↓ SIGNALS ↓↓↓↓

  # Is originally:
  # GtkTextTagTable, GtkTextTag, gpointer --> void
  method tag-added {
    self.connect-tag($!ttt, 'tag-added');
  }

  # Is originally:
  # GtkTextTagTable, GtkTextTag, gboolean, gpointer --> void
  method tag-changed {
    self.connect-tag-changed($!ttt);
  }

  # Is originally:
  # GtkTextTagTable, GtkTextTag, gpointer --> void
  method tag-removed {
    self.connect($!ttt, 'tag-removed');
  }

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

  method get_size is also<get-size> {
    gtk_text_tag_table_get_size($!ttt);
  }

  method get_type is also<get-type> {
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
