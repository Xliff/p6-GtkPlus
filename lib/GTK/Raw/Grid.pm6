use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Enums;
use GTK::Raw::Definitions:ver<3.0.1146>;

unit package GTK::Raw::Grid:ver<3.0.1146>;

sub gtk_grid_attach (
  GtkGrid $grid,
  GtkWidget $child,
  gint $left,
  gint $top,
  gint $width,
  gint $height
)
  is native(gtk)
  is export
  { * }

sub gtk_grid_attach_next_to (
  GtkGrid $grid,
  GtkWidget $child,
  GtkWidget $sibling,
  uint32 $side,                   # GtkPositionType $side,
  gint $width,
  gint $height
)
  is native(gtk)
  is export
  { * }

sub gtk_grid_get_child_at (GtkGrid $grid, gint $left, gint $top)
  returns GtkWidget
  is native(gtk)
  is export
  { * }

sub gtk_grid_get_row_baseline_position (GtkGrid $grid, gint $row)
  returns uint32 # GtkBaselinePosition
  is native(gtk)
  is export
  { * }

sub gtk_grid_get_type ()
  returns GType
  is native(gtk)
  is export
  { * }

sub gtk_grid_insert_column (GtkGrid $grid, gint $position)
  is native(gtk)
  is export
  { * }

sub gtk_grid_insert_next_to (
  GtkGrid $grid,
  GtkWidget $sibling,
  uint32 $side                    # GtkPositionType $side
)
  is native(gtk)
  is export
  { * }

sub gtk_grid_insert_row (GtkGrid $grid, gint $position)
  is native(gtk)
  is export
  { * }

sub gtk_grid_new ()
  returns GtkWidget
  is native(gtk)
  is export
  { * }

sub gtk_grid_remove_column (GtkGrid $grid, gint $position)
  is native(gtk)
  is export
  { * }

sub gtk_grid_remove_row (GtkGrid $grid, gint $position)
  is native(gtk)
  is export
  { * }

sub gtk_grid_set_row_baseline_position (
  GtkGrid $grid,
  gint $row,
  uint32                          # GtkBaselinePosition $pos
)
  is native(gtk)
  is export
  { * }

sub gtk_grid_get_column_homogeneous (GtkGrid $grid)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_grid_get_column_spacing (GtkGrid $grid)
  returns guint
  is native(gtk)
  is export
  { * }

sub gtk_grid_get_baseline_row (GtkGrid $grid)
  returns gint
  is native(gtk)
  is export
  { * }

sub gtk_grid_get_row_homogeneous (GtkGrid $grid)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_grid_get_row_spacing (GtkGrid $grid)
  returns guint
  is native(gtk)
  is export
  { * }

sub gtk_grid_set_column_homogeneous (GtkGrid $grid, gboolean $homogeneous)
  is native(gtk)
  is export
  { * }

sub gtk_grid_set_column_spacing (GtkGrid $grid, guint $spacing)
  is native(gtk)
  is export
  { * }

sub gtk_grid_set_baseline_row (GtkGrid $grid, gint $row)
  is native(gtk)
  is export
  { * }

sub gtk_grid_set_row_homogeneous (GtkGrid $grid, gboolean $homogeneous)
  is native(gtk)
  is export
  { * }

sub gtk_grid_set_row_spacing (GtkGrid $grid, guint $spacing)
  is native(gtk)
  is export
  { * }