use v6.c;

use Method::Also;
use NativeCall;


use GTK::Raw::FileChooser;
use GTK::Raw::Types;

use GTK::FileFilter;

use GTK::Roles::Signals::Generic;
use GTK::Roles::Types;

role GTK::Roles::FileChooser {
  also does GTK::Roles::Signals::Generic;
  also does GTK::Roles::Types;

  has GtkFileChooser $!fc;

  # ↓↓↓↓ SIGNALS ↓↓↓↓

  # Is originally:
  # gchar
  method confirm-overwrite is also<confirm_overwrite> {
    self.connect($!fc, 'confirm-overwrite');
  }

  # Is originally:
  # GtkFileChooser, gpointer --> void
  method current-folder-changed is also<current_folder_changed> {
    self.connect($!fc, 'current-folder-changed');
  }

  # Is originally:
  # GtkFileChooser, gpointer --> void
  method file-activated is also<file_activated> {
    self.connect($!fc, 'file-activated');
  }

  # Is originally:
  # GtkFileChooser, gpointer --> void
  method selection-changed is also<selection_changed> {
    self.connect($!fc, 'selection-changed');
  }

  # Is originally:
  # GtkFileChooser, gpointer --> void
  method update-preview is also<update_preview> {
    self.connect($!fc, 'update-preview');
  }

  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  method action is rw {
    Proxy.new(
      FETCH => sub ($) {
        GtkFileChooserActionEnum( gtk_file_chooser_get_action($!fc) );
      },
      STORE => sub ($, Int() $action is copy) {
        my guint $a = self.RESOLVE-UINT($action);
        gtk_file_chooser_set_action($!fc, $a);
      }
    );
  }

  method create_folders is rw is also<create-folders> {
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

  method current_folder is rw is also<current-folder> {
    Proxy.new(
      FETCH => sub ($) {
        gtk_file_chooser_get_current_folder($!fc);
      },
      STORE => sub ($, Str() $filename is copy) {
        gtk_file_chooser_set_current_folder($!fc, $filename);
      }
    );
  }

  method current_folder_uri is rw is also<current-folder-uri> {
    Proxy.new(
      FETCH => sub ($) {
        gtk_file_chooser_get_current_folder_uri($!fc);
      },
      STORE => sub ($, Str() $uri is copy) {
        gtk_file_chooser_set_current_folder_uri($!fc, $uri);
      }
    );
  }

  method current_name is rw is also<current-name> {
    Proxy.new(
      FETCH => sub ($) {
        gtk_file_chooser_get_current_name($!fc);
      },
      STORE => sub ($, Str() $name is copy) {
        gtk_file_chooser_set_current_name($!fc, $name);
      }
    );
  }

  method do_overwrite_confirmation is rw is also<do-overwrite-confirmation> {
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

  method extra_widget is rw is also<extra-widget> {
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
      STORE => sub ($, Str() $filename is copy) {
        gtk_file_chooser_set_filename($!fc, $filename);
      }
    );
  }

  method filter is rw {
    Proxy.new(
      FETCH => sub ($) {
        GTK::FileFilter.new( gtk_file_chooser_get_filter($!fc) );
      },
      STORE => sub ($, GtkFileFilter() $filter is copy) {
        gtk_file_chooser_set_filter($!fc, $filter);
      }
    );
  }

  method local_only is rw is also<local-only> {
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

  method preview_widget is rw is also<preview-widget> {
    Proxy.new(
      FETCH => sub ($) {
        gtk_file_chooser_get_preview_widget($!fc);
      },
      STORE => sub ($, GtkWidget() $preview_widget is copy) {
        gtk_file_chooser_set_preview_widget($!fc, $preview_widget);
      }
    );
  }

  method preview_widget_active is rw is also<preview-widget-active> {
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

  method select_multiple is rw is also<select-multiple> {
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

  method show_hidden is rw is also<show-hidden> {
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
      STORE => sub ($, Str() $uri is copy) {
        gtk_file_chooser_set_uri($!fc, $uri);
      }
    );
  }

  method use_preview_label is rw is also<use-preview-label> {
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
    Str() $id,
    Str() $label,
    Str() $options,
    Str() $option_labels
  ) is also<add-choice> {
    gtk_file_chooser_add_choice($!fc, $id, $label, $options, $option_labels);
  }

  method add_filter (GtkFileFilter $filter) is also<add-filter> {
    gtk_file_chooser_add_filter($!fc, $filter);
  }

  method add_shortcut_folder (Str() $folder, GError $error) is also<add-shortcut-folder> {
    gtk_file_chooser_add_shortcut_folder($!fc, $folder, $error);
  }

  method add_shortcut_folder_uri (Str() $uri, GError $error) is also<add-shortcut-folder-uri> {
    gtk_file_chooser_add_shortcut_folder_uri($!fc, $uri, $error);
  }

  method error_quark is also<error-quark> {
    gtk_file_chooser_error_quark();
  }

  method get_choice (Str() $id) is also<get-choice> {
    gtk_file_chooser_get_choice($!fc, $id);
  }

  method get_current_folder_file is also<get-current-folder-file> {
    gtk_file_chooser_get_current_folder_file($!fc);
  }

  method get_file is also<get-file> {
    gtk_file_chooser_get_file($!fc);
  }

  method get_filenames is also<get-filenames> {
    gtk_file_chooser_get_filenames($!fc);
  }

  method get_files is also<get-files> {
    gtk_file_chooser_get_files($!fc);
  }

  method get_preview_file is also<get-preview-file> {
    gtk_file_chooser_get_preview_file($!fc);
  }

  method get_preview_filename is also<get-preview-filename> {
    gtk_file_chooser_get_preview_filename($!fc);
  }

  method get_preview_uri is also<get-preview-uri> {
    gtk_file_chooser_get_preview_uri($!fc);
  }

  method get_filechooser_type is also<get-filechooser-type> {
    gtk_file_chooser_get_type();
  }

  method get_uris is also<get-uris> {
    gtk_file_chooser_get_uris($!fc);
  }

  method list_filters is also<list-filters> {
    gtk_file_chooser_list_filters($!fc);
  }

  method list_shortcut_folder_uris is also<list-shortcut-folder-uris> {
    gtk_file_chooser_list_shortcut_folder_uris($!fc);
  }

  method list_shortcut_folders is also<list-shortcut-folders> {
    gtk_file_chooser_list_shortcut_folders($!fc);
  }

  method remove_choice (Str() $id) is also<remove-choice> {
    gtk_file_chooser_remove_choice($!fc, $id);
  }

  method remove_filter (GtkFileFilter $filter) is also<remove-filter> {
    gtk_file_chooser_remove_filter($!fc, $filter);
  }

  method remove_shortcut_folder (
    Str() $folder,
    GError $error = GError
  ) is also<remove-shortcut-folder> {
    gtk_file_chooser_remove_shortcut_folder($!fc, $folder, $error);
  }

  method remove_shortcut_folder_uri (
    Str() $uri,
    GError $error = GError
  ) is also<remove-shortcut-folder-uri> {
    gtk_file_chooser_remove_shortcut_folder_uri($!fc, $uri, $error);
  }

  method select_all is also<select-all> {
    gtk_file_chooser_select_all($!fc);
  }

  method select_file (
    GFile $file,
    GError $error = GError
  ) is also<select-file> {
    gtk_file_chooser_select_file($!fc, $file, $error);
  }

  method select_filename (Str() $filename) is also<select-filename> {
    gtk_file_chooser_select_filename($!fc, $filename);
  }

  method select_uri (Str() $uri) is also<select-uri> {
    gtk_file_chooser_select_uri($!fc, $uri);
  }

  method set_choice (Str() $id, Str() $option) is also<set-choice> {
    gtk_file_chooser_set_choice($!fc, $id, $option);
  }

  method set_current_folder_file (
    GFile $file,
    GError $error = GError
  ) is also<set-current-folder-file> {
    gtk_file_chooser_set_current_folder_file($!fc, $file, $error);
  }

  method set_file (
    GFile $file,
    GError $error = GError
  ) is also<set-file> {
    gtk_file_chooser_set_file($!fc, $file, $error);
  }

  method unselect_all is also<unselect-all> {
    gtk_file_chooser_unselect_all($!fc);
  }

  method unselect_file (GFile $file) is also<unselect-file> {
    gtk_file_chooser_unselect_file($!fc, $file);
  }

  method unselect_filename (Str() $filename) is also<unselect-filename> {
    gtk_file_chooser_unselect_filename($!fc, $filename);
  }

  method unselect_uri (Str() $uri) is also<unselect-uri> {
    gtk_file_chooser_unselect_uri($!fc, $uri);
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}

