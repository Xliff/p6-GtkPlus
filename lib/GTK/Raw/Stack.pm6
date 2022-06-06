use v6.c;

use NativeCall;


use GTK::Raw::Types:ver<3.0.1146>;

unit package GTK::Raw::Stack:ver<3.0.1146>;

sub gtk_stack_add_named (GtkStack $stack, GtkWidget $child, gchar $name)
  is native(gtk)
  is export
  { * }

sub gtk_stack_add_titled (
  GtkStack $stack,
  GtkWidget $child,
  gchar $name,
  gchar $title
)
  is native(gtk)
  is export
  { * }

sub gtk_stack_get_child_by_name (GtkStack $stack, gchar $name)
  returns GtkWidget
  is native(gtk)
  is export
  { * }

sub gtk_stack_get_transition_running (GtkStack $stack)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_stack_get_type ()
  returns GType
  is native(gtk)
  is export
  { * }

sub gtk_stack_new ()
  returns GtkWidget
  is native(gtk)
  is export
  { * }

sub gtk_stack_set_visible_child_full (
  GtkStack $stack,
  gchar $name,
  uint32 $transition            # GtkStackTransitionType $transition
)
  is native(gtk)
  is export
  { * }

sub gtk_stack_get_transition_type (GtkStack $stack)
  returns uint32 # GtkStackTransitionType
  is native(gtk)
  is export
  { * }

sub gtk_stack_get_visible_child (GtkStack $stack)
  returns GtkWidget
  is native(gtk)
  is export
  { * }

sub gtk_stack_get_visible_child_name (GtkStack $stack)
  returns Str
  is native(gtk)
  is export
  { * }

sub gtk_stack_get_hhomogeneous (GtkStack $stack)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_stack_get_interpolate_size (GtkStack $stack)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_stack_get_transition_duration (GtkStack $stack)
  returns guint
  is native(gtk)
  is export
  { * }

sub gtk_stack_get_vhomogeneous (GtkStack $stack)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_stack_get_homogeneous (GtkStack $stack)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_stack_set_transition_type (
  GtkStack $stack,
  uint32 $transition          # GtkStackTransitionType $transition
)
  is native(gtk)
  is export
  { * }

sub gtk_stack_set_visible_child (GtkStack $stack, GtkWidget $child)
  is native(gtk)
  is export
  { * }

sub gtk_stack_set_visible_child_name (GtkStack $stack, gchar $name)
  is native(gtk)
  is export
  { * }

sub gtk_stack_set_hhomogeneous (GtkStack $stack, gboolean $hhomogeneous)
  is native(gtk)
  is export
  { * }

sub gtk_stack_set_interpolate_size (
  GtkStack $stack,
  gboolean $interpolate_size
)
  is native(gtk)
  is export
  { * }

sub gtk_stack_set_transition_duration (GtkStack $stack, guint $duration)
  is native(gtk)
  is export
  { * }

sub gtk_stack_set_vhomogeneous (GtkStack $stack, gboolean $vhomogeneous)
  is native(gtk)
  is export
  { * }

sub gtk_stack_set_homogeneous (GtkStack $stack, gboolean $homogeneous)
  is native(gtk)
  is export
  { * }

sub gtk_stack_switcher_new ()
  returns GtkStackSwitcher
  is native(gtk)
  is export
  { * }

sub gtk_stack_switcher_set_stack (
  GtkStackSwitcher $switcher,
  GtkStack $stack
)
  is native(gtk)
  is export
  { * }