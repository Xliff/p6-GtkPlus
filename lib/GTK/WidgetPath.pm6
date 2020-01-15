use v6.c;

use Method::Also;
use NativeCall;


use GTK::Raw::Types;

use GTK::Raw::WidgetPath;

use GLib::GSList;

# Opaque struct.

class GTK::WidgetPath {
  has GtkWidgetPath $!wp is implementor;

  submethod BUILD(:$path) {
    $!wp = $path;
  }

  # widgetpath and path should be removed once all references to them have been
  # changed to GtkWidgetPath
  method GTK::Raw::Definitions::GtkWidgetPath
    is also<
      GtkWidgetPath
      widgetpath
      path
    >
  { $!wp }

  multi method new(GtkWidgetPath $path) {
    return unless $path;

    self.bless( :$path );
  }
  multi method new {
    my $path = gtk_widget_path_new();

    $path ?? self.bless( :$path ) !! $path;
  }

  # ↓↓↓↓ SIGNALS ↓↓↓↓
  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ PROPERTIES ↓↓↓↓
  # ↑↑↑↑ PROPERTIES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  method append_for_widget (GtkWidget() $widget)
    is also<append-for-widget>
  {
    gtk_widget_path_append_for_widget($!wp, $widget);
  }

  method append_type (GType $type) is also<append-type> {
    gtk_widget_path_append_type($!wp, $type);
  }

  method append_with_siblings (
    GtkWidgetPath() $siblings,
    Int() $sibling_index
  )
    is also<append-with-siblings>
  {
    my guint $si = $sibling_index;

    gtk_widget_path_append_with_siblings($!wp, $siblings, $si);
  }

  method copy (GTK::WidgetPath:U: GtkWidgetPath() $path) {
    GTK::WidgetPath.new( gtk_widget_path_copy($path) );
  }

  method free {
    gtk_widget_path_free($!wp);
  }

