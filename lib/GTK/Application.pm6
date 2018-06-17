use v6.c;

use NativeCall;

use GTK::Class::Subs :app;

class GTK::Application {
  has $!gtk_app;
  has $!gac;
  has @!signals;

  has $!shutdown_supply;
  has $!startup_supply;

  submethod BUILD(
    Str   :$title,
    uint32:$flags,
    Array :$children
  ) {
    $!gtk_app = gtk_application_new($title, $flags);
    # $!gac = <Create GTKApplicationClass object
    gtk_application_add_window($!gtk_app, $_) for $children;
  }

  method run {
    #self.show();
    gtk_main();
  }

  method exit {
    gtk_main_quit();
  }

  method startup {
    $!startup_supply //= do {
        my $s = Supplier.new;
        @!signals.push: g_signal_connect_object($!gtk_app, "startup",
            -> $, $ {
                $s.emit(self);
                CATCH { default { note $_; } }
            },
            OpaquePointer, 0);
        $s.Supply;
    }
  }

  method shutdown {
    $!shutdown_supply //= do {
        my $s = Supplier.new;
        @!signals.push: g_signal_connect_object($!gtk_app, "shutdown",
            -> $, $ {
                $s.emit(self);
                CATCH { default { note $_; } }
            },
            OpaquePointer, 0);
        $s.Supply;
    }
  }

  submethod DESTROY {
    g_signal_handler_disconnect($!gtk_app, $_) for @!signals;
  }

}
