use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::Types;
use GTK::Raw::Subs;

class FormatValueHandler {
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
      warn "{ $!s.tc } signal for GTK::Scale was already connected";
      self.free;
    }
    my $sid = g_connect_format_value($!o, $!s, &handler, OpaquePointer, 0);
    %!sig{$!s} = [ self, $sid ];
  }

  method free {
    g_signal_handler_disconnect($!o, $_[1]) with %!sig{$!s};
  }
}

role GTK::Roles::Signals::Scale {
  has %!signals;

  method connect-format-value(
    $obj,
    &handler?
  ) {
    my $r = FormatValueHandler.new($obj, 'format-value', %!signals);
    $r.tap(&handler) with &handler;
    $r;
  }
}

sub g_connect_format_value(
  Pointer $app,
  Str $name,
  &handler (Pointer, gdouble, Pointer --> Str),
  Pointer $data,
  uint32 $flags
)
  returns uint32
  is native('gobject-2.0')
  is symbol('g_signal_connect_object')
  is export
  { * }
