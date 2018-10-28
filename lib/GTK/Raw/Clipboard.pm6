use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::Types;

unit package GTK::Raw::Clipboard;

sub gtk_clipboard_clear (GtkClipboard $clipboard)
  is native(gtk)
  is export
  { * }

sub gtk_clipboard_get (GdkAtom $selection)
  returns GtkClipboard
  is native(gtk)
  is export
  { * }

sub gtk_clipboard_get_default (GdkDisplay $display)
  returns GtkClipboard
  is native(gtk)
  is export
  { * }

sub gtk_clipboard_get_display (GtkClipboard $clipboard)
  returns GdkDisplay
  is native(gtk)
  is export
  { * }

sub gtk_clipboard_get_for_display (
  GdkDisplay $display,
  GdkAtom $selection
)
  returns GtkClipboard
  is native(gtk)
  is export
  { * }

sub gtk_clipboard_get_owner (GtkClipboard $clipboard)
  returns GObject
  is native(gtk)
  is export
  { * }

sub gtk_clipboard_get_selection (GtkClipboard $clipboard)
  returns GdkAtom
  is native(gtk)
  is export
  { * }

sub gtk_clipboard_get_type ()
  returns GType
  is native(gtk)
  is export
  { * }

sub gtk_clipboard_request_contents (
  GtkClipboard $clipboard,
  GdkAtom $target,
  GtkClipboardReceivedFunc $callback,
  gpointer $user_data
)
  is native(gtk)
  is export
  { * }

sub gtk_clipboard_request_image (
  GtkClipboard $clipboard,
  GtkClipboardImageReceivedFunc $callback,
  gpointer $user_data
)
  is native(gtk)
  is export
  { * }

sub gtk_clipboard_request_rich_text (
  GtkClipboard $clipboard,
  GtkTextBuffer $buffer,
  GtkClipboardRichTextReceivedFunc $callback,
  gpointer $user_data
)
  is native(gtk)
  is export
  { * }

sub gtk_clipboard_request_targets (
  GtkClipboard $clipboard,
  GtkClipboardTargetsReceivedFunc $callback,
  gpointer $user_data
)
  is native(gtk)
  is export
  { * }

sub gtk_clipboard_request_text (
  GtkClipboard $clipboard,
  GtkClipboardTextReceivedFunc $callback,
  gpointer $user_data
)
  is native(gtk)
  is export
  { * }

sub gtk_clipboard_request_uris (
  GtkClipboard $clipboard,
  GtkClipboardURIReceivedFunc $callback,
  gpointer $user_data
)
  is native(gtk)
  is export
  { * }

sub gtk_clipboard_set_can_store (
  GtkClipboard $clipboard,
  GtkTargetEntry $targets,
  gint $n_targets
)
  is native(gtk)
  is export
  { * }

sub gtk_clipboard_set_image (
  GtkClipboard $clipboard,
  GdkPixbuf $pixbuf
)
  is native(gtk)
  is export
  { * }

sub gtk_clipboard_set_text (
  GtkClipboard $clipboard,
  gchar $text,
  gint $len
)
  is native(gtk)
  is export
  { * }

sub gtk_clipboard_set_with_data (
  GtkClipboard $clipboard,
  GtkTargetEntry $targets,
  guint $n_targets,
  GtkClipboardGetFunc $get_func,
  GtkClipboardClearFunc $clear_func,
  gpointer $user_data
)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_clipboard_set_with_owner (
  GtkClipboard $clipboard,
  GtkTargetEntry $targets,
  guint $n_targets,
  GtkClipboardGetFunc $get_func,
  GtkClipboardClearFunc $clear_func,
  GObject $owner
)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_clipboard_store (GtkClipboard $clipboard)
  is native(gtk)
  is export
  { * }

sub gtk_clipboard_wait_for_contents (
  GtkClipboard $clipboard,
  GdkAtom $target
)
  returns GtkSelectionData
  is native(gtk)
  is export
  { * }

sub gtk_clipboard_wait_for_image (GtkClipboard $clipboard)
  returns GdkPixbuf
  is native(gtk)
  is export
  { * }

sub gtk_clipboard_wait_for_rich_text (
  GtkClipboard $clipboard,
  GtkTextBuffer $buffer,
  GdkAtom $format,
  gsize $length
)
  returns guint8
  is native(gtk)
  is export
  { * }

sub gtk_clipboard_wait_for_targets (
  GtkClipboard $clipboard,
  GdkAtom $targets,
  gint $n_targets
)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_clipboard_wait_for_text (GtkClipboard $clipboard)
  returns Str
  is native(gtk)
  is export
  { * }

sub gtk_clipboard_wait_for_uris (GtkClipboard $clipboard)
  returns CArray[Str]
  is native(gtk)
  is export
  { * }

sub gtk_clipboard_wait_is_image_available (GtkClipboard $clipboard)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_clipboard_wait_is_rich_text_available (
  GtkClipboard $clipboard,
  GtkTextBuffer $buffer
)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_clipboard_wait_is_target_available (
  GtkClipboard $clipboard,
  GdkAtom $target
)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_clipboard_wait_is_text_available (GtkClipboard $clipboard)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_clipboard_wait_is_uris_available (GtkClipboard $clipboard)
  returns uint32
  is native(gtk)
  is export
  { * }