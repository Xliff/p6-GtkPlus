use v6.c;

use Method::Also;
use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::Menu;
use GTK::Raw::Types;

use GTK::MenuShell;

use GTK::Roles::Signals::Generic;
use GTK::Roles::Signals::Menu;

my subset Ancestry
  where GtkMenu | GtkMenuShell | GtkBuildable | GtkWidget;

class GTK::Menu is GTK::MenuShell {
  also does GTK::Roles::Signals::Generic;
  also does GTK::Roles::Signals::Menu;

  has GtkMenu $!m;

  method bless(*%attrinit) {
    my $o = self.CREATE.BUILDALL(Empty, %attrinit);
    $o.setType('GTK::MenuShell');
    $o;
  }

  submethod BUILD(:$menu, :@items) {
    my $to-parent;
    given $menu {
      when Ancestry {
        $!m = do {
          when GtkBuildable | GtkMenuShell | GtkWidget {
            $to-parent = $_;
            nativecast(GtkMenu, $_);
          }
          when GtkMenu {
            $to-parent = nativecast(GtkMenuShell, $_);
            $_;
          }
        };
        self.setMenuShell($to-parent);
      }
      when GTK::Menu {
      }
      default {
      }
    }

    with @items {
      die 'All items in @append must be GTK::MenuItems or GtkMenuItem references.'
        unless @items.all ~~ (GTK::MenuItem, GtkMenuItem).any;
      self.append-widgets($_) for @items;
    }
  }

  submethod DESTROY {
    self.disconnect-all($_) for %!signals, %!signals-menu;
  }

  multi method new {
    my $menu = gtk_menu_new();
    self.bless(:$menu);
  }
  multi method new (Ancestry $menu) {
    self.bless(:$menu);
  }
  multi method new (*@items) {
    my $menu = gtk_menu_new();
    self.bless(:$menu, :@items);
  }

  method new_from_model (GMenuModel $model) is also<new-from-model> {
    my $menu = gtk_menu_new_from_model($model);
    self.bless(:$menu);
  }

  # ↓↓↓↓ SIGNALS ↓↓↓↓

  # Is originally:
  # GtkMenu, GtkScrollType, gpointer --> void
  method move-scroll is also<move_scroll> {
    self.connect-uint($!m, 'move-scroll');
  }

  # Is originally:
  # GtkMenu, gpointer, gpointer, gboolean, gboolean, gpointer --> void
  method popped-up is also<popped_up> {
    self.connect-popped-up($!m);
  }
  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  method accel_group is rw is also<accel-group> {
    Proxy.new(
      FETCH => sub ($) {
        gtk_menu_get_accel_group($!m);
      },
      STORE => sub ($, GtkAccelGroup $accel_group is copy) {
        # GTK::AccelGroup NYI
        gtk_menu_set_accel_group($!m, $accel_group);
      }
    );
  }

  method accel_path is rw is also<accel-path> {
    Proxy.new(
      FETCH => sub ($) {
        gtk_menu_get_accel_path($!m);
      },
      STORE => sub ($, Str() $accel_path is copy) {
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
        my gint $i = self.RESOLVE-INT($index);
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
        my gint $mn = self.RESOLVE-INT($monitor_num);
        gtk_menu_set_monitor($!m, $mn);
      }
    );
  }

  method reserve_toggle_size is rw is also<reserve-toggle-size> {
    Proxy.new(
      FETCH => sub ($) {
        so gtk_menu_get_reserve_toggle_size($!m);
      },
      STORE => sub ($, Int() $reserve_toggle_size is copy) {
        my $rts = self.RESOLVE-BOOL($reserve_toggle_size);
        gtk_menu_set_reserve_toggle_size($!m, $rts);
      }
    );
  }

  method tearoff_state is rw is also<tearoff-state> {
    Proxy.new(
      FETCH => sub ($) {
        so gtk_menu_get_tearoff_state($!m);
      },
      STORE => sub ($, $torn_off is copy) {
        my $to = self.RESOLVE-BOOL($torn_off);
        gtk_menu_set_tearoff_state($!m, $to);
      }
    );
  }

