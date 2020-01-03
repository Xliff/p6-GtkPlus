use v6.c;

use NativeCall;

use GLib::Raw::Types;

use GTK::Roles::Signals::Generic;

role GIO::Roles::Signals::ActionGroup {
  has %!signals-ag;

  # GActionGroup, gchar, gboolean, gpointer
  method connect-action-enabled-changed (
    $obj,
    $signal = 'action-enabled-changed',
    &handler?
  ) {
    my $hid;
    %!signals-ag{$signal} //= do {
      my $s = Supplier.new;
      $hid = g-connect-action-enabled-changed($obj, $signal,
        -> $, $s, $b, $ud {
          CATCH {
            default { $s.note($_) }
          }

          $s.emit( [self, $s, $b, $ud ] );
        },
        Pointer, 0
      );
      [ $s.Supply, $obj, $hid ];
    };
    %!signals-ag{$signal}[0].tap(&handler) with &handler;
    %!signals-ag{$signal}[0];
  }

  # GActionGroup, gchar, GVariant, gpointer
  method connect-action-state-changed (
    $obj,
    $signal = 'action-state-changed',
    &handler?
  ) {
    my $hid;
    %!signals-ag{$signal} //= do {
      my $s = Supplier.new;
      $hid = g-connect-action-state-changed($obj, $signal,
        -> $, $s, $v, $ud {
          CATCH {
            default { $s.note($_) }
          }

          $s.emit( [self, $s, $v, $ud ] );
        },
        Pointer, 0
      );
      [ $s.Supply, $obj, $hid ];
    };
    %!signals-ag{$signal}[0].tap(&handler) with &handler;
    %!signals-ag{$signal}[0];
  }

}

# GActionGroup, gchar, gboolean, gpointer
sub g-connect-action-enabled-changed(
  Pointer $app,
  Str $name,
  &handler (Pointer, gchar, gboolean, Pointer),
  Pointer $data,
  uint32 $flags
)
  returns uint64
  is native(gobject)
  is symbol('g_signal_connect_object')
{ * }

# GActionGroup, gchar, GVariant, gpointer
sub g-connect-action-state-changed(
  Pointer $app,
  Str $name,
  &handler (Pointer, gchar, GVariant, Pointer),
  Pointer $data,
  uint32 $flags
)
  returns uint64
  is native(gobject)
  is symbol('g_signal_connect_object')
{ * }
