use v6.c;

use Method::Also;

use GLib::Raw::Traits;
use GTK::Raw::Menu:ver<3.0.1146>;
use GTK::Raw::Types:ver<3.0.1146>;

use GTK::Roles::Signals::Generic:ver<3.0.1146>;
use GTK::Roles::Signals::Menu:ver<3.0.1146>;

use GTK::AccelGroup:ver<3.0.1146>;
use GTK::MenuShell:ver<3.0.1146>;
use GTK::Widget:ver<3.0.1146>;

our subset GtkMenuAncestry is export
  where GtkMenu | GtkMenuShellAncestry;

class GTK::Menu:ver<3.0.1146> is GTK::MenuShell {
  also does GTK::Roles::Signals::Menu;

  has GtkMenu $!m is implementor;

  submethod BUILD ( :$menu ) {
    self.setGtkMenu($menu) if $menu;
  }

  submethod TWEAK ( :@items ) {
    # Type check is done inside.
    self.append-widgets(|@items) if @items;
  }

  method setGtkMenu (GtkMenuAncestry $_) {
    my $to-parent;
    $!m = do {
      when GtkMenu {
        $to-parent = cast(GtkMenuShell, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GtkMenu, $_);
      }
    }
    self.setGtkMenuShell($to-parent);
  }

  submethod DESTROY {
    self.disconnect-all($_) for %!signals-menu;
  }

  method GTK::Raw::Definitions::GtkMenu
    is also<
      Menu
      GtkMenu
    >
  { $!m }

  multi method new (GtkMenuAncestry $menu, :$ref = True) {
    return Nil unless $menu;

    my $o = self.bless(:$menu);
    $o.ref if $ref;
    $o;
  }
  multi method new {
    my $menu = gtk_menu_new();

    $menu ?? self.bless(:$menu) !! Nil;
  }
  multi method new (*@items) {
    my $menu = gtk_menu_new();

    $menu ?? self.bless(:$menu, :@items) !! Nil;
  }

  multi method new (GMenuModel $m, :$model is required) {
    self.new_from_model($m);
  }
  method new_from_model (GMenuModel() $model) is also<new-from-model> {
    my $menu = gtk_menu_new_from_model($model);

    $menu ?? self.bless(:$menu) !! Nil;
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
  method accel_group (:$raw = False) is rw is also<accel-group> {
    Proxy.new(
      FETCH => sub ($) {
        my $ag = gtk_menu_get_accel_group($!m);

        $ag ??
          ( $raw ?? $ag !! GTK::AccelGroup.new($ag) )
          !!
          Nil;
      },
      STORE => sub ($, GtkAccelGroup() $accel_group is copy) {
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
        my gint $i = $index;

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
        my gint $mn = $monitor_num;

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
        my gboolean $rts = $reserve_toggle_size.so.Int;

        gtk_menu_set_reserve_toggle_size($!m, $rts);
      }
    );
  }

  method tearoff_state is rw is also<tearoff-state> {
    Proxy.new(
      FETCH => sub ($) {
        so gtk_menu_get_tearoff_state($!m);
      },
      STORE => sub ($, Int() $torn_off is copy) {
        my gboolean $to = $torn_off.so.Int;

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
    Int()       $left_attach,
    Int()       $right_attach,
    Int()       $top_attach,
    Int()       $bottom_attach
  ) {
    my guint ($la, $ra, $ta, $ba) =
      ($left_attach, $right_attach, $top_attach, $bottom_attach);

    gtk_menu_attach($!m, $child, $la, $ra, $ta, $ba);
  }

  method attach_to_widget (
    GtkWidget() $attach_widget,
                &detacher       = Callable
  )
    is also<attach-to-widget>
  {
    gtk_menu_attach_to_widget($!m, $attach_widget, &detacher);
  }

  method detach {
    gtk_menu_detach($!m);
  }

  method get_attach_widget (:$raw = False, :$widget = False)
    is also<
      get-attach-widget
      attach_widget
      attach-widget
    >
  {
    my $w = gtk_menu_get_attach_widget($!m);

    ReturnWidget($w, $raw, $widget);
  }

  method get_for_attach_widget (
    GtkWidget()  $w,
                :$glist  = False,
                :$raw    = False,
                :$widget = False
  )
    is static
    is also<get-for-attach-widget>
  {
    my $wl = gtk_menu_get_for_attach_widget($w);

    return Nil unless $wl;
    return $wl if $glist;

    $wl = GLib::GList.new($wl) but GLib::Roles::ListData[GtkWidget];
    $wl.Array.map({ ReturnWidget($_, $raw, $widget) });
  }

  method get_type is also<get-type> {
    state ($n, $t);

    GTK::Widget.unstable_get_type( &gtk_menu_get_type, $n, $t );
  }

  method place_on_monitor (GdkMonitor $monitor)
    is also<place-on-monitor>
  {
    gtk_menu_place_on_monitor($!m, $monitor);
  }

  method popdown {
    gtk_menu_popdown($!m);
  }

  method popup_at_pointer (GdkEvent() $trigger_event = GdkEvent)
    is also<popup-at-pointer>
  {
    gtk_menu_popup_at_pointer($!m, $trigger_event);
  }

  method popup_at_rect (
    GdkWindow()    $rect_window,
    GdkRectangle() $rect,
    Int()          $rect_anchor,
    Int()          $menu_anchor,
    GdkEvent()     $trigger_event = GdkEvent
  )
    is also<popup-at-rect>
  {
    my guint ($ra, $ma) = $rect_anchor, $menu_anchor;

    gtk_menu_popup_at_rect(
      $!m,
      $rect_window,
      $rect,
      $ra,
      $ma,
      $trigger_event
    );
  }

  method popup_at_widget (
    GtkWidget() $widget,
    Int()       $widget_anchor,
    Int()       $menu_anchor,
    GdkEvent()  $trigger_event  = GdkEvent
  )
    is also<popup-at-widget>
  {
    my guint ($wa, $ma) = ($widget_anchor, $menu_anchor);

    gtk_menu_popup_at_widget($!m, $widget, $wa, $ma, $trigger_event);
  }

  method reorder_child (GtkWidget() $child, Int() $position)
    is also<reorder-child>
  {
    my gint $p = $position;

    gtk_menu_reorder_child($!m, $child, $p);
  }

  method reposition {
    gtk_menu_reposition($!m);
  }

  method set_screen (GdkScreen() $screen) is also<set-screen> {
    gtk_menu_set_screen($!m, $screen);
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
