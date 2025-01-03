use v6.c;

use Method::Also;
use NativeCall;

use GTK::Raw::FileChooser:ver<3.0.1146>;
use GTK::Raw::Types:ver<3.0.1146>;

use GTK::FileFilter:ver<3.0.1146>;
use GTK::Widget:ver<3.0.1146>;

use GTK::Roles::Signals::Generic:ver<3.0.1146>;
use GTK::Roles::Types:ver<3.0.1146>;

role GTK::Roles::FileChooser:ver<3.0.1146> {
  also does GTK::Roles::Signals::Generic;
  also does GTK::Roles::Types;

  has GtkFileChooser $!fc;

  method roleInit-GtkFileChooser {
    return if $!fc;

    my \i = findProperImplementor(self.^attributes);
    
    $!fc = cast( GtkFileChooser, i.get_value(self) );
  }

  method GTK::Raw::Definitions::GtkFileChooser
    is also<GtkFileChooser>
  { $!fc }

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

  method filter (:$raw = False) is rw {
    Proxy.new(
      FETCH => sub ($) {
        my $ff = gtk_file_chooser_get_filter($!fc);

        $ff ??
          ( $raw ?? $ff !! GTK::FileFilter.new($ff) )
          !!
          Nil;
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

  method preview_widget (:$raw = False, :$widget = False)
    is rw
    is also<preview-widget>
  {
    Proxy.new(
      FETCH => sub ($) {
        my $pw = gtk_file_chooser_get_preview_widget($!fc);

        ReturnWidget($pw, $raw, $widget);
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
      STORE => sub ($, Int() $active is copy) {
        my gboolean $a = $active.so.Int;

        gtk_file_chooser_set_preview_widget_active($!fc, $a);
      }
    );
  }

  method select_multiple is rw is also<select-multiple> {
    Proxy.new(
      FETCH => sub ($) {
        so gtk_file_chooser_get_select_multiple($!fc);
      },
      STORE => sub ($, Int() $select_multiple is copy) {
        my gboolean $s = $select_multiple.so.Int;

        gtk_file_chooser_set_select_multiple($!fc, $s);
      }
    );
  }

  method show_hidden is rw is also<show-hidden> {
    Proxy.new(
      FETCH => sub ($) {
        so gtk_file_chooser_get_show_hidden($!fc);
      },
      STORE => sub ($, Int() $show_hidden is copy) {
        my gboolean $s = $show_hidden.so.Int;

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
      STORE => sub ($, Int() $use_label is copy) {
        my gboolean $u = $use_label.so.Int;

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
  )
    is also<add-choice>
  {
    gtk_file_chooser_add_choice($!fc, $id, $label, $options, $option_labels);
  }

  method add_filter (GtkFileFilter() $filter) is also<add-filter> {
    gtk_file_chooser_add_filter($!fc, $filter);
  }

  method add_shortcut_folder (
    Str() $folder,
    CArray[Pointer[GError]] $error = gerror
  )
    is also<add-shortcut-folder>
  {
    clear_error;
    my $rv = gtk_file_chooser_add_shortcut_folder($!fc, $folder, $error);
    set_error($error);
    $rv;
  }

  method add_shortcut_folder_uri (
    Str() $uri,
    CArray[Pointer[GError]] $error
  )
    is also<add-shortcut-folder-uri>
  {
    clear_error;
    my $rv = gtk_file_chooser_add_shortcut_folder_uri($!fc, $uri, $error);
    set_error($error);
    $rv;
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

  method get_filenames (:$glist = False) is also<get-filenames> {
    my $fnl = gtk_file_chooser_get_filenames($!fc);

    return Nil unless $fnl;
    return $fnl if $glist;

    ( GLib::GList.new($fnl) but GLib::Roles::ListData[Str] ).Array;
  }

  method get_files (:$glist = False, :$raw = False) is also<get-files> {
    my $fl = gtk_file_chooser_get_files($!fc);

    return Nil unless $fl;
    return $fl if $glist;

    $fl = GLib::GList.new($fl) but GLib::Roles::ListData[GFile];

    $raw ?? $fl.Array
         !! $fl.Array.map({ GLib::Roles::GFile.new-file-obj($_) });
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

  method get_uris (:$glist = False) is also<get-uris> {
    my $ul = gtk_file_chooser_get_uris($!fc);

    return Nil unless $ul;
    return $ul if $glist;

    ( GLib::GList.new($ul) but GLib::Roles::ListData[Str] ).Array;
  }

  method list_filters (:$glist = False, :$raw = False) is also<list-filters> {
    my $fl = gtk_file_chooser_list_filters($!fc);

    return Nil unless $fl;
    return $fl if $glist;

    $fl = GLib::GList.new($fl) but GLib::Roles::ListData[GtkFileFilter];
    $raw ?? $fl.Array !! $fl.Array.map({ GTK::FileFilter.new($_) });
  }

  method list_shortcut_folder_uris (:$glist = False)
    is also<list-shortcut-folder-uris>
  {
    my $ful = gtk_file_chooser_list_shortcut_folder_uris($!fc);

    return Nil unless $ful;
    return $ful if $glist;

    ( GLib::GList.new($ful) but GLib::Roles::ListData[Str] ).Array;
  }

  method list_shortcut_folders (:$glist = False)
    is also<list-shortcut-folders>
  {
    my $sfl = gtk_file_chooser_list_shortcut_folders($!fc);

    return Nil unless $sfl;
    return $sfl if $glist;

    ( GLib::GList.new($sfl) but GLib::Roles::ListData[Str] ).Array;
  }

  method remove_choice (Str() $id) is also<remove-choice> {
    gtk_file_chooser_remove_choice($!fc, $id);
  }

  method remove_filter (GtkFileFilter() $filter) is also<remove-filter> {
    gtk_file_chooser_remove_filter($!fc, $filter);
  }

  method remove_shortcut_folder (
    Str() $folder,
    CArray[Pointer[GError]] $error = gerror
  )
    is also<remove-shortcut-folder>
  {
    clear_error;
    my $rv = gtk_file_chooser_remove_shortcut_folder($!fc, $folder, $error);
    set_error($error);
    $rv;
  }

  method remove_shortcut_folder_uri (
    Str() $uri,
    CArray[Pointer[GError]] $error = gerror
  )
    is also<remove-shortcut-folder-uri>
  {
    clear_error;
    my $rv = gtk_file_chooser_remove_shortcut_folder_uri($!fc, $uri, $error);
    set_error($error);
    $rv;
  }

  method select_all is also<select-all> {
    gtk_file_chooser_select_all($!fc);
  }

  method select_file (
    GFile() $file,
    CArray[Pointer[GError]] $error = gerror
  )
    is also<select-file>
  {
    clear_error;
    my $rv = gtk_file_chooser_select_file($!fc, $file, $error);
    set_error($error);
    $rv;
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
    GFile() $file,
    CArray[Pointer[GError]] $error = gerror
  ) is also<set-current-folder-file> {
    clear_error;
    my $rv = gtk_file_chooser_set_current_folder_file($!fc, $file, $error);
    set_error($error);
    $rv;
  }

  method set_file (
    GFile() $file,
    CArray[Pointer[GError]] $error = gerror
  )
    is also<set-file>
  {
    clear_error;
    my $rv = gtk_file_chooser_set_file($!fc, $file, $error);
    set_error($error);
    $rv;
  }

  method unselect_all is also<unselect-all> {
    gtk_file_chooser_unselect_all($!fc);
  }

  method unselect_file (GFile() $file) is also<unselect-file> {
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
