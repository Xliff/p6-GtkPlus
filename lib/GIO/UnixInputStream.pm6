use v6.c;

use Method::Also;

use GTK::Compat::Types;
use GIO::Raw::UnixInputStream;

use GIO::InputStream;

use GIO::Roles::FileDescriptorBased;
use GIO::Roles::PollableInputStream;

our subset UnixInputStreamAncestry is export of Mu
  where GUnixInputStream | GFileDescriptorBased | GPollableInputStream |
        GInputStream;

class GIO::UnixInputStream is GIO::InputStream {
  also does GIO::Roles::FileDescriptorBased;
  also does GIO::Roles::PollableInputStream;

  has GUnixInputStream $!uis;

  submethod BUILD (:$unix-stream) {
    given $unix-stream {
      when UnixInputStreamAncestry {
        self.setUnixInputStream($unix-stream);
      }

      when GIO::UnixInputStream {
      }

      default {
      }
    }
  }

  method setUnixInputStream (UnixInputStreamAncestry $_) {
    my $to-parent;

    $!uis = do {
      when GUnixInputStream {
        $to-parent = cast(GInputStream, $_);
        $_;
      }

      when GFileDescriptorBased {
        $to-parent = cast(GInputStream, $_);
        $!fdb = $_;
        cast(GUnixInputStream, $_);
      }

      when GPollableInputStream {
        $to-parent = cast(GInputStream, $_);
        $!pis = $_;
        cast(GUnixInputStream, $_);
      }

      default {
        $to-parent = $_;
        cast(GUnixInputStream, $_);
      }
    }
    self.roleInit-FileDescriptorBased  unless $!fdb;
    self.roleInit-GPollableInputStream unless $!pis;
    self.setInputStream($to-parent);
  }

  method new (Int() $fd, Int() $close_fd) {
    my gint $f = $fd;
    my gboolean $cfd = $close_fd;

    self.bless( unix-stream =>  g_unix_input_stream_new($f, $cfd) );
  }

  method GTK::Compat::Types::GUnixInputStream
    is also<GUnixInputStream>
  { $!uis }

  method get_fd is also<get-fd> {
    g_unix_input_stream_get_fd($!uis);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &g_unix_input_stream_get_type, $n, $t );
  }

}
