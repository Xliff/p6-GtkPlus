use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::Types;

unit package GTK::Raw::NoteBook;

sub gtk_notebook_append_page (
  GtkNotebook $notebook,
  GtkWidget $child,
  GtkWidget $tab_label
)
  returns gint
  is native(gtk)
  is export
  { * }

sub gtk_notebook_append_page_menu (
  GtkNotebook $notebook,
  GtkWidget $child,
  GtkWidget $tab_label,
  GtkWidget $menu_label
)
  returns gint
  is native(gtk)
  is export
  { * }

sub gtk_notebook_detach_tab (
  GtkNotebook $notebook,
  GtkWidget $child
)
  is native(gtk)
  is export
  { * }

sub gtk_notebook_get_action_widget (
  GtkNotebook $notebook,
  uint32 $pack_type           # GtkPackType $pack_type
)
  returns GtkWidget
  is native(gtk)
  is export
  { * }

sub gtk_notebook_get_menu_label (GtkNotebook $notebook, GtkWidget $child)
  returns GtkWidget
  is native(gtk)
  is export
  { * }

sub gtk_notebook_get_menu_label_text (GtkNotebook $notebook, GtkWidget $child)
  returns Str
  is native(gtk)
  is export
  { * }

sub gtk_notebook_get_n_pages (GtkNotebook $notebook)
  returns gint
  is native(gtk)
  is export
  { * }

sub gtk_notebook_get_nth_page (GtkNotebook $notebook, gint $page_num)
  returns GtkWidget
  is native(gtk)
  is export
  { * }

sub gtk_notebook_get_tab_detachable (GtkNotebook $notebook, GtkWidget $child)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_notebook_get_tab_hborder (GtkNotebook $notebook)
  returns guint16
  is native(gtk)
  is export
  { * }

sub gtk_notebook_get_tab_label (GtkNotebook $notebook, GtkWidget $child)
  returns GtkWidget
  is native(gtk)
  is export
  { * }

sub gtk_notebook_get_tab_label_text (GtkNotebook $notebook, GtkWidget $child)
  returns Str
  is native(gtk)
  is export
  { * }

sub gtk_notebook_get_tab_reorderable (GtkNotebook $notebook, GtkWidget $child)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_notebook_get_tab_vborder (GtkNotebook $notebook)
  returns guint16
  is native(gtk)
  is export
  { * }

sub gtk_notebook_get_type ()
  returns GType
  is native(gtk)
  is export
  { * }

sub gtk_notebook_insert_page (
  GtkNotebook $notebook,
  GtkWidget $child,
  GtkWidget $tab_label,
  gint $position
)
  returns gint
  is native(gtk)
  is export
  { * }

sub gtk_notebook_insert_page_menu (
  GtkNotebook $notebook,
  GtkWidget $child,
  GtkWidget $tab_label,
  GtkWidget $menu_label,
  gint $position
)
  returns gint
  is native(gtk)
  is export
  { * }

sub gtk_notebook_new ()
  returns GtkWidget
  is native(gtk)
  is export
  { * }

sub gtk_notebook_next_page (GtkNotebook $notebook)
  is native(gtk)
  is export
  { * }

sub gtk_notebook_page_num (GtkNotebook $notebook, GtkWidget $child)
  returns gint
  is native(gtk)
  is export
  { * }

sub gtk_notebook_popup_disable (GtkNotebook $notebook)
  is native(gtk)
  is export
  { * }

sub gtk_notebook_popup_enable (GtkNotebook $notebook)
  is native(gtk)
  is export
  { * }

sub gtk_notebook_prepend_page (
  GtkNotebook $notebook,
  GtkWidget $child,
  GtkWidget $tab_label
)
  returns gint
  is native(gtk)
  is export
  { * }

sub gtk_notebook_prepend_page_menu (
  GtkNotebook $notebook,
  GtkWidget $child,
  GtkWidget $tab_label,
  GtkWidget $menu_label
)
  returns gint
  is native(gtk)
  is export
  { * }

sub gtk_notebook_prev_page (GtkNotebook $notebook)
  is native(gtk)
  is export
  { * }

sub gtk_notebook_remove_page (GtkNotebook $notebook, gint $page_num)
  is native(gtk)
  is export
  { * }

sub gtk_notebook_reorder_child (
  GtkNotebook $notebook,
  GtkWidget $child,
  gint $position
)
  is native(gtk)
  is export
  { * }

sub gtk_notebook_set_action_widget (
  GtkNotebook $notebook,
  GtkWidget $widget,
  uint32 $pack_type           # GtkPackType $pack_type
)
  is native(gtk)
  is export
  { * }

sub gtk_notebook_set_menu_label (
  GtkNotebook $notebook,
  GtkWidget $child,
  GtkWidget $menu_label
)
  is native(gtk)
  is export
  { * }

sub gtk_notebook_set_menu_label_text (
  GtkNotebook $notebook,
  GtkWidget $child,
  gchar $menu_text
)
  is native(gtk)
  is export
  { * }

sub gtk_notebook_set_tab_detachable (
  GtkNotebook $notebook,
  GtkWidget $child,
  gboolean $detachable
)
  is native(gtk)
  is export
  { * }

sub gtk_notebook_set_tab_label (
  GtkNotebook $notebook,
  GtkWidget $child,
  GtkWidget $tab_label
)
  is native(gtk)
  is export
  { * }

sub gtk_notebook_set_tab_label_text (
  GtkNotebook $notebook,
  GtkWidget $child,
  gchar $tab_text
)
  is native(gtk)
  is export
  { * }

sub gtk_notebook_set_tab_reorderable (
  GtkNotebook $notebook,
  GtkWidget $child,
  gboolean $reorderable
)
  is native(gtk)
  is export
  { * }

sub gtk_notebook_get_show_border (GtkNotebook $notebook)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_notebook_get_tab_pos (GtkNotebook $notebook)
  returns uint32 # GtkPositionType
  is native(gtk)
  is export
  { * }

sub gtk_notebook_get_group_name (GtkNotebook $notebook)
  returns Str
  is native(gtk)
  is export
  { * }

sub gtk_notebook_get_show_tabs (GtkNotebook $notebook)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_notebook_get_scrollable (GtkNotebook $notebook)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_notebook_get_current_page (GtkNotebook $notebook)
  returns gint
  is native(gtk)
  is export
  { * }

sub gtk_notebook_set_show_border (GtkNotebook $notebook, gboolean $show_border)
  is native(gtk)
  is export
  { * }

sub gtk_notebook_set_tab_pos (
  GtkNotebook $notebook,
  uint32 $pos                 # GtkPositionType $pos
)
  is native(gtk)
  is export
  { * }

sub gtk_notebook_set_group_name (GtkNotebook $notebook, gchar $group_name)
  is native(gtk)
  is export
  { * }

sub gtk_notebook_set_show_tabs (GtkNotebook $notebook, gboolean $show_tabs)
  is native(gtk)
  is export
  { * }

sub gtk_notebook_set_scrollable (GtkNotebook $notebook, gboolean $scrollable)
  is native(gtk)
  is export
  { * }

sub gtk_notebook_set_current_page (GtkNotebook $notebook, gint $page_num)
  is native(gtk)
  is export
  { * }