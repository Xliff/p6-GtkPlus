use v6.c;

use Method::Also;

use GTK::Compat::Types;
use GIO::DBus::Raw::Types;

use GIO::DBus::Raw::Utils;

class GIO::DBus::Utils {

  method new (|) {
    warn 'GIO::DBus::Utils is a static class and does not need instantiation';

    GIO::DBus::Utils;
  }

  method generate_guid is also<generate-guid> {
    g_dbus_generate_guid();
  }

  method gvalue_to_gvariant (GValue() $gvalue, Int() $type) is also<gvalue-to-gvariant> {
    my GVariantType $t = $type;

    g_dbus_gvalue_to_gvariant($gvalue, $t);
  }

  proto method gvariant_to_gvalue (|)
      is also<gvariant-to-gvalue>
  { * }

  multi method gvariant_to_gvalue (GVariant() $value) {
    my $gv = GValue.new;
    samewith($value, $gv);
  }
  multi method gvariant_to_gvalue (GVariant() $value, GValue() $out_gvalue) {
    g_dbus_gvariant_to_gvalue($value, $out_gvalue);
    $out_gvalue;
  }

  method is_guid (Str() $string) is also<is-guid> {
    so g_dbus_is_guid($string);
  }

  method is_interface_name (Str() $string) is also<is-interface-name> {
    so g_dbus_is_interface_name($string);
  }

  method is_member_name (Str() $string) is also<is-member-name> {
    so g_dbus_is_member_name($string);
  }

  method is_name (Str() $string) is also<is-name> {
    so g_dbus_is_name($string);
  }

  method is_unique_name (Str() $string) is also<is-unique-name> {
    so g_dbus_is_unique_name($string);
  }

  method own_name (
    Int() $bus_type,
    Str() $name,
    Int() $flags,
    &bus_acquired_handler,
    &name_acquired_handler,
    &name_lost_handler,
    gpointer $user_data                 = gpointer,
    GDestroyNotify $user_data_free_func = gpointer
  ) {
    my GBusType $b = $bus_type;
    my GBusNameOwnerFlags $f = $flags;

    g_bus_own_name(
      $b,
      $name,
      $f,
      &bus_acquired_handler,
      &name_acquired_handler,
      &name_lost_handler,
      $user_data,
      $user_data_free_func
    );
  }

  method own_name_on_connection (
    GDBusConnection() $connection,
    Str() $name,
    Int() $flags,
    &name_acquired_handler,
    &name_lost_handler,
    gpointer $user_data                 = gpointer,
    GDestroyNotify $user_data_free_func = gpointer
  ) {
    my GBusNameOwnerFlags $f = $flags;

    g_bus_own_name_on_connection(
      $connection,
      $name,
      $f,
      &name_acquired_handler,
      &name_lost_handler,
      $user_data,
      $user_data_free_func
    );
  }

  method own_name_on_connection_with_closures (
    GDBusConnection() $connection,
    Str() $name,
    Int() $flags,
    GClosure() $name_acquired_closure,
    GClosure() $name_lost_closure
  ) {
    my GBusNameOwnerFlags $f = $flags;

    g_bus_own_name_on_connection_with_closures(
      $connection,
      $name,
      $f,
      $name_acquired_closure,
      $name_lost_closure
    );
  }

  method own_name_with_closures (
    Int() $bus_type,
    Str() $name,
    Int() $flags,
    GClosure() $bus_acquired_closure,
    GClosure() $name_acquired_closure,
    GClosure() $name_lost_closure
  ) {
    my GBusType $b = $bus_type;
    my GBusNameOwnerFlags $f = $flags;

    g_bus_own_name_with_closures(
      $b,
      $name,
      $f,
      $bus_acquired_closure,
      $name_acquired_closure,
      $name_lost_closure
    );
  }

  method unown_name (Int() $owner_id) {
    my guint $o = $owner_id;

    g_bus_unown_name($o);
  }

}
