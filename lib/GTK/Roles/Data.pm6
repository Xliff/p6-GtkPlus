use v6.c;

use Method::Also;

use NativeCall;

use GTK::Raw::Types;

constant gObjectTypeKey = 'p6-GObject-Type';

role GTK::Roles::Data {
  has $!data;

  method get_data_string(Str() $key)
    is also<get-data-string>
  {
    g_object_get_string($!data, $key);
  }
  method set_data_string(Str() $key, Str() $val)
    is also<set-data-string>
  {
    g_object_set_string($!data, $key, $val);
  }

  method get_data_uint(Str() $key)
    is also<get-data-uint>
  {
    my CArray[guint] $pi = g_object_get_uint($!data, $key);
    $pi.defined ?? $pi[0] !! Nil;
  }
  method set_data_uint(Str() $key, Int() $val)
    is also<set-data-uint>
  {
    my $v = CArray[guint].new;
    $v[0] = $val;
    g_object_set_uint($!data, $key, $v);
  }

  method get_data_int(Str() $key)
    is also<get-data-int>
  {
    my CArray[gint] $pi = g_object_get_int($!data, $key);
    $pi.defined ?? $pi[0] !! Nil;
  }
  method set_data_int(Str() $key, Int() $val)
    is also<set-data-int>
  {
    my $v = CArray[gint].new;
    $v[0] = $val;
    g_object_set_int($!data, $key, $v);
  }

  method set_data_ptr(Str() $key, Pointer $val)
    is also<set-data-ptr>
  {
    g_object_set_ptr($!data, $key, $val);
  }
  method get_data_ptr(Str() $key)
    is also<get-data-ptr>
  {
    g_object_get_ptr($!data, $key);
  }

  method clear_data(Str() $key)
    is also<clear-data>
  {
    g_object_set_ptr($!data, $key, Pointer);
  }

  method setType($typeName) {
    my $oldType = self.getType;
    self.set_data_string(gObjectTypeKey, $typeName) unless $oldType.defined;
    warn "WARNING -- Using a $oldType as a $typeName"
      unless [||](
        %*ENV<P6_GTK_DEBUG>.defined.not,
        $oldType.defined.not,
        $oldType eq $typeName
      );
  }

  multi method getType {
    self.get_data_string(gObjectTypeKey);
  }

  multi method getType($w) {
    g_object_get_string($w.p, gObjectTypeKey);
  }

}
