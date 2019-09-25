use v6.c;

use Method::Also;

use NativeCall;

use GTK::Compat::Types;
use GIO::Raw::MemoryInputStream;

use GIO::InputStream;

use GIO::Roles::Seekable;
use GIO::Roles::PollableInputStream;

our subset MemoryInputStreamAncestry is export of Mu
  where GMemoryInputStream | GPollableInputStream | GSeekable | GInputStream;

class GIO::MemoryInputStream is GIO::InputStream {
  also does GIO::Roles::Seekable;
  also does GIO::Roles::PollableInputStream;

  has GMemoryInputStream $!mis;

  submethod BUILD (:$memory-stream) {
    given $memory-stream {
      when MemoryInputStreamAncestry {
        self.setMemoryInputStream($memory-stream);
      }

      when GIO::MemoryInputStream {
      }

      default {
      }
    }
  }

  method setMemoryInputStream (MemoryInputStreamAncestry $_) {
    my $to-parent;

    $!mis = do {
      when GMemoryInputStream {
        $to-parent = cast(GInputStream, $_);
        $_
      }

      when GSeekable {
        $to-parent = cast(GInputStream, $_);
        $!s = $_;
        cast(GMemoryInputStream, $_);
      }

      when GPollableInputStream {
        $to-parent = cast(GInputStream, $_);
        $!pis = $_;
        cast(GMemoryInputStream, $_);
      }

      default {
        $to-parent = $_;
        cast(GMemoryInputStream, $_)
      }
    }
    self.roleInit-Seekable            unless $!s;
    self.roleInit-PollableInputStream unless $!pis;
    self.setInputStream($to-parent);
  }

  method GTK::Compat::Types::GMemoryInputStream
    is also<GMemoryInputStream>
  { $!mis }

  multi method new (GMemoryInputStream $memory-stream) {
    self.bless( :$memory-stream );
  }
  multi method new {
    self.bless( memory-stream => g_memory_input_stream_new() );
  }

  method new_from_bytes (GBytes() $bytes) is also<new-from-bytes> {
    self.bless( memory-stream => g_memory_input_stream_new_from_bytes($bytes) );
  }

  method new_from_data (Str() $data, Int() $len, GDestroyNotify $destroy)
    is also<new-from-data>
  {
    my gssize $l = $len;

    self.bless(
      memory-stream => g_memory_input_stream_new_from_data($data, $l, $destroy)
    );
  }

  method add_bytes (GBytes() $bytes) is also<add-bytes> {
    g_memory_input_stream_add_bytes($!mis, $bytes);
  }

  method add_data (Pointer $data, Int() $len, GDestroyNotify $destroy)
    is also<add-data>
  {
    my gssize $l = $len;

    g_memory_input_stream_add_data($!mis, $data, $l, $destroy);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &g_memory_input_stream_get_type, $n, $t );
  }

}
