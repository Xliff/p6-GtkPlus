use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::MenuShell;
use GTK::Raw::Types;

use GTK::Container;

class GTK::MenuShell is GTK::Container {
  has GtkMenuShell $!ms;

  method new {
    die "Cannot instantiate a GTK::MenuShell object.";
  }

  method setMenuShell($menushell) {
    self.IS-PROTECTED;

    my $to-parent;
    $!ms = do given $menushell {
      when GtkMenuShell {
        $to-parent = nativecall(GtkContainer, $_);
        $menushell;
      }
      when GtkWidget {
        $to-parent = $_;
        nativecast(GtkMenuShell, $_);
      }
    }
    self.setContainer($to-parent);
  }

  # ↓↓↓↓ SIGNALS ↓↓↓↓

  # Is originally:
  # GtkMenuShell, gboolean, gpointer --> void
  method activate-current {
    self.connect($!ms, 'activate-current');
  }

  # Is originally:
  # GtkMenuShell, gpointer --> void
  method cancel {
    self.connect($!ms, 'cancel');
  }

  # Is originally:
  # GtkMenuShell, GtkDirectionType, gpointer --> void
  method cycle-focus {
    self.connect($!ms, 'cycle-focus');
  }

  # Is originally:
  # GtkMenuShell, gpointer --> void
  method deactivate {
    self.connect($!ms, 'deactivate');
  }

  # Is originally:
  # GtkMenuShell, GtkWidget, gint, gpointer --> void
  method insert {
    self.connect($!ms, 'insert');
  }

  # Is originally:
  # GtkMenuShell, GtkMenuDirectionType, gpointer --> void
  method move-current {
    self.connect($!ms, 'move-current');
  }

  # Is originally:
  # GtkMenuShell, gint, gpointer --> gboolean
  method move-selected {
    self.connect($!ms, 'move-selected');
  }

  # Is originally:
  # GtkMenuShell, gpointer --> void
  method selection-done {
    self.connect($!ms, 'selection-done');
  }
  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  method take_focus is rw {
    Proxy.new(
      FETCH => sub ($) {
        Bool( gtk_menu_shell_get_take_focus($!ms) );
      },
      STORE => sub ($, Int() $take_focus is copy) {
        my $tf = $take_focus == 0 ?? 0 !! 1;
        gtk_menu_shell_set_take_focus($!ms, $tf);
      }
    );
  }
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  multi method activate_item (
    GtkWidget $menu_item,
    gboolean $force_deactivate
  ) {
    gtk_menu_shell_activate_item($!ms, $menu_item, $force_deactivate);
  }
  multi method activate_item (
    GTK::Widget $menu_item,
    Int() $force_deactivate
  ) {
    my $fd = $force_deactivate +& 0xffff;
    samewith($menu_item.widget, $fd);
  }

  multi method append (GtkWidget $child) {
    gtk_menu_shell_append($!ms, $child);
  }
  multi method append (GTK::Widget $child)  {
    samewith($child.widget);
  }

  method bind_model (
    GMenuModel $model,
    gchar $action_namespace,
    Int() $with_separators
  ) {
    my $ws = $with_separators +& 0xffff;
    gtk_menu_shell_bind_model($!ms, $model, $action_namespace, $ws);
  }

  method cancel {
    gtk_menu_shell_cancel($!ms);
  }

  method deactivate {
    gtk_menu_shell_deactivate($!ms);
  }

  method deselect {
    gtk_menu_shell_deselect($!ms);
  }

  method get_parent_shell {
    gtk_menu_shell_get_parent_shell($!ms);
  }

  method get_selected_item {
    gtk_menu_shell_get_selected_item($!ms);
  }

  method get_type {
    gtk_menu_shell_get_type();
  }

  multi method insert (GtkWidget $child, Int() $position) {
    my $p = $position +& 0xffff;
    gtk_menu_shell_insert($!ms, $child, $p);
  }
  multi method insert (GTK::Widget $child, Int() $position)  {
    my $p = $position +& 0xffff;
    samewith($child.widget, $p);
  }

  multi method prepend (GtkWidget $child) {
    gtk_menu_shell_prepend($!ms, $child);
  }
  multi method prepend (GTK::Widget $child)  {
    samewith($child.widget);
  }

  method select_first (Int() $search_sensitive) {
    my $ss = $search_sensitive +& 0xffff;
    gtk_menu_shell_select_first($!ms, $ss);
  }

  multi method select_item (GtkWidget $menu_item) {
    gtk_menu_shell_select_item($!ms, $menu_item);
  }
  multi method select_item (GTK::Widget $menu_item)  {
    samewith($menu_item.widget);
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
