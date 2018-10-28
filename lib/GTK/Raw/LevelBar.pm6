use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::Types;

unit package GTK::Raw::LevelBar;

sub gtk_level_bar_get_offset_value (
  GtkLevelBar $self,
  gchar $name,
  gdouble $value
)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_level_bar_get_type ()
  returns GType
  is native(gtk)
  is export
  { * }

sub gtk_level_bar_new ()
  returns GtkWidget
  is native(gtk)
  is export
  { * }

sub gtk_level_bar_new_for_interval (gdouble $min_value, gdouble $max_value)
  returns GtkWidget
  is native(gtk)
  is export
  { * }

sub gtk_level_bar_get_inverted (GtkLevelBar $self)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_level_bar_get_max_value (GtkLevelBar $self)
  returns gdouble
  is native(gtk)
  is export
  { * }

sub gtk_level_bar_get_value (GtkLevelBar $self)
  returns gdouble
  is native(gtk)
  is export
  { * }

sub gtk_level_bar_get_min_value (GtkLevelBar $self)
  returns gdouble
  is native(gtk)
  is export
  { * }

sub gtk_level_bar_get_mode (GtkLevelBar $self)
  returns uint32 # GtkLevelBarMode
  is native(gtk)
  is export
  { * }

sub gtk_level_bar_set_inverted (GtkLevelBar $self, gboolean $inverted)
  is native(gtk)
  is export
  { * }

sub gtk_level_bar_set_max_value (GtkLevelBar $self, gdouble $value)
  is native(gtk)
  is export
  { * }

sub gtk_level_bar_remove_offset_value (GtkLevelBar $self, gchar $name)
  is native(gtk)
  is export
  { * }

sub gtk_level_bar_set_min_value (GtkLevelBar $self, gdouble $value)
  is native(gtk)
  is export
  { * }

sub gtk_level_bar_set_mode (
  GtkLevelBar $self,
  uint32 $mode                  # GtkLevelBarMode $mode
)
  is native(gtk)
  is export
  { * }

sub gtk_level_bar_add_offset_value (
  GtkLevelBar $self,
  gchar $name,
  gdouble $value
)
  is native(gtk)
  is export
  { * }

sub gtk_level_bar_set_value (GtkLevelBar $self, gdouble $value)
  is native(gtk)
  is export
  { * }