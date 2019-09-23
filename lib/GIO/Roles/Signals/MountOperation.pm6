use v6.c;

use NativeCall;

use GTK::Compat::Types;

role GIO::Roles::Signals::MountOperation {
  has %!signals-mo;

  # GMountOperation, Str, Str, Str, GAskPasswordFlags, gpointer
  method connect-ask-password (
    $obj,
    $signal = 'ask-password',
    &handler?
  ) {
    my $hid;
    %!signals-mo{$signal} //= do {
      my $s = Supplier.new;
      $hid = g-connect-ask-password($obj, $signal,
        -> $, $g1, $g2, $g3, $apf, $ud {
          CATCH {
            default { $s.note($_) }
          }

          $s.emit( [self, $g1, $g2, $g3, $apf, $ud ] );
        },
        Pointer, 0
      );
      [ $s.Supply, $obj, $hid ];
    };
    %!signals-mo{$signal}[0].tap(&handler) with &handler;
    %!signals-mo{$signal}[0];
  }

  # GMountOperation, Str, GStrv, gpointer
  method connect-ask-question (
    $obj,
    $signal = 'ask-question',
    &handler?
  ) {
    my $hid;
    %!signals-mo{$signal} //= do {
      my $s = Supplier.new;
      $hid = g-connect-ask-question($obj, $signal,
        -> $, $g, $s, $ud {
          CATCH {
            default { $s.note($_) }
          }

          $s.emit( [self, $g, $s, $ud ] );
        },
        Pointer, 0
      );
      [ $s.Supply, $obj, $hid ];
    };
    %!signals-mo{$signal}[0].tap(&handler) with &handler;
    %!signals-mo{$signal}[0];
  }

  # GMountOperation, GMountOperationResult, gpointer
  method connect-reply (
    $obj,
    $signal = 'reply',
    &handler?
  ) {
    my $hid;
    %!signals-mo{$signal} //= do {
      my $s = Supplier.new;
      $hid = g-connect-reply($obj, $signal,
        -> $, $mor, $ud {
          CATCH {
            default { $s.note($_) }
          }

          $s.emit( [self, $mor, $ud ] );
        },
        Pointer, 0
      );
      [ $s.Supply, $obj, $hid ];
    };
    %!signals-mo{$signal}[0].tap(&handler) with &handler;
    %!signals-mo{$signal}[0];
  }

  # GMountOperation, Str, GArray, GStrv, gpointer
  method connect-show-processes (
    $obj,
    $signal = 'show-processes',
    &handler?
  ) {
    my $hid;
    %!signals-mo{$signal} //= do {
      my $s = Supplier.new;
      $hid = g-connect-show-processes($obj, $signal,
        -> $, $s, $a, $gsv, $ud {
          CATCH {
            default { $s.note($_) }
          }

          $s.emit( [self, $s, $a, $gsv, $ud ] );
        },
        Pointer, 0
      );
      [ $s.Supply, $obj, $hid ];
    };
    %!signals-mo{$signal}[0].tap(&handler) with &handler;
    %!signals-mo{$signal}[0];
  }

  # GMountOperation, Str, gint64, gint64, gpointer
  method connect-show-unmount-progress (
    $obj,
    $signal = 'show-unmount-progress',
    &handler?
  ) {
    my $hid;
    %!signals-mo{$signal} //= do {
      my $s = Supplier.new;
      $hid = g-connect-show-unmount-progress($obj, $signal,
        -> $, $g1, $g2, $g3, $ud {
          CATCH {
            default { $s.note($_) }
          }

          $s.emit( [self, $g1, $g2, $g3, $ud ] );
        },
        Pointer, 0
      );
      [ $s.Supply, $obj, $hid ];
    };
    %!signals-mo{$signal}[0].tap(&handler) with &handler;
    %!signals-mo{$signal}[0];
  }

}

# GMountOperation, Str, Str, Str, GAskPasswordFlags, gpointer
sub g-connect-ask-password(
  Pointer $app,
  Str $name,
  &handler (Pointer, Str, Str, Str, GAskPasswordFlags, Pointer),
  Pointer $data,
  uint32 $flags
)
  returns uint64
  is native(gobject)
  is symbol('g_signal_connect_object')
{ * }

# GMountOperation, Str, GStrv, gpointer
sub g-connect-ask-question(
  Pointer $app,
  Str $name,
  &handler (Pointer, Str, GStrv, Pointer),
  Pointer $data,
  uint32 $flags
)
  returns uint64
  is native(gobject)
  is symbol('g_signal_connect_object')
{ * }

# GMountOperation, GMountOperationResult, gpointer
sub g-connect-reply(
  Pointer $app,
  Str $name,
  &handler (Pointer, GMountOperationResult, Pointer),
  Pointer $data,
  uint32 $flags
)
  returns uint64
  is native(gobject)
  is symbol('g_signal_connect_object')
{ * }

# GMountOperation, Str, GArray, GStrv, gpointer
sub g-connect-show-processes(
  Pointer $app,
  Str $name,
  &handler (Pointer, Str, GArray, GStrv, Pointer),
  Pointer $data,
  uint32 $flags
)
  returns uint64
  is native(gobject)
  is symbol('g_signal_connect_object')
{ * }

# GMountOperation, Str, gint64, gint64, gpointer
sub g-connect-show-unmount-progress(
  Pointer $app,
  Str $name,
  &handler (Pointer, Str, gint64, gint64, Pointer),
  Pointer $data,
  uint32 $flags
)
  returns uint64
  is native(gobject)
  is symbol('g_signal_connect_object')
{ * }
