use v6.c;

use Method::Also;

use NativeCall;

use GTK::Compat::Types;
use GIO::Raw::PollableOutputStream;

use GTK::Compat::Source;

role GIO::Roles::PollableOutputStream {
  has GPollableOutputStream $!pos;

  submethod BUILD (:$pollable) {
    $!pos = $pollable;
  }

  method roleInit-PollableOutputStream is also<roleInit_PollableOutputStream> {
    my \i = findProperImplementor(self.^attributes);

    $!pos = cast( GPollableOutputStream, i.get_value(self) );
  }

  method GTK::Compat::Types::GPollableOutputStream
    is also<GPollableOutputStream>
  { $!pos }

  method new-pollableoutputstream-obj (GPollableOutputStream $pollable)
    is also<new_pollableoutputstream_obj>
  {
    self.bless( :$pollable );
  }

  method can_poll is also<can-poll> {
    so g_pollable_output_stream_can_poll($!pos);
  }

  method create_source (
    GCancellable() $cancellable = GCancellable,
    :$raw = False
  )
    is also<create-source>
  {
    my $s = g_pollable_output_stream_create_source($!pos, $cancellable);

    $s ??
      ( $raw ?? $s !! GTK::Compat::Source.new($s) )
      !!
      Nil;
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &g_pollable_output_stream_get_type, $n, $t );
  }

  method is_writable is also<is-writable> {
    so g_pollable_output_stream_is_writable($!pos);
  }

  method write_nonblocking (
    Pointer $buffer,
    Int() $count,
    GCancellable() $cancellable = GCancellable,
    CArray[Pointer[GError]] $error = gerror
  )
    is also<write-nonblocking>
  {
    my gsize $c = $count;

    clear_error;
    my $rv = g_pollable_output_stream_write_nonblocking(
      $!pos,
      $buffer,
      $c,
      $cancellable,
      $error
    );
    set_error($error);
    $rv;
  }

  proto method writev_nonblocking (|)
      is also<writev-nonblocking>
  { * }

  multi method writev_nonblocking (
    GOutputVector $vectors,
    Int() $n_vectors,
    GCancellable() $cancellable = GCancellable,
    CArray[Pointer[GError]] $error = gerror,
    :$all = False
  ) {
    samewith($vectors, $n_vectors, $, $cancellable, $error, :$all);
  }
  multi method writev_nonblocking (
    GOutputVector $vectors,
    Int() $n_vectors,
    $bytes_written is rw,
    GCancellable() $cancellable = GCancellable,
    CArray[Pointer[GError]] $error = gerror,
    :$all = False
  ) {
    my gsize ($n, $bw) = ($n_vectors, $bw);

    clear_error;
    my $rv = g_pollable_output_stream_writev_nonblocking(
      $!pos,
      $vectors,
      $n,
      $bw,
      $cancellable,
      $error
    );
    set_error($error);
    $bytes_written = $bw;
    $all ?? $rv !! ($rv, $bytes_written);
  }

}
