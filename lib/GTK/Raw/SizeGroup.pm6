use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::Types;

unit package GTK::Raw::SizeGroup;

sub gtk_size_group_add_widget (GtkSizeGroup $size_group, GtkWidget $widget)
  is native('gtk-3')
  is export
  { * }

sub gtk_size_group_get_type ()
  returns GType
  is native('gtk-3')
  is export
  { * }

sub gtk_size_group_get_widgets (GtkSizeGroup $size_group)
  returns GSList
  is native('gtk-3')
  is export
  { * }

sub gtk_size_group_new (
  uint32 $mode                    # GtkSizeGroupMode $mode
)
  returns GtkSizeGroup
  is native('gtk-3')
  is export
  { * }

sub gtk_size_group_remove_widget (GtkSizeGroup $size_group, GtkWidget $widget)
  is native('gtk-3')
  is export
  { * }

sub gtk_size_group_get_ignore_hidden (GtkSizeGroup $size_group)
  returns uint32
  is native('gtk-3')
  is export
  { * }

sub gtk_size_group_get_mode (GtkSizeGroup $size_group)
  returns uint32 # GtkSizeGroupMode
  is native('gtk-3')
  is export
  { * }

sub gtk_size_group_set_ignore_hidden (
  GtkSizeGroup $size_group,
  gboolean $ignore_hidden
)
  is native('gtk-3')
  is export
  { * }

sub gtk_size_group_set_mode (
  GtkSizeGroup $size_group,
  uint32 $mode                    # GtkSizeGroupMode $mode
)
  is native('gtk-3')
  is export
  { * }
