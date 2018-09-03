use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::NoteBook;
use GTK::Raw::Types;

use GTK::Container;

class GTK::NoteBook is GTK::Container {
  has Gtk $!n;

  submethod BUILD(:$notebook) {
    given $notebook {
      when GtkNoteBook | GtkWidget {
        $!n = do {
          when GtkNoteBook { $notebook; }
          when GtkWidget   { nativecast(GtkNoteBook, $notebook); }
        }
        self.setContainer($notebook);
      }
      when GTK::NoteBook {
      }
      default {
      }
    }
    self.setType('GTK::NoteBook');
  }

  method new {
    my $notebook = gtk_notebook_new();
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
  # NEEDS REFINEMENT
  method current_page is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_notebook_get_current_page($!n);
      },
      STORE => sub ($, $page_num is copy) {
        gtk_notebook_set_current_page($!n, $page_num);
      }
    );
  }

  method group_name is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_notebook_get_group_name($!n);
      },
      STORE => sub ($, $group_name is copy) {
        gtk_notebook_set_group_name($!n, $group_name);
      }
    );
  }

  method scrollable is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_notebook_get_scrollable($!n);
      },
      STORE => sub ($, $scrollable is copy) {
        gtk_notebook_set_scrollable($!n, $scrollable);
      }
    );
  }

  method show_border is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_notebook_get_show_border($!n);
      },
      STORE => sub ($, $show_border is copy) {
        gtk_notebook_set_show_border($!n, $show_border);
      }
    );
  }

  method show_tabs is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_notebook_get_show_tabs($!n);
      },
      STORE => sub ($, $show_tabs is copy) {
        gtk_notebook_set_show_tabs($!n, $show_tabs);
      }
    );
  }

  method tab_pos is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_notebook_get_tab_pos($!n);
      },
      STORE => sub ($, $pos is copy) {
        gtk_notebook_set_tab_pos($!n, $pos);
      }
    );
  }
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  multi method append_page (GtkWidget $child, GtkWidget $tab_label) {
    gtk_notebook_append_page($!n, $child, $tab_label);
  }
  multi method append_page (GTK::Widget $child, GTK::Widget $tab_label) {
    samewith($child.widget, $tab_label.widget);
  }

  multi method append_page_menu (
    GtkWidget $child,
    GtkWidget $tab_label,
    GtkWidget $menu_label
  ) {
    gtk_notebook_append_page_menu($!n, $child, $tab_label, $menu_label);
  }
  multi method append_page_menu (
    GTK::Widget $child,
    GTK::Widget $tab_label,
    GTK::Widget $menu_label
  )  {
    samewith($child.widget, $tab_label.widget, $menu_label.widget);
  }

  multi method detach_tab (GtkWidget $child) {
    gtk_notebook_detach_tab($!n, $child);
  }
  multi method detach_tab (GTK:Widget $child) {
    samewith($child.widget);
  }

  method get_action_widget (GtkPackType $pack_type) {
    my uint32 $pt = $pack_type.Int;
    gtk_notebook_get_action_widget($!n, $pt);
  }

  multi method get_menu_label (GtkWidget $child) {
    gtk_notebook_get_menu_label($!n, $child);
  }
  multi method get_menu_label (GTK::Widget $child)  {
    samewith($child.widget);
  }

  multi method get_menu_label_text (GtkWidget $child) {
    gtk_notebook_get_menu_label_text($!n, $child);
  }
  multi method get_menu_label_text (GTK::Widget $child)  {
    samewith($child.widget);
  }

  method get_n_pages {
    gtk_notebook_get_n_pages($!n);
  }

  method get_nth_page (gint $page_num) {
    gtk_notebook_get_nth_page($!n, $page_num);
  }

  multi method get_tab_detachable (GtkWidget $child) {
    gtk_notebook_get_tab_detachable($!n, $child);
  }
  multi method get_tab_detachable (GTK::Widget $child)  {
    samewith($child.widget);
  }

  method get_tab_hborder {
    gtk_notebook_get_tab_hborder($!n);
  }

  multi method get_tab_label (GtkWidget $child) {
    gtk_notebook_get_tab_label($!n, $child);
  }
  multi method get_tab_label (GTK::Widget $child)  {
    samewith($child.widget);
  }

  multi method get_tab_label_text (GtkWidget $child) {
    gtk_notebook_get_tab_label_text($!n, $child);
  }
  multi method get_tab_label_text (GTK::Widget $child)  {
    samewith($child.widget);
  }

  multi method get_tab_reorderable (GtkWidget $child) {
    gtk_notebook_get_tab_reorderable($!n, $child);
  }
  multi method get_tab_reorderable (GTK::Widget $child)  {
    samewith($child.widget);
  }

  method get_tab_vborder {
    gtk_notebook_get_tab_vborder($!n);
  }

  method get_type {
    gtk_notebook_get_type();
  }

  multi method insert_page (
    GtkWidget $child,
    GtkWidget $tab_label,
    Int() $position
  ) {
    my uint32 $p = $position +& 0xffff;
    gtk_notebook_insert_page($!n, $child, $tab_label, $p);
  }
  multi method insert_page (
    GTK::Widget $child,
    GTK::Widget $tab_label,
    Int()       $position
  ) {
    samewith($child.widget, $tab_label.widget, $position);
  }

  multi method insert_page_menu (
    GtkWidget $child,
    GtkWidget $tab_label,
    GtkWidget $menu_label,
    gint $position
  ) {
    my uint32 $p = $position +& 0xffff;
    gtk_notebook_insert_page_menu($!n, $child, $tab_label, $menu_label, $p);
  }
  multi method insert_page_menu (
    GtkWidget $child,
    GtkWidget $tab_label,
    GtkWidget $menu_label,
    Int()     $position
  ) {
    samewith($child, $tab_label, $menu_label, $position);
  }

  method next_page {
    gtk_notebook_next_page($!n);
  }

  multi method page_num (GtkWidget $child) {
    gtk_notebook_page_num($!n, $child);
  }
  multi method page_num (GTK::Widget $child)  {
    samewith($child.widget);
  }

  method popup_disable {
    gtk_notebook_popup_disable($!n);
  }

  method popup_enable {
    gtk_notebook_popup_enable($!n);
  }

  multi method prepend_page (GtkWidget $child, GtkWidget $tab_label) {
    gtk_notebook_prepend_page($!n, $child, $tab_label);
  }
  multi method prepend_page (GTK::Widget $child, GTK::Widget $tab_label)  {
    samewith($child.widget, $tab_label.widget);
  }

  multi method prepend_page_menu (
    GtkWidget $child,
    GtkWidget $tab_label,
    GtkWidget $menu_label
  ) {
    gtk_notebook_prepend_page_menu($!n, $child, $tab_label, $menu_label);
  }
  multi method prepend_page_menu (
    GTK::Widget $child,
    GtkWidget $tab_label,
    GtkWidget $menu_label
  ) {
    samewith($child.widget, $tab_label.widget, $menu_label.widget);
  }

  method prev_page {
    gtk_notebook_prev_page($!n);
  }

  method remove_page (Int() $page_num) {
    my gint $pn = $page_num +& 0xffff;
    gtk_notebook_remove_page($!n, $page_num);
  }

  multi method reorder_child (GtkWidget $child, Int() $position) {
    my gint $p = $position +& 0xffff;
    gtk_notebook_reorder_child($!n, $child, $p);
  }
  multi method reorder_child (GTK::Widget $child, Int() $position)  {
    samewith($child, $position);
  }

  multi method set_action_widget (GtkWidget $widget, GtkPackType $pack_type) {
    gtk_notebook_set_action_widget($!n, $widget, $pack_type);
  }
  multi method set_action_widget (GtkWidget $widget, GtkPackType $pack_type)  {
    samewith($widget, $pack_type);
  }

  multi method set_menu_label (GtkWidget $child, GtkWidget $menu_label) {
    gtk_notebook_set_menu_label($!n, $child, $menu_label);
  }
  multi method set_menu_label (GTK::Widget $child, GTK::Widget $menu_label)  {
    samewith($child.widget, $menu_label.widget);
  }

  multi method set_menu_label_text (GtkWidget $child, gchar $menu_text) {
    gtk_notebook_set_menu_label_text($!n, $child, $menu_text);
  }
  multi method set_menu_label_text (GTK::Widget $child, gchar $menu_text)  {
    samewith($child.widget, $menu_text);
  }

  multi method set_tab_detachable (GtkWidget $child, gboolean $detachable) {
    my $mn = ?::CLASS ~ "::{ &?ROUTINE }";
    my $d = self.RESOLVE_BOOLEAN($reorderable, $mn);
    gtk_notebook_set_tab_detachable($!n, $child, $d);
  }
  multi method set_tab_detachable (GTK::Widget $child, $detachable)  {
    samewith($child, $detachable);
  }

  multi method set_tab_label (GtkWidget $child, GtkWidget $tab_label) {
    gtk_notebook_set_tab_label($!n, $child, $tab_label);
  }
  multi method set_tab_label (GTK::Widget $child, GTK::Widget $tab_label)  {
    samewith($child.widget, $tab_label.widget);
  }

  multi method set_tab_label_text (GtkWidget $child, gchar $tab_text) {
    gtk_notebook_set_tab_label_text($!n, $child, $tab_text);
  }
  multi method set_tab_label_text (GTK::Widget $child, gchar $tab_text)  {
    samewith($child.widget, $tab_text);
  }

  multi method set_tab_reorderable (GtkWidget $child, gboolean $reorderable) {
    my $mn = ?::CLASS ~ "::{ &?ROUTINE }";
    my $r = self.RESOLVE_BOOLEAN($reorderable, $mn);
    gtk_notebook_set_tab_reorderable($!n, $child, $r);
  }
  multi method set_tab_reorderable (GTK::Widget $child, $reorderable)  {
    samewith($child.widget, $reorderable);
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
