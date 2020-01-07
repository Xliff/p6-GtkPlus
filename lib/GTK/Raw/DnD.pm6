use v6.c;

use NativeCall;

use GTK::Raw::Types;


unit package GTK::Raw::DnD;

sub gtk_drag_begin (
  GtkWidget $widget,
  GtkTargetList $targets,
  uint32 $actions,                # GdkDragAction $actions
  gint $button,
  GdkEvent $event
)
  returns GdkDragContext
  is native(gtk)
  is export
  { * }

sub gtk_drag_begin_with_coordinates (
  GtkWidget $widget,
  GtkTargetList $targets,
  uint32 $actions,                # GdkDragAction $actions
  gint $button,
  GdkEvent $event,
  gint $x,
  gint $y
)
  returns GdkDragContext
  is native(gtk)
  is export
  { * }

sub gtk_drag_cancel (GdkDragContext $context)
  is native(gtk)
  is export
  { * }

sub gtk_drag_check_threshold (
  GtkWidget $widget,
  gint $start_x,
  gint $start_y,
  gint $current_x,
  gint $current_y
)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_drag_finish (
  GdkDragContext $context,
  gboolean $success,
  gboolean $del,
  guint32 $time
)
  is native(gtk)
  is export
  { * }

sub gtk_drag_get_data (
  GtkWidget $widget,
  GdkDragContext $context,
  GdkAtom $target,
  guint32 $time
)
  is native(gtk)
  is export
  { * }

sub gtk_drag_get_source_widget (GdkDragContext $context)
  returns GtkWidget
  is native(gtk)
  is export
  { * }

sub gtk_drag_highlight (GtkWidget $widget)
  is native(gtk)
  is export
  { * }

sub gtk_drag_set_icon_default (GdkDragContext $context)
  is native(gtk)
  is export
  { * }

sub gtk_drag_set_icon_gicon (
  GdkDragContext $context,
  GIcon $icon,
  gint $hot_x,
  gint $hot_y
)
  is native(gtk)
  is export
  { * }

sub gtk_drag_set_icon_name (
  GdkDragContext $context,
  gchar $icon_name,
  gint $hot_x,
  gint $hot_y
)
  is native(gtk)
  is export
  { * }

sub gtk_drag_set_icon_pixbuf (
  GdkDragContext $context,
  GdkPixbuf $pixbuf,
  gint $hot_x,
  gint $hot_y
)
  is native(gtk)
  is export
  { * }

sub gtk_drag_set_icon_stock (
  GdkDragContext $context,
  gchar $stock_id,
  gint $hot_x,
  gint $hot_y
)
  is native(gtk)
  is export
  { * }

sub gtk_drag_set_icon_surface (
  GdkDragContext $context,
  cairo_surface_t $surface
)
  is native(gtk)
  is export
  { * }

sub gtk_drag_set_icon_widget (
  GdkDragContext $context,
  GtkWidget $widget,
  gint $hot_x,
  gint $hot_y
)
  is native(gtk)
  is export
  { * }

sub gtk_drag_unhighlight (GtkWidget $widget)
  is native(gtk)
  is export
  { * }
