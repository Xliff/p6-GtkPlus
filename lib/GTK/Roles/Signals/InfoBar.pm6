use v6.c;

use NativeCall;

use GTK::Raw::Types;
use GTK::Raw::Subs;

use GTK::Roles::Signals;

role GTK::Roles::Signals::Infobar {

  class ResponseSignal {
    has $!s;
    has $!o;

    method new($o, $s;) {
      self.bless(:$!o, $!s);
    }

    submethod DESTROY {
      self.free;
    }

    method tap( &handler(GtkInfoBar, gint, gpointer) ) {
      if %!signals{$!s}:exists {
        warn "Response signal for GTK::Infobar was already connected";
        self.free;
      }
      my $sid = g_connect_response($!o, $!s, &handler, OpaquePointer, 0)
      %!signals{$!s} = [ self, $sid ];
    }

    method free {
      g_signal_handler_disconnect($!o, $_[1]) with %!signals{$!s};
    }
  }

  method connect-response(
    $obj,
    &handler?
  ) {
    %!signals{'response'} //= do {
      ResponseSignal.new($obj, 'response')
    };
    %!signals{'response'}[0].tap(&handler) with &handler;
    %!signals{'response'}[0];
  }

  sub g_connect_response(
    OpaquePointer $app,
    Str $name,
    &handler (GtkInfoBar, gint, gpointer)
    OpaquePointer $data,
    uint32 $connect_flags
  )
    returns uint32
    is native('gobject-2.0')
    is symbol('g_signal_connect_object')
    is export
    { * }


}
