use v6.c;

use GTK::Compat::Types;
use GTK::Raw::EntryBuffer;
use GTK::Raw::Types;

use GTK::Roles::Signals;

class GTK::EntryBuffer {
  also does GTK::Roles::Signals;

  has $!b;

  submethod BUILD (:$buffer) {
    $!b = $buffer;
  }

  method new (Str $text, gint $text_len) {
    my $buffer = gtk_entry_buffer_new($text, $text_len);
    self.bless(:$buffer);
  }

  # ↓↓↓↓ SIGNALS ↓↓↓↓
  method deleted-text {
    self.connect($!b, 'deleted-text');
  }

  method inserted-text {
    self.connect($!b, 'inserted-text');
  }
  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  method max_length is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_entry_buffer_get_max_length($!b);
      },
      STORE => sub ($, $max_length is copy) {
        gtk_entry_buffer_set_max_length($!b, $max_length);
      }
    );
  }

  method text is rw {
    Proxy.new(
      FETCH => sub($) {
        gtk_entry_buffer_get_text($!b);
      },
      STORE => sub($, Str $text is copy) {
        gtk_entry_buffer_set_text($!b, $text, $text.chars);
      }
    );
  }
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  method delete_text (guint $position, gint $n_chars) {
    gtk_entry_buffer_delete_text($!b, $position, $n_chars);
  }

  method emit_deleted_text (guint $position, guint $n_chars) {
    gtk_entry_buffer_emit_deleted_text($!b, $position, $n_chars);
  }

  method emit_inserted_text (guint $position, gchar $chars, guint $n_chars) {
    gtk_entry_buffer_emit_inserted_text($!b, $position, $chars, $n_chars);
  }

  method get_bytes {
    gtk_entry_buffer_get_bytes($!b);
  }

  method get_length {
    gtk_entry_buffer_get_length($!b);
  }

  method get_type {
    gtk_entry_buffer_get_type();
  }

  method insert_text (guint $position, gchar $chars, gint $n_chars) {
    gtk_entry_buffer_insert_text($!b, $position, $chars, $n_chars);
  }

  method set_text (gchar $chars, gint $n_chars) {
    gtk_entry_buffer_set_text($!b, $chars, $n_chars);
  }

}
