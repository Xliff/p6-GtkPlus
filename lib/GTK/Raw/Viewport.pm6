use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Enums;
use GTK::Raw::Definitions:ver<3.0.1146>;

unit package GTK::Raw::Viewport:ver<3.0.1146>;

sub gtk_viewport_get_bin_window (GtkViewport $viewport)
  returns GdkWindow
  is native(gtk)
  is export
  { * }

sub gtk_viewport_get_type ()
  returns GType
  is native(gtk)
  is export
  { * }

sub gtk_viewport_get_view_window (GtkViewport $viewport)
  returns GdkWindow
  is native(gtk)
  is export
  { * }

sub gtk_viewport_new (GtkAdjustment $hadjustment, GtkAdjustment $vadjustment)
  returns GtkWidget
  is native(gtk)
  is export
  { * }

sub gtk_viewport_get_shadow_type (GtkViewport $viewport)
  returns uint32 # GtkShadowType
  is native(gtk)
  is export
  { * }

sub gtk_viewport_get_hadjustment (GtkViewport $viewport)
  returns GtkAdjustment
  is native(gtk)
  is export
  { * }

sub gtk_viewport_get_vadjustment (GtkViewport $viewport)
  returns GtkAdjustment
  is native(gtk)
  is export
  { * }

sub gtk_viewport_set_shadow_type (
  GtkViewport $viewport,
  uint32 $type                  # GtkShadowType $type
)
  is native(gtk)
  is export
  { * }

sub gtk_viewport_set_hadjustment (GtkViewport $viewport, GtkAdjustment $adjustment)
  is native(gtk)
  is export
  { * }

sub gtk_viewport_set_vadjustment (GtkViewport $viewport, GtkAdjustment $adjustment)
  is native(gtk)
  is export
  { * }