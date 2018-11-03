use v6.c;

use Method::Also;
use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::Selection;
use GTK::Raw::Types;

use GTK::Roles::Types;

class GTK::Selection {
  also does GTK::Roles::Types;

  has GtkSelectionData $!s;

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
  method gtk_selection_data_pixbuf is rw is also<gtk-selection-data-pixbuf> {
    Proxy.new(
      FETCH => sub ($) {
        gtk_selection_data_get_pixbuf($!s);
      },
      STORE => sub ($, GdkPixbuf $pixbuf is copy) {
        gtk_selection_data_set_pixbuf($!s, $pixbuf);
      }
    );
  }

  method gtk_selection_data_uris is rw is also<gtk-selection-data-uris> {
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
  ) is also<add-target> {
    my guint $i = self.RESOLVE-UINT($info);
    gtk_selection_add_target($widget, $selection, $target, $i);
  }

  method add_targets (
    GtkWidget() $widget,
    GdkAtom $selection,
    GtkTargetEntry() $targets,
    Int() $ntargets
  ) is also<add-targets> {
    my guint $nt = self.RESOLVE-UINT($ntargets);
    gtk_selection_add_targets($widget, $selection, $targets, $nt);
  }

  method clear_targets (GtkWidget() $widget, GdkAtom $selection) is also<clear-targets> {
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

  method owner_set (GtkWidget() $widget, GdkAtom $selection, Int() $time) is also<owner-set> {
    my guint32 $t = self.RESOLVE-UINT($time);
    gtk_selection_owner_set($widget, $selection, $t);
  }

  multi method owner_set_for_display (
    GtkWidget() $widget,
    GdkAtom $selection,
    Int() $time
  ) is also<owner-set-for-display> {
    my guint32 $t = self.RESOLVE-UINT($time);
    gtk_selection_owner_set_for_display($widget, $selection, $t);
  }

  method remove_all(GtkWidget() $widget) is also<remove-all> {
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

  method get_data is also<get-data> {
    gtk_selection_data_get_data($!s);
  }

  method get_data_with_length (Int() $length) is also<get-data-with-length> {
    my guint $l = self.RESOLVE-INT($length);
    gtk_selection_data_get_data_with_length($!s, $l);
  }

  method get_data_type is also<get-data-type> {
    gtk_selection_data_get_data_type($!s);
  }

  method get_display is also<get-display> {
    gtk_selection_data_get_display($!s);
  }

  method get_format is also<get-format> {
    gtk_selection_data_get_format($!s);
  }

  method get_length is also<get-length> {
    gtk_selection_data_get_length($!s);
  }

  method get_selection is also<get-selection> {
    gtk_selection_data_get_selection($!s);
  }

  method get_target is also<get-target> {
    gtk_selection_data_get_target($!s);
  }

  method get_targets (GdkAtom $targets, Int() $n_atoms) is also<get-targets> {
    my gint $na = self.RESOLVE-INT($n_atoms);
    gtk_selection_data_get_targets($!s, $targets, $na);
  }

  method get_text is also<get-text> {
    gtk_selection_data_get_text($!s);
  }

  method set (GdkAtom $type, Int() $format, guchar $data, Int() $length) {
    my @i = ($format, $length);
    my gint ($f, $l) = self.RESOLVE-INT(@i);
    gtk_selection_data_set($!s, $type, $format, $data, $length);
  }

  method set_text (gchar $str, Int() $len) is also<set-text> {
    my gint $l = self.RESOLVE-INT($len);
    gtk_selection_data_set_text($!s, $str, $len);
  }

  method targets_include_image (Int() $writeable) is also<targets-include-image> {
    my gboolean $w = self.RESOLVE-BOOL($writeable);
    gtk_selection_data_targets_include_image($!s, $w);
  }

  multi method targets_include_rich_text (GtkTextBuffer() $buffer) is also<targets-include-rich-text> {
    gtk_selection_data_targets_include_rich_text($!s, $buffer);
  }

  method targets_include_text is also<targets-include-text> {
    gtk_selection_data_targets_include_text($!s);
  }

  method targets_include_uri is also<targets-include-uri> {
    gtk_selection_data_targets_include_uri($!s);
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}

