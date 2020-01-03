use v6.c;

use Method::Also;

use NativeCall;

use GLib::Raw::Types;

use GIO::Stream;
use GIO::TcpConnection;

our subset TcpWrapperConnectionAncestry is export of Mu
  where GTcpWrapperConnection | TcpConnectionAncestry;

class GIO::TcpWrapperConnection is GIO::TcpConnection {
  has GTcpWrapperConnection $!twc is implementor;

  submethod BUILD (:$wrapper-connection) {
    given $wrapper-connection {
      when TcpWrapperConnectionAncestry {
        my $to-parent;

        $!twc = do {
          when GTcpWrapperConnection {
            $to-parent = cast(GTcpConnection, $_);
            $_;
          }

          default {
            $to-parent = $_;
            cast(GTcpWrapperConnection, $_);
          }
        }
        self.setTcpConnection($to-parent);
      }

      when GIO::TcpWrapperConnection {
      }

      default {
      }
    }
  }

  method GLib::Raw::Types::GTcpWrapperConnection
    is also<GTcpWrapperConnection>
  { $!twc }

  method new (GIOStream() $base_io_stream, GSocket() $socket) {
    g_tcp_wrapper_connection_new($base_io_stream, $socket);
  }

  method get_base_io_stream (:$raw = False) is also<get-base-io-stream> {
    my $ios = g_tcp_wrapper_connection_get_base_io_stream($!twc);

    $ios ??
      ( $raw ?? $ios !! GIO::Stream.new($ios) )
      !!
      Nil;
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &g_tcp_wrapper_connection_get_type, $n, $t );
  }

}

sub g_tcp_wrapper_connection_get_base_io_stream (GTcpWrapperConnection $conn)
  returns GIOStream
  is native(gio)
  is export
{ * }

sub g_tcp_wrapper_connection_get_type ()
  returns GType
  is native(gio)
  is export
{ * }

sub g_tcp_wrapper_connection_new (GIOStream $base_io_stream, GSocket $socket)
  returns GTcpWrapperConnection
  is native(gio)
  is export
{ * }
