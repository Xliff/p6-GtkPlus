use v6.c;

use Method::Also;

use NativeCall;

use GTK::Compat::Types;
use GIO::Raw::FileEnumerator;

use GIO::FileInfo;

use GTK::Compat::Roles::Object;
use GTK::Compat::Roles::GFile;

class GIO::FileEnumerator {
  also does GTK::Compat::Roles::Object;

  has GFileEnumerator $!fe is implementor;

  submethod BUILD (:$enumerator) {
    $!fe = $enumerator;

    self.roleInit-Object;
  }

  method GTK::Compat::Types::GFileEnumerator
  { $!fe }

  method new (GFileEnumerator $enumerator) {
    self.bless( :$enumerator );
  }

  method close (
    GCancellable() $cancellable,
    CArray[Pointer[GError]] $error = gerror
  ) {
    clear_error;
    my $rv = g_file_enumerator_close($!fe, $cancellable, $error);
    set_error($error);
    $rv;
  }

  method close_async (
    Int() $io_priority,
    GCancellable() $cancellable,
    GAsyncReadyCallback $callback,
    gpointer $user_data = gpointer
  )
    is also<close-async>
  {
    my gint $i = $io_priority;

    g_file_enumerator_close_async(
      $!fe,
      $i,
      $cancellable,
      $callback,
      $user_data
    );
  }

  method close_finish (
    GAsyncResult() $result,
    CArray[Pointer[GError]] $error = gerror
  )
    is also<close-finish>
  {
    clear_error;
    my $rv = g_file_enumerator_close_finish($!fe, $result, $error);
    set_error($error);
    $rv;
  }

  method get_child (GFileInfo() $info, :$raw = False) is also<get-child> {
    my $c = g_file_enumerator_get_child($!fe, $info);

    $c ??
      ( $raw ?? $c !! GTK::Compat::Roles::File.new-file-obj($c) )
      !!
      Nil;
  }

  method get_container (:$raw = False) is also<get-container> {
    my $c = g_file_enumerator_get_container($!fe);

    $c ??
      ( $raw ?? $c !! GTK::Compat::Roles::File.new-file-obj($c) )
      !!
      Nil;
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &g_file_enumerator_get_type, $n, $t );
  }

  method has_pending is also<has-pending> {
    so g_file_enumerator_has_pending($!fe);
  }

  method is_closed is also<is-closed> {
    so g_file_enumerator_is_closed($!fe);
  }

  proto method iterate (|)
  { * }

  multi method iterate (
    GCancellable() $cancellable = GCancellable,
    CArray[Pointer[GError]] $error = gerror,
    :$raw = False
  ) {
    samewith($, $, $cancellable, $error, :$raw);
  }
  multi method iterate (
    $out_info  is rw,
    $out_child is rw,
    GCancellable() $cancellable = GCancellable,
    CArray[Pointer[GError]] $error = gerror,
    :$raw = False
  ) {
    my $oi = CArray[Pointer[GFileInfo]].new;
    $oi[0] = Pointer[GFileInfo].new;
    my $oc = CArray[Pointer[GFile]].new;
    $oc[0] = Pointer[GFile].new;

    clear_error;
    my $rv = g_file_enumerator_iterate(
      $!fe,
      $oi,
      $oc,
      $cancellable,
      $error
    );
    set_error($error);

    $out_info = $oi[0] ??
      ($raw ?? $oi[0] !! GIO::FileInfo.new( $oi[0] ) )
      !!
      Nil;

    $out_child = $oc[0] ??
      ($raw ?? $oc[0] !! GTK::Compat::Roles::File.new-file-obj( $oc[0] ) )
      !!
      Nil;

    ($rv, $out_info, $out_child);
  }

  method next_file (
    GCancellable() $cancellable = GCancellable,
    CArray[Pointer[GError]] $error = gerror,
    :$raw = False
  )
    is also<next-file>
  {
    clear_error;
    my $rv = g_file_enumerator_next_file($!fe, $cancellable, $error);
    set_error($error);

    $rv ??
      ( $raw ?? $rv !! GIO::FileInfo.new($rv) )
      !!
      Nil;
  }

  method next_files_async (
    Int() $num_files,
    Int() $io_priority,
    GCancellable() $cancellable,
    GAsyncReadyCallback $callback,
    gpointer $user_data = gpointer
  )
    is also<next-files-async>
  {
    my gint ($nf, $i) = ($num_files, $io_priority);
    g_file_enumerator_next_files_async(
      $!fe,
      $nf,
      $i,
      $cancellable,
      $callback,
      $user_data
    );
  }

  method next_files_finish (
    GAsyncResult() $result,
    CArray[Pointer[GError]] $error = gerror,
    :$raw = False
  )
    is also<next-files-finish>
  {
    clear_error;
    my $rv = g_file_enumerator_next_files_finish($!fe, $result, $error);
    set_error($error);

    $rv ??
      ( $raw ?? $rv !! GIO::FileInfo.new($rv) )
      !!
      Nil;
  }

  method set_pending (Int() $pending)
    is also<set-pending>
  {
    my gboolean $p = $pending;

    g_file_enumerator_set_pending($!fe, $p);
  }

}
