use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Structs;
use GTK::Raw::Definitions:ver<3.0.1146>;
use GTK::Raw::Structs:ver<3.0.1146>;

unit package GTK::Raw::Statusbar:ver<3.0.1146>;

sub gtk_statusbar_get_context_id (
  GtkStatusbar $statusbar,
  Str $context_description
)
  returns guint
  is native(gtk)
  is export
  { * }

sub gtk_statusbar_get_message_area (GtkStatusbar $statusbar)
  returns GtkWidget
  is native(gtk)
  is export
  { * }

sub gtk_statusbar_get_type ()
  returns GType
  is native(gtk)
  is export
  { * }

sub gtk_statusbar_new ()
  returns GtkWidget
  is native(gtk)
  is export
  { * }

sub gtk_statusbar_pop (GtkStatusbar $statusbar, guint $context_id)
  is native(gtk)
  is export
  { * }

sub gtk_statusbar_push (
  GtkStatusbar $statusbar,
  guint $context_id,
  Str $text
)
  returns guint
  is native(gtk)
  is export
  { * }

sub gtk_statusbar_remove (
  GtkStatusbar $statusbar,
  guint $context_id,
  guint $message_id
)
  is native(gtk)
  is export
  { * }

sub gtk_statusbar_remove_all (GtkStatusbar $statusbar, guint $context_id)
  is native(gtk)
  is export
  { * }