use v6.c;

use Method::Also;

use GTK::Raw::MenuShell;
use GTK::Raw::Types;

use GTK::Container;
use GTK::MenuItem;

use GTK::Roles::Signals::MenuShell;

our subset MenuShellAncestry is export
  where GtkMenuShell | ContainerAncestry;

class GTK::MenuShell is GTK::Container {
  also does GTK::Roles::Signals::MenuShell;

  has GtkMenuShell $!ms is implementor;

  submethod DESTROY {
    self.disconnect-all($_) for %!signals-ms;
  }

  method GTK::Raw::Definitions::GtkMenuShell
    is also<
      MenuShell
      GtkMenuShell
    >
  { $!ms }

  method new {
    die 'Cannot instantiate a GTK::MenuShell object.';
  }

  method setMenuShell(MenuShellAncestry $menushell) {
    self.IS-PROTECTED;

    my $to-parent;
    $!ms = do given $menushell {
      when GtkMenuShell {
        $to-parent = cast(GtkContainer, $_);
        $menushell;
      }
      when GtkWidget {
        $to-parent = $_;
        cast(GtkMenuShell, $_);
      }
    }
    self.setContainer($to-parent);
  }

  # ↓↓↓↓ SIGNALS ↓↓↓↓

  # Is originally:
  # GtkMenuShell, gboolean, gpointer --> void
  method activate-current is also<activate_current> {
    self.connect-uint($!ms, 'activate-current');
  }

  # Is originally:
  # GtkMenuShell, gpointer --> void
  method cancel {
    self.connect($!ms, 'cancel');
  }

  # Is originally:
  # GtkMenuShell, GtkDirectionType, gpointer --> void
  method cycle-focus is also<cycle_focus> {
    self.connect-uint($!ms, 'cycle-focus');
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
    self.connect-insert($!ms);
  }

  # Is originally:
  # GtkMenuShell, GtkMenuDirectionType, gpointer --> void
  method move-current is also<move_current> {
    self.connect-uint($!ms, 'move-current');
  }

  # Is originally:
  # GtkMenuShell, gint, gpointer --> gboolean
  method move-selected is also<move_selected> {
    self.connect-int-ruint($!ms, 'move-selected');
  }

  # Is originally:
  # GtkMenuShell, gpointer --> void
  method selection-done is also<selection_done> {
    self.connect($!ms, 'selection-done');
  }
  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  method take_focus is rw is also<take-focus> {
    Proxy.new(
      FETCH => sub ($) {
        so gtk_menu_shell_get_take_focus($!ms);
      },
      STORE => sub ($, Int() $take_focus is copy) {
        my gboolean $tf = $take_focus.so.Int;

        gtk_menu_shell_set_take_focus($!ms, $tf);
      }
    );
  }
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  method activate_item (
    GtkWidget() $menu_item,
    Int() $force_deactivate
  )
    is also<activate-item>
  {
    my gboolean $fd = $force_deactivate.so.Int;

    gtk_menu_shell_activate_item($!ms, $menu_item, $fd);
  }

  multi method append-widgets (*@children) is also<append_widgets> {
    die 'All menu children must be of type GTK::MenuItem or GtkMenuItem.'
      unless @children.all ~~ (GTK::MenuItem, GtkMenuItem).any;

    self.append($_) for @children;
  }
  multi method append (GTK::Widget $child) {
    self.push-start($child);
    self.SET-LATCH;
    samewith($child.Widget);
  }
  multi method append (GtkWidget $child) {
    self.push-start($child) unless self.IS-LATCHED;
    self.UNSET-LATCH;
    gtk_menu_shell_append($!ms, $child);
  }

  method bind_model (
    GMenuModel() $model,
    Str() $action_namespace,
    Int() $with_separators
  )
    is also<bind-model>
  {
    my gboolean $ws = $with_separators.so.Int;

    gtk_menu_shell_bind_model($!ms, $model, $action_namespace, $ws);
  }

  method emit-cancel is also<emit_cancel> {
    gtk_menu_shell_cancel($!ms);
  }

  method emit-deactivate is also<emit_deactivate> {
    gtk_menu_shell_deactivate($!ms);
  }

  method deselect {
    gtk_menu_shell_deselect($!ms);
  }

  method get_parent_shell (:$raw = False, :$widget = False)
    is also<get-parent-shell>
  {
    my $w = gtk_menu_shell_get_parent_shell($!ms);

    self.ReturnWidget($w, $raw, $widget);
  }

  method get_selected_item (:$raw = False, :$widget = False)
    is also<get-selected-item>
  {
    my $w = gtk_menu_shell_get_selected_item($!ms);

    self.ReturnWidget($w, $raw, $widget);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    GTK::Widget.unstable_get_type( &gtk_menu_shell_get_type, $n, $t );
  }

  multi method insert (GtkWidget $child, Int() $position) {
    self.INSERT-START($child, $position) unless self.IS-LATCHED;
    self.UNSET-LATCH;
    my gint $p = $position;

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
    samewith($child.Widget);
  }

  method select_first (Int() $search_sensitive) is also<select-first> {
    my gboolean $ss = $search_sensitive.so.Int;

    gtk_menu_shell_select_first($!ms, $ss);
  }

  method select_item (GtkWidget() $menu_item) is also<select-item> {
    gtk_menu_shell_select_item($!ms, $menu_item);
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
