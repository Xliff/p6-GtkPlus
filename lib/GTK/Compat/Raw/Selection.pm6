use v6.c;

use NativeCall;

use GTK::Compat::Types;

unit package GTK::Compat::Raw::Selection;

sub gdk_selection_convert (
  GdkWindow $requestor,
  GdkAtom $selection,
  GdkAtom $target,
  guint32 $time
)
  is native(gdk)
  is export
  { * }

sub gdk_selection_owner_get (GdkAtom $selection)
  returns GdkWindow
  is native(gdk)
  is export
  { * }

sub gdk_selection_owner_get_for_display (
  GdkDisplay $display,
  GdkAtom $selection
)
  returns GdkWindow
  is native(gdk)
  is export
  { * }

sub gdk_selection_owner_set (
  GdkWindow $owner,
  GdkAtom $selection,
  guint32 $time,
  gboolean $send_event
)
  returns uint32
  is native(gdk)
  is export
  { * }

sub gdk_selection_owner_set_for_display (
  GdkDisplay $display,
  GdkWindow $owner,
  GdkAtom $selection,
  guint32 $time,
  gboolean $send_event
)
  returns uint32
  is native(gdk)
  is export
  { * }

sub gdk_selection_property_get (
  GdkWindow $requestor,
  Str $data is rw,
  GdkAtom $prop_type,
  gint $prop_format is rw
)
  returns gint
  is native(gdk)
  is export
  { * }

sub gdk_selection_send_notify (
  GdkWindow $requestor,
  GdkAtom $selection,
  GdkAtom $target,
  GdkAtom $property,
  guint32 $time
)
  is native(gdk)
  is export
  { * }

sub gdk_selection_send_notify_for_display (
  GdkDisplay $display,
  GdkWindow $requestor,
  GdkAtom $selection,
  GdkAtom $target,
  GdkAtom $property,
  guint32 $time
)
  is native(gdk)
  is export
  { * }
