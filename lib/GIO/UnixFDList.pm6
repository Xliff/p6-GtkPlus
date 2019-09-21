use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GIO::Raw::UnixFDList;

use GTK::Compat::Roles::Object;

class GIO::UnixFDList {
  also does GTK::Compat::Roles::Object;

  has GUnixFDList $!fd;

  submethod BUILD (:$!fd) {
    $!fd = $!fd;

    self.roleInit-Object;
  }

  multi method new (GUnixFDList $!fd) {
    self.bless( :$!fd );
  }
  multi method new {
    self.bless( list => g_unix_fd_list_new() );
  }

  proto method new_from_array (|)
  { * }

  multi method new_from_array(@fds) {
    my $fda = CArray[gint].new;
    my $cnt = 0;

    $fda[$cnt++] = $_ for @fds;
    samewith($fda, @fds.elems);
  }
  multi method new_from_array (CArray[gint] $fds, Int() $n_fds) {
    g_unix_fd_list_new_from_array($fds, $n_fds);
  }

  method append (
    Int() $fd,
    CArray[Pointer[GError]] $error = gerror
  ) {
    my gint $ffd = $fd;

    clear_error;
    my $rv = g_unix_fd_list_append($!fd, $ffd, $error);
    set_error($error);
    $rv;
  }

  method get (
    Int() $index,
    CArray[Pointer[GError]] $error = gerror
  ) {
    my gint $i = $index;

    clear_error;
    my $rv = g_unix_fd_list_get($!fd, $i, $error);
    set_error($error);
    $rv;
  }

  method get_length {
    g_unix_fd_list_get_length($!fd);
  }

  method get_type {
    state ($n, $t);

    unstable_get_type( self.^name, &g_unix_fd_list_get_type, $n, $t );
  }

  proto method peek_fds (|)
  { * }

  multi method peek_fds (:$raw = False) {
    samewith($, :$raw);
  }
  multi method peek_fds (Int() $length, :$raw = False) {
    my gint $l = $length;

    my $fds = g_unix_fd_list_peek_fds($!fd, $l);
    return $fds if $raw;

    my @fds;
    @fds.push: $fds[$_] for ^$l;
    @fds;
  }

  proto method steal_fds (|)
  { * }

  multi method steal_fds (:$raw = False) {
    samewith($, :$raw);
  }
  multi method steal_fds ($length is rw, :$raw = False) {
    my gint $l = 0;

    my $fds = g_unix_fd_list_steal_fds($!fd, $l);
    return $fds if $raw;

    my @fds;
    @fds.push: $fds[$_] for ^$l;
    @fds;
  }

}
