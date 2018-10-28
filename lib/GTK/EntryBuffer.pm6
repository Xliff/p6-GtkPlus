use v6.c;

use GTK::Compat::Value;
use GTK::Compat::Types;
use GTK::Raw::EntryBuffer;
use GTK::Raw::Types;

use GTK::Roles::Signals::EntryBuffer;
use GTK::Roles::Signals::Generic;

class GTK::EntryBuffer {
  also does GTK::Roles::Signals::EntryBuffer;
  also does GTK::Roles::Signals::Generic;

  has GtkEntryBuffer $!b;

  submethod BUILD (:$buffer) {
    $!b = $buffer;
  }

  submethod DESTROY {
    self.disconnect-all($_) for %!signals, %!signals-eb;
  }

  method new (Str $text, Int() $text_len) {
    # Move resolve functions to utilities package.
    my gint $tl = ($text_len.abs +& 0x7fff) * ($text_len < 0 ?? -1 !! 1);
    my $buffer = gtk_entry_buffer_new($text, $tl);
    self.bless(:$buffer);
  }

  method buffer {
    $!b;
  }

  # ↓↓↓↓ SIGNALS ↓↓↓↓
  method deleted-text {
    self.connect-movement-step($!b, 'deleted-text');
  }

  method inserted-text {
    self.connect-inserted-textt($!b);
  }
  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  method max_length is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_entry_buffer_get_max_length($!b);
      },
      STORE => sub ($, Int() $max_length is copy) {
        my guint $m = self.RESOLVE-INT($max_length);
        gtk_entry_buffer_set_max_length($!b, $m);
      }
    );
  }

  method text is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_entry_buffer_get_text($!b);
      },
      STORE => sub ($, Str() $text is copy) {
        gtk_entry_buffer_set_text($!b, $text, $text.chars);
      }
    );
  }
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # Type: guint
  method length is rw {
    my GTK::Compat::Value $gv .= new( G_TYPE_UINT );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new( self.prop_get($!b, 'length', $gv); );
        $gv.uint;
      },
      STORE => -> $, $val is copy {
        warn "length does not allow writing"
      }
    );
  }

  method delete_text (Int() $position, Int() $n_chars) {
    my guint $p = self.RESOLVE-UINT($position);
    my gint $nc = self.RESOLVE-INT($n_chars);
    gtk_entry_buffer_delete_text($!b, $p, $nc);
  }

  method emit_deleted_text (Int() $position, Int() $n_chars) {
    my guint $p = self.RESOLVE-UINT($position);
    my gint $nc = self.RESOLVE-INT($n_chars);
    gtk_entry_buffer_emit_deleted_text($!b, $p, $nc);
  }

  method emit_inserted_text (Int() $position, Str() $chars, Int() $n_chars) {
    my guint $p = self.RESOLVE-UINT($position);
    my gint $nc = self.RESOLVE-INT($n_chars);
    gtk_entry_buffer_emit_inserted_text($!b, $p, $chars, $nc);
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

  method insert_text (guint $position, Str() $chars, Int() $n_chars) {
    my guint $p = self.RESOLVE-UINT($position);
    my gint $nc = self.RESOLVE-INT($n_chars);
    gtk_entry_buffer_insert_text($!b, $p, $chars, $nc);
  }

  method set_text (Str() $chars, Int() $n_chars) {
    my gint $nc = self.RESOLVE-INT($n_chars);
    gtk_entry_buffer_set_text($!b, $chars, $nc);
  }

}
