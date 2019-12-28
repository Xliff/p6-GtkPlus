use v6.c;

use Method::Also;
use NativeCall;

use GTK::Compat::Types;
use GIO::Raw::AsyncResult;

role GIO::Roles::AsyncResult {
  has GAsyncResult $!ar;

  submethod BUILD (:$result) {
    $!ar = $result if $result;
  }

  method roleInit-AsyncResult is also<roleInit_AsyncResult> {
    my \i = findProperImplementor(self.^attributes);

    $!ar = cast( GAsyncResult, i.get_value(self) );
  }

  method GTK::Compat::Types::GAsyncResult
    is also<GAsyncResult>
  { $!ar }

  method new-asyncresult-obj (GAsyncResult $result) {
    self.bless( :$result );
  }

  method get_source_object (:$raw = False) is also<get-source-object> {
    my $o = g_async_result_get_source_object($!ar);

    $o ??
      ( $raw ?? $o !! GLib::Roles::Object.new-object-obj($o) )
      !!
      Nil;
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &g_async_result_get_type, $n, $t );
  }

  method get_user_data is also<get-user-data> {
    g_async_result_get_user_data($!ar);
  }

  method is_tagged (gpointer $source_tag) is also<is-tagged> {
    so g_async_result_is_tagged($!ar, $source_tag);
  }

  method legacy_propagate_error (CArray[Pointer[GError]] $error = gerror)
    is also<legacy-propagate-error>
  {
    clear_error;
    my $rv = g_async_result_legacy_propagate_error($!ar, $error);
    set_error($error);
    $rv;
  }

}
