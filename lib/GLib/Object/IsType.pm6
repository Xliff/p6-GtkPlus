use v6.c;

use NativeCall;

use GTK::Compat::Types;

use GTK::Roles::Pointers;

unit package GLib::Object::IsType;

our subset GObjectOrPointer of Mu is export
  where ::('GTK::Compat::Roles::Object') | GObject | GTK::Roles::Pointers;

sub is_type (GObjectOrPointer $t, $object) is export {
  $t .= GObject if $t ~~ ::('GTK::Compat::Roles::Object');
  my ($to, $ot) =
    ( nativecast(GObjectStruct, $t), $object.get_type );
  $to.checkType($ot);
}
