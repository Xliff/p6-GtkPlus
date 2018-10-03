use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::FileChooser;
use GTK::Raw::Types;

use GTK::Roles::Signals;
use GTK::Roles::Types;

role GTK::Roles::FileChooser {
  also does GTK::Roles::Signals
  also does GTK::Roles::Types;

  has GtkFileChooser $!fc;

  # ↓↓↓↓ SIGNALS ↓↓↓↓

  # Is originally:
  # char
  method confirm-overwrite {
    self.connect($!fc, 'confirm-overwrite');
  }

  # Is originally:
  # GtkFileChooser, gpointer --> void
  method current-folder-changed {
    self.connect($!fc, 'current-folder-changed');
  }

  # Is originally:
  # GtkFileChooser, gpointer --> void
  method file-activated {
    self.connect($!fc, 'file-activated');
  }

  # Is originally:
  # GtkFileChooser, gpointer --> void
  method selection-changed {
    self.connect($!fc, 'selection-changed');
  }

  # Is originally:
  # GtkFileChooser, gpointer --> void
  method update-preview {
    self.connect($!fc, 'update-preview');
  }

  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  method action is rw {
    Proxy.new(
      FETCH => sub ($) {
        GtkFileChooserAction( gtk_file_chooser_get_action($!fc) );
      },
      STORE => sub ($, Int() $action is copy) {
        my guint $a = self.RESOLVE-UINT($action);
        gtk_file_chooser_set_action($!fc, $a);
      }
    );
  }

  method create_folders is rw {
    Proxy.new(
      FETCH => sub ($) {
        so gtk_file_chooser_get_create_folders($!fc);
      },
      STORE => sub ($, $create_folders is copy) {
        my gboolean $cf = self.RESOLVE-BOOL($create_folders);
        gtk_file_chooser_set_create_folders($!fc, $cf);
      }
    );
  }

  method current_folder is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_file_chooser_get_current_folder($!fc);
      },
      STORE => sub ($, $filename is copy) {
        gtk_file_chooser_set_current_folder($!fc, $filename);
      }
    );
  }

  method current_folder_uri is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_file_chooser_get_current_folder_uri($!fc);
      },
      STORE => sub ($, $uri is copy) {
        gtk_file_chooser_set_current_folder_uri($!fc, $uri);
      }
    );
  }

  method current_name is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_file_chooser_get_current_name($!fc);
      },
      STORE => sub ($, $name is copy) {
        gtk_file_chooser_set_current_name($!fc, $name);
      }
    );
  }

  method do_overwrite_confirmation is rw {
    Proxy.new(
      FETCH => sub ($) {
        so gtk_file_chooser_get_do_overwrite_confirmation($!fc);
      },
      STORE => sub ($, $do_overwrite_confirmation is copy) {
        my gboolean $d = self.RESOLVE-BOOL($do_overwrite_confirmation);
        gtk_file_chooser_set_do_overwrite_confirmation($!fc, $d);
      }
    );
  }

  method extra_widget is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_file_chooser_get_extra_widget($!fc);
      },
      STORE => sub ($, GtkWidget() $extra_widget is copy) {
        gtk_file_chooser_set_extra_widget($!fc, $extra_widget);
      }
    );
  }

  method filename is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_file_chooser_get_filename($!fc);
      },
      STORE => sub ($, $filename is copy) {
        gtk_file_chooser_set_filename($!fc, $filename);
      }
    );
  }

  # GTK::FileFilter
  method filter is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_file_chooser_get_filter($!fc);
      },
      STORE => sub ($, GtkFileFilter() $filter is copy) {
        gtk_file_chooser_set_filter($!fc, $filter);
      }
    );
  }

  method local_only is rw {
    Proxy.new(
      FETCH => sub ($) {
        so gtk_file_chooser_get_local_only($!fc);
      },
      STORE => sub ($, $local_only is copy) {
        my gboolean $l = self.RESOLVE-BOOL($local_only);
        gtk_file_chooser_set_local_only($!fc, $l);
      }
    );
  }

  method preview_widget is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_file_chooser_get_preview_widget($!fc);
      },
      STORE => sub ($, GtkWidget() $preview_widget is copy) {
        gtk_file_chooser_set_preview_widget($!fc, $preview_widget);
      }
    );
  }

  method preview_widget_active is rw {
    Proxy.new(
      FETCH => sub ($) {
        so gtk_file_chooser_get_preview_widget_active($!fc);
      },
      STORE => sub ($, $active is copy) {
        my gboolean $a = self.RESOLVE-BOOL($active);
        gtk_file_chooser_set_preview_widget_active($!fc, $a);
      }
    );
  }

  method select_multiple is rw {
    Proxy.new(
      FETCH => sub ($) {
        so gtk_file_chooser_get_select_multiple($!fc);
      },
      STORE => sub ($, $select_multiple is copy) {
        my gboolean $s = self.RESOLVE-BOOL($select_multiple);
        gtk_file_chooser_set_select_multiple($!fc, $s);
      }
    );
  }

  method show_hidden is rw {
    Proxy.new(
      FETCH => sub ($) {
        so gtk_file_chooser_get_show_hidden($!fc);
      },
      STORE => sub ($, $show_hidden is copy) {
        my gboolean $s = self.RESOLVE-BOOL($show_hidden);
        gtk_file_chooser_set_show_hidden($!fc, $s);
      }
    );
  }

  method uri is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_file_chooser_get_uri($!fc);
      },
      STORE => sub ($, $uri is copy) {
        gtk_file_chooser_set_uri($!fc, $uri);
      }
    );
  }

  method use_preview_label is rw {
    Proxy.new(
      FETCH => sub ($) {
        so gtk_file_chooser_get_use_preview_label($!fc);
      },
      STORE => sub ($, $use_label is copy) {
        my gboolean $u = self.RESOLVE-BOOL($use_label);
        gtk_file_chooser_set_use_preview_label($!fc, $u);
      }
    );
  }
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  method add_choice (
    char $id,
    char $label,
    char $options,
    char $option_labels
  ) {
    gtk_file_chooser_add_choice($!fc, $id, $label, $options, $option_labels);
  }

  method add_filter (GtkFileFilter $filter) {
    gtk_file_chooser_add_filter($!fc, $filter);
  }

  method add_shortcut_folder (Str() $folder, GError $error) {
    gtk_file_chooser_add_shortcut_folder($!fc, $folder, $error);
  }

  method add_shortcut_folder_uri (Str() $uri, GError $error) {
    gtk_file_chooser_add_shortcut_folder_uri($!fc, $uri, $error);
  }

  method error_quark {
    gtk_file_chooser_error_quark($!fc);
  }

  method get_choice (Str() $id) {
    gtk_file_chooser_get_choice($!fc, $id);
  }

  method get_current_folder_file {
    gtk_file_chooser_get_current_folder_file($!fc);
  }

  method get_file {
    gtk_file_chooser_get_file($!fc);
  }

  method get_filenames {
    gtk_file_chooser_get_filenames($!fc);
  }

  method get_files {
    gtk_file_chooser_get_files($!fc);
  }

  method get_preview_file {
    gtk_file_chooser_get_preview_file($!fc);
  }

  method get_preview_filename {
    gtk_file_chooser_get_preview_filename($!fc);
  }

  method get_preview_uri {
    gtk_file_chooser_get_preview_uri($!fc);
  }

  method get_type {
    gtk_file_chooser_get_type();
  }

  method get_uris {
    gtk_file_chooser_get_uris($!fc);
  }

  method list_filters {
    gtk_file_chooser_list_filters($!fc);
  }

  method list_shortcut_folder_uris {
    gtk_file_chooser_list_shortcut_folder_uris($!fc);
  }

  method list_shortcut_folders {
    gtk_file_chooser_list_shortcut_folders($!fc);
  }

  method remove_choice (Str() $id) {
    gtk_file_chooser_remove_choice($!fc, $id);
  }

  method remove_filter (GtkFileFilter $filter) {
    gtk_file_chooser_remove_filter($!fc, $filter);
  }

  method remove_shortcut_folder (
    Str() $folder,
    GError $error = GError
  ) {
    gtk_file_chooser_remove_shortcut_folder($!fc, $folder, $error);
  }

  method remove_shortcut_folder_uri (
    Str() $uri,
    GError $error = GError
  ) {
    gtk_file_chooser_remove_shortcut_folder_uri($!fc, $uri, $error);
  }

  method select_all {
    gtk_file_chooser_select_all($!fc);
  }

  method select_file (
    GFile $file,
    GError $error = GError
  ) {
    gtk_file_chooser_select_file($!fc, $file, $error);
  }

  method select_filename (Str() $filename) {
    gtk_file_chooser_select_filename($!fc, $filename);
  }

  method select_uri (Str() $uri) {
    gtk_file_chooser_select_uri($!fc, $uri);
  }

  method set_choice (Str() $id, Str() $option) {
    gtk_file_chooser_set_choice($!fc, $id, $option);
  }

  method set_current_folder_file (
    GFile $file,
    GError $error = GError
  ) {
    gtk_file_chooser_set_current_folder_file($!fc, $file, $error);
  }

  method set_file (
    GFile $file,
    GError $error = GError
  ) {
    gtk_file_chooser_set_file($!fc, $file, $error);
  }

  method unselect_all {
    gtk_file_chooser_unselect_all($!fc);
  }

  method unselect_file (GFile $file) {
    gtk_file_chooser_unselect_file($!fc, $file);
  }

  method unselect_filename (Str() $filename) {
    gtk_file_chooser_unselect_filename($!fc, $filename);
  }

  method unselect_uri (Str() $uri) {
    gtk_file_chooser_unselect_uri($!fc, $uri);
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
