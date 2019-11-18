use v6.c;

use Method::Also;
use NativeCall;

use GTK::Compat::Raw::IsType;

use GTK::Compat::Types;

use GTK::Raw::Subs;

role GTK::Compat::Roles::Object {
  has GObject $!o;

  submethod BUILD (:$object) {
    $!o = $object;
  }

  method new-object-obj (GObject $object) {
    self.bless( :$object );
  }

  method roleInit-Object {
    my \i = findProperImplementor(self.^attributes);

    $!o = cast( GObject, i.get_value(self) );
  }

  method !setObject($obj) {
    $!o = nativecast(GObject, $obj);
  }

  method GTK::Compat::Types::GObject
    is also<GObject>
  { $!o }

  method is_type (GObjectOrPointer $t) {
    is_type($t, self);
  }

  # We use these for inc/dec ops
  method ref   is also<upref>   {   g_object_ref($!o); self; }
  method unref is also<downref> { g_object_unref($!o); }

  method check_gobject_type($compare_type) {
    my $o = nativecast(GTypeInstance, $!o);
    $o.checkType($compare_type);
  }

  method get_gobject_type {
    my $o = nativecast(GTypeInstance, $!o);
    $o.getType;
  }

}
