use v6.c;

use NativeCall;

use GTK::Raw::Types;
use GTK::Raw::Subs :DEFAULT, :app;

class GTK::Application {
  has %!signals;

  has GtkApplication $!gtk_app;
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

  method init(GTK::Application:U: Int $ac, Str @av) {
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

    die "Application must have a title." unless $title;

    self.bless(
      :$title,
      :flags($f),
      :width($w),
      :height($h)
    );
  }

  method run {
    #gtk_main();
    g_application_run($!app, Pointer[uint32], CArray[Str]);
  }

  method exit {
    gtk_main_quit();
  }

  method activate {
    connect("activate");
  }

  method startup {
    connect("startup");
  }

  method shutdown {
    connect("shutdown");
  }

}
