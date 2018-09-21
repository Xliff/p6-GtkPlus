use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::Selection;
use GTK::Raw::Types;

class GTK::Selection {
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

  method GtkSelectionData {
    $!s;
  }

  # ↓↓↓↓ SIGNALS ↓↓↓↓
  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  method gtk_selection_data_pixbuf is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_selection_data_get_pixbuf($!tl);
      },
      STORE => sub ($, $pixbuf is copy) {
        gtk_selection_data_set_pixbuf($!tl, $pixbuf);
      }
    );
  }

  method gtk_selection_data_uris is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_selection_data_get_uris($!tl);
      },
      STORE => sub ($, $uris is copy) {
        gtk_selection_data_set_uris($!tl, $uris);
      }
    );
  }
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  method add_target (GdkAtom $selection, GdkAtom $target, guint $info) {
    gtk_selection_add_target($selection, $target, $info);
  }

  multi method add_targets (
    GdkAtom $selection,
    GtkTargetEntry() $targets,
    guint $ntargets
  ) {
    gtk_selection_add_targets($selection, $targets, $ntargets);
  }

  method clear_targets (GdkAtom $selection) {
    gtk_selection_clear_targets($selection);
  }

  method convert (GdkAtom $selection, GdkAtom $target, guint32 $time_) {
    gtk_selection_convert($selection, $target, $time_);
  }

  method owner_set (GdkAtom $selection, guint32 $time_) {
    gtk_selection_owner_set($selection, $time_);
  }

  multi method owner_set_for_display (
    GtkWidget() $widget,
    GdkAtom $selection,
    guint32 $time
  ) {
    gtk_selection_owner_set_for_display($widget, $selection, $time);
  }

  method remove_all {
    gtk_selection_remove_all();
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

  method get_data_type {
    gtk_selection_data_get_data_type();
  }

  method get_data_with_length (gint $length) {
    gtk_selection_data_get_data_with_length($!s, $length);
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

  method get_targets (GdkAtom $targets, gint $n_atoms) {
    gtk_selection_data_get_targets($!s, $targets, $n_atoms);
  }

  method get_text {
    gtk_selection_data_get_text($!s);
  }

  method set (GdkAtom $type, gint $format, guchar $data, gint $length) {
    gtk_selection_data_set($!s, $type, $format, $data, $length);
  }

  method set_text (gchar $str, gint $len) {
    gtk_selection_data_set_text($!s, $str, $len);
  }

  method targets_include_image (Int() $writable) {
    my gboolean $w = $writeable == 0 ?? 0 !! 1;
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
