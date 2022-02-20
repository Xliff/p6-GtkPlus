use v6.c;

use NativeCall;


use GTK::Raw::Types:ver<3.0.1146>;

unit package GTK::Raw::EntryCompletion:ver<3.0.1146>;

sub gtk_entry_completion_complete (GtkEntryCompletion $completion)
  is native(gtk)
  is export
  { * }

sub gtk_entry_completion_compute_prefix (GtkEntryCompletion $completion, Str $key)
  returns Str
  is native(gtk)
  is export
  { * }

sub gtk_entry_completion_delete_action (GtkEntryCompletion $completion, gint $index_)
  is native(gtk)
  is export
  { * }

sub gtk_entry_completion_get_completion_prefix (GtkEntryCompletion $completion)
  returns Str
  is native(gtk)
  is export
  { * }

sub gtk_entry_completion_get_entry (GtkEntryCompletion $completion)
  returns GtkWidget
  is native(gtk)
  is export
  { * }

sub gtk_entry_completion_get_type ()
  returns GType
  is native(gtk)
  is export
  { * }

sub gtk_entry_completion_insert_action_markup (GtkEntryCompletion $completion, gint $index_, gchar $markup)
  is native(gtk)
  is export
  { * }

sub gtk_entry_completion_insert_action_text (GtkEntryCompletion $completion, gint $index_, gchar $text)
  is native(gtk)
  is export
  { * }

sub gtk_entry_completion_insert_prefix (GtkEntryCompletion $completion)
  is native(gtk)
  is export
  { * }

sub gtk_entry_completion_new ()
  returns GtkEntryCompletion
  is native(gtk)
  is export
  { * }

sub gtk_entry_completion_new_with_area (GtkCellArea $area)
  returns GtkEntryCompletion
  is native(gtk)
  is export
  { * }

sub gtk_entry_completion_set_match_func (
  GtkEntryCompletion $completion,
  &func (GtkEntryCompletion, Str, GtkTreeIter, Pointer --> gboolean),
  gpointer $func_data,
  GDestroyNotify $func_notify
)
  is native(gtk)
  is export
  { * }

sub gtk_entry_completion_get_inline_completion (GtkEntryCompletion $completion)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_entry_completion_get_minimum_key_length (GtkEntryCompletion $completion)
  returns gint
  is native(gtk)
  is export
  { * }

sub gtk_entry_completion_get_inline_selection (GtkEntryCompletion $completion)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_entry_completion_get_popup_set_width (GtkEntryCompletion $completion)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_entry_completion_get_text_column (GtkEntryCompletion $completion)
  returns gint
  is native(gtk)
  is export
  { * }

sub gtk_entry_completion_get_model (GtkEntryCompletion $completion)
  returns GtkTreeModel
  is native(gtk)
  is export
  { * }

sub gtk_entry_completion_get_popup_completion (GtkEntryCompletion $completion)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_entry_completion_get_popup_single_match (GtkEntryCompletion $completion)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_entry_completion_set_inline_completion (GtkEntryCompletion $completion, gboolean $inline_completion)
  is native(gtk)
  is export
  { * }

sub gtk_entry_completion_set_minimum_key_length (GtkEntryCompletion $completion, gint $length)
  is native(gtk)
  is export
  { * }

sub gtk_entry_completion_set_inline_selection (GtkEntryCompletion $completion, gboolean $inline_selection)
  is native(gtk)
  is export
  { * }

sub gtk_entry_completion_set_popup_set_width (GtkEntryCompletion $completion, gboolean $popup_set_width)
  is native(gtk)
  is export
  { * }

sub gtk_entry_completion_set_text_column (GtkEntryCompletion $completion, gint $column)
  is native(gtk)
  is export
  { * }

sub gtk_entry_completion_set_model (GtkEntryCompletion $completion, GtkTreeModel $model)
  is native(gtk)
  is export
  { * }

sub gtk_entry_completion_set_popup_completion (GtkEntryCompletion $completion, gboolean $popup_completion)
  is native(gtk)
  is export
  { * }

sub gtk_entry_completion_set_popup_single_match (GtkEntryCompletion $completion, gboolean $popup_single_match)
  is native(gtk)
  is export
  { * }
