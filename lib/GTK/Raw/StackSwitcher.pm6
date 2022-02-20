use v6.c;

use NativeCall;


use GTK::Raw::Types:ver<3.0.1146>;

unit package GTK::Raw::StackSwitcher:ver<3.0.1146>;

sub gtk_stack_switcher_get_type ()
  returns GType
  is native(gtk)
  is export
  { * }

sub gtk_stack_switcher_new ()
  returns GtkStackSwitcher
  is native(gtk)
  is export
  { * }

sub gtk_stack_switcher_get_stack (GtkStackSwitcher $switcher)
  returns GtkStack
  is native(gtk)
  is export
  { * }

sub gtk_stack_switcher_set_stack (GtkStackSwitcher $switcher, GtkStack $stack)
  is native(gtk)
  is export
  { * }
