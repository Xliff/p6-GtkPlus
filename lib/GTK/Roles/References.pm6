use v6.c;

use NativeCall;

use GTK::Raw::Subs;

role GTK::Roles::References {
  has Pointer $!ref;

  # We use these for inc/dec ops
  method upref   {   g_object_ref($!ref) }
  method downref { g_object_unref($!ref) }
}
