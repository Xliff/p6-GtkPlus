use v6.c;

use NativeCall;


use GTK::Raw::Types;

unit package GTK::Raw::Buildable;

sub gtk_buildable_add_child (
  GtkBuildable $buildable,
  GtkBuilder $builder,
  GObject $child,
  gchar $type
)
  is native(gtk)
  is export
  { * }

sub gtk_buildable_construct_child (
  GtkBuildable $buildable,
  GtkBuilder $builder,
  gchar $name
)
  returns GObject
  is native(gtk)
  is export
  { * }

sub gtk_buildable_custom_finished (
  GtkBuildable $buildable,
  GtkBuilder $builder,
  GObject $child,
  gchar $tagname,
  gpointer $data
)
  is native(gtk)
  is export
  { * }

sub gtk_buildable_custom_tag_end (
  GtkBuildable $buildable,
  GtkBuilder $builder,
  GObject $child,
  gchar $tagname,
  gpointer $data
)
  is native(gtk)
  is export
  { * }

sub gtk_buildable_custom_tag_start (
  GtkBuildable $buildable,
  GtkBuilder $builder,
  GObject $child,
  gchar $tagname,
  GMarkupParser $parser,
  gpointer $data
)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_buildable_get_internal_child (
  GtkBuildable $buildable,
  GtkBuilder $builder,
  gchar $childname
)
  returns GObject
  is native(gtk)
  is export
  { * }

sub gtk_buildable_get_type ()
  returns GType
  is native(gtk)
  is export
  { * }

sub gtk_buildable_parser_finished (
  GtkBuildable $buildable,
  GtkBuilder $builder
)
  is native(gtk)
  is export
  { * }

sub gtk_buildable_set_buildable_property (
  GtkBuildable $buildable,
  GtkBuilder $builder,
  gchar $name,
  GValue $value
)
  is native(gtk)
  is export
  { * }

sub gtk_buildable_get_name (GtkBuildable $buildable)
  returns Str
  is native(gtk)
  is export
  { * }

sub gtk_buildable_set_name (GtkBuildable $buildable, gchar $name)
  is native(gtk)
  is export
  { * }