use v6.c;

use Method::Also;

use NativeCall;

use GLib::Raw::Types;

use GIO::Raw::AsyncInitable;

use GLib::Roles::TypedBuffer;

role GIO::Roles::AsyncInitable {
  has GAsyncInitable $!ai;

  method roleInit-AsyncInitable {
    my \i = findProperImplementor(self.^attributes);

    $!ai = cast(GAsyncInitable, i.get_value(self) );
  }

  method GLib::Raw::Types::GAsyncInitable
    is also<GAsyncInitable>
  { $!ai; }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &g_async_initable_get_type, $n, $t );
  }

  proto method init_async (|)
      is also<init-async>
  { * }

  multi method init (Int() $io_priority, :$async is required) {
    self.init_async($io_priority);
  }
  multi method init_async (Int() $io_priority) {
    my $s = Supplier::Preserving.new;

    self.init_async(
      $io_priority,
      -> *@a { $s.emit( @a[1] ) }
    );
    $s.Supply;
  }
  multi method init (
    Int() $io_priority,
    &callback,
    gpointer $user_data = gpointer,
    :$async is required
  ) {
    self.init_async(
      $io_priority,
      &callback,
      $user_data
    );
  }
  multi method init_async (
    Int() $io_priority,
    &callback,
    gpointer $user_data = gpointer
  ) {
    self.init_async(
      $io_priority,
      GCancellable,
      &callback,
      $user_data
    );
  }
  multi method init (
    Int() $io_priority,
    GCancellable() $cancellable,
    &callback,
    gpointer $user_data = gpointer,
    :$async is required
  ) {
    self.init_async(
      $io_priority,
      $cancellable,
      &callback,
      $user_data
    );
  }
  multi method init_async (
    Int() $io_priority,
    GCancellable() $cancellable,
    &callback,
    gpointer $user_data = gpointer
  ) {
    my gint $i = $io_priority;

    g_async_initable_init_async(
      $!ai,
      $io_priority,
      $cancellable,
      &callback,
      $user_data
    );
  }

  method init_finish (
    GAsyncResult() $res,
    CArray[Pointer[GError]] $error = gerror
  )
    is also<init-finish>
  {
    clear_error;
    my $rv = so g_async_initable_init_finish($!ai, $res, $error);
    set_error($error);
    $rv;
  }

  method new_finish (
    GAsyncResult() $res,
    CArray[Pointer[GError]] $error = gerror,
  )
    is also<new-finish>
  {
    clear_error
    my $o = g_async_initable_new_finish($!ai, $res, $error);
    set_error($error);
    $o ?? GLib::Roles::Object.new-object-obj($o) !! Nil;
  }

  proto method new_async (|)
      is also<new-async>
  { * }

  multi method new (
    Int() $io_priority,
    Int() $object_type,
          *@parameters,
    :$async is required,
    :$list  is required
  ) {
    self.new_async(
      $io_priority,
      $object_type,
      @parameters
    );
  }
  multi method new (
    Int() $io_priority,
    Int() $object_type,
          @parameters,
    :$async is required,
  ) {
    self.new_async(
      $io_priority,
      $object_type,
      @parameters
    );
  }
  # To slurp or not to slurp, however if it doesn't work for everything, it's
  # better to NOT confuse the dispatch.
  #
  # - "Let the wookie win."
  multi method new_async (
    Int() $io_priority,
    Int() $object_type,
          @parameters
  ) {
    my $s = Supplier::Preserving.new;

    self.new_async(
      $object_type,
      @parameters,
      $io_priority,
      -> *@a { $s.emit( @a[1] ) },
    );
    $s.Supply;
  }
  # cw: This is PROPER way to handle GParameter based functions. -- 10/28/2019
  multi method new (
    Int() $object_type,
          @parameters,
    Int() $io_priority,
          &callback,
          :$async is required
  ) {
    self.new_async(
      $object_type,
      @parameters,
      $io_priority,
      &callback
    );
  }
  multi method new_async (
    Int() $object_type,
          @parameters,
    Int() $io_priority,
          &callback
  ) {
    die '@parameters must contain only GParameter objects.'
      unless @parameters.all ~~ GParameter;

    my $p = GLib::Roles::TypedBuffer[GParameter].new(@parameters);
    self.new_async(
      $object_type,
      @parameters.elems,
      $p.p,
      $io_priority,
      &callback,
      gpointer
    );
  }
  multi method new (
    Int()     $object_type,
    Int()     $n_parameters,
    gpointer  $parameters,
    Int()     $io_priority,
              &callback,
    gpointer  $user_data = gpointer,
              :$async is required
  ) {
    self.new_async(
      $object_type,
      $n_parameters,
      $parameters,
      $io_priority,
      &callback,
      $user_data
    );
  };
  multi method new_async (
    Int()     $object_type,
    Int()     $n_parameters,
    gpointer  $parameters,
    Int()     $io_priority,
              &callback,
    gpointer  $user_data = gpointer
  ) {
    self.new_async(
      $object_type,
      $n_parameters,
      $io_priority,
      GCancellable,
      &callback,
      $user_data
    );
  }
  multi method new (
    Int()                $object_type,
    Int()                $n_parameters,
    gpointer             $parameters,
    Int()                $io_priority,
    GCancellable()       $cancellable,
                         &callback,
    gpointer             $user_data = gpointer,
                         :$async is required
  ) {
    self.new_async(
      $object_type,
      $n_parameters,
      $parameters,
      $io_priority,
      $cancellable,
      &callback,
      $user_data
    );
  }
  multi method new_async (
    Int()                $object_type,
    Int()                $n_parameters,
    gpointer             $parameters,
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
