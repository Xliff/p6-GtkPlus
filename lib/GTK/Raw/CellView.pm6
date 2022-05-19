use v6.c;

use NativeCall;

use GDK::RGBA;
use GLib::Raw::Definitions;
use GLib::Raw::Enums;
use GTK::Raw::Definitions:ver<3.0.1146>;

unit package GTK::Raw::CellView:ver<3.0.1146>;

sub gtk_cell_view_get_size_of_row (
  GtkCellView $cell_view,
  GtkTreePath $path,
  GtkRequisition $requisition
)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_cell_view_get_type ()
  returns GType
  is native(gtk)
  is export
  { * }

sub gtk_cell_view_new ()
  returns GtkWidget
  is native(gtk)
  is export
  { * }

sub gtk_cell_view_new_with_context (
  GtkCellArea $area,
  GtkCellAreaContext $context
)
  returns GtkWidget
  is native(gtk)
  is export
  { * }

sub gtk_cell_view_new_with_markup (gchar $markup)
  returns GtkWidget
  is native(gtk)
  is export
  { * }

sub gtk_cell_view_new_with_pixbuf (GdkPixbuf $pixbuf)
  returns GtkWidget
  is native(gtk)
  is export
  { * }

sub gtk_cell_view_new_with_text (gchar $text)
  returns GtkWidget
  is native(gtk)
  is export
  { * }

sub gtk_cell_view_set_background_color (
  GtkCellView $cell_view,
  GdkColor $color
)
  is native(gtk)
  is export
  { * }

sub gtk_cell_view_set_background_rgba (GtkCellView $cell_view, GdkRGBA $rgba)
  is native(gtk)
  is export
  { * }

sub gtk_cell_view_get_draw_sensitive (GtkCellView $cell_view)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_cell_view_get_fit_model (GtkCellView $cell_view)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_cell_view_get_displayed_row (GtkCellView $cell_view)
  returns GtkTreePath
  is native(gtk)
  is export
  { * }

sub gtk_cell_view_get_model (GtkCellView $cell_view)
  returns GtkTreeModel
  is native(gtk)
  is export
  { * }

sub gtk_cell_view_set_draw_sensitive (
  GtkCellView $cell_view,
  gboolean $draw_sensitive
)
  is native(gtk)
  is export
  { * }

sub gtk_cell_view_set_fit_model (GtkCellView $cell_view, gboolean $fit_model)
  is native(gtk)
  is export
  { * }

sub gtk_cell_view_set_displayed_row (GtkCellView $cell_view, GtkTreePath $path)
  is native(gtk)
  is export
  { * }

sub gtk_cell_view_set_model (GtkCellView $cell_view, GtkTreeModel $model)
  is native(gtk)
  is export
  { * }
