use v6.c;

use NativeCall;


use GTK::Raw::Types;

unit package GTK::Raw::StackSidebar;

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