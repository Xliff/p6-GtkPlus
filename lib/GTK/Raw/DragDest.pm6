use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Enums;
use GDK::Raw::Definitions;
use GTK::Raw::Definitions:ver<3.0.1146>;

unit package GTK::Raw::DragDest:ver<3.0.1146>;

sub gtk_drag_dest_add_image_targets (GtkWidget $widget)
  is native(gtk)
  is export
{ * }

sub gtk_drag_dest_add_text_targets (GtkWidget $widget)
  is native(gtk)
  is export
{ * }

sub gtk_drag_dest_add_uri_targets (GtkWidget $widget)
  is native(gtk)
  is export
{ * }

sub gtk_drag_dest_find_target (
  GtkWidget      $widget,
  GdkDragContext $context,
  GtkTargetList  $target_list
)
  returns GdkAtom
  is native(gtk)
  is export
{ * }

sub gtk_drag_dest_set (
  GtkWidget $widget,
  uint32    $flags,                  # GtkDestDefaults $flags,
  Pointer   $targets,
  gint      $n_targets,
  uint32    $actions                 # GdkDragAction $actions
)
  is native(gtk)
  is export
{ * }

sub gtk_drag_dest_set_proxy (
  GtkWidget $widget,
  GdkWindow $proxy_window,
  uint32    $protocol,               # GdkDragProtocol $protocol,
  gboolean  $use_coordinates
)
  is native(gtk)
  is export
{ * }

sub gtk_drag_dest_unset (GtkWidget $widget)
  is native(gtk)
  is export
{ * }

sub gtk_drag_dest_get_track_motion (GtkWidget $widget)
  returns uint32
  is native(gtk)
  is export
{ * }

sub gtk_drag_dest_get_target_list (GtkWidget $widget)
  returns GtkTargetList
  is native(gtk)
  is export
{ * }

sub gtk_drag_dest_set_track_motion (GtkWidget $widget, gboolean $track_motion)
  is native(gtk)
  is export
{ * }

sub gtk_drag_dest_set_target_list (
  GtkWidget     $widget,
  GtkTargetList $target_list
)
  is native(gtk)
  is export
{ * }
