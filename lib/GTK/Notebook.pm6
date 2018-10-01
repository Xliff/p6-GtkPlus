use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::Notebook;
use GTK::Raw::Types;

use GTK::Container;

class GTK::Notebook is GTK::Container {
  has GtkNotebook $!n;

  method bless(*%attrinit) {
    my $o = self.CREATE.BUILDALL(Empty, %attrinit);
    $o.setType('GTK::NoteBook');
    $o;
  }

  submethod BUILD(:$notebook) {
    my $to-parent;
    given $notebook {
      when GtkNotebook | GtkWidget {
        $!n = do {
          when GtkNotebook {
            $to-parent = nativecast(GtkContainer, $_);
            $_;
          }
          when GtkWidget   {
            $to-parent = $_;
            nativecast(GtkNotebook, $_);
          }
        }
        self.setContainer($to-parent);
      }
      when GTK::Notebook {
      }
      default {
      }
    }
  }

  multi method new {
    my $notebook = gtk_notebook_new();
    self.bless(:$notebook);
  }
  multi method new (GtkWidget $notebook) {
    self.bless(:$notebook);
  }

  # ↓↓↓↓ SIGNALS ↓↓↓↓

  # Is originally:
  # GtkNotebook, gint, gpointer --> gboolean
  method change-current-page {
    self.connect($!n, 'change-current-page');
  }

  # Is originally:
  # GtkNotebook, GtkWidget, gint, gint, gpointer --> GtkNotebook
  method create-window {
    self.connect($!n, 'create-window');
  }

  # Is originally:
  # GtkNotebook, GtkNotebookTab, gpointer --> gboolean
  method focus-tab {
    self.connect($!n, 'focus-tab');
  }

  # Is originally:
  # GtkNotebook, GtkDirectionType, gpointer --> void
  method move-focus-out {
    self.connect($!n, 'move-focus-out');
  }

  # Is originally:
  # GtkNotebook, GtkWidget, guint, gpointer --> void
  method page-added {
    self.connect($!n, 'page-added');
  }

  # Is originally:
  # GtkNotebook, GtkWidget, guint, gpointer --> void
  method page-removed {
    self.connect($!n, 'page-removed');
  }

  # Is originally:
  # GtkNotebook, GtkWidget, guint, gpointer --> void
  method page-reordered {
    self.connect($!n, 'page-reordered');
  }

  # Is originally:
  # GtkNotebook, GtkDirectionType, gboolean, gpointer --> gboolean
  method reorder-tab {
    self.connect($!n, 'reorder-tab');
  }

  # Is originally:
  # GtkNotebook, gboolean, gpointer --> gboolean
  method select-page {
    self.connect($!n, 'select-page');
  }

