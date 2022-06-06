use v6.c;

use Method::Also;

use GTK::Raw::EntryBuffer:ver<3.0.1146>;
use GTK::Raw::Types:ver<3.0.1146>;

use GLib::Value;

use GLib::Roles::Properties;
use GTK::Roles::Signals::EntryBuffer:ver<3.0.1146>;
use GTK::Roles::Signals::Generic:ver<3.0.1146>;

class GTK::EntryBuffer:ver<3.0.1146> {
  also does GLib::Roles::Properties;
  also does GTK::Roles::Signals::EntryBuffer;
  also does GTK::Roles::Signals::Generic;

  has GtkEntryBuffer $!b is implementor;

  submethod BUILD (:$buffer) {
    self!setObject($!b = $buffer);
  }

  submethod DESTROY {
    self.disconnect-all($_) for %!signals, %!signals-eb;
  }

  method GTK::Raw::Definitions::GtkEntryBuffer
    is also<EntryBuffer>
  { $!b }

  multi method new (GtkEntryBuffer $buffer) {
    $buffer ?? self.bless(:$buffer) !! Nil;
  }
  multi method new (Str $text, Int() $text_len) {
    my gint $tl = $text_len;
    my $buffer = gtk_entry_buffer_new($text, $tl);

    $buffer ?? self.bless(:$buffer) !! Nil;
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
        my guint $m = $max_length;

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
    my GLib::Value $gv .= new( G_TYPE_UINT );
    Proxy.new(
      FETCH => sub ($) {
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
    my guint $p = $position;
    my gint $nc = $n_chars;

    gtk_entry_buffer_delete_text($!b, $p, $nc);
  }

  method emit_deleted_text (Int() $position, Int() $n_chars)
    is also<emit-deleted-text>
  {
    my guint $p = $position;
    my gint $nc = $n_chars;

    gtk_entry_buffer_emit_deleted_text($!b, $p, $nc);
  }

  method emit_inserted_text (Int() $position, Str() $chars, Int() $n_chars)
    is also<emit-inserted-text>
  {
    my guint $p = $position;
    my gint $nc = $n_chars;

    gtk_entry_buffer_emit_inserted_text($!b, $p, $chars, $nc);
  }

  method get_bytes is also<get-bytes> {
    gtk_entry_buffer_get_bytes($!b);
  }

  method get_length is also<get-length> {
    state ($n, $t);

    gtk_entry_buffer_get_length($!b);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gtk_entry_buffer_get_type, $n, $t );
  }

  method insert_text (guint $position, Str() $chars, Int() $n_chars)
    is also<insert-text>
  {
    my guint $p = $position;
    my gint $nc = $n_chars;

    gtk_entry_buffer_insert_text($!b, $p, $chars, $nc);
  }

  method set_text (Str() $chars, Int() $n_chars) is also<set-text> {
    my gint $nc = $n_chars;

    gtk_entry_buffer_set_text($!b, $chars, $nc);
  }

}
