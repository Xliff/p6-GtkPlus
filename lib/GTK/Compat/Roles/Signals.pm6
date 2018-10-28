use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::Subs;
use GTK::Raw::Types;
use GTK::Raw::ReturnedValue;

role GTK::Compat::Roles::Signals {
  has %!signals-compat;

  method connect-items-changed(
    $obj,
    $signal = 'items-changed',
    &handler?
  ) {
    my $hid;
    %!signals-compat{$signal} //= do {
      my $s = Supplier.new;
      $hid = g-connect-items-changed($obj, $signal,
        -> $, $i1, $i2, $i3, $ud  {
            CATCH { default { note($_) } }

            $s.emit( [self, $i1, $i2, $i3, $ud] );
        },
        Pointer, 0
      );
      [ $s.Supply, $obj, $hid ];
    };
    %!signals-compat{$signal}[0].tap(&handler) with &handler;
    %!signals-compat{$signal}[0];
  }

  # Has this supply been created yet? If True, this is a good indication that
  # that signal $name has been tapped.
  #
  # Must be overridden by all consumers that use another Signal-based role.
  method is-connected(Str $name) {
    %!signals-compat{$name}:exists;
  }

  # If I cannot share attributes between roles, then each one will have
  # to have its own signature, or clean-up routine.
  method disconnect-all (%sigs) {
    self.disconnect($_, %sigs) for %sigs.keys;
  }

  method disconnect($signal, %signals) {
    # First parameter is good, but concerned about the second.
    g_signal_handler_disconnect(%signals{$signal}[1], %signals{$signal}[2]);
    %signals{$signal}:delete;
  }

}

sub g-connect-items-changed(
  Pointer $app,
  Str $name,
  &handler (Pointer, gint, gint, gint, Pointer),
  Pointer $data,
  uint32 $connect_flags
)
  returns uint64
  is native('gobject-2.0')
  is symbol('g_signal_connect_object')
  { * }
