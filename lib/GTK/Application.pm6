use v6.c;

use NativeCall;

use GTK::Class::Pointers;
use GTK::Class::Subs :DEFAULT, :app;

class GTK::Application {
  has GtkApplication $!gtk_app;
  has $!gac;
  has @!signals;

  has $!title;
  has $!width;
  has $!height;

  has $!activate_supply;
  has $!shutdown_supply;
  has $!startup_supply;

  has $!win;

  submethod BUILD(
    Str    :$title,
    uint32 :$flags = 0,
    uint32 :$width,
    uint32 :$height,
    Array  :$children
  ) {
    $!gtk_app = gtk_application_new($title, $flags);
    $!title = $title;
    $!width = $width;
    $!height = $height;
    #gtk_init(Pointer, Nil);
  }

  method p {
    nativecast(OpaquePointer, $!gtk_app);
  }

  method app {
    $!gtk_app;
  }

  method title {
    $!title;
  }

  method width {
    $!width;
  }

  method height {
    $!height;
  }

  method init(GTK::Application:U: Int $ac, @av) {
    my int32 $argc = $ac;
    my CArray[Str] $argv = CArray[Str].new;

    my $i = 0;
    $argv[$i++] = $_ for @av;

    gtk_init($argc, $argv);
  }

  method new(
    Str :$title,
    Int :$flags = 0,
    Int :$width = 200,
    Int :$height = 200
  ) {
    my uint32 $f = $flags;
    my uint32 $w = $width;
    my uint32 $h = $height;

    die "Application must have a title."
      unless $title;

    self.bless(
      :$title,
      :flags($f),
      :width($w),
      :height($h)
    );
  }

  method run {
    #gtk_main();
    g_application_run(self.p, Pointer[uint32], CArray[Str]);
  }

  method exit {
    gtk_main_quit();
  }

  method activate {
    say "A: " ~ self.p.gist;

    $!activate_supply //= do {
        my $s = Supplier.new;
            @!signals.push: g_signal_connect(self.p, "activate",
                -> $, $ {
                  $s.emit(self);
                  CATCH { default { note $_; } }
                },
                OpaquePointer);
        $s.Supply;
    }
  }

  method startup {
    $!startup_supply //= do {
        my $s = Supplier.new;
        @!signals.push: g_signal_connect_object(self.p, "startup",
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
        @!signals.push: g_signal_connect_object(self.p, "shutdown",
            -> $, $ {
                $s.emit(self);
                CATCH { default { note $_; } }
            },
            OpaquePointer, 0);
        $s.Supply;
    }
  }

  submethod DESTROY {
    for @!signals {
      g_signal_handler_disconnect(self.p, $_) if $_;
    }
    g_object_unref($!gtk_app.p);
  }

}
