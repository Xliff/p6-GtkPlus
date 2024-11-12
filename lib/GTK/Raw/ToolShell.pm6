use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Structs;
use GTK::Raw::Definitions:ver<3.0.1146>;
use GTK::Raw::Structs:ver<3.0.1146>;

unit package GTK::Raw::ToolShell:ver<3.0.1146>;

sub gtk_tool_shell_get_ellipsize_mode (GtkToolShell $shell)
  returns uint32 # PangoEllipsizeMode
  is native(gtk)
  is export
  { * }

sub gtk_tool_shell_get_icon_size (GtkToolShell $shell)
  returns uint32 # GtkIconSize
  is native(gtk)
  is export
  { * }

sub gtk_tool_shell_get_orientation (GtkToolShell $shell)
  returns uint32 # GtkOrientation
  is native(gtk)
  is export
  { * }

sub gtk_tool_shell_get_relief_style (GtkToolShell $shell)
  returns uint32 # GtkReliefStyle
  is native(gtk)
  is export
  { * }

sub gtk_tool_shell_get_style (GtkToolShell $shell)
  returns uint32 # GtkToolbarStyle
  is native(gtk)
  is export
  { * }

sub gtk_tool_shell_get_text_alignment (GtkToolShell $shell)
  returns gfloat
  is native(gtk)
  is export
  { * }

sub gtk_tool_shell_get_text_orientation (GtkToolShell $shell)
  returns uint32 # GtkOrientation
  is native(gtk)
  is export
  { * }

sub gtk_tool_shell_get_text_size_group (GtkToolShell $shell)
  returns uint32 # GtkSizeGroup
  is native(gtk)
  is export
  { * }

sub gtk_tool_shell_get_type ()
  returns GType
  is native(gtk)
  is export
  { * }

sub gtk_tool_shell_rebuild_menu (GtkToolShell $shell)
  is native(gtk)
  is export
  { * }
