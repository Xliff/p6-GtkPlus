use v6.c;

use Method::Also;
use NativeCall;


use GTK::Raw::Editable:ver<3.0.1146>;
use GTK::Raw::Types:ver<3.0.1146>;

use GTK::Roles::Signals::Generic:ver<3.0.1146>;
use GTK::Roles::Signals::Editable:ver<3.0.1146>;
use GTK::Roles::Types:ver<3.0.1146>;

role GTK::Roles::Editable:ver<3.0.1146> {
  also does GTK::Roles::Signals::Generic;
  also does GTK::Roles::Signals::Editable;
  also does GTK::Roles::Types;

  has GtkEditable $!er;

  # ↓↓↓↓ SIGNALS ↓↓↓↓

  # Is originally:
  # GtkEditable, gpointer --> void
  method changed {
    self.connect($!er, 'changed');
  }

  # Is originally:
  # GtkEditable, gint, gint, gpointer --> void
  method delete-text is also<delete_text> {
    self.connect($!er, 'delete-text');
  }

  # Is originally:
  # GtkEditable, gchar, gint, gpointer, gpointer --> void
  method insert-text is also<insert_text> {
    self.connect($!er, 'insert-text');
  }

  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  method editable is rw {
    Proxy.new(
      FETCH => sub ($) {
        so gtk_editable_get_editable($!er);
      },
      STORE => sub ($, $is_editable is copy) {
        my gboolean $i = self.RESOLVE-BOOL($is_editable);
        gtk_editable_set_editable($!er, $i);
      }
    );
  }

  method position is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_editable_get_position($!er);
      },
      STORE => sub ($, Int() $position is copy) {
        my gint $p = self.RESOLVE-INT($position);
        gtk_editable_set_position($!er, $p);
      }
    );
  }
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  method copy_clipboard is also<copy-clipboard> {
    gtk_editable_copy_clipboard($!er);
  }

  method cut_clipboard is also<cut-clipboard> {
    gtk_editable_cut_clipboard($!er);
  }

  method delete_selection is also<delete-selection> {
    gtk_editable_delete_selection($!er);
  }

  method delete_text_between (Int() $start_pos, Int() $end_pos)
    is also<delete-text-between>
  {
    my @u = ($start_pos, $end_pos);
    my gint ($sp, $ep) = self.RESOLVE-INT(@u);
    gtk_editable_delete_text($!er, $sp, $ep);
  }

  method get_chars (Int() $start_pos, Int() $end_pos) is also<get-chars> {
    my @i = ($start_pos, $end_pos);
    my gint ($sp, $ep) = self.RESOLVE-INT(@i);
    gtk_editable_get_chars($!er, $start_pos, $end_pos);
  }

  method get_selection_bounds (Int() $start_pos, Int() $end_pos)
    is also<get-selection-bounds>
  {
    my @i = ($start_pos, $end_pos);
    my gint ($sp, $ep) = self.RESOLVE-INT(@i);
    gtk_editable_get_selection_bounds($!er, $start_pos, $end_pos);
  }

  method get_editable_type () is also<get-editable-type> {
    gtk_editable_get_type();
  }

  method insert_text_at (
    Str() $new_text,
    gint $new_text_length,
    gint $position)
  is
    also<insert-text-at>
  {
    my @i = ($new_text_length, $position);
    my gint ($n, $p) = self.RESOLVE-INT(@i);
    gtk_editable_insert_text($!er, $new_text, $n, $p);
  }

  method paste_clipboard is also<paste-clipboard> {
    gtk_editable_paste_clipboard($!er);
  }

  method select_region (Int() $start_pos, Int() $end_pos)
    is also<select-region>
  {
    my @i = ($start_pos, $end_pos);
    my gint ($sp, $ep) = self.RESOLVE-INT(@i);
    gtk_editable_select_region($!er, $sp, $ep);
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
