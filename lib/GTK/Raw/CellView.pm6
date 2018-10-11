use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::Types;

unit package GTK::Raw::CellView;

sub gtk_cell_view_get_size_of_row (
  GtkCellView $cell_view,
  GtkTreePath $path,
  GtkRequisition $requisition
)
  returns uint32
  is native('gtk-3')
  is export
  { * }

sub gtk_cell_view_get_type ()
  returns GType
  is native('gtk-3')
  is export
  { * }

sub gtk_cell_view_new ()
  returns GtkWidget
  is native('gtk-3')
  is export
  { * }

sub gtk_cell_view_new_with_context (
  GtkCellArea $area,
  GtkCellAreaContext $context
)
  returns GtkWidget
  is native('gtk-3')
  is export
  { * }

sub gtk_cell_view_new_with_markup (gchar $markup)
  returns GtkWidget
  is native('gtk-3')
  is export
  { * }

sub gtk_cell_view_new_with_pixbuf (GdkPixbuf $pixbuf)
  returns GtkWidget
  is native('gtk-3')
  is export
  { * }

sub gtk_cell_view_new_with_text (gchar $text)
  returns GtkWidget
  is native('gtk-3')
  is export
  { * }

sub gtk_cell_view_set_background_color (
  GtkCellView $cell_view,
  GdkColor $color
)
  is native('gtk-3')
  is export
  { * }

sub gtk_cell_view_set_background_rgba (GtkCellView $cell_view, GdkRGBA $rgba)
  is native('gtk-3')
  is export
  { * }

sub gtk_cell_view_get_draw_sensitive (GtkCellView $cell_view)
  returns uint32
  is native('gtk-3')
  is export
  { * }

sub gtk_cell_view_get_fit_model (GtkCellView $cell_view)
  returns uint32
  is native('gtk-3')
  is export
  { * }

sub gtk_cell_view_get_displayed_row (GtkCellView $cell_view)
  returns GtkTreePath
  is native('gtk-3')
  is export
  { * }

sub gtk_cell_view_get_model (GtkCellView $cell_view)
  returns GtkTreeModel
  is native('gtk-3')
  is export
  { * }

sub gtk_cell_view_set_draw_sensitive (
  GtkCellView $cell_view,
  gboolean $draw_sensitive
)
  is native('gtk-3')
  is export
  { * }

sub gtk_cell_view_set_fit_model (GtkCellView $cell_view, gboolean $fit_model)
  is native('gtk-3')
  is export
  { * }

sub gtk_cell_view_set_displayed_row (GtkCellView $cell_view, GtkTreePath $path)
  is native('gtk-3')
  is export
  { * }

sub gtk_cell_view_set_model (GtkCellView $cell_view, GtkTreeModel $model)
  is native('gtk-3')
  is export
  { * }