  # Is originally:
  # GtkNotebook, GtkWidget, guint, gpointer --> void
  method switch-page {
    self.connect($!n, 'switch-page');
  }
  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  method current_page is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_notebook_get_current_page($!n);
      },
      STORE => sub ($, Int() $page_num is copy) {
        my gint $pn = self.RESOLVE-INT($page_num);
        gtk_notebook_set_current_page($!n, $pn);
      }
    );
  }

  method group_name is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_notebook_get_group_name($!n);
      },
      STORE => sub ($, Str() $group_name is copy) {
        gtk_notebook_set_group_name($!n, $group_name);
      }
    );
  }

  method scrollable is rw {
    Proxy.new(
      FETCH => sub ($) {
        Bool( gtk_notebook_get_scrollable($!n) );
      },
      STORE => sub ($, Int() $scrollable is copy) {
        my gboolean $s = self.RESOLVE-BOOL($scrollable);
        gtk_notebook_set_scrollable($!n, $s);
      }
    );
  }

  method show_border is rw {
    Proxy.new(
      FETCH => sub ($) {
        Bool( gtk_notebook_get_show_border($!n) );
      },
      STORE => sub ($, Int() $show_border is copy) {
        my gboolean $sb = self.RESOLVE-BOOL($show_border);
        gtk_notebook_set_show_border($!n, $sb);
      }
    );
  }

  method show_tabs is rw {
    Proxy.new(
      FETCH => sub ($) {
        Bool( gtk_notebook_get_show_tabs($!n) );
      },
      STORE => sub ($, $show_tabs is copy) {
        my gboolean $st = self.RESOLVE-BOOL($show_tabs);
        gtk_notebook_set_show_tabs($!n, $st);
      }
    );
  }

  method tab_pos is rw {
    Proxy.new(
      FETCH => sub ($) {
        GtkPositionType( gtk_notebook_get_tab_pos($!n) );
      },
      STORE => sub ($, Int() $pos is copy) {
        my uint32 $p = self.RESOLVE-UINT($pos);
        gtk_notebook_set_tab_pos($!n, $p);
      }
    );
  }
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  method append_page (GtkWidget() $child, GtkWidget() $tab_label) {
    gtk_notebook_append_page($!n, $child, $tab_label);
  }

  method append_page_menu (
    GtkWidget() $child,
    GtkWidget() $tab_label,
    GtkWidget() $menu_label
  ) {
    gtk_notebook_append_page_menu($!n, $child, $tab_label, $menu_label);
  }

  method detach_tab (GtkWidget() $child) {
    gtk_notebook_detach_tab($!n, $child);
  }

  method get_action_widget (Int() $pack_type) {
    my uint32 $pt = self.RESOLVE-UINT($pack_type);
    gtk_notebook_get_action_widget($!n, $pt);
  }

  method get_menu_label (GtkWidget() $child) {
    gtk_notebook_get_menu_label($!n, $child);
  }

  method get_menu_label_text (GtkWidget() $child) {
    gtk_notebook_get_menu_label_text($!n, $child);
  }

  method get_n_pages {
    gtk_notebook_get_n_pages($!n);
  }

  method get_nth_page (
    Int() $page_num               # gint $page_num
  ) {
    my gint $pn = self.RESOLVE-INT($page_num);
    gtk_notebook_get_nth_page($!n, $pn);
  }

  method get_tab_detachable (GtkWidget() $child) {
    gtk_notebook_get_tab_detachable($!n, $child);
  }

  method get_tab_hborder {
    gtk_notebook_get_tab_hborder($!n);
  }

  method get_tab_label (GtkWidget() $child) {
    gtk_notebook_get_tab_label($!n, $child);
  }

  method get_tab_label_text (GtkWidget() $child) {
    gtk_notebook_get_tab_label_text($!n, $child);
  }

  multi method get_tab_reorderable (GtkWidget() $child) {
    gtk_notebook_get_tab_reorderable($!n, $child);
  }

  method get_tab_vborder {
    gtk_notebook_get_tab_vborder($!n);
  }

  method get_type {
    gtk_notebook_get_type();
  }

  method insert_page (
    GtkWidget() $child,
    GtkWidget() $tab_label,
    Int() $position
  ) {
    my uint32 $p = self.RESOLVE-UINT($position);
    gtk_notebook_insert_page($!n, $child, $tab_label, $p);
  }

  method insert_page_menu (
    GtkWidget() $child,
    GtkWidget() $tab_label,
    GtkWidget() $menu_label,
    Int() $position               # gint $position
  ) {
    my uint32 $p = self.RESOLVE-UINT($position);
    gtk_notebook_insert_page_menu($!n, $child, $tab_label, $menu_label, $p);
  }

  method next_page {
    gtk_notebook_next_page($!n);
  }

  method page_num (GtkWidget() $child) {
    gtk_notebook_page_num($!n, $child);
  }

  method popup_disable {
    gtk_notebook_popup_disable($!n);
  }

  method popup_enable {
    gtk_notebook_popup_enable($!n);
  }

  method prepend_page (
    GtkWidget() $child,
    GtkWidget() $tab_label
  ) {
    gtk_notebook_prepend_page($!n, $child, $tab_label);
  }

  method prepend_page_menu (
    GtkWidget() $child,
    GtkWidget() $tab_label,
    GtkWidget() $menu_label
  ) {
    gtk_notebook_prepend_page_menu($!n, $child, $tab_label, $menu_label);
  }

  method prev_page {
    gtk_notebook_prev_page($!n);
  }

  method remove_page (Int() $page_num) {
    my gint $pn = self.RESOLVE-INT($page_num);
    gtk_notebook_remove_page($!n, $pn);
  }

  method reorder_child (GtkWidget $child, Int() $position) {
    my gint $p = self.RESOLVE-INT($position);
    gtk_notebook_reorder_child($!n, $child, $p);
  }

  method set_action_widget (
    GtkWidget() $widget,
    int() $pack_type              # GtkPackType $pack_type)
  ) {
    gtk_notebook_set_action_widget($!n, $widget, $pack_type);
  }

  method set_menu_label (
    GtkWidget() $child,
    GtkWidget() $menu_label
  ) {
    gtk_notebook_set_menu_label($!n, $child, $menu_label);
  }

  method set_menu_label_text (GtkWidget() $child, gchar $menu_text) {
    gtk_notebook_set_menu_label_text($!n, $child, $menu_text);
  }

  method set_tab_detachable (
    GtkWidget() $child,
    Int() $detachable             # gboolean $detachable
  ) {
    my gboolean $d = self.RESOLVE-BOOL($detachable);
    gtk_notebook_set_tab_detachable($!n, $child, $d);
  }

  method set_tab_label (GtkWidget() $child, GtkWidget() $tab_label) {
    gtk_notebook_set_tab_label($!n, $child, $tab_label);
  }

  method set_tab_label_text (GtkWidget() $child, gchar $tab_text) {
    gtk_notebook_set_tab_label_text($!n, $child, $tab_text);
  }

  method set_tab_reorderable (
    GtkWidget() $child,
    Int() $reorderable            # gboolean $reorderable
  ) {
    my $r = self.RESOLVE-BOOL($reorderable);
    gtk_notebook_set_tab_reorderable($!n, $child, $r);
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
