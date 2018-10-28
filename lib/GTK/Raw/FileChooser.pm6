use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::Types;

unit package GTK::Raw::FileChooser;

sub gtk_file_chooser_add_choice (
  GtkFileChooser $chooser,
  gchar $id,
  gchar $label,
  gchar $options,
  gchar $option_labels
)
  is native($LIBGTK)
  is export
  { * }

sub gtk_file_chooser_add_filter (
  GtkFileChooser $chooser,
  GtkFileFilter $filter
)
  is native($LIBGTK)
  is export
  { * }

sub gtk_file_chooser_add_shortcut_folder (
  GtkFileChooser $chooser,
  gchar $folder,
  GError $error
)
  returns uint32
  is native($LIBGTK)
  is export
  { * }

sub gtk_file_chooser_add_shortcut_folder_uri (
  GtkFileChooser $chooser,
  gchar $uri,
  GError $error
)
  returns uint32
  is native($LIBGTK)
  is export
  { * }

sub gtk_file_chooser_error_quark ()
  returns GQuark
  is native($LIBGTK)
  is export
  { * }

sub gtk_file_chooser_get_choice (GtkFileChooser $chooser, gchar $id)
  returns gchar
  is native($LIBGTK)
  is export
  { * }

sub gtk_file_chooser_get_current_folder_file (GtkFileChooser $chooser)
  returns GFile
  is native($LIBGTK)
  is export
  { * }

sub gtk_file_chooser_get_file (GtkFileChooser $chooser)
  returns GFile
  is native($LIBGTK)
  is export
  { * }

sub gtk_file_chooser_get_filenames (GtkFileChooser $chooser)
  returns GSList
  is native($LIBGTK)
  is export
  { * }

sub gtk_file_chooser_get_files (GtkFileChooser $chooser)
  returns GSList
  is native($LIBGTK)
  is export
  { * }

sub gtk_file_chooser_get_preview_file (GtkFileChooser $chooser)
  returns GFile
  is native($LIBGTK)
  is export
  { * }

sub gtk_file_chooser_get_preview_filename (GtkFileChooser $chooser)
  returns gchar
  is native($LIBGTK)
  is export
  { * }

sub gtk_file_chooser_get_preview_uri (GtkFileChooser $chooser)
  returns gchar
  is native($LIBGTK)
  is export
  { * }

sub gtk_file_chooser_get_type ()
  returns GType
  is native($LIBGTK)
  is export
  { * }

sub gtk_file_chooser_get_uris (GtkFileChooser $chooser)
  returns GSList
  is native($LIBGTK)
  is export
  { * }

sub gtk_file_chooser_list_filters (GtkFileChooser $chooser)
  returns GSList
  is native($LIBGTK)
  is export
  { * }

sub gtk_file_chooser_list_shortcut_folder_uris (GtkFileChooser $chooser)
  returns GSList
  is native($LIBGTK)
  is export
  { * }

sub gtk_file_chooser_list_shortcut_folders (GtkFileChooser $chooser)
  returns GSList
  is native($LIBGTK)
  is export
  { * }

sub gtk_file_chooser_remove_choice (GtkFileChooser $chooser, gchar $id)
  is native($LIBGTK)
  is export
  { * }

sub gtk_file_chooser_remove_filter (
  GtkFileChooser $chooser,
  GtkFileFilter $filter
)
  is native($LIBGTK)
  is export
  { * }

sub gtk_file_chooser_remove_shortcut_folder (
  GtkFileChooser $chooser,
  gchar $folder,
  GError $error
)
  returns uint32
  is native($LIBGTK)
  is export
  { * }

sub gtk_file_chooser_remove_shortcut_folder_uri (
  GtkFileChooser $chooser,
  gchar $uri,
  GError $error
)
  returns uint32
  is native($LIBGTK)
  is export
  { * }

sub gtk_file_chooser_select_all (GtkFileChooser $chooser)
  is native($LIBGTK)
  is export
  { * }

sub gtk_file_chooser_select_file (
  GtkFileChooser $chooser,
  GFile $file,
  GError $error
)
  returns uint32
  is native($LIBGTK)
  is export
  { * }

sub gtk_file_chooser_select_filename (
  GtkFileChooser $chooser,
  gchar $filename
)
  returns uint32
  is native($LIBGTK)
  is export
  { * }

sub gtk_file_chooser_select_uri (GtkFileChooser $chooser, gchar $uri)
  returns uint32
  is native($LIBGTK)
  is export
  { * }

sub gtk_file_chooser_set_choice (
  GtkFileChooser $chooser,
  gchar $id,
  gchar $option
)
  is native($LIBGTK)
  is export
  { * }

sub gtk_file_chooser_set_current_folder_file (
  GtkFileChooser $chooser,
  GFile $file,
  GError $error
)
  returns uint32
  is native($LIBGTK)
  is export
  { * }

sub gtk_file_chooser_set_file (
  GtkFileChooser $chooser,
  GFile $file,
  GError $error
)
  returns uint32
  is native($LIBGTK)
  is export
  { * }

sub gtk_file_chooser_unselect_all (GtkFileChooser $chooser)
  is native($LIBGTK)
  is export
  { * }

sub gtk_file_chooser_unselect_file (GtkFileChooser $chooser, GFile $file)
  is native($LIBGTK)
  is export
  { * }

sub gtk_file_chooser_unselect_filename (
  GtkFileChooser $chooser,
  gchar $filename
)
  is native($LIBGTK)
  is export
  { * }

