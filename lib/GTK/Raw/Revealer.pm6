use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Structs;
use GTK::Raw::Definitions:ver<3.0.1146>;
use GTK::Raw::Structs:ver<3.0.1146>;

unit package GTK::Raw::Revealer:ver<3.0.1146>;

sub gtk_revealer_get_child_revealed (GtkRevealer $revealer)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_revealer_get_type ()
  returns GType
  is native(gtk)
  is export
  { * }

sub gtk_revealer_new ()
  returns GtkWidget
  is native(gtk)
  is export
  { * }

sub gtk_revealer_get_transition_type (GtkRevealer $revealer)
  returns uint32 # GtkRevealerTransitionType
  is native(gtk)
  is export
  { * }

sub gtk_revealer_get_transition_duration (GtkRevealer $revealer)
  returns guint
  is native(gtk)
  is export
  { * }

sub gtk_revealer_get_reveal_child (GtkRevealer $revealer)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_revealer_set_transition_type (
  GtkRevealer $revealer,
  uint32 $transition            # GtkRevealerTransitionType $transition
)
  is native(gtk)
  is export
  { * }

sub gtk_revealer_set_transition_duration (
  GtkRevealer $revealer,
  guint $duration
)
  is native(gtk)
  is export
  { * }

sub gtk_revealer_set_reveal_child (
  GtkRevealer $revealer,
  gboolean $reveal_child
)
  is native(gtk)
  is export
  { * }