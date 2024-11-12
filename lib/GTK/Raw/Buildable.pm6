use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Object;
use GLib::Raw::Structs;
use GTK::Raw::Definitions:ver<3.0.1146>;
use GTK::Raw::Structs:ver<3.0.1146>;

unit package GTK::Raw::Buildable:ver<3.0.1146>;

sub gtk_buildable_add_child (
  GtkBuildable $buildable,
  GtkBuilder $builder,
  GObject $child,
  Str $type
)
  is native(gtk)
  is export
  { * }

sub gtk_buildable_construct_child (
  GtkBuildable $buildable,
  GtkBuilder $builder,
  Str $name
)
  returns GObject
  is native(gtk)
  is export
  { * }

sub gtk_buildable_custom_finished (
  GtkBuildable $buildable,
  GtkBuilder $builder,
  GObject $child,
  Str $tagname,
  gpointer $data
)
  is native(gtk)
  is export
  { * }

sub gtk_buildable_custom_tag_end (
  GtkBuildable $buildable,
  GtkBuilder $builder,
  GObject $child,
  Str $tagname,
  gpointer $data
)
  is native(gtk)
  is export
  { * }

sub gtk_buildable_custom_tag_start (
  GtkBuildable $buildable,
  GtkBuilder $builder,
  GObject $child,
  Str $tagname,
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
  Str $childname
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
  Str $name,
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

sub gtk_buildable_set_name (GtkBuildable $buildable, Str $name)
  is native(gtk)
  is export
  { * }
