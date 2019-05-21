use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::Subs;
use GTK::Raw::Utils;

role GTK::Roles::Data {
  has $!data;

  method get_data_string(Str() $key) {
    g_object_get_string($!data, $key);
  }
  method set_data_string(Str() $key, Str() $val) {
    g_object_set_string($!data, $key, $val);
  }

  method get_data_uint(Str() $key) {
    my CArray[guint] $pi = g_object_get_uint($!data, $key);
    $pi.defined ?? $pi[0] !! Nil;
  }
  method set_data_uint(Str() $key, Int() $val) {
    my $v = CArray[guint].new;
    $v[0] = resolve-int($val);
    g_object_set_uint($!data, $key, $v);
  }

  method get_data_int(Str() $key) {
    my CArray[gint] $pi = g_object_get_int($!data, $key);
    $pi.defined ?? $pi[0] !! Nil;
  }

  method set_data_ptr(Str() $key, Pointer $val) {
    g_object_set_ptr($!data, $key, $val);
  }

  method clear_data(Str() $key) {
    g_object_set_ptr($!data, $key, Pointer);
  }


  method setType($typeName) {
    my $oldType = self.getType;
    self.set_data_string('GTKPLUS-Type', $typeName) without $oldType;
    warn "WARNING -- Using a $oldType as a $typeName"
      unless $oldType.defined.not || $oldType eq $typeName;
  }

  multi method getType {
    self.get_data_string('GTKPLUS-Type');
  }

  multi method getType($w) {
    g_object_get_string($w.p, 'GTKPLUS-Type');
  }

}
