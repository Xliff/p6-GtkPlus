use v6.c;

use Method::Also;
use NativeCall;

use GTK::Raw::Utils;

use GTK::Compat::Types;

use GLib::Object::Raw::Binding;

use GLib::Roles::Object;

class GLib::Object::Binding {
  also does GLib::Roles::Object;

  has GBinding $!b is implementor;

  submethod BUILD (:$binding) {
    self!setObject($!b = $binding);
  }

  method bind (
    GLib::Object::Binding:U:
    GObject() $source,
    Str() $source_property,
    GObject() $target,
    Str() $target_property,
    Int() $flags = 3    # G_BINDING_BIDIRECTIONAL +| G_BINDING_SYNC_CREATE
  ) {
    my $f = resolve-uint($flags);
    my $binding = g_object_bind_property(
      $source,
      $source_property,
      $target,
      $target_property,
      $f
    );

    $binding ?? self.bless( :$binding ) !! Nil;
  }

  method bind_full (
    GLib::Object::Binding:U:
    GObject() $source,
    Str() $source_property,
    GObject() $target,
    Str() $target_property,
    Int() $flags,
    GBindingTransformFunc $transform_to,
    GBindingTransformFunc $transform_from,
    gpointer $user_data                   = Pointer,
    GDestroyNotify $notify                = Pointer
  )
    is also<bind-full>
  {
    my $f = resolve-uint($flags);
    my $binding = g_object_bind_property_full(
      $source,
      $source_property,
      $target,
      $target_property,
      $f,
      $transform_to,
      $transform_from,
      $user_data,
      $notify
    );

    $binding ?? self.bless( :$binding ) !! Nil;
  }

  method bind_with_closures (
    GLib::Object::Binding:U:
    GObject() $source,
    Str() $source_property,
    GObject() $target,
    Str() $target_property,
    Int() $flags,
    GClosure $transform_to,
    GClosure $transform_from
  )
    is also<bind-with-closures>
  {
    my $f = resolve-uint($flags);
    my $binding =  g_object_bind_property_with_closures(
      $source,
      $source_property,
      $target,
      $target_property,
      $f,
      $transform_to,
      $transform_from
    );

    $binding ?? self.bless( :$binding ) !! Nil;
  }

  method get_flags is also<get-flags> {
    GBindingFlags( g_binding_get_flags($!b) );
  }

  method get_source (:$raw = False) is also<get-source> {
    my $obj = g_binding_get_source($!b);

    $obj ??
      ( $raw ?? $obj !! GLib::Roles::Object.new-object-obj($obj) )
      !!
      Nil;
  }

  method get_source_property is also<get-source-property> {
    g_binding_get_source_property($!b);
  }

  method get_target (:$raw = False) is also<get-target> {
    my $obj = g_binding_get_target($!b);

    $obj ??
      ( $raw ?? $obj !! GLib::Roles::Object.new-object-obj($obj) )
      !!
      Nil;
  }

  method get_target_property is also<get-target-property> {
    g_binding_get_target_property($!b);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &g_binding_get_type, $n, $t );
  }

  method unbind {
    g_binding_unbind($!b);
  }

}
