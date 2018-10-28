use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::Types;

unit package GTK::Raw::Scrollable;

sub gtk_scrollable_get_border (GtkScrollable $scrollable, GtkBorder $border)
  returns uint32
  is native($LIBGTK)
  is export
  { * }

sub gtk_scrollable_get_type ()
  returns GType
  is native($LIBGTK)
  is export
  { * }

sub gtk_scrollable_get_vadjustment (GtkScrollable $scrollable)
  returns GtkAdjustment
  is native($LIBGTK)
  is export
  { * }

sub gtk_scrollable_get_hscroll_policy (GtkScrollable $scrollable)
  returns uint32 # GtkScrollablePolicy
  is native($LIBGTK)
  is export
  { * }

sub gtk_scrollable_get_vscroll_policy (GtkScrollable $scrollable)
  returns uint32 # GtkScrollablePolicy
  is native($LIBGTK)
  is export
  { * }

sub gtk_scrollable_get_hadjustment (GtkScrollable $scrollable)
  returns GtkAdjustment
  is native($LIBGTK)
  is export
  { * }

sub gtk_scrollable_set_vadjustment (
  GtkScrollable $scrollable,
  GtkAdjustment $vadjustment
)
  is native($LIBGTK)
  is export
  { * }

sub gtk_scrollable_set_hscroll_policy (
  GtkScrollable $scrollable,
  uint32 $p                     # GtkScrollablePolicy $policy
)
  is native($LIBGTK)
  is export
  { * }

sub gtk_scrollable_set_vscroll_policy (
  GtkScrollable $scrollable,
  uint32 $p                     # GtkScrollablePolicy $policy
)
  is native($LIBGTK)
  is export
  { * }

sub gtk_scrollable_set_hadjustment (
  GtkScrollable $scrollable,
  GtkAdjustment $hadjustment
)
  is native($LIBGTK)
  is export
  { * }