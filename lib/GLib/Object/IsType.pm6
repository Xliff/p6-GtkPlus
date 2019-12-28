use v6.c;

use NativeCall;

use GTK::Compat::Types;

use GTK::Roles::Pointers;

unit package GLib::Object::IsType;

our subset GObjectOrPointer of Mu is export
  where ::('GLib::Roles::Object') | GObject | GTK::Roles::Pointers;

sub is_type (GObjectOrPointer $t, $object) is export {
  $t .= GObject if $t ~~ ::('GLib::Roles::Object');
  my ($to, $ot) =
    ( nativecast(GObjectStruct, $t), $object.get_type );
  $to.checkType($ot);
}
