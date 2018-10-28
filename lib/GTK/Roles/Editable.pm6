use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::Editable;
use GTK::Raw::Types;

use GTK::Roles::Signals::Generic;
use GTK::Roles::Signals::Editable;
use GTK::Roles::Types;

role GTK::Roles::Editable {
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
  method delete-text {
    self.connect($!er, 'delete-text');
  }

  # Is originally:
  # GtkEditable, gchar, gint, gpointer, gpointer --> void
  method insert-text {
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
  method copy_clipboard {
    gtk_editable_copy_clipboard($!er);
  }

  method cut_clipboard {
    gtk_editable_cut_clipboard($!er);
  }

  method delete_selection {
    gtk_editable_delete_selection($!er);
  }

  method delete_text (Int() $start_pos, Int() $end_pos) {
    my @u = ($start_pos, $end_pos);
    my gint ($sp, $ep) = self.RESOLVE-INT(@u);
    gtk_editable_delete_text($!er, $sp, $ep);
  }

  method get_chars (Int() $start_pos, Int() $end_pos) {
    my @i = ($start_pos, $end_pos);
    my gint ($sp, $ep) = self.RESOLVE-INT(@i);
    gtk_editable_get_chars($!er, $start_pos, $end_pos);
  }

  method get_selection_bounds (Int() $start_pos, Int() $end_pos) {
    my @i = ($start_pos, $end_pos);
    my gint ($sp, $ep) = self.RESOLVE-INT(@i);
    gtk_editable_get_selection_bounds($!er, $start_pos, $end_pos);
  }

  method get_editable_type () {
    gtk_editable_get_type();
  }

  method insert_text (
    Str() $new_text,
    gint $new_text_length,
    gint $position)
  {
    my @i = ($new_text_length, $position);
    my gint ($n, $p) = self.RESOLVE-INT(@i);
    gtk_editable_insert_text($!er, $new_text, $n, $p);
  }

  method paste_clipboard {
    gtk_editable_paste_clipboard($!er);
  }

  method select_region (Int() $start_pos, Int() $end_pos) {
    my @i = ($start_pos, $end_pos);
    my gint ($sp, $ep) = self.RESOLVE-INT(@i);
    gtk_editable_select_region($!er, $sp, $ep);
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
