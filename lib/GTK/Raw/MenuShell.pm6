use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Enums;
use GTK::Raw::Definitions:ver<3.0.1146>;

unit package GTK::Raw::MenuShell:ver<3.0.1146>;

sub gtk_menu_shell_activate_item (
  GtkMenuShell $menu_shell,
  GtkWidget $menu_item,
  gboolean $force_deactivate
)
  is native(gtk)
  is export
  { * }

sub gtk_menu_shell_append (GtkMenuShell $menu_shell, GtkWidget $child)
  is native(gtk)
  is export
  { * }

sub gtk_menu_shell_bind_model (
  GtkMenuShell $menu_shell,
  GMenuModel $model,
  gchar $action_namespace,
  gboolean $with_separators
)
  is native(gtk)
  is export
  { * }

sub gtk_menu_shell_cancel (GtkMenuShell $menu_shell)
  is native(gtk)
  is export
  { * }

sub gtk_menu_shell_deactivate (GtkMenuShell $menu_shell)
  is native(gtk)
  is export
  { * }

sub gtk_menu_shell_deselect (GtkMenuShell $menu_shell)
  is native(gtk)
  is export
  { * }

sub gtk_menu_shell_get_parent_shell (GtkMenuShell $menu_shell)
  returns GtkWidget
  is native(gtk)
  is export
  { * }

sub gtk_menu_shell_get_selected_item (GtkMenuShell $menu_shell)
  returns GtkWidget
  is native(gtk)
  is export
  { * }

sub gtk_menu_shell_get_type ()
  returns GType
  is native(gtk)
  is export
  { * }

sub gtk_menu_shell_insert (
  GtkMenuShell $menu_shell,
  GtkWidget $child,
  gint $position
)
  is native(gtk)
  is export
  { * }

sub gtk_menu_shell_prepend (GtkMenuShell $menu_shell, GtkWidget $child)
  is native(gtk)
  is export
  { * }

sub gtk_menu_shell_select_first (
  GtkMenuShell $menu_shell,
  gboolean $search_sensitive
)
  is native(gtk)
  is export
  { * }

sub gtk_menu_shell_select_item (
  GtkMenuShell $menu_shell,
  GtkWidget $menu_item
)
  is native(gtk)
  is export
  { * }

sub gtk_menu_shell_get_take_focus (GtkMenuShell $menu_shell)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_menu_shell_set_take_focus (
  GtkMenuShell $menu_shell,
  gboolean $take_focus
)
  is native(gtk)
  is export
  { * }