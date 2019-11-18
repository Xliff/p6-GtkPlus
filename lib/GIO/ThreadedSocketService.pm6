use v6.c;

use NativeCall;
use Method::Also;

use GTK::Compat::Types;

use GIO::SocketService;

our subset ThreadedSocketServiceAncestry is export of Mu
  where GThreadedSocketService | SocketServiceAncestry;

class GIO::ThreadedSocketService is GIO::SocketService {
  has GThreadedSocketService $!tss is implementor;

  submethod BUILD (:$socket-service) {
    given $socket-service {
      when ThreadedSocketServiceAncestry {
        my $to-parent;

        $!tss = do {
          when GThreadedSocketService {
            $to-parent = cast(GSocketService, $_);
            $_;
          }

          default {
            $to-parent = $_;
            cast(GThreadedSocketService, $_);
          }
        }
        self.setSocketService($to-parent);
      }

      when GIO::ThreadedSocketService {
      }

      default {
      }
    }
  }

  method GTK::Compat::Types::GThreadedSocketService
    is also<GThreadedSocketService>
  { $!tss }

  method new (Int() $max) {
    my gint $m = $max;

    self.bless(
      socket-service => g_threaded_socket_service_new($max)
    );
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type(
      self.^name,
      &g_threaded_socket_service_get_type,
      $n,
      $t
    );
  }

}

sub g_threaded_socket_service_get_type ()
  returns GType
  is native(gio)
  is export
{ * }

sub g_threaded_socket_service_new (gint $max_threads)
  returns GThreadedSocketService
  is native(gio)
  is export
{ * }
