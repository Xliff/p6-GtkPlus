use v6.c;

use Method::Also;

use NativeCall;

use GLib::Raw::Types;

use GIO::SocketConnection;

our subset TcpConnectionAncestry is export of Mu
  where GTcpConnection | SocketConnectionAncestry;

class GIO::TcpConnection is GIO::SocketConnection {
  has GTcpConnection $!tc is implementor;

  submethod BUILD (:$tcp-connection) {
    given $tcp-connection {
      when TcpConnectionAncestry {
        self.setTcpConnection($tcp-connection);
      }

      when GIO::TcpConnection {
      }

      default {
      }
    }
  }

  method setTcpConnection (TcpConnectionAncestry $_) {
    my $to-parent;

    $!tc = do {
      when GTcpConnection {
        $to-parent = cast(GSocketConnection, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GTcpConnection, $_);
      }
    }
    self.setSocketConnection($to-parent);
  }

  method GLib::Raw::Types::GTcpConnection
    is also<GTcpConnection>
  { $!tc }

  method new (TcpConnectionAncestry $tcp-connection) {
    self.bless( :$tcp-connection );
  }

  method graceful_disconnect is rw is also<graceful-disconnect> {
    Proxy.new(
      FETCH => sub ($) {
        g_tcp_connection_get_graceful_disconnect($!tc);
      },
      STORE => sub ($, $graceful_disconnect is copy) {
        g_tcp_connection_set_graceful_disconnect($!tc, $graceful_disconnect);
      }
    );
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &g_tcp_connection_get_type, $n, $t );
  }

}

sub g_tcp_connection_get_type ()
  returns GType
  is native(gio)
  is export
{ * }

sub g_tcp_connection_get_graceful_disconnect (GTcpConnection $connection)
  returns uint32
  is native(gio)
  is export
{ * }

sub g_tcp_connection_set_graceful_disconnect (
  GTcpConnection $connection,
  gboolean $graceful_disconnect
)
  is native(gio)
  is export
{ * }
