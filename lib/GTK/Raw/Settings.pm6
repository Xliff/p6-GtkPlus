use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Structs;
use GDK::Raw::Definitions;
use GTK::Raw::Definitions:ver<3.0.1146>;
use GTK::Raw::Structs:ver<3.0.1146>;

unit package GTK::Raw::Settings:ver<3.0.1146>;

sub gtk_settings_get_default ()
  returns GtkSettings
  is native(gtk)
  is export
  { * }

sub gtk_settings_get_for_screen (GdkScreen $screen)
  returns GtkSettings
  is native(gtk)
  is export
  { * }

sub gtk_settings_get_type ()
  returns GType
  is native(gtk)
  is export
  { * }

sub gtk_rc_property_parse_border (
  GParamSpec $pspec,
  GString $gstring,
  GValue $property_value
)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_rc_property_parse_color (
  GParamSpec $pspec,
  GString $gstring,
  GValue $property_value
)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_rc_property_parse_enum (
  GParamSpec $pspec,
  GString $gstring,
  GValue $property_value
)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_rc_property_parse_flags (
  GParamSpec $pspec,
  GString $gstring,
  GValue $property_value
)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_rc_property_parse_requisition (
  GParamSpec $pspec,
  GString $gstring,
  GValue $property_value
)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_settings_install_property (GParamSpec $pspec)
  is native(gtk)
  is export
  { * }

sub gtk_settings_install_property_parser (
  GParamSpec $pspec,
  Pointer $parser             # GtkRcPropertyParser, which is deprecated
)
  is native(gtk)
  is export
  { * }

sub gtk_settings_reset_property (GtkSettings $settings, Str $name)
  is native(gtk)
  is export
  { * }

sub gtk_settings_set_double_property (
  GtkSettings $settings,
  Str $name,
  gdouble $v_double,
  Str $origin
)
  is native(gtk)
  is export
  { * }

sub gtk_settings_set_long_property (
  GtkSettings $settings,
  Str $name,
  glong $v_long,
  Str $origin
)
  is native(gtk)
  is export
  { * }

sub gtk_settings_set_property_value (
  GtkSettings $settings,
  Str $name,
  GtkSettingsValue $svalue
)
  is native(gtk)
  is export
  { * }

sub gtk_settings_set_string_property (
  GtkSettings $settings,
  Str $name,
  Str $v_string,
  Str $origin
)
  is native(gtk)
  is export
  { * }
