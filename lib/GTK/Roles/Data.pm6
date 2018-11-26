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
    my Pointer[uint32] $pi =
      nativecast( Pointer[uint32], g_object_get_ptr($!data, $key) );
    $pi.defined ?? $pi.deref !! Nil;
  }
  method set_data_uint(Str() $key, Int() $val) {
    my uint32 $v = resolve-int($val);
    g_object_set_uint($!data, $key, $v);
  }

  method setType($typeName) {
    my $oldType = self.getType;
    # This block may be unnecesary.
    with $oldType {
      warn "WARNING -- Resetting type from $oldType to $typeName"
        unless $oldType eq 'GTK::Widget' || $oldType eq $typeName;
    }

    self.set_data_string('GTKPLUS-Type', $typeName)
      unless ($oldType // '') ne $typeName;
  }

  multi method getType {
    self.get_data_string('GTKPLUS-Type');
  }

  multi method getType($w) {
    g_object_get_string( nativecast(GObject, $w), 'GTKPLUS-Type' );
  }

}
