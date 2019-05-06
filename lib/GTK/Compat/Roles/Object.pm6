use v6.c;

use NativeCall;

use GTK::Compat::Raw::IsType;

use GTK::Compat::Types;

role GTK::Compat::Roles::Object {
  has GObject $o;

  method !setObject($obj) {
    $!o = nativecast(GObject, $obj);
  }

  method GTK::Compat::Types::GObject { $o }

  method is_type (GObjectOrPointer $t) {
    is_type($t, self);
  }

}
