use v6.c;

use Method::Also;

use NativeCall;

use GTK::Compat::Types;
use GIO::Raw::UnixConnection;

use GIO::SocketConnection;

our subset UnixConnectionAncestry is export of Mu
  where GUnixConnection | SocketConnectionAncestry;

class GIO::UnixConnection is GIO::SocketConnection {
  has GUnixConnection $!uc;

  submethod BUILD (:$unix-connection) {
    given $unix-connection {
      when UnixConnectionAncestry {
        self.setUnixConnection($unix-connection);
      }

      when GIO::UnixConnection {
      }

      default {
      }
    }
  }

  method setUnixConnection (UnixConnectionAncestry $_) {
    my $to-parent;

    $!uc = do {
      when GUnixConnection {
        $to-parent = cast(GSocketConnection, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GUnixConnection, $_);
      }
    };
    self.setSocketConnection($to-parent);
  }

  method GTK::Compat::Types::GUnixConnection
    is also<GUnixConnection>
  { $!uc }

  method new (UnixConnectionAncestry $unix-connection) {
    self.bless( :$unix-connection );
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &g_unix_connection_get_type, $n, $t );
  }

  method receive_credentials (
    GCancellable $cancellable = GCancellable,
    CArray[Pointer[GError]] $error = gerror,
    :$raw = False
  )
    is also<receive-credentials>
  {
    clear_error;
    my $rv = g_unix_connection_receive_credentials($!uc, $cancellable, $error);
    set_error($error);

    $rv ??
      ( $raw ?? $rv !! GIO::Credentials.new($rv) )
      !!
      Nil;
  }

  method receive_credentials_async (
    GCancellable $cancellable,
    GAsyncReadyCallback $callback,
    gpointer $user_data = gpointer
  )
    is also<receive-credentials-async>
  {
    g_unix_connection_receive_credentials_async(
      $!uc,
      $cancellable,
      $callback,
      $user_data
    );
  }

  method receive_credentials_finish (
    GAsyncResult() $result,
    CArray[Pointer[GError]] $error = gerror,
    :$raw = False
  )
    is also<receive-credentials-finish>
  {
    clear_error;
    my $rv =
      g_unix_connection_receive_credentials_finish($!uc, $result, $error);
    set_error($error);

    $rv ??
      ( $raw ?? $rv !! GIO::Credentials.new($rv) )
      !!
      Nil;
  }

  method receive_fd (
    GCancellable $cancellable = GCancellable,
    CArray[Pointer[GError]] $error = gerror
  )
    is also<receive-fd>
  {
    clear_error;
    my $rv = g_unix_connection_receive_fd($!uc, $cancellable, $error);
    set_error($error);
    $rv;
  }

  method send_credentials (
    GCancellable $cancellable = GCancellable,
    CArray[Pointer[GError]] $error = gerror
  )
    is also<send-credentials>
  {
    clear_error;
    my $rv = so g_unix_connection_send_credentials($!uc, $cancellable, $error);
    set_error($error);
    $rv;
  }

  method send_credentials_async (
    GCancellable $cancellable,
    GAsyncReadyCallback $callback,
    gpointer $user_data = gpointer
  )
    is also<send-credentials-async>
  {
    g_unix_connection_send_credentials_async(
      $!uc,
      $cancellable,
      $callback,
      $user_data
    );
  }

  method send_credentials_finish (
    GAsyncResult() $result,
    CArray[Pointer[GError]] $error = gerror
  )
    is also<send-credentials-finish>
  {
    clear_error;
    my $rv =
      so g_unix_connection_send_credentials_finish($!uc, $result, $error);
    set_error($error);
    $rv;
  }

  method send_fd (
    Int() $fd,
    GCancellable $cancellable = GCancellable,
    CArray[Pointer[GError]] $error = gerror
  )
    is also<send-fd>
  {
    my gint $f = $fd;

    clear_error;
    my $rv = so g_unix_connection_send_fd($!uc, $f, $cancellable, $error);
    set_error($error);
    $rv;
  }

}
