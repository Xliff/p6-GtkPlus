use v6.c;

use NativeCall;


use GTK::Raw::Types;

unit package GTK::Raw::Builder;

sub gtk_builder_add_callback_symbol (
  GtkBuilder $builder,
  Str $callback_name,
  &callback_symbol (Pointer, Pointer)
)
  is native(gtk)
  is export
  { * }

sub gtk_builder_add_from_file (
  GtkBuilder $builder,
  gchar $filename,
  CArray[Pointer[GError]] $error
)
  returns guint
  is native(gtk)
  is export
  { * }

sub gtk_builder_add_from_resource (
  GtkBuilder $builder,
  gchar $resource_path,
  CArray[Pointer[GError]] $error
)
  returns guint
  is native(gtk)
  is export
  { * }

sub gtk_builder_add_from_string (
  GtkBuilder $builder,
  gchar $buffer,
  gsize $length,
  CArray[Pointer[GError]] $error
)
  returns guint
  is native(gtk)
  is export
  { * }

sub gtk_builder_add_objects_from_file (
  GtkBuilder $builder,
  gchar $filename,
  CArray[Str] $object_ids,
  CArray[Pointer[GError]] $error
)
  returns guint
  is native(gtk)
  is export
  { * }

sub gtk_builder_add_objects_from_resource (
  GtkBuilder $builder,
  gchar $resource_path,
  CArray[Str] $object_ids,
  CArray[Pointer[GError]] $error
)
  returns guint
  is native(gtk)
  is export
  { * }

sub gtk_builder_add_objects_from_string (
  GtkBuilder $builder,
  gchar $buffer,
  gsize $length,
  CArray[Str] $object_ids,
  CArray[Pointer[GError]] $error
)
  returns guint
  is native(gtk)
  is export
  { * }

sub gtk_builder_connect_signals (
  GtkBuilder $builder,
  gpointer $user_data
)
  is native(gtk)
  is export
  { * }

sub gtk_builder_connect_signals_full (
  GtkBuilder $builder,
  GtkBuilderConnectFunc $func,
  gpointer $user_data
)
  is native(gtk)
  is export
  { * }

sub gtk_builder_error_quark ()
  returns GQuark
  is native(gtk)
  is export
  { * }

sub gtk_builder_expose_object (
  GtkBuilder $builder,
  gchar $name,
  GObject $object
)
  is native(gtk)
  is export
  { * }

sub gtk_builder_extend_with_template (
  GtkBuilder $builder,
  GtkWidget $widget,
  GType $template_type,
  gchar $buffer,
  gsize $length,
  CArray[Pointer[GError]] $error
)
  returns guint
  is native(gtk)
  is export
  { * }

sub gtk_builder_get_object (GtkBuilder $builder, gchar $name)
  returns GtkWidget # GObject
  is native(gtk)
  is export
  { * }

sub gtk_builder_get_objects (GtkBuilder $builder)
  returns GSList
  is native(gtk)
  is export
  { * }

sub gtk_builder_get_type ()
  returns GType
  is native(gtk)
  is export
  { * }

sub gtk_builder_get_type_from_name (GtkBuilder $builder, gchar $type_name)
  returns GType
  is native(gtk)
  is export
  { * }

sub gtk_builder_lookup_callback_symbol (GtkBuilder $builder, gchar $callback_name)
  returns GCallback
  is native(gtk)
  is export
  { * }

sub gtk_builder_new ()
  returns GtkBuilder
  is native(gtk)
  is export
  { * }

sub gtk_builder_new_from_file (gchar $filename)
  returns GtkBuilder
  is native(gtk)
  is export
  { * }

sub gtk_builder_new_from_resource (gchar $resource_path)
  returns GtkBuilder
  is native(gtk)
  is export
  { * }

sub gtk_builder_new_from_string (gchar $string, gssize $length)
  returns GtkBuilder
  is native(gtk)
  is export
  { * }

sub gtk_builder_value_from_string (
  GtkBuilder $builder,
  GParamSpec $pspec,
  gchar $string,
  GValue $value,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_builder_value_from_string_type (
  GtkBuilder $builder,
  GType $type,
  gchar $string,
  GValue $value,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_builder_get_application (GtkBuilder $builder)
  returns GtkApplication
  is native(gtk)
  is export
  { * }

sub gtk_builder_get_translation_domain (GtkBuilder $builder)
  returns Str
  is native(gtk)
  is export
  { * }

sub gtk_builder_set_application (GtkBuilder $builder, GtkApplication $application)
  is native(gtk)
  is export
  { * }

sub gtk_builder_set_translation_domain (GtkBuilder $builder, gchar $domain)
  is native(gtk)
  is export
  { * }
