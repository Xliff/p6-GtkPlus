use v6.c;

use NativeCall;

use GTK::Raw::Types;
use GTK::Raw::Subs;

role GTK::Roles::Signals {
  has %!signals;

  # Signal handling code thank to jnthn
  #
  # Need another method that does a proper return value for signals like
  #
  # GTK::Scale.format-value
  method connect(
    $obj,
    $signal,
    &handler?
  ) {
    my $hid;
    %!signals{$signal} //= do {
      my $s = Supplier.new;
      #"O: $obj".say;
      #"S: $signal".say;
      $hid = g_signal_connect_wd($obj, $signal,
        -> $, $ {
            $s.emit(self);
            CATCH { default { note $_; } }
        },
        OpaquePointer, 0
      );
      [ $s.Supply, $obj, $hid];
    };
    %!signals{$signal}[0].tap(&handler) with &handler;
    %!signals{$signal}[0];
  }

  # Has this supply been created yet? If True, this is a good indication that
  # that signal $name has been tapped.
  method is-connected(Str $name) {
    %!signals{$name}:exists;
  }

  # If I cannot share attributes between roles, then each one will have
  # to have its own signature, or clean-up routine.
  method disconnect_all {
    self.disconnect($_) for %!signals.keys;
  }

  method disconnect($signal, %signals) {
    # First parameter is good, but concerned about the second.
    g_signal_handler_disconnect(%signals{$signal}[1], %signals{$signal}[2]);
  }

}
