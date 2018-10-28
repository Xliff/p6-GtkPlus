use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::Types;

unit package GTK::Raw::Revealer;

sub gtk_revealer_get_child_revealed (GtkRevealer $revealer)
  returns uint32
  is native($LIBGTK)
  is export
  { * }

sub gtk_revealer_get_type ()
  returns GType
  is native($LIBGTK)
  is export
  { * }

sub gtk_revealer_new ()
  returns GtkWidget
  is native($LIBGTK)
  is export
  { * }

sub gtk_revealer_get_transition_type (GtkRevealer $revealer)
  returns uint32 # GtkRevealerTransitionType
  is native($LIBGTK)
  is export
  { * }

sub gtk_revealer_get_transition_duration (GtkRevealer $revealer)
  returns guint
  is native($LIBGTK)
  is export
  { * }

sub gtk_revealer_get_reveal_child (GtkRevealer $revealer)
  returns uint32
  is native($LIBGTK)
  is export
  { * }

sub gtk_revealer_set_transition_type (
  GtkRevealer $revealer,
  uint32 $transition            # GtkRevealerTransitionType $transition
)
  is native($LIBGTK)
  is export
  { * }

sub gtk_revealer_set_transition_duration (
  GtkRevealer $revealer,
  guint $duration
)
  is native($LIBGTK)
  is export
  { * }

sub gtk_revealer_set_reveal_child (
  GtkRevealer $revealer,
  gboolean $reveal_child
)
  is native($LIBGTK)
  is export
  { * }