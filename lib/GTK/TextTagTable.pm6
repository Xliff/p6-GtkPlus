use v6.c;

use Method::Also;

use GTK::Raw::TextTagTable:ver<3.0.1146>;
use GTK::Raw::Types:ver<3.0.1146>;

use GTK::TextTag:ver<3.0.1146>;

use GLib::Roles::Object;
use GTK::Roles::Buildable:ver<3.0.1146>;
use GTK::Roles::Signals::TextTagTable:ver<3.0.1146>;

class GTK::TextTagTable:ver<3.0.1146> {
  also does GLib::Roles::Object;
  also does GTK::Roles::Buildable;
  also does GTK::Roles::Signals::TextTagTable;

  has GtkTextTagTable $!ttt is implementor;

  submethod BUILD(:$table) {
    self!setObject($!ttt = $table);           # GLib::Roles::Object
    $!b = cast(GtkBuildable, $!ttt);    # GTK::Roles::Buildable
  }

  submethod DESTROY {
    self.disconnect-all($_) for %!signals-ttt;
    self.unref;
  }

  method GTK::Raw::Definitions::GtkTextTagTable
    is also<
      GtkTextTagTable
      TextTagTable
    >
  { $!ttt }

  multi method new {
    my $table = gtk_text_tag_table_new();

    $table ??self.bless(:$table) !! Nil;
  }
  multi method new (GtkTextTagTable $table, :$ref = True) {
    return Nil unless $table;

    my $o = self.bless(:$table);
    $o.ref if $ref;
    $o;
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

  method foreach (
    &func,
    gpointer $data = gpointer
  ) {
    gtk_text_tag_table_foreach($!ttt, &func, $data);
  }

  method get_size is also<get-size> {
    gtk_text_tag_table_get_size($!ttt);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gtk_text_tag_table_get_type, $n, $t );
  }

  method lookup (Str() $name, :$raw = False) {
    my $tag = gtk_text_tag_table_lookup($!ttt, $name);

    $tag ??
      ( $raw ?? $tag !! GTK::TextTag.new($tag) )
      !!
      Nil;
  }

  method remove (GtkTextTag() $tag) {
    gtk_text_tag_table_remove($!ttt, $tag);
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
