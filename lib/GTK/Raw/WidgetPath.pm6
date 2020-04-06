use v6.c;

use NativeCall;


use GTK::Raw::Types;

unit package GTK::Raw::WidgetPath;

sub gtk_widget_path_append_for_widget (
  GtkWidgetPath $path,
  GtkWidget $widget
)
  returns gint
  is native(gtk)
  is export
  { * }

sub gtk_widget_path_append_type (GtkWidgetPath $path, GType $type)
  returns gint
  is native(gtk)
  is export
  { * }

sub gtk_widget_path_append_with_siblings (
  GtkWidgetPath $path,
  GtkWidgetPath $siblings,
  guint $sibling_index
)
  returns gint
  is native(gtk)
  is export
  { * }

sub gtk_widget_path_copy (GtkWidgetPath $path)
  returns GtkWidgetPath
  is native(gtk)
  is export
  { * }

sub gtk_widget_path_free (GtkWidgetPath $path)
  is native(gtk)
  is export
  { * }

sub gtk_widget_path_get_object_type (GtkWidgetPath $path)
  returns GType
  is native(gtk)
  is export
  { * }

sub gtk_widget_path_get_type ()
  returns GType
  is native(gtk)
  is export
  { * }

sub gtk_widget_path_has_parent (GtkWidgetPath $path, GType $type)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_widget_path_is_type (GtkWidgetPath $path, GType $type)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_widget_path_iter_add_class (
  GtkWidgetPath $path,
  gint $pos,
  gchar $name
)
  is native(gtk)
  is export
  { * }

sub gtk_widget_path_iter_add_region (
  GtkWidgetPath $path,
  gint $pos,
  gchar $name,
  uint32 $flags                 # GtkRegionFlags $flags
)
  is native(gtk)
  is export
  { * }

sub gtk_widget_path_iter_clear_classes (GtkWidgetPath $path, gint $pos)
  is native(gtk)
  is export
  { * }

sub gtk_widget_path_iter_clear_regions (GtkWidgetPath $path, gint $pos)
  is native(gtk)
  is export
  { * }

sub gtk_widget_path_iter_get_name (GtkWidgetPath $path, gint $pos)
  returns Str
  is native(gtk)
  is export
  { * }

sub gtk_widget_path_iter_get_object_name (GtkWidgetPath $path, gint $pos)
  returns gchar
  is native(gtk)
  is export
  { * }

sub gtk_widget_path_iter_get_sibling_index (GtkWidgetPath $path, gint $pos)
  returns guint
  is native(gtk)
  is export
  { * }

sub gtk_widget_path_iter_get_siblings (GtkWidgetPath $path, gint $pos)
  returns GtkWidgetPath
  is native(gtk)
  is export
  { * }

sub gtk_widget_path_iter_get_state (GtkWidgetPath $path, gint $pos)
  returns uint32 # GtkStateFlags
  is native(gtk)
  is export
  { * }

sub gtk_widget_path_iter_has_class (
  GtkWidgetPath $path,
  gint $pos,
  gchar $name
)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_widget_path_iter_has_name (
  GtkWidgetPath $path,
  gint $pos,
  gchar $name
)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_widget_path_iter_has_qclass (
  GtkWidgetPath $path,
  gint $pos,
  GQuark $qname
)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_widget_path_iter_has_qname (
  GtkWidgetPath $path,
  gint $pos,
  GQuark $qname
)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_widget_path_iter_has_qregion (
  GtkWidgetPath $path,
  gint $pos,
  GQuark $qname,
  uint32 $flags                 # GtkRegionFlags $flags
)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_widget_path_iter_has_region (
  GtkWidgetPath $path,
  gint $pos,
  gchar $name,
  uint32 $flags                 # GtkRegionFlags $flags
)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_widget_path_iter_list_classes (GtkWidgetPath $path, gint $pos)
  returns GSList
  is native(gtk)
  is export
  { * }

sub gtk_widget_path_iter_list_regions (GtkWidgetPath $path, gint $pos)
  returns GSList
  is native(gtk)
  is export
  { * }

sub gtk_widget_path_iter_remove_class (
  GtkWidgetPath $path,
  gint $pos,
  gchar $name
)
  is native(gtk)
  is export
  { * }

sub gtk_widget_path_iter_remove_region (
  GtkWidgetPath $path,
  gint $pos,
  gchar $name
)
  is native(gtk)
  is export
  { * }

sub gtk_widget_path_iter_set_name (
  GtkWidgetPath $path,
  gint $pos,
  gchar $name
)
  is native(gtk)
  is export
  { * }

sub gtk_widget_path_iter_set_object_name (
  GtkWidgetPath $path,
  gint $pos,
  gchar $name
)
  is native(gtk)
  is export
  { * }

sub gtk_widget_path_iter_set_object_type (
  GtkWidgetPath $path,
  gint $pos,
  GType $type
)
  is native(gtk)
  is export
  { * }

sub gtk_widget_path_iter_set_state (
  GtkWidgetPath $path,
  gint $pos,
  uint32 $flags                 # GtkStateFlags $flags
)
  is native(gtk)
  is export
  { * }

sub gtk_widget_path_length (GtkWidgetPath $path)
  returns gint
  is native(gtk)
  is export
  { * }

sub gtk_widget_path_new ()
  returns GtkWidgetPath
  is native(gtk)
  is export
  { * }

sub gtk_widget_path_prepend_type (GtkWidgetPath $path, GType $type)
  is native(gtk)
  is export
  { * }

sub gtk_widget_path_ref (GtkWidgetPath $path)
  returns GtkWidgetPath
  is native(gtk)
  is export
  { * }

sub gtk_widget_path_to_string (GtkWidgetPath $path)
  returns gchar
  is native(gtk)
  is export
  { * }

sub gtk_widget_path_unref (GtkWidgetPath $path)
  is native(gtk)
  is export
  { * }
