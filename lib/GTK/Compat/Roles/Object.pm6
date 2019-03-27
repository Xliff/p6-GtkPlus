use v6.c;

use NativeCall;

use GTK::Compat::Types;

role GTK::Compat::Roles::Object {
  has GObject $o;
  
  method !setObject($obj) {
    $!o = nativecast(GObject, $obj);
  }
  
  method GTK::Compat::Types::GObject { $o }
  
}
