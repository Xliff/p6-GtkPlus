use v6.c;

use NativeCall;


use GTK::Raw::Types:ver<3.0.1146>;

unit package GTK::Raw::CellAreaContext:ver<3.0.1146>;

sub gtk_cell_area_context_allocate (
  GtkCellAreaContext $context,
  gint $width,
  gint $height
)
  is native(gtk)
  is export
  { * }

sub gtk_cell_area_context_get_allocation (
  GtkCellAreaContext $context,
  gint $width,
  gint $height
)
  is native(gtk)
  is export
  { * }

sub gtk_cell_area_context_get_area (GtkCellAreaContext $context)
  returns GtkCellArea
  is native(gtk)
  is export
  { * }

sub gtk_cell_area_context_get_preferred_height (
  GtkCellAreaContext $context,
  gint $minimum_height,
  gint $natural_height
)
  is native(gtk)
  is export
  { * }

sub gtk_cell_area_context_get_preferred_height_for_width (
  GtkCellAreaContext $context,
  gint $width,
  gint $minimum_height,
  gint $natural_height
)
  is native(gtk)
  is export
  { * }

sub gtk_cell_area_context_get_preferred_width (
  GtkCellAreaContext $context,
  gint $minimum_width,
  gint $natural_width
)
  is native(gtk)
  is export
  { * }

sub gtk_cell_area_context_get_preferred_width_for_height (
  GtkCellAreaContext $context,
  gint $height,
  gint $minimum_width,
  gint $natural_width
)
  is native(gtk)
  is export
  { * }

sub gtk_cell_area_context_get_type ()
  returns GType
  is native(gtk)
  is export
  { * }

sub gtk_cell_area_context_push_preferred_height (
  GtkCellAreaContext $context,
  gint $minimum_height,
  gint $natural_height
)
  is native(gtk)
  is export
  { * }

sub gtk_cell_area_context_push_preferred_width (
  GtkCellAreaContext $context,
  gint $minimum_width,
  gint $natural_width
)
  is native(gtk)
  is export
  { * }

sub gtk_cell_area_context_reset (GtkCellAreaContext $context)
  is native(gtk)
  is export
  { * }