sub gtk_file_chooser_unselect_uri (GtkFileChooser $chooser, gchar $uri)
  is native($LIBGTK)
  is export
  { * }

sub gtk_file_chooser_get_uri (GtkFileChooser $chooser)
  returns Str
  is native($LIBGTK)
  is export
  { * }

sub gtk_file_chooser_get_current_folder (GtkFileChooser $chooser)
  returns Str
  is native($LIBGTK)
  is export
  { * }

sub gtk_file_chooser_get_extra_widget (GtkFileChooser $chooser)
  returns GtkWidget
  is native($LIBGTK)
  is export
  { * }

sub gtk_file_chooser_get_use_preview_label (GtkFileChooser $chooser)
  returns uint32
  is native($LIBGTK)
  is export
  { * }

sub gtk_file_chooser_get_current_name (GtkFileChooser $chooser)
  returns Str
  is native($LIBGTK)
  is export
  { * }

sub gtk_file_chooser_get_preview_widget (GtkFileChooser $chooser)
  returns GtkWidget
  is native($LIBGTK)
  is export
  { * }

sub gtk_file_chooser_get_action (GtkFileChooser $chooser)
  returns uint32 # GtkFileChooserAction
  is native($LIBGTK)
  is export
  { * }

sub gtk_file_chooser_get_filter (GtkFileChooser $chooser)
  returns GtkFileFilter
  is native($LIBGTK)
  is export
  { * }

sub gtk_file_chooser_get_current_folder_uri (GtkFileChooser $chooser)
  returns Str
  is native($LIBGTK)
  is export
  { * }

sub gtk_file_chooser_get_filename (GtkFileChooser $chooser)
  returns Str
  is native($LIBGTK)
  is export
  { * }

sub gtk_file_chooser_get_do_overwrite_confirmation (GtkFileChooser $chooser)
  returns uint32
  is native($LIBGTK)
  is export
  { * }

sub gtk_file_chooser_get_select_multiple (GtkFileChooser $chooser)
  returns uint32
  is native($LIBGTK)
  is export
  { * }

sub gtk_file_chooser_get_preview_widget_active (GtkFileChooser $chooser)
  returns uint32
  is native($LIBGTK)
  is export
  { * }

sub gtk_file_chooser_get_create_folders (GtkFileChooser $chooser)
  returns uint32
  is native($LIBGTK)
  is export
  { * }

sub gtk_file_chooser_get_local_only (GtkFileChooser $chooser)
  returns uint32
  is native($LIBGTK)
  is export
  { * }

sub gtk_file_chooser_get_show_hidden (GtkFileChooser $chooser)
  returns uint32
  is native($LIBGTK)
  is export
  { * }

sub gtk_file_chooser_set_uri (GtkFileChooser $chooser, gchar $uri)
  returns uint32
  is native($LIBGTK)
  is export
  { * }

sub gtk_file_chooser_set_current_folder (
  GtkFileChooser $chooser,
  gchar $filename
)
  returns uint32
  is native($LIBGTK)
  is export
  { * }

sub gtk_file_chooser_set_extra_widget (
  GtkFileChooser $chooser,
  GtkWidget $extra_widget
)
  is native($LIBGTK)
  is export
  { * }

sub gtk_file_chooser_set_use_preview_label (
  GtkFileChooser $chooser,
  gboolean $use_label
)
  is native($LIBGTK)
  is export
  { * }

sub gtk_file_chooser_set_current_name (GtkFileChooser $chooser, gchar $name)
  is native($LIBGTK)
  is export
  { * }

sub gtk_file_chooser_set_preview_widget (
  GtkFileChooser $chooser,
  GtkWidget $preview_widget
)
  is native($LIBGTK)
  is export
  { * }

sub gtk_file_chooser_set_action (
  GtkFileChooser $chooser,
  uint32 $action                # GtkFileChooserAction $action
)
  is native($LIBGTK)
  is export
  { * }

sub gtk_file_chooser_set_filter (
  GtkFileChooser $chooser,
  GtkFileFilter $filter
)
  is native($LIBGTK)
  is export
  { * }

sub gtk_file_chooser_set_current_folder_uri (
  GtkFileChooser $chooser,
  gchar $uri
)
  returns uint32
  is native($LIBGTK)
  is export
  { * }

sub gtk_file_chooser_set_filename (GtkFileChooser $chooser, gchar $filename)
  returns uint32
  is native($LIBGTK)
  is export
  { * }

sub gtk_file_chooser_set_do_overwrite_confirmation (
  GtkFileChooser $chooser,
  gboolean $do_overwrite_confirmation
)
  is native($LIBGTK)
  is export
  { * }

sub gtk_file_chooser_set_select_multiple (
  GtkFileChooser $chooser,
  gboolean $select_multiple
)
  is native($LIBGTK)
  is export
  { * }

sub gtk_file_chooser_set_preview_widget_active (
  GtkFileChooser $chooser,
  gboolean $active
)
  is native($LIBGTK)
  is export
  { * }

sub gtk_file_chooser_set_create_folders (
  GtkFileChooser $chooser,
  gboolean $create_folders
)
  is native($LIBGTK)
  is export
  { * }

sub gtk_file_chooser_set_local_only (
  GtkFileChooser $chooser,
  gboolean $local_only
)
  is native($LIBGTK)
  is export
  { * }

sub gtk_file_chooser_set_show_hidden (
  GtkFileChooser $chooser,
  gboolean $show_hidden
)
  is native($LIBGTK)
  is export
  { * }