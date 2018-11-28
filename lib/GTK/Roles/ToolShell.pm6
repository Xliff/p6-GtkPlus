use v6.c;

use Method::Also;
use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::ToolShell;
use GTK::Raw::Types;

use GTK::SizeGroup;

role GTK::Roles::ToolShell {
  has GtkToolShell $!shell;

  # ↓↓↓↓ SIGNALS ↓↓↓↓
  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ PROPERTIES ↓↓↓↓
  # ↑↑↑↑ PROPERTIES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  method get_ellipsize_mode
    is also<
      get-ellipsize-mode
      ellipsize-mode
      ellipsize_mode
    >
  {
    PangoEllipsizeMode( gtk_tool_shell_get_ellipsize_mode($!shell) );
  }

  method get_icon_size
    is also<
      get-icon-size
      icon-size
      icon_size
    >
  {
    GtkIconSize( gtk_tool_shell_get_icon_size($!shell) );
  }

  method get_orientation is also<get-orientation orientation> {
    GtkOrientation( gtk_tool_shell_get_orientation($!shell) );
  }

  method get_relief_style
    is also<
      get-relief-style
      relief-style
      relief_style
    >
  {
    GtkReliefStyle( gtk_tool_shell_get_relief_style($!shell) );
  }

  method get_style is also<get-style style> {
    GtkToolbarStyle( gtk_tool_shell_get_style($!shell) );
  }

  method get_text_alignment
    is also<
      get-text-alignment
      text-alignment
      text_alignment
    >
  {
    gtk_tool_shell_get_text_alignment($!shell);
  }

  method get_text_orientation
    is also<
      get-text-orientation
      text-orientation
      text_orientation
    >
  {
    gtk_tool_shell_get_text_orientation($!shell);
  }

  method get_text_size_group
    is also<
      get-text-size-group
      text-size-group
      text_size_group
    >
  {
    GTK::TextSize.new( gtk_tool_shell_get_text_size_group($!shell) );
  }

  method get_toolshell_type is also<get-toolshell-type > {
    gtk_tool_shell_get_type();
  }

  method rebuild_menu is also<rebuild-menu> {
    gtk_tool_shell_rebuild_menu($!shell);
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
