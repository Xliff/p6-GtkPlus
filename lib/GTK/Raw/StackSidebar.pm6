use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Enums;
use GTK::Raw::Definitions:ver<3.0.1146>;

unit package GTK::Raw::StackSidebar:ver<3.0.1146>;

sub gtk_stack_sidebar_get_type ()
  returns GType
  is native(gtk)
  is export
  { * }

sub gtk_stack_sidebar_new ()
  returns GtkWidget
  is native(gtk)
  is export
  { * }

sub gtk_stack_sidebar_get_stack (GtkStackSidebar $sidebar)
  returns GtkStack
  is native(gtk)
  is export
  { * }

sub gtk_stack_sidebar_set_stack (GtkStackSidebar $sidebar, GtkStack $stack)
  is native(gtk)
  is export
  { * }