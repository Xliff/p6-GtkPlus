use v6.c;

use NativeCall;


use GTK::Raw::Types;
use GTK::Raw::Subs;

use GTK::Roles::Signals::Generic;

role GTK::Roles::Signals::TextBuffer {
  also does GTK::Roles::Signals::Generic;
  
  has %!signals-tb;

  # GtkTextBuffer, GtkTextTag, GtkTextIter, GtkTextIter, gpointer --> void
  method connect-tag (
    $obj,
    $signal,
    &handler?
  ) {
    my $hid;
    %!signals-tb{$signal} //= do {
      my $s = Supplier.new;
      $hid = g-connect-tag($obj, $signal,
        -> $, $tt, $ti1, $ti2, $ud {
          CATCH {
            default { note($_) }
          }

          $s.emit( [self, $tt, $ti1, $ti2, $ud] );
        },
        Pointer, 0
      );
      [ $s.Supply, $obj, $hid];
    };
    %!signals-tb{$signal}[0].tap(&handler) with &handler;
    %!signals-tb{$signal}[0];
  }

  # GtkTextBuffer, GtkTextIter, GtkTextIter, gpointer --> void
  method connect-delete-range (
    $obj,
    $signal = 'delete-range',
    &handler?
  ) {
    my $hid;
    %!signals-tb{$signal} //= do {
      my $s = Supplier.new;
      $hid = g-connect-delete-range($obj, $signal,
        -> $, $ti1, $ti2, $ud {
          CATCH {
            default { note($_) }
          }

          $s.emit( [self, $ti1, $ti2, $ud] );
        },
        Pointer, 0
      );
      [ $s.Supply, $obj, $hid];
    };
    %!signals-tb{$signal}[0].tap(&handler) with &handler;
    %!signals-tb{$signal}[0];
  }

  # GtkTextBuffer, GtkTextIter, GtkTextChildAnchor, gpointer --> void
  method connect-insert-child-anchor (
    $obj,
    $signal = 'insert-child-anchor',
    &handler?
  ) {
    my $hid;
    %!signals-tb{$signal} //= do {
      my $s = Supplier.new;
      $hid = g-connect-insert-child-anchor($obj, $signal,
        -> $, $ti, $ca, $ud {
          CATCH {
            default { note($_) }
          }

          $s.emit( [self, $ti, $ca, $ud] );
        },
        Pointer, 0
      );
      [ $s.Supply, $obj, $hid];
    };
    %!signals-tb{$signal}[0].tap(&handler) with &handler;
    %!signals-tb{$signal}[0];
  }

  # GtkTextBuffer, GtkTextIter, GdkPixbuf, gpointer --> void
  method connect-insert-pixbuf (
    $obj,
    $signal = 'insert-pixbuf',
    &handler?
  ) {
    my $hid;
    %!signals-tb{$signal} //= do {
      my $s = Supplier.new;
      $hid = g-connect-insert-pixbuf($obj, $signal,
        -> $, $ti, $pix, $ud {
          CATCH {
            default { note($_) }
          }

          $s.emit( [self, $ti, $pix, $ud] );
        },
        Pointer, 0
      );
      [ $s.Supply, $obj, $hid];
    };
    %!signals-tb{$signal}[0].tap(&handler) with &handler;
    %!signals-tb{$signal}[0];
  }

  # GtkTextBuffer, GtkTextIter, gchar, gint, gpointer --> void
  method connect-insert-text (
    $obj,
    $signal = 'insert-text',
    &handler?
  ) {
    my $hid;
    %!signals-tb{$signal} //= do {
      my $s = Supplier.new;
      $hid = g-connect-insert-text($obj, $signal,
        -> $, $ti, $str, $i, $ud {
          CATCH {
            default { note($_) }
          }

          $s.emit( [self, $ti, $str, $i, $ud] );
        },
        Pointer, 0
      );
      [ $s.Supply, $obj, $hid];
    };
    %!signals-tb{$signal}[0].tap(&handler) with &handler;
    %!signals-tb{$signal}[0];
  }

  # GtkTextBuffer, GtkTextMark, gpointer --> void
  method connect-mark-deleted (
    $obj,
    $signal = 'mark-deleted',
    &handler?
  ) {
    my $hid;
    %!signals-tb{$signal} //= do {
      my $s = Supplier.new;
      $hid = g-connect-mark-deleted($obj, $signal,
        -> $, $tm, $ud {
          CATCH {
            default { note($_) }
          }

          $s.emit( [self, $tm, $ud] );
        },
        Pointer, 0
      );
      [ $s.Supply, $obj, $hid];
    };
    %!signals-tb{$signal}[0].tap(&handler) with &handler;
    %!signals-tb{$signal}[0];
  }

  # GtkTextBuffer, GtkTextIter, GtkTextMark, gpointer --> void
  method connect-mark-set (
    $obj,
    $signal = 'mark-set',
    &handler?
  ) {
    my $hid;
    %!signals-tb{$signal} //= do {
      my $s = Supplier.new;
      $hid = g-connect-mark-set($obj, $signal,
        -> $, $ti, $tm, $ud {
          CATCH {
            default { note($_) }
          }

          $s.emit( [self, $ti, $tm, $ud] );
        },
        Pointer, 0
      );
      [ $s.Supply, $obj, $hid];
    };
    %!signals-tb{$signal}[0].tap(&handler) with &handler;
    %!signals-tb{$signal}[0];
  }

  # GtkTextBuffer, GtkClipboard, gpointer --> void
  method connect-paste-done (
    $obj,
    $signal = 'paste-done',
    &handler?
  ) {
    my $hid;
    %!signals-tb{$signal} //= do {
      my $s = Supplier.new;
      $hid = g-connect-paste-done($obj, $signal,
        -> $, $c, $ud {
          CATCH {
            default { note($_) }
          }

          $s.emit( [self, $c, $ud] );
        },
        Pointer, 0
      );
      [ $s.Supply, $obj, $hid];
    };
    %!signals-tb{$signal}[0].tap(&handler) with &handler;
    %!signals-tb{$signal}[0];
  }

}

