use v6.c;

use Method::Also;

use GTK::Compat::Types;
use GIO::Raw::UnixOutputStream;

use GIO::OutputStream;

use GIO::Roles::FileDescriptorBased;
use GIO::Roles::PollableOutputStream;

our subset UnixOutputStreamAncestry is export of Mu
  where GUnixOutputStream | GFileDescriptorBased | GPollableOutputStream |
        GOutputStream;

class GIO::UnixOutputStream is GIO::OutputStream {
  also does GIO::Roles::FileDescriptorBased;
  also does GIO::Roles::PollableOutputStream;

  has GUnixOutputStream $!uos;

  submethod BUILD (:$unix-stream) {
    given $unix-stream {
      when UnixOutputStreamAncestry {
        self.setUnixOutputStream($unix-stream);
      }

      when GIO::UnixOutputStream {
      }

      default {
      }
    }
  }

  method setUnixOutputStream (UnixOutputStreamAncestry $_) {
    my $to-parent;

    $!uos = do {
      when GUnixOutputStream {
        $to-parent = cast(GOutputStream, $_);
        $_;
      }

      when GFileDescriptorBased {
        $to-parent = cast(GOutputStream, $_);
        $!fdb = $_;
        cast(GUnixOutputStream, $_);
      }

      when GPollableOutputStream {
        $to-parent = cast(GOutputStream, $_);
        $!pos = $_;
        cast(GUnixOutputStream, $_);
      }

      default {
        $to-parent = $_;
        cast(GUnixOutputStream, $_);
      }
    }
    self.roleInit-FileDescriptorBased  unless $!fdb;
    self.roleInit-GPollableOutputStream unless $!pos;
    self.setOutputStream($to-parent);
  }

  method new (Int() $fd, Int() $close_fd) {
    my gint $f = $fd;
    my gboolean $cfd = $close_fd;

    self.bless( unix-stream =>  g_unix_output_stream_new($f, $cfd) );
  }

  method GTK::Compat::Types::GUnixOutputStream
    is also<GUnixOutputStream>
  { $!uos }

  method close_fd is rw is also<close-fd> {
    Proxy.new(
      FETCH => sub ($) {
        g_unix_output_stream_get_close_fd($!uos);
      },
      STORE => sub ($, $close_fd is copy) {
        g_unix_output_stream_set_close_fd($!uos, $close_fd);
      }
    );
  }

  method get_fd is also<get-fd> {
    g_unix_output_stream_get_fd($!uos);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &g_unix_output_stream_get_type, $n, $t );
  }

}
