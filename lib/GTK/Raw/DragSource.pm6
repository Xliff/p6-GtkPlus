use v6.c;

use NativeCall;


use GTK::Raw::Types;

unit package GTK::Raw::DragSource;

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
  uint32 $sbm,                    # GdkModifierType $start_button_mask,
  GtkTargetEntry $targets,
  gint $n_targets,
  uint32 $actions                 # GdkDragAction $actions
)
  is native(gtk)
  is export
  { * }

sub gtk_drag_source_set_icon_gicon (GtkWidget $widget, GIcon $icon)
  is native(gtk)
  is export
  { * }

sub gtk_drag_source_set_icon_name (GtkWidget $widget, gchar $icon_name)
  is native(gtk)
  is export
  { * }

sub gtk_drag_source_set_icon_pixbuf (GtkWidget $widget, GdkPixbuf $pixbuf)
  is native(gtk)
  is export
  { * }

sub gtk_drag_source_set_icon_stock (GtkWidget $widget, gchar $stock_id)
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
  GtkWidget $widget,
  GtkTargetList $target_list
)
  is native(gtk)
  is export
  { * }
