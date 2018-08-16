use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::Types;

unit package GTK::Raw::LevelBar

sub gtk_level_bar_get_offset_value (GtkLevelBar $self, gchar $name, gdouble $value)
  returns uint32
  is native('gtk-3')
  is export
  { * }

sub gtk_level_bar_get_type ()
  returns GType
  is native('gtk-3')
  is export
  { * }

sub gtk_level_bar_new ()
  returns GtkWidget
  is native('gtk-3')
  is export
  { * }

sub gtk_level_bar_new_for_interval (gdouble $min_value, gdouble $max_value)
  returns GtkWidget
  is native('gtk-3')
  is export
  { * }

sub gtk_level_bar_get_inverted (GtkLevelBar $self)
  returns uint32
  is native('gtk-3')
  is export
  { * }

sub gtk_level_bar_get_max_value (GtkLevelBar $self)
  returns gdouble
  is native('gtk-3')
  is export
  { * }

sub gtk_level_bar_get_value (GtkLevelBar $self)
  returns gdouble
  is native('gtk-3')
  is export
  { * }

sub gtk_level_bar_get_min_value (GtkLevelBar $self)
  returns gdouble
  is native('gtk-3')
  is export
  { * }

sub gtk_level_bar_get_mode (GtkLevelBar $self)
  returns GtkLevelBarMode
  is native('gtk-3')
  is export
  { * }

sub gtk_level_bar_set_inverted (GtkLevelBar $self, gboolean $inverted)
  is native('gtk-3')
  is export
  { * }

sub gtk_level_bar_set_max_value (GtkLevelBar $self, gdouble $value)
  is native('gtk-3')
  is export
  { * }

sub gtk_level_bar_remove_offset_value (GtkLevelBar $self, gchar $name)
  is native('gtk-3')
  is export
  { * }

sub gtk_level_bar_set_min_value (GtkLevelBar $self, gdouble $value)
  is native('gtk-3')
  is export
  { * }

sub gtk_level_bar_set_mode (GtkLevelBar $self, GtkLevelBarMode $mode)
  is native('gtk-3')
  is export
  { * }
