use v6.c;

use Method::Also;
use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::Subs;

role GTK::Roles::References {
  has GObject $!ref;

  # We use these for inc/dec ops
  method ref   is also<upref>   {   g_object_ref($!ref); self; }
  method unref is also<downref> { g_object_unref($!ref); self; }

  method check_gobject_type($compare_type) {
    my $o = nativecast(GTypeInstance, $!ref);
    $o.checkType($compare_type);
  }

  method get_gobject_type {
    my $o = nativecast(GTypeInstance, $!ref);
    $o.getType;
  }

}