  method get_object_type is also<get-object-type> {
    GTypeEnum( gtk_widget_path_get_object_type($!wp) );
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gtk_widget_path_get_type, $n, $t );
  }

  method has_parent (Int() $type) is also<has-parent> {
    my uint64 $t = $type;

    so gtk_widget_path_has_parent($!wp, $t);
  }

  method is_type (GType $type) is also<is-type> {
    so gtk_widget_path_is_type($!wp, $type);
  }

  method iter_add_class (Int() $pos, Str() $name) is also<iter-add-class> {
    my gint $p = $pos;

    gtk_widget_path_iter_add_class($!wp, $p, $name);
  }

  # Deprecated.
  #
  # method iter_add_region (
  #   Int() $pos,
  #   Str() $name,
  #   Int() $flags                  # GtkRegionFlags $flags
  # )
  #   is also<iter-add-region>
  # {
  #   my gint $p = $pos;
  #   my guint $f = $flags;
  #
  #   gtk_widget_path_iter_add_region($!wp, $p, $name, $f);
  # }

  method iter_clear_classes (Int() $pos) is also<iter-clear-classes> {
    my gint $p = $pos;

    gtk_widget_path_iter_clear_classes($!wp, $p);
  }

  # Deprecated.
  #
  # method iter_clear_regions (Int() $pos) is also<iter-clear-regions> {
  #   my gint $p = $pos;
  #
  #   gtk_widget_path_iter_clear_regions($!wp, $p);
  # }

  method iter_get_name (Int() $pos) is also<iter-get-name> {
    my gint $p = $pos;

    gtk_widget_path_iter_get_name($!wp, $p);
  }

  method iter_get_object_name (Int() $pos) is also<iter-get-object-name> {
    my gint $p = $pos;

    gtk_widget_path_iter_get_object_name($!wp, $p);
  }

  method iter_get_sibling_index (Int() $pos) is also<iter-get-sibling-index> {
    my gint $p = $pos;

    gtk_widget_path_iter_get_sibling_index($!wp, $p);
  }

  method iter_get_siblings (Int() $pos) is also<iter-get-siblings> {
    my gint $p = $pos;

    GTK::WidgetPath.new( gtk_widget_path_iter_get_siblings($!wp, $p) );
  }

  method iter_get_state (Int() $pos) is also<iter-get-state> {
    my gint $p = $pos;

    GtkStateFlagsEnum( gtk_widget_path_iter_get_state($!wp, $p) );
  }

  method iter_has_class (Int() $pos, Str() $name) is also<iter-has-class> {
    my gint $p = $pos;

    so gtk_widget_path_iter_has_class($!wp, $p, $name);
  }

  method iter_has_name (Int() $pos, Str() $name) is also<iter-has-name> {
    my gint $p = $pos;

    so gtk_widget_path_iter_has_name($!wp, $p, $name);
  }

  method iter_has_qclass (
    Int() $pos,
    GQuark $qname
  )
    is also<iter-has-qclass>
  {
    my gint $p = $pos;

    so gtk_widget_path_iter_has_qclass($!wp, $p, $qname);
  }

  method iter_has_qname (Int() $pos, GQuark $qname) is also<iter-has-qname> {
    my gint $p = $pos;

    so gtk_widget_path_iter_has_qname($!wp, $p, $qname);
  }

  # Deprecated.
  #
  # method iter_has_qregion (
  #   Int() $pos,
  #   GQuark $qname,
  #   Int() $flags
  # )
  #   is also<iter-has-qregion>
  # {
  #   my gint $p = $pos;
  #   my guint $f = $flags;
  #
  #   so gtk_widget_path_iter_has_qregion($!wp, $p, $qname, $f);
  # }
  #
  # method iter_has_region (
  #   Int() $pos,
  #   Str() $name,
  #   Int() $flags
  # )
  #   is also<iter-has-region>
  # {
  #   my gint $p = $pos;
  #   my guint $f = $flags;
  #
  #   so gtk_widget_path_iter_has_region($!wp, $p, $name, $f);
  # }

  method iter_list_classes (Int() $pos) is also<iter-list-classes> {
    my gint $p = $pos;

    gtk_widget_path_iter_list_classes($!wp, $p);
  }

  # Deprecated.
  #
  # method iter_list_regions (Int() $pos) is also<iter-list-regions> {
  #   my gint $p = $pos;
  #
  #   GLib::GSList.new( gtk_widget_path_iter_list_regions($!wp, $p) );
  # }

  method iter_remove_class (Int() $pos, Str() $name)
    is also<iter-remove-class>
  {
    my gint $p = $pos;

    gtk_widget_path_iter_remove_class($!wp, $p, $name);
  }

  # Deprecated.
  #s
  # method iter_remove_region (Int() $pos, Str() $name)
  #   is also<iter-remove-region>
  # {
  #   my gint $p = $pos;
  #
  #   gtk_widget_path_iter_remove_region($!wp, $p, $name);
  # }

  method iter_set_name (Int() $pos, Str() $name) is also<iter-set-name> {
    my gint $p = $pos;

    gtk_widget_path_iter_set_name($!wp, $p, $name);
  }

  method iter_set_object_name (Int() $pos, Str() $name)
    is also<iter-set-object-name>
  {
    my gint $p = $pos;

    gtk_widget_path_iter_set_object_name($!wp, $p, $name);
  }

  method iter_set_object_type (Int() $pos, GTypeEnum $type)
    is also<iter-set-object-type>
  {
    my gint $p = $pos;
    my gulong $t = $type;

    gtk_widget_path_iter_set_object_type($!wp, $p, $t);
  }

  method iter_set_state (Int() $pos, Int() $state)
    is also<iter-set-state>
  {
    my gint $p = $pos;
    my GtkStateFlags $s = $state;

    gtk_widget_path_iter_set_state($!wp, $p, $s);
  }

  method length is also<elems> {
    gtk_widget_path_length($!wp);
  }

  method prepend_type (GType $type) is also<prepend-type> {
    gtk_widget_path_prepend_type($!wp, $type);
  }

  method ref is also<upref> {
    gtk_widget_path_ref($!wp);
    self;
  }

  method to_string
    is also<
      to-string
      Str
    >
  {
    gtk_widget_path_to_string($!wp);
  }

  method unref is also<downref> {
    gtk_widget_path_unref($!wp);
  }

  # ↑↑↑↑ METHODS ↑↑↑↑

}
