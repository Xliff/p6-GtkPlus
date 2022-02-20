use v6.c;

use NativeCall;

use GTK::Raw::Types:ver<3.0.1146>;

unit package GTK::Raw::Assistant:ver<3.0.1146>;

sub gtk_assistant_add_action_widget (
  GtkAssistant $assistant,
  GtkWidget $child
)
  is native(gtk)
  is export
  { * }

sub gtk_assistant_append_page (
  GtkAssistant $assistant,
  GtkWidget $page
)
  returns gint
  is native(gtk)
  is export
  { * }

sub gtk_assistant_commit (GtkAssistant $assistant)
  is native(gtk)
  is export
  { * }

sub gtk_assistant_get_n_pages (GtkAssistant $assistant)
  returns gint
  is native(gtk)
  is export
  { * }

sub gtk_assistant_get_nth_page (GtkAssistant $assistant, gint $page_num)
  returns GtkWidget
  is native(gtk)
  is export
  { * }

sub gtk_assistant_get_page_complete (
  GtkAssistant $assistant,
  GtkWidget $page
)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_assistant_get_page_has_padding (
  GtkAssistant $assistant,
  GtkWidget $page
)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_assistant_get_page_header_image (
  GtkAssistant $assistant,
  GtkWidget $page
)
  returns GdkPixbuf
  is native(gtk)
  is export
  { * }

sub gtk_assistant_get_page_side_image (
  GtkAssistant $assistant,
  GtkWidget $page
)
  returns GdkPixbuf
  is native(gtk)
  is export
  { * }

sub gtk_assistant_get_page_title (
  GtkAssistant $assistant,
  GtkWidget $page
)
  returns Str
  is native(gtk)
  is export
  { * }

sub gtk_assistant_get_page_type (
  GtkAssistant $assistant,
  GtkWidget $page
)
  returns uint32 # GtkAssistantPageType
  is native(gtk)
  is export
  { * }

sub gtk_assistant_get_type ()
  returns GType
  is native(gtk)
  is export
  { * }

sub gtk_assistant_insert_page (
  GtkAssistant $assistant,
  GtkWidget $page,
  gint $position
)
  returns gint
  is native(gtk)
  is export
  { * }

sub gtk_assistant_new ()
  returns GtkWidget
  is native(gtk)
  is export
  { * }

sub gtk_assistant_next_page (GtkAssistant $assistant)
  is native(gtk)
  is export
  { * }

sub gtk_assistant_prepend_page (
  GtkAssistant $assistant,
  GtkWidget $page
)
  returns gint
  is native(gtk)
  is export
  { * }

sub gtk_assistant_previous_page (GtkAssistant $assistant)
  is native(gtk)
  is export
  { * }

sub gtk_assistant_remove_action_widget (
  GtkAssistant $assistant,
  GtkWidget $child
)
  is native(gtk)
  is export
  { * }

sub gtk_assistant_remove_page (GtkAssistant $assistant, gint $page_num)
  is native(gtk)
  is export
  { * }

sub gtk_assistant_set_forward_page_func (
  GtkAssistant $assistant,
  GtkAssistantPageFunc $page_func,
  gpointer $data,
  GDestroyNotify $destroy
)
  is native(gtk)
  is export
  { * }

sub gtk_assistant_set_page_complete (
  GtkAssistant $assistant,
  GtkWidget $page,
  gboolean $complete
)
  is native(gtk)
  is export
  { * }

sub gtk_assistant_set_page_has_padding (
  GtkAssistant $assistant,
  GtkWidget $page,
  gboolean $has_padding
)
  is native(gtk)
  is export
  { * }

sub gtk_assistant_set_page_header_image (
  GtkAssistant $assistant,
  GtkWidget $page,
  GdkPixbuf $pixbuf
)
  is native(gtk)
  is export
  { * }

sub gtk_assistant_set_page_side_image (
  GtkAssistant $assistant,
  GtkWidget $page,
  GdkPixbuf $pixbuf
)
  is native(gtk)
  is export
  { * }

sub gtk_assistant_set_page_title (
  GtkAssistant $assistant,
  GtkWidget $page,
  gchar $title
)
  is native(gtk)
  is export
  { * }

sub gtk_assistant_set_page_type (
  GtkAssistant $assistant,
  GtkWidget $page,
  uint32 $type                # GtkAssistantPageType $type
)
  is native(gtk)
  is export
  { * }

sub gtk_assistant_update_buttons_state (GtkAssistant $assistant)
  is native(gtk)
  is export
  { * }

sub gtk_assistant_get_current_page (GtkAssistant $assistant)
  returns gint
  is native(gtk)
  is export
  { * }

sub gtk_assistant_set_current_page (GtkAssistant $assistant, gint $page_num)
  is native(gtk)
  is export
  { * }
