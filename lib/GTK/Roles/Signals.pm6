use v6.c;

role GTK::Roles::Signals {
  has %!signals;

  method connect($obj, $signal, {
      %!signal{$signal} //= do [
        {
          my $s = Supplier.new;
          g_signal_connect_wd($obj, $signal,
              -> $, $ {
                  $s.emit(self);
                  CATCH { default { note $_; } }
              },
              OpaquePointer, 0);
          $s.Supply;
        },
        $obj
      ];
      %!signal{$$signal};
  );

  method disconnect_all {
    self.disconnect($_) for %!signals;
  }

  method disconnect($obj, $signal) {
    g_signal_handler_disconnect($obj, %!signals{$signal});
    %!signals{$signal}:delete;
  }

}
