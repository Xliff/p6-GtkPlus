use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::MenuShell;
use GTK::Raw::Types;

use GTK::Container;
use GTK::MenuItem;

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
        $to-parent = nativecast(GtkContainer, $_);
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
  # Made multi due to further declarations in subclasses
  multi method insert {
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
        my $tf = self.RESOLVE-BOOL($take_focus);
        gtk_menu_shell_set_take_focus($!ms, $tf);
      }
    );
  }
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  method activate_item (
    GtkWidget() $menu_item,
    Int() $force_deactivate
  ) {
    my gboolean $fd = self.RESOLVE-BOOL($force_deactivate);
    gtk_menu_shell_activate_item($!ms, $menu_item, $fd);
  }

  multi method append-widgets (*@children) {
    die 'All children must be GTK::MenuItem or a GtkMenuItem reference.'
      unless @children.all ~~ (GTK::MenuItem, GtkMenuItem).any;

    for @children {
      self.append($_);
    }
  }
  multi method append (GTK::Widget $child) {
    self.push-start($child);
    self.SET-LATCH;
    samewith($child.widget);
  }
  multi method append (GtkWidget $child) {
    self.push-start($child) unless self.IS-LATCHED;
    self.UNSET-LATCH;
    gtk_menu_shell_append($!ms, $child);
  }

  method bind_model (
    GMenuModel $model,
    gchar $action_namespace,
    Int() $with_separators
  ) {
    my gboolean $ws = self.RESOLVE-BOOL($with_separators);
    gtk_menu_shell_bind_model($!ms, $model, $action_namespace, $ws);
  }

  method emit-cancel {
    gtk_menu_shell_cancel($!ms);
  }

  method emit-deactivate {
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
    self.INSERT-START($child, $position) unless self.IS-LATCHED;
    self.UNSET-LATCH;
    my gint $p = self.RESOLVE-INT($position);
    gtk_menu_shell_insert($!ms, $child, $p);
  }
  multi method insert (GTK::MenuItem $child, Int() $position) {
    self.INSERT-START($child, $position);
    self.SET-LATCH;
    samewith($child, $position);
  }

  multi method prepend (GtkWidget $child) {
    self.unshift-end($child) unless self.IS-LATCHED;
    self.UNSET-LATCH;
    gtk_menu_shell_prepend($!ms, $child);
  }
  multi method prepend (GTK::MenuItem $child) {
    self.unshift-end($child);
    self.SET-LATCH;
    samewith($child.widget);
  }

  method select_first (Int() $search_sensitive) {
    my gboolean $ss = self.RESOLVE-BOOL($search_sensitive);
    gtk_menu_shell_select_first($!ms, $ss);
  }

  method select_item (GtkWidget() $menu_item) {
    gtk_menu_shell_select_item($!ms, $menu_item);
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
