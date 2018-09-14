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
  method connect($obj, $signal) {
    %!signals{$signal} //= do {
      my $s = Supplier.new;
      g_signal_connect_wd($obj, $signal,
        -> $, $ {
            $s.emit(self);
            CATCH { default { note $_; } }
        },
        OpaquePointer, 0
      );
      [ $s.Supply, $obj ];
    };
    %!signals{$signal}[0];
  }

  # First draft of a generic handler that imitates the interface of what was
  # provided with GTK::Simple, but with the ability to provide a return
  # value, and to adapt to multiple signatures.
  method connect_handler($obj, $signal) {
    without %!signals{$signal} {
      my &gc := &g_signal_connect_handler;
      my %gd := &g_signal_handler_disconnect;
      my \op := OpaquePointer;
      my $s = class {
        has $!h;
        method getHandler       { $!h; }
        method tap (Routine $s) { gc($obj, $signal, $!h = $s, op, 0); }
        method disconnect       { gd($obk, $signal, $!h);             }
      }.new;

      %!signals{$signal} = [ $s, $obj ];
    }
    %!signals{$signal}[0];
  }

  method disconnect_all {
    self.disconnect($_) for %!signals.keys;
  }

  method disconnect($signal) {
    given %!signals{$signal} {
      when Supply {
        g_signal_handler_disconnect($_[1], $_[0]);
      }
      when .^name ~~ /^ '<anon' / {
        .disconnect;
      }
    }
    %!signals{$signal}:delete;
  }

}
