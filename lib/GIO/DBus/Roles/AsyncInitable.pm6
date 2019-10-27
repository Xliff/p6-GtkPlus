use v6.c;

use NativeCall;

use GTK::Compat::Types;

role GIO::Roles::AsyncInitable {
  has GAsyncInitable $!ai;

  method get_type {
    state ($n, $t);

    unstable_get_type( self.^name, &g_async_initable_get_type, $n, $t );
  }

  method init_async (
    Int() $io_priority,
    GCancellable() $cancellable,
    &callback,
    gpointer $user_data = gpointer
  ) {
    my gint $i = $io_priority;

    g_async_initable_init_async(
      $!ai,
      $initable,
      $io_priority,
      $cancellable,
      &callback,
      $user_data
    );
  }

  method init_finish (
    GAsyncResult() $res,
    CArray[Pointer[GError]] $error = gerror
  ) {
    g_async_initable_init_finish($!ai, $res, $error);
  }

  method new_finish (
    GAsyncResult() $res,
    CArray[Pointer[GError]] $error = gerror
  ) {
    g_async_initable_new_finish($!ai, $res, $error);
  }

  method new (
    Int()                $object_type,
    Int()                $n_parameters,
    GParameter()         $parameters,
    Int()                $io_priority,
    GCancellable()       $cancellable,
    GAsyncReadyCallback  $callback,
    gpointer             $user_data = gpointer
  ) {
    my GType $o = $object_type;
    my guint $n = $n_parameters;
    my int   $i = $io_priority;

    g_async_initable_newv_async (
      $o,
      $n,
      $parameters,
      $i,
      $cancellable,
      $callback,
      $user_data
    );
  }

}
