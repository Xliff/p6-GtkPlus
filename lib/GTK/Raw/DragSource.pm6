use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Enums;
use GIO::Raw::Definitions;
use GDK::Raw::Definitions;
use GTK::Raw::Definitions:ver<3.0.1146>;

unit package GTK::Raw::DragSource:ver<3.0.1146>;

sub gtk_drag_source_add_image_targets (GtkWidget $widget)
  is native(gtk)
  is export
{ * }

sub gtk_drag_source_add_text_targets (GtkWidget $widget)
  is native(gtk)
  is export
{ * }

sub gtk_drag_source_add_uri_targets (GtkWidget $widget)
  is native(gtk)
  is export
{ * }

sub gtk_drag_source_set (
  GtkWidget $widget,
  uint32    $sbm,                    # GdkModifierType $start_button_mask,
  Pointer   $targets,
  gint      $n_targets,
  uint32    $actions                 # GdkDragAction $actions
)
  is native(gtk)
  is export
{ * }

sub gtk_drag_source_set_icon_gicon (GtkWidget $widget, GIcon $icon)
  is native(gtk)
  is export
{ * }

sub gtk_drag_source_set_icon_name (GtkWidget $widget, Str $icon_name)
  is native(gtk)
  is export
{ * }

sub gtk_drag_source_set_icon_pixbuf (GtkWidget $widget, GdkPixbuf $pixbuf)
  is native(gtk)
  is export
{ * }

sub gtk_drag_source_set_icon_stock (GtkWidget $widget, Str $stock_id)
  is native(gtk)
  is export
{ * }

sub gtk_drag_source_unset (GtkWidget $widget)
  is native(gtk)
  is export
{ * }

sub gtk_drag_source_get_target_list (GtkWidget $widget)
  returns GtkTargetList
  is native(gtk)
  is export
{ * }

sub gtk_drag_source_set_target_list (
  GtkWidget     $widget,
  GtkTargetList $target_list
)
  is native(gtk)
  is export
{ * }