# (GtkTextTag, GtkTextIter, GtkTextIter)
sub g-connect-tag(
  Pointer $app,
  Str $name,
  &handler (Pointer, GtkTextTag, GtkTextIter, GtkTextIter, Pointer),
  Pointer $data,
  uint32 $flags
)
  returns uint64
  is native('gobject-2.0')
  is symbol('g_signal_connect_object')
  { * }

# GtkTextBuffer, GtkTextIter, GtkTextIter, gpointer --> void
sub g-connect-delete-range(
  Pointer $app,
  Str $name,
  &handler (Pointer, GtkTextIter, GtkTextIter, Pointer),
  Pointer $data,
  uint32 $flags
)
  returns uint64
  is native('gobject-2.0')
  is symbol('g_signal_connect_object')
  { * }

# GtkTextBuffer, GtkTextIter, GtkTextChildAnchor, gpointer --> void
sub g-connect-insert-child-anchor (
  Pointer $app,
  Str $name,
  &handler (Pointer, GtkTextIter, GtkTextChildAnchor, Pointer),
  Pointer $data,
  uint32 $flags
)
  returns uint64
  is native('gobject-2.0')
  is symbol('g_signal_connect_object')
  { * }

# GtkTextBuffer, GtkTextIter, GdkPixbuf, gpointer --> void
sub g-connect-insert-pixbuf (
  Pointer $app,
  Str $name,
  &handler (Pointer, GtkTextIter, GdkPixbuf, Pointer),
  Pointer $data,
  uint32 $flags
)
  returns uint64
  is native('gobject-2.0')
  is symbol('g_signal_connect_object')
  { * }

# GtkTextBuffer, GtkTextIter, gchar, gint, gpointer --> void
sub g-connect-insert-text (
  Pointer $app,
  Str $name,
  &handler (Pointer, GtkTextIter, gchar, gint, Pointer),
  Pointer $data,
  uint32 $flags
)
  returns uint64
  is native('gobject-2.0')
  is symbol('g_signal_connect_object')
  { * }

# GtkTextBuffer, GtkTextMark, gpointer --> void
sub g-connect-mark-deleted (
  Pointer $app,
  Str $name,
  &handler (Pointer, GtkTextMark, Pointer),
  Pointer $data,
  uint32 $flags
)
  returns uint64
  is native('gobject-2.0')
  is symbol('g_signal_connect_object')
  { * }

# GtkTextBuffer, GtkTextIter, GtkTextMark, gpointer --> void
sub g-connect-mark-set (
  Pointer $app,
  Str $name,
  &handler (Pointer, GtkTextIter, GtkTextMark, Pointer),
  Pointer $data,
  uint32 $flags
)
  returns uint64
  is native('gobject-2.0')
  is symbol('g_signal_connect_object')
  { * }

# GtkTextBuffer, GtkClipboard, gpointer --> void
sub g-connect-paste-done (
  Pointer $app,
  Str $name,
  &handler (Pointer, GtkClipboard, Pointer),
  Pointer $data,
  uint32 $flags
)
  returns uint64
  is native('gobject-2.0')
  is symbol('g_signal_connect_object')
  { * }
