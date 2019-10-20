use v6.c;

use Method::Also;

use GTK::Compat::Types;

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

}
