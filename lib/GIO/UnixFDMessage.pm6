use v6.c;

use Method::Also;

use NativeCall;

use GTK::Compat::Types;
use GIO::Raw::UnixFDMessage;

use GIO::SocketControlMessage;
use GIO::UnixFDList;

our subset UnixFDMessageAncestry is export of Mu
  where GUnixFDMessage | SocketControlMessageAncestry;

class GIO::UnixFDMessage is GIO::SocketControlMessage {
  has GUnixFDMessage $!fdm is implementor;

  submethod BUILD (:$fd-message) {
    given $fd-message {
      when UnixFDMessageAncestry {
        self.setFDMessage($fd-message);
      }

      when GIO::UnixFDMessage {
      }

      default {
      }
    }
  }

  method setFDMessage (UnixFDMessageAncestry $_) {
    my $to-parent;
    $!fdm = do {
      when GUnixFDMessage {
        $to-parent = cast(GSocketControlMessage, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GUnixFDMessage, $_);
      }
    }
    self.setSocketControlMessage($to-parent);
  }

  method GTK::Compat::Types::GUnixFDMessage
    is also<GUnixFDMessage>
  { $!fdm }

  multi method new (UnixFDMessageAncestry $fd-message) {
    self.bless( :$fd-message );
  }
  multi method new {
    self.bless( fd-message => g_unix_fd_message_new() );
  }

  method new_with_fd_list (GUnixFDList() $list) is also<new-with-fd-list> {
    self.bless( fd-message => g_unix_fd_message_new_with_fd_list($list) );
  }

  method append_fd (
    Int() $fd,
    CArray[Pointer[GError]] $error = gerror
  )
    is also<append-fd>
  {
    my gint $ffd = $fd;

    clear_error;
    my $rv = g_unix_fd_message_append_fd($!fdm, $fd, $error);
    set_error($error);
    $rv;
  }

  method get_fd_list (:$raw = False) is also<get-fd-list> {
    my $fds = g_unix_fd_message_get_fd_list($!fdm);

    $raw ?? $fds !! GIO::UnixFDList.new($fds);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &g_unix_fd_message_get_type, $n, $t );
  }

  method steal_fds ($length, :$raw = False) is also<steal-fds> {
    my gint ($l, $idx) = (0, 0);

    my $fds = g_unix_fd_message_steal_fds($!fdm, $l);
    return $fds if $raw;

    my @fds;
    @fds.push: $fds[$idx++] for ^$l;
  }

}
