use v6.c;

use Method::Also;

use GTK::Compat::Value;
use GTK::Compat::Types;
use GTK::Raw::EntryBuffer;
use GTK::Raw::Types;

use GTK::Roles::Properties;
use GTK::Roles::Signals::EntryBuffer;
use GTK::Roles::Signals::Generic;

class GTK::EntryBuffer {
  also does GTK::Roles::Properties;
  also does GTK::Roles::Signals::EntryBuffer;
  also does GTK::Roles::Signals::Generic;

  has GtkEntryBuffer $!b;

  submethod BUILD (:$buffer) {
    self!setObject($!b = $buffer);
  }

  submethod DESTROY {
    self.disconnect-all($_) for %!signals, %!signals-eb;
  }
  
  method GTK::Raw::Types::GtkEntryBuffer 
    is also<EntryBuffer>
  { $!b }

  multi method new (GtkEntryBuffer $buffer) {
    self.bless(:$buffer);
  }
  multi method new (Str $text, Int() $text_len) {
    # Move resolve functions to utilities package.
    my gint $tl = ($text_len.abs +& 0x7fff) * ($text_len < 0 ?? -1 !! 1);
    my $buffer = gtk_entry_buffer_new($text, $tl);
    self.bless(:$buffer);
  }


  # ↓↓↓↓ SIGNALS ↓↓↓↓
  method deleted-text is also<deleted_text> {
    self.connect-movement-step($!b, 'deleted-text');
  }

  method inserted-text is also<inserted_text> {
    self.connect-inserted-textt($!b);
  }
  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  method max_length is rw is also<max-length> {
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
        self.prop_get('length', $gv);
        $gv.uint;
      },
      STORE => -> $, $val is copy {
        warn "length does not allow writing"
      }
    );
  }

  method delete_text (Int() $position, Int() $n_chars)
    is also<delete-text>
  {
    my guint $p = self.RESOLVE-UINT($position);
    my gint $nc = self.RESOLVE-INT($n_chars);
    gtk_entry_buffer_delete_text($!b, $p, $nc);
  }

  method emit_deleted_text (Int() $position, Int() $n_chars)
    is also<emit-deleted-text>
  {
    my guint $p = self.RESOLVE-UINT($position);
    my gint $nc = self.RESOLVE-INT($n_chars);
    gtk_entry_buffer_emit_deleted_text($!b, $p, $nc);
  }

  method emit_inserted_text (Int() $position, Str() $chars, Int() $n_chars)
    is also<emit-inserted-text>
  {
    my guint $p = self.RESOLVE-UINT($position);
    my gint $nc = self.RESOLVE-INT($n_chars);
    gtk_entry_buffer_emit_inserted_text($!b, $p, $chars, $nc);
  }

  method get_bytes is also<get-bytes> {
    gtk_entry_buffer_get_bytes($!b);
  }

  method get_length is also<get-length> {
    gtk_entry_buffer_get_length($!b);
  }

  method get_type is also<get-type> {
    gtk_entry_buffer_get_type();
  }

  method insert_text (guint $position, Str() $chars, Int() $n_chars)
    is also<insert-text>
  {
    my guint $p = self.RESOLVE-UINT($position);
    my gint $nc = self.RESOLVE-INT($n_chars);
    gtk_entry_buffer_insert_text($!b, $p, $chars, $nc);
  }

  method set_text (Str() $chars, Int() $n_chars) is also<set-text> {
    my gint $nc = self.RESOLVE-INT($n_chars);
    gtk_entry_buffer_set_text($!b, $chars, $nc);
  }

}
