use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Compat::Raw::Selection;

use GTK::Roles::Types;

class GTK::Compat::Selection  {
  also does GTK::Roles::Types;

  method new(|) {
    warn 'GTK::Compat::Selection is not an instantiable class';
    GTK::Compat::Selection;
  }

  # ↓↓↓↓ SIGNALS ↓↓↓↓
  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ PROPERTIES ↓↓↓↓
  # ↑↑↑↑ PROPERTIES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  method convert (
    GdkWindow() $requestor,
    GdkAtom $selection,
    GdkAtom $target,
    Int() $time
  ) {
    my guint $t = self.RESOLVE-UINT($time);
    gdk_selection_convert($requestor, $selection, $target, $t);
  }

  method owner_get (GdkAtom $selection){
    GTK::Compat::Window.new( gdk_selection_owner_get($selection) );
  }

  method owner_get_for_display (GdkDisplay() $display, GdkAtom $selection) {
    GTK::Compat::Window.new(
      gdk_selection_owner_get_for_display($display, $selection)
    );
  }

  method owner_set (
    GdkWindow() $owner,
    GdkAtom $selection,
    Int() $time,
    Int() $send_event
  ) {
    my guint ($t, $se) = self.RESOLVE-UINT($time, $send_event);
    so gdk_selection_owner_set($owner, $selection, $t, $se);
  }

  method owner_set_for_display (
    GdkDisplay() $display,
    GdkWindow() $owner,
    GdkAtom $selection,
    Int() $time,
    Int() $send_event
  ) {
    my guint ($t, $se) = self.RESOLVE-UINT($time, $send_event);
    so gdk_selection_owner_set_for_display(
      $display, $owner, $selection, $t, $se
    );
  }

  multi method property_get (GdkWindow() $requestor, GdkAtom $prop_type) {
    my $pt = 0;
    my $d = '';
    my $rc = samewith($requestor, $d, $prop_type, $pt);
    ($rc, $d, $prop_type);
  }
  multi method property_get (
    GdkWindow() $requestor,
    Str $data is rw,
    GdkAtom $prop_type,
    Int() $prop_format is rw
  ) {
    my gint $p = 0;
    my $rc = gdk_selection_property_get($requestor, $data, $prop_type, $p);
    $prop_format = $p;
    $rc;
  }

  method send_notify (
    GdkWindow() $requestor,
    GdkAtom $selection,
    GdkAtom $target,
    GdkAtom $property,
    Int() $time
  ) {
    my guint $t = self.RESOLVE-UINT($time);
    gdk_selection_send_notify($requestor, $selection, $target, $property, $t);
  }

  method send_notify_for_display (
    GdkDisplay() $display,
    GdkWindow() $requestor,
    GdkAtom $selection,
    GdkAtom $target,
    GdkAtom $property,
    Int() $time
  ) {
    my guint $t = self.RESOLVE-UINT($time);
    gdk_selection_send_notify_for_display(
      $display, $requestor, $selection, $target, $property, $t
    );
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
