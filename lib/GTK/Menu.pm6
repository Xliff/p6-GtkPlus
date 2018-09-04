use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::Menu;
use GTK::Raw::Types;

use GTK::MenuShell;

class GTK::Menu is GTK::MenuShell {
  has GtkMenu $!m;

  submethod BUILD(:$menu) {
    my $to-parent;
    given $menu {
      when GtkMenu | GtkMenuShell | GtkWidget {
        $!m = do {
          when GtkMenuShell | GtkWidget {
            $to-parent = $menu;
            nativecast(GtkMenu, $menu);
          }
          when GtkMenu {
            $to-parent = nativecast(GtkMenuShell, $menu);
            $menu;
          }
        };
        self.setMenuShell($to-parent);
      }
      when GTK::Menu {
      }
      default {
      }
    }
  }

  method new {
    my $menu = gtk_menu_new();
    self.bless(:$menu);
  }

  method new_from_model (GMenuModel $model) {
    my $menu = gtk_menu_new_from_model($model);
    self.bless(:$menu);
  }

  # ↓↓↓↓ SIGNALS ↓↓↓↓

  # Is originally:
  # GtkMenu, GtkScrollType, gpointer --> void
  method move-scroll {
    self.connect($!m, 'move-scroll');
  }

  # Is originally:
  # GtkMenu, gpointer, gpointer, gboolean, gboolean, gpointer --> void
  method popped-up {
    self.connect($!m, 'popped-up');
  }
  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  method accel_group is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_menu_get_accel_group($!m);
      },
      STORE => sub ($, $accel_group is copy) {
        gtk_menu_set_accel_group($!m, $accel_group);
      }
    );
  }

  method accel_path is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_menu_get_accel_path($!m);
      },
      STORE => sub ($, $accel_path is copy) {
        gtk_menu_set_accel_path($!m, $accel_path);
      }
    );
  }

  method active is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_menu_get_active($!m);
      },
      STORE => sub ($, Int() $index is copy) {
        my gint $ii = $index +& 0xffff;
        gtk_menu_set_active($!m, $i);
      }
    );
  }

  method monitor is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_menu_get_monitor($!m);
      },
      STORE => sub ($, Int() $monitor_num is copy) {
        my gint $mn = $monitor_num +& 0xffff;
        gtk_menu_set_monitor($!m, $mn);
      }
    );
  }

  method reserve_toggle_size is rw {
    Proxy.new(
      FETCH => sub ($) {
        Bool( gtk_menu_get_reserve_toggle_size($!m) );
      },
      STORE => sub ($, Int() $reserve_toggle_size is copy) {
        my $rts = $reserve_toggle_size == 0 ?? 0 !! 1;
        gtk_menu_set_reserve_toggle_size($!m, $rts);
      }
    );
  }

  method tearoff_state is rw {
    Proxy.new(
      FETCH => sub ($) {
        Bool( gtk_menu_get_tearoff_state($!m) );
      },
      STORE => sub ($, $torn_off is copy) {
        my $to = $torn_off == 0 ?? 0 !! 1
        gtk_menu_set_tearoff_state($!m, $to);
      }
    );
  }

  method title is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_menu_get_title($!m);
      },
      STORE => sub ($, Str $title is copy) {
        gtk_menu_set_title($!m, $title);
      }
    );
  }
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  multi method attach (
    GtkWidget $child,
    Int() $left_attach,
    Int() $right_attach,
    Int() $top_attach,
    Int() $bottom_attach
  ) {
    my guint ($la, $ra, $ta, $ba) =
      ($left_attach, $right_attach, $top_attach, $bottom_attach)
      >>+&<<
      (0xffff xx 4);

    gtk_menu_attach($!m, $child, $la, $ra, $ta, $ba);
  }
  multi method attach (
    GTK::Widget $child,
    Int() $left_attach,
    Int() $right_attach,
    Int() $top_attach,
    Int() $bottom_attach
  ) {
    samewith(
      $child.widget,
      $left_attach,
      $right_attach,
      $top_attach,
      $bottom_attach
    );
  }

  multi method attach_to_widget (
    GtkWidget $attach_widget,
    GtkMenuDetachFunc $detacher
  ) {
    gtk_menu_attach_to_widget($!m, $attach_widget, $detacher);
  }
  multi method attach_to_widget (
    GTK::Widget $attach_widget,
    GtkMenuDetachFunc $detacher
  ) {
    samewith($attach_widget.widget, $detacher);
  }

  method detach {
    gtk_menu_detach($!m);
  }

  method get_attach_widget {
    gtk_menu_get_attach_widget($!m);
  }

  method get_for_attach_widget {
    gtk_menu_get_for_attach_widget($!m);
  }

  method get_type {
    gtk_menu_get_type();
  }

  method place_on_monitor (GdkMonitor $monitor) {
    gtk_menu_place_on_monitor($!m, $monitor);
  }

  method popdown () {
    gtk_menu_popdown($!m);
  }

  multi method popup (
    GtkWidget $parent_menu_shell,
    GtkWidget $parent_menu_item,
    GtkMenuPositionFunc $func,
    gpointer $data,
    Int() $button,
    Int() $activate_time
  ) {
    my guint    $b = $button +& 0xffff;
    my guint32 $at = $activate_time +& 0xffff;
    gtk_menu_popup(
      $!m,
      $parent_menu_shell,
      $parent_menu_item,
      $func,
      $data,
      $b,
      $at
    );
  }
  multi method popup (
    GtkWidget $parent_menu_shell,
    GtkWidget $parent_menu_item,
    GtkMenuPositionFunc $func,
    gpointer $data,
    Int() $button,
    Int() $activate_time
  ) {
    samewith(
      $parent_menu_shell.widget,
      $parent_menu_item.widget,
      $func,
      $data,
      $button,
      $activate_time
    );
  }

  method popup_at_pointer (GdkEvent $trigger_event) {
    gtk_menu_popup_at_pointer($!m, $trigger_event);
  }

  method popup_at_rect (
    GdkWindow $rect_window,
    GdkRectangle $rect,
    GdkGravity $rect_anchor,
    GdkGravity $menu_anchor,
    GdkEvent $trigger_event
  ) {
    gtk_menu_popup_at_rect($!m, $rect_window, $rect, $rect_anchor, $menu_anchor, $trigger_event);
  }

  multi method popup_at_widget (
    GtkWidget $widget,
    GdkGravity $widget_anchor,
    GdkGravity $menu_anchor,
    GdkEvent $trigger_event
  ) {
    gtk_menu_popup_at_widget(
      $!m,
      $widget,
      $widget_anchor,
      $menu_anchor,
      $trigger_event
    );
  }
  multi method popup_at_widget (
    GtkWidget $widget,
    GdkGravity $widget_anchor,
    GdkGravity $menu_anchor,
    GdkEvent $trigger_event
  ) {
    samewith($widget.widget, $widget_anchor, $menu_anchor, $trigger_event);
  }

  multi method popup_for_device (
    GdkDevice $device,
    GtkWidget $parent_menu_shell,
    GtkWidget $parent_menu_item,
    GtkMenuPositionFunc $func,
    gpointer $data, GDestroyNotify
    $destroy,
    Int() $button,
    Int() $activate_time
  ) {
    my guint    $b = $button +& 0xffff;
    my guint32 $at = $activate_time +& 0xffff;
    gtk_menu_popup_for_device(
      $!m,
      $device,
      $parent_menu_shell,
      $parent_menu_item,
      $func,
      $data,
      $destroy,
      $b,
      $at
    );
  }
  multi method popup_for_device (
    GdkDevice $device,
    GTK::Widget $parent_menu_shell,
    GTK::Widget $parent_menu_item,
    GtkMenuPositionFunc $func,
    gpointer $data,
    GDestroyNotify $destroy,
    Int() $button,
    Int() $activate_time
  ) {
    samewith(
      $device,
      $parent_menu_shell.widget,
      $parent_menu_item.widget,
      $func,
      $data,
      $destroy,
      $button,
      $activate_time
    );
  }

  multi method reorder_child (GtkWidget $child, Int() $position) {
    my $p = $position +& 0xffff;
    gtk_menu_reorder_child($!m, $child, $p);
  }
  multi method reorder_child (GTK::Widget $child, Int() $position)  {
    samewith($child.widget, $position);
  }

  method reposition {
    gtk_menu_reposition($!m);
  }

  method set_screen (GdkScreen $screen) {
    gtk_menu_set_screen($!m, $screen);
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
