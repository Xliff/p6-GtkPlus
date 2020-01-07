use v6.c;

use NativeCall;


use GTK::Raw::Types;
use GTK::Raw::Subs;
use GTK::Raw::ReturnedValue;

role GTK::Roles::Signals::Editable {
  has %!signals-er;

  # GtkEditable, gint, gint, gpointer --> void
  method connect-delete-text (
    $obj,
    $signal = 'delete-text',
    &handler?
  ) {
    my $hid;
    %!signals-er{$signal} //= do {
      my $s = Supplier.new;
      $hid = g-connect-delete-text($obj, $signal,
        -> $, $i1, $i2, $ud {
          CATCH {
            default { note($_) }
          }

          $s.emit( [self, $i1, $i2, $ud] );
        },
        Pointer, 0
      );
      [ $s.Supply, $obj, $hid ];
    };
    %!signals-er{$signal}[0].tap(&handler) with &handler;
    %!signals-er{$signal}[0];
  }

  # GtkEditable, gchar, gint, CArray[Int], gpointer --> void
  #
  # Note, to set the value in the 4th parameter, you will have to do the
  # equivalent of $ptr-i[0]. ONLY access that first element, or you WILL
  # crash your code!
  method connect-insert-text (
    $obj,
    $signal = 'insert-text',
    &handler?
  ) {
    my $hid;
    %!signals-er{$signal} //= do {
      my $s = Supplier.new;
      $hid = g-connect-insert-text($obj, $signal,
        -> $, $str, $i, $ptr-i, $ud {
          CATCH {
            default { note($_) }
          }

          $s.emit( [self, $str, $i, $ptr-i, $ud] );
        },
        Pointer, 0
      );
      [ $s.Supply, $obj, $hid ];
    };
    %!signals-er{$signal}[0].tap(&handler) with &handler;
    %!signals-er{$signal}[0];
  }
}

# Define for each signal
sub g-connect-delete-text(
  Pointer $app,
  Str $name,
  &handler (Pointer, gint, gint, Pointer),
  Pointer $data,
  uint32 $flags
)
  returns uint64
  is native('gobject-2.0')
  is symbol('g_signal_connect_object')
  { * }

# GtkEditable, gchar, gint, CArray[Int], gpointer --> void
sub g-connect-insert-text(
  Pointer $app,
  Str $name,
  &handler (Pointer, gint, gint, CArray[guint], Pointer),
  Pointer $data,
  uint32 $flags
)
  returns uint64
  is native('gobject-2.0')
  is symbol('g_signal_connect_object')
  { * }