  method title is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_menu_get_title($!m);
      },
      STORE => sub ($, Str() $title is copy) {
        gtk_menu_set_title($!m, $title);
      }
    );
  }
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  method attach (
    GtkWidget() $child,
    Int() $left_attach,
    Int() $right_attach,
    Int() $top_attach,
    Int() $bottom_attach
  ) {
    my @u = ($left_attach, $right_attach, $top_attach, $bottom_attach);
    my guint ($la, $ra, $ta, $ba) = self.RESOLVE-UINT(@u);
    gtk_menu_attach($!m, $child, $la, $ra, $ta, $ba);
  }

  method attach_to_widget (
    GtkWidget() $attach_widget,
    GtkMenuDetachFunc $detacher
  ) is also<attach-to-widget> {
    gtk_menu_attach_to_widget($!m, $attach_widget, $detacher);
  }

  method detach {
    gtk_menu_detach($!m);
  }

  method get_attach_widget is also<get-attach-widget> {
    gtk_menu_get_attach_widget($!m);
  }

  method get_for_attach_widget is also<get-for-attach-widget> {
    gtk_menu_get_for_attach_widget($!m.widget);
  }

  method get_type is also<get-type> {
    gtk_menu_get_type();
  }

  method place_on_monitor (GdkMonitor $monitor) is also<place-on-monitor> {
    gtk_menu_place_on_monitor($!m, $monitor);
  }

  method popdown {
    gtk_menu_popdown($!m);
  }

  multi method popup (
    GtkWidget() $parent_menu_shell,
    GtkWidget() $parent_menu_item,
    GtkMenuPositionFunc $func,
    gpointer $data,
    Int() $button,
    Int() $activate_time
  ) is DEPRECATED {
    my @u = ($button, $activate_time);
    my guint32 ($b, $at) = self.RESOLVE-UINT(@u);
    gtk_menu_popup(
      $!m, $parent_menu_shell, $parent_menu_item, $func, $data, $b, $at
    );
  }

  method popup_at_pointer (GdkEvent $trigger_event) is also<popup-at-pointer> {
    gtk_menu_popup_at_pointer($!m, $trigger_event);
  }

  method popup_at_rect (
    GdkWindow $rect_window,
    GdkRectangle() $rect,
    GdkGravity $rect_anchor,
    GdkGravity $menu_anchor,
    GdkEvent $trigger_event
  ) is also<popup-at-rect> {
    gtk_menu_popup_at_rect(
      $!m, $rect_window, $rect, $rect_anchor, $menu_anchor, $trigger_event
    );
  }

  method popup_at_widget (
    GtkWidget() $widget,
    GdkGravity $widget_anchor,
    GdkGravity $menu_anchor,
    GdkEvent $trigger_event
  ) is also<popup-at-widget> {
    gtk_menu_popup_at_widget(
      $!m, $widget, $widget_anchor, $menu_anchor, $trigger_event
    );
  }

  method popup_for_device (
    GdkDevice $device,
    GtkWidget() $parent_menu_shell,
    GtkWidget() $parent_menu_item,
    GtkMenuPositionFunc $func,
    gpointer $data,
    GDestroyNotify $destroy,
    Int() $button,
    Int() $activate_time
  ) is DEPRECATED is also<popup-for-device> {
    my @u = ($button, $activate_time);
    my guint32 ($b, $at) = self.RESOLVE-UINT(@u);
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

  method reorder_child (GtkWidget() $child, Int() $position) is also<reorder-child> {
    my gint $p = self.RESOLVE-INT($position);
    gtk_menu_reorder_child($!m, $child, $p);
  }

  method reposition {
    gtk_menu_reposition($!m);
  }

  method set_screen (GdkScreen $screen) is also<set-screen> {
    gtk_menu_set_screen($!m, $screen);
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}

