use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::Selection;
use GTK::Raw::Types;

use GTK::Roles::Types;

class GTK::Selection {
  also does GTK::Roles::Types;

  has GtkSelectionData $!s;

  method bless(*%attrinit) {
    use nqp;
    my $o = nqp::create(self).BUILDALL(Empty, %attrinit);
    self.setType('GTK::Selection');
    $o;
  }

  submethod BUILD(:$selection) {
    $!s = $selection
  }

  submethod DESTROY {
    self.free;
  }

  method GtkSelectionData {
    $!s;
  }

  # ↓↓↓↓ SIGNALS ↓↓↓↓
  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  method gtk_selection_data_pixbuf is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_selection_data_get_pixbuf($!s);
      },
      STORE => sub ($, GdkPixbuf $pixbuf is copy) {
        gtk_selection_data_set_pixbuf($!s, $pixbuf);
      }
    );
  }

  method gtk_selection_data_uris is rw {
    Proxy.new(
      FETCH => sub ($) {
        my @ret;
        my CArray[Str] $u;
        $u = gtk_selection_data_get_uris($!s);
        @ret.push($_) for $u.list;
        @ret;
      },
      STORE => sub ($, Str @uris is copy) {
        my CArray[Str] $u = CArray[Str].new;
        $u[$++] = $_ for @uris;
        gtk_selection_data_set_uris($!s, $u);
      }
    );
  }
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ STATIC (non GtkSelectionData) METHODS ↓↓↓↓
  method add_target (
    GtkWidget() $widget,
    GdkAtom $selection,
    GdkAtom $target,
    Int() $info
  ) {
    my guint $i = self.RESOLVE-UINT($info);
    gtk_selection_add_target($widget, $selection, $target, $i);
  }

  method add_targets (
    GtkWidget() $widget,
    GdkAtom $selection,
    GtkTargetEntry() $targets,
    Int() $ntargets
  ) {
    my guint $nt = self.RESOLVE-UINT($ntargets);
    gtk_selection_add_targets($widget, $selection, $targets, $nt);
  }

  method clear_targets (GtkWidget() $widget, GdkAtom $selection) {
    gtk_selection_clear_targets($widget, $selection);
  }

  method convert (
    GtkWidget() $widget,
    GdkAtom $selection,
    GdkAtom $target,
    Int() $time
  ) {
    my guint32 $t = self.RESOLVE-UINT($time);
    gtk_selection_convert($widget, $selection, $target, $t);
  }

  method owner_set (GtkWidget() $widget, GdkAtom $selection, Int() $time) {
    my guint32 $t = self.RESOLVE-UINT($time);
    gtk_selection_owner_set($widget, $selection, $t);
  }

  multi method owner_set_for_display (
    GtkWidget() $widget,
    GdkAtom $selection,
    Int() $time
  ) {
    my guint32 $t = self.RESOLVE-UINT($time);
    gtk_selection_owner_set_for_display($widget, $selection, $t);
  }

  method remove_all(GtkWidget() $widget) {
    gtk_selection_remove_all($widget);
  }
  # ↑↑↑↑ STATIC (non GtkSelectionData) METHODS ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  method copy {
    gtk_selection_data_copy($!s);
  }

  method free {
    gtk_selection_data_free($!s);
  }

  method get_data {
    gtk_selection_data_get_data($!s);
  }

  method get_data_with_length (Int() $length) {
    my guint $l = self.RESOLVE-INT($length);
    gtk_selection_data_get_data_with_length($!s, $l);
  }

  method get_data_type {
    gtk_selection_data_get_data_type($!s);
  }

  method get_display {
    gtk_selection_data_get_display($!s);
  }

  method get_format {
    gtk_selection_data_get_format($!s);
  }

  method get_length {
    gtk_selection_data_get_length($!s);
  }

  method get_selection {
    gtk_selection_data_get_selection($!s);
  }

  method get_target {
    gtk_selection_data_get_target($!s);
  }

  method get_targets (GdkAtom $targets, Int() $n_atoms) {
    my gint $na = self.RESOLVE-INT($n_atoms);
    gtk_selection_data_get_targets($!s, $targets, $na);
  }

  method get_text {
    gtk_selection_data_get_text($!s);
  }

  method set (GdkAtom $type, Int() $format, guchar $data, Int() $length) {
    my @i = ($format, $length);
    my gint ($f, $l) = self.RESOLVE-INT(@i);
    gtk_selection_data_set($!s, $type, $format, $data, $length);
  }

  method set_text (gchar $str, Int() $len) {
    my gint $l = self.RESOLVE-INT($len);
    gtk_selection_data_set_text($!s, $str, $len);
  }

  method targets_include_image (Int() $writeable) {
    my gboolean $w = self.RESOLVE-BOOL($writeable);
    gtk_selection_data_targets_include_image($!s, $w);
  }

  multi method targets_include_rich_text (GtkTextBuffer() $buffer) {
    gtk_selection_data_targets_include_rich_text($!s, $buffer);
  }

  method targets_include_text {
    gtk_selection_data_targets_include_text($!s);
  }

  method targets_include_uri {
    gtk_selection_data_targets_include_uri($!s);
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
