use v6.c;

use NativeCall;


use GTK::Raw::Types;

unit package GTK::Raw::StackSwitcher;

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
