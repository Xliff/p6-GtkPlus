use v6.c;

use Method::Also;

use GLib::Raw::Types;
use GIO::Raw::SocketService;

use GIO::SocketListener;

use GIO::Roles::Signals::SocketService;

our subset SocketServiceAncestry is export of Mu
  where GSocketService | GSocketListener;

class GIO::SocketService is GIO::SocketListener {
  also does GIO::Roles::Signals::SocketService;

  has GSocketService $!ss is implementor;

  submethod BUILD (:$service) {
    given $service {
      when SocketServiceAncestry {
        self.setSocketService($service);
      }

      when GIO::SocketService {
      }

      default {
      }
    }
  }

  method setSocketService(SocketServiceAncestry $_) {
    my $to-parent;

    $!ss = do {
      when GSocketService {
        $to-parent = cast(GSocketListener, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GSocketService, $_);
      }
    };
    self.setSocketListener($to-parent);
  }

  method GLib::Raw::Types::GSocketService
    is also<GSocketService>
  { $!ss }

  multi method new (GSocketService $service) {
    self.bless( :$service );
  }
  multi method new {
    self.bless( service => g_socket_service_new() );
  }

  # Is originally:
  # GSocketService, GSocketConnection, GObject, gpointer --> gboolean
  method incoming {
    self.connect-incoming($!ss);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &g_socket_service_get_type, $n, $t );
  }

  method is_active is also<is-active> {
    so g_socket_service_is_active($!ss);
  }

  method start {
    g_socket_service_start($!ss);
  }

  method stop {
    g_socket_service_stop($!ss);
  }

}
