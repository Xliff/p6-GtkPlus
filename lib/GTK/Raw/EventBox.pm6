use v6.c;

use NativeCall;


use GTK::Raw::Types:ver<3.0.1146>;

unit package GTK::Raw::EventBox:ver<3.0.1146>;

sub gtk_event_box_get_type ()
  returns GType
  is native(gtk)
  is export
  { * }

sub gtk_event_box_new ()
  returns GtkWidget
  is native(gtk)
  is export
  { * }

sub gtk_event_box_get_above_child (GtkEventBox $event_box)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_event_box_get_visible_window (GtkEventBox $event_box)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_event_box_set_above_child (
  GtkEventBox $event_box,
  gboolean $above_child
)
  is native(gtk)
  is export
  { * }

sub gtk_event_box_set_visible_window (
  GtkEventBox $event_box,
  gboolean $visible_window
)
  is native(gtk)
  is export
  { * }
