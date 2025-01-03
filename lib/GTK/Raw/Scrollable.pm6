use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Structs;
use GTK::Raw::Definitions:ver<3.0.1146>;
use GTK::Raw::Structs:ver<3.0.1146>;

unit package GTK::Raw::Scrollable:ver<3.0.1146>;

sub gtk_scrollable_get_border (GtkScrollable $scrollable, GtkBorder $border)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_scrollable_get_type ()
  returns GType
  is native(gtk)
  is export
  { * }

sub gtk_scrollable_get_vadjustment (GtkScrollable $scrollable)
  returns GtkAdjustment
  is native(gtk)
  is export
  { * }

sub gtk_scrollable_get_hscroll_policy (GtkScrollable $scrollable)
  returns uint32 # GtkScrollablePolicy
  is native(gtk)
  is export
  { * }

sub gtk_scrollable_get_vscroll_policy (GtkScrollable $scrollable)
  returns uint32 # GtkScrollablePolicy
  is native(gtk)
  is export
  { * }

sub gtk_scrollable_get_hadjustment (GtkScrollable $scrollable)
  returns GtkAdjustment
  is native(gtk)
  is export
  { * }

sub gtk_scrollable_set_vadjustment (
  GtkScrollable $scrollable,
  GtkAdjustment $vadjustment
)
  is native(gtk)
  is export
  { * }

sub gtk_scrollable_set_hscroll_policy (
  GtkScrollable $scrollable,
  uint32 $p                     # GtkScrollablePolicy $policy
)
  is native(gtk)
  is export
  { * }

sub gtk_scrollable_set_vscroll_policy (
  GtkScrollable $scrollable,
  uint32 $p                     # GtkScrollablePolicy $policy
)
  is native(gtk)
  is export
  { * }

sub gtk_scrollable_set_hadjustment (
  GtkScrollable $scrollable,
  GtkAdjustment $hadjustment
)
  is native(gtk)
  is export
  { * }