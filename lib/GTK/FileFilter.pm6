use v6.c;

use Method::Also;
use NativeCall;

use GTK::Raw::FileFilter:ver<3.0.1146>;
use GTK::Raw::Types:ver<3.0.1146>;

use GLib::Variant;

use GTK::Roles::Buildable:ver<3.0.1146>;
use GTK::Roles::Types:ver<3.0.1146>;
use GLib::Roles::Object;

my subset Ancestry where GtkFileFilter | GtkBuilder;

class GTK::FileFilter:ver<3.0.1146> {
  also does GTK::Roles::Types;
  also does GTK::Roles::Buildable;
  also does GLib::Roles::Object;

  has GtkFileFilter $!ff is implementor;

  submethod BUILD(:$filter) {
    $!b = nativecast(GtkBuildable, $!ff);         # GTK::Roles::Buildable
    self!setObject($filter);                      # GLib::Roles::Object
  }

  method GTK::Raw::Definitions::GtkFileFilter
    is also<FileFilter>
  { $!ff }

  multi method new {
    my $filter = gtk_file_filter_new();

    $filter ?? self.bless(:$filter) !! Nil;
  }
  multi method new (Ancestry $filter, :$ref = True) {
    return Nil unless $filter;

    my $o = self.bless(:$filter);
    $o.upref if $ref;
    $o;
  }

  method new_from_gvariant (GVariant() $v) is also<new-from-gvariant> {
    my $filter = gtk_file_filter_new_from_gvariant($v);

    $filter ?? self.bless(:$filter) !! Nil;
  }

  # ↓↓↓↓ SIGNALS ↓↓↓↓
  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  method name is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_file_filter_get_name($!ff);
      },
      STORE => sub ($, Str() $name is copy) {
        gtk_file_filter_set_name($!ff, $name);
      }
    );
  }
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  multi method add_custom (
    Int() $needed,              # GtkFileFilterFlags $needed,
    GtkFileFilterFunc $func,
    gpointer $data         = gpointer,
    GDestroyNotify $notify = GDestroyNotify
  )
    is also<add-custom>
  {
    my guint $n = $needed;

    gtk_file_filter_add_custom($!ff, $n, $func, $data, $notify);
  }

  method add_mime_type (Str() $mime_type) is also<add-mime-type> {
    gtk_file_filter_add_mime_type($!ff, $mime_type);
  }

  method add_pattern (Str() $pattern) is also<add-pattern> {
    gtk_file_filter_add_pattern($!ff, $pattern);
  }

  method add_pixbuf_formats is also<add-pixbuf-formats> {
    gtk_file_filter_add_pixbuf_formats($!ff);
  }

  method filter (GtkFileFilterInfo $filter_info) {
    gtk_file_filter_filter($!ff, $filter_info);
  }

  method get_needed is also<get-needed> {
    so gtk_file_filter_get_needed($!ff);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gtk_file_filter_get_type, $n, $t );
  }

  method to_gvariant (:$raw = False) is also<to-gvariant> {
    my $v = gtk_file_filter_to_gvariant($!ff);

    $v ??
      ( $raw ?? $v !! GLib::Variant.new($v) )
      !!
      Nil;
  }

  # ↑↑↑↑ METHODS ↑↑↑↑

}
