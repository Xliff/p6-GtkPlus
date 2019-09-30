use v6.c;

use Method::Also;

use NativeCall;

use GTK::Compat::Types;
use GIO::Raw::NetworkMonitor;

role GIO::Roles::NetworkMonitor {
  has GNetworkMonitor $!nm;

  submethod BUILD (:$monitor) {
    $!nm = $monitor;
  }

  method roleInit-NetworkMonitor is also<roleInit_NetworkMonitor> {
    $!nm = cast(GNetworkMonitor, self.^attributes(:local)[0].get_value(self) );
  }

  method GTK::Compat::Types::GNetworkMonitor
    is also<GNetworkMonitor>
  { $!nm }

  method new-networkmonitor-obj (GNetworkMonitor $monitor)
    is also<new_networkmonitor_obj>
  {
    self.bless( :$monitor );
  }

  method can_reach (
    GSocketConnectable() $connectable,
    GCancellable $cancellable = GCancellable,
    CArray[Pointer[GError]] $error = gerror
  )
    is also<can-reach>
  {
    clear_error;
    my $rv =
      g_network_monitor_can_reach($!nm, $connectable, $cancellable, $error);
    set_error($error);
    $rv;
  }

  method can_reach_async (
    GSocketConnectable() $connectable,
    GCancellable $cancellable,
    GAsyncReadyCallback $callback,
    gpointer $user_data = gpointer
  )
    is also<can-reach-async>
  {
    g_network_monitor_can_reach_async(
      $!nm,
      $connectable,
      $cancellable,
      $callback,
      $user_data
    );
  }

  method can_reach_finish (
    GAsyncResult() $result,
    CArray[Pointer[GError]] $error = gerror
  )
    is also<can-reach-finish>
  {
    clear_error;
    my $rv = g_network_monitor_can_reach_finish($!nm, $result, $error);
    set_error($error);
    $rv;
  }

  method get_connectivity is also<get-connectivity> {
    GNetworkConnectivityEnum( g_network_monitor_get_connectivity($!nm) );
  }

  method get_default (:$raw = False)
    is also<
      get-default
      default
    >
  {
    my $nm = g_network_monitor_get_default();

    $nm ??
      ( $raw ?? $nm !! GIO::Roles::NetworkMonitor.new-networkmonitor-obj($nm) )
      !!
      Nil;
  }

  method get_network_available
    is also<
      get-network-available
      network_available
      network-available
    >
  {
    so g_network_monitor_get_network_available($!nm);
  }

  method get_network_metered
    is also<
      get-network-metered
      network_metered
      network-metered
    >
  {
    so g_network_monitor_get_network_metered($!nm);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &g_network_monitor_get_type, $n, $t );
  }

}
