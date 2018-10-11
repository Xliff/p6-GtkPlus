use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::Buildable;
use GTK::Raw::Types;

role GTK::Roles::Buildable {
  has GtkBuildable $!b;

  # ↓↓↓↓ SIGNALS ↓↓↓↓
  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  method name is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_buildable_get_name($!b);
      },
      STORE => sub ($, Str() $name is copy) {
        gtk_buildable_set_name($!b, $name);
      }
    );
  }
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓

  method add_child (GtkBuilder() $builder, GObject $child, Str() $type) {
    gtk_buildable_add_child($!b, $builder, $child, $type);
  }

  method construct_child (GtkBuilder() $builder, Str() $name) {
    gtk_buildable_construct_child($!b, $builder, $name);
  }

  method custom_finished (
    GtkBuilder() $builder,
    GObject $child,
    Str() $tagname,
    gpointer $data
  ) {
    gtk_buildable_custom_finished($!b, $builder, $child, $tagname, $data);
  }

  method custom_tag_end (
    GtkBuilder() $builder,
    GObject $child,
    Str() $tagname,
    gpointer $data
  ) {
    gtk_buildable_custom_tag_end($!b, $builder, $child, $tagname, $data);
  }

  method custom_tag_start (
    GtkBuilder() $builder,
    GObject $child,
    Str() $tagname,
    GMarkupParser $parser,
    gpointer $data
  ) {
    gtk_buildable_custom_tag_start(
      $!b,
      $builder,
      $child,
      $tagname,
      $parser,
      $data
    );
  }

  method get_internal_child (GtkBuilder() $builder, Str() $childname) {
    gtk_buildable_get_internal_child($!b, $builder, $childname);
  }

  method get_type {
    gtk_buildable_get_type();
  }

  method parser_finished (GtkBuilder() $builder) {
    gtk_buildable_parser_finished($!b, $builder);
  }

  method set_buildable_property (
    GtkBuilder() $builder,
    Str() $name,
    GValue $value
  ) {
    gtk_buildable_set_buildable_property($!b, $builder, $name, $value);
  }

  # ↑↑↑↑ METHODS ↑↑↑↑

}
