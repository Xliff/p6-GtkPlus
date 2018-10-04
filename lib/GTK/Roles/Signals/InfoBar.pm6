use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::Types;
use GTK::Raw::Subs;

class ResponseSignal {
  has $!s;
  has $!o;
  has %!sig;

  submethod BUILD(:$!o, :$!s, :$sig) {
    %!sig = %($sig);
  }

  method new($o, $s, $sig) {
    self.bless(:$o, :$s, :$sig);
  }

  submethod DESTROY {
    self.free;
  }

  method tap(&handler) {
    if %!sig{$!s}:exists {
      warn "Response signal for GTK::Infobar was already connected";
      self.free;
    }
    my $sid = g_connect_response($!o, $!s, &handler, OpaquePointer, 0);
    %!sig{$!s} = [ self, $sid ];
  }

  method free {
    g_signal_handler_disconnect($!o, $_[1]) with %!sig{$!s};
  }
}

role GTK::Roles::Signals::InfoBar {
  has %!signals;

  method connect-response(
    $obj,
    &handler?
  ) {
    my $r = ResponseSignal.new($obj, 'response', %!signals);
    $r.tap(&handler) with &handler;
    $r;
  }
}

sub g_connect_response(
  OpaquePointer $app,
  Str $name,
  &handler (Pointer, gint, Pointer),
  OpaquePointer $data,
  uint32 $connect_flags
)
  returns uint32
  is native('gobject-2.0')
  is symbol('g_signal_connect_object')
  { * }
