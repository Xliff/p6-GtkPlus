use v6.c;

use NativeCall;

use GDK::Raw::Types;
use GDK::Raw::Selection;

use GLib::Roles::StaticClass;

class GDK::Selection  {
  also does GLib::Roles::StaticClass;

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
    my guint $t = $time;

    gdk_selection_convert($requestor, $selection, $target, $t);
  }

  method owner_get (GdkAtom $selection, :$raw = False){
    my $w = gdk_selection_owner_get($selection);

    $w ??
      ( $raw ?? $w !! GDK::Window.new($w) )
      !!
      Nil;
  }

  method owner_get_for_display (
    GdkDisplay() $display,
    GdkAtom $selection,
    :$raw = False
  ) {
    my $w = gdk_selection_owner_get_for_display($display, $selection)

    $w ??
      ( $raw ?? $w !! GDK::Window.new($w) )
      !!
      Nil;
  }

  method owner_set (
    GdkWindow() $owner,
    GdkAtom $selection,
    Int() $time,
    Int() $send_event
  ) {
    my guint ($t, $se) = ($time, $send_event);

    so gdk_selection_owner_set($owner, $selection, $t, $se);
  }

  method owner_set_for_display (
    GdkDisplay() $display,
    GdkWindow() $owner,
    GdkAtom $selection,
    Int() $time,
    Int() $send_event
  ) {
    my guint ($t, $se) = ($time, $send_event);

    so gdk_selection_owner_set_for_display(
      $display, $owner, $selection, $t, $se
    );
  }

  multi method property_get (GdkWindow() $requestor) {
    samewith($requestor, $, $, $);
  }
  multi method property_get (
    GdkWindow() $requestor,
    $data        is rw,
    $prop_type   is rw,
    $prop_format is rw
  ) {
    my GdkAtom $pt = 0;
    my gint $pf = 0;
    my $da = CArray[Str].new;
    $da[0] = Str;
    my $rc = gdk_selection_property_get($requestor, $da, $pt, $pf);

    ($data, $prop_type, $prop_format) =
      ($da[0] ?? CStringArrayToArray($da[0], $pt, $pf);
    ($rc, $data, $prop_type, $prop_format);
  }

  method send_notify (
    GdkWindow() $requestor,
    GdkAtom $selection,
    GdkAtom $target,
    GdkAtom $property,
    Int() $time
  ) {
    my guint $t = $time;

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
    my guint $t = $time;

    gdk_selection_send_notify_for_display(
      $display, $requestor, $selection, $target, $property, $t
    );
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
