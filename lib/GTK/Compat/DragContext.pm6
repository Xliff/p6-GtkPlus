use v6.c;

use Method::Also;
use NativeCall;

use GTK::Compat::Raw::DragContext;
use GTK::Compat::Types;

use GTK::Roles::Signals::Generic;
use GTK::Roles::Types;

class GTK::Compat::DragContext {
  also does GTK::Roles::Types;
  also does GTK::Roles::Signals::Generic;

  has GdkDragContext $!dc;

  submethod BUILD(:$context) {
    $!dc = $context;
  }

  submethod DESTROY {
    self.disconnect-all($_) for %!signals;
  }

  method new (GdkDragContext $context) {
    self.bless(:$context);
  }

  method begin (GdkWindow() $window, GList $targets) {
    my $context = gdk_drag_begin($window, $targets);
    self.bless(:$context);
  }

  method begin_for_device (
    GdkWindow() $window,
    GdkDevice $device,
    GList $targets
  )
    is also<begin-for-device>
  {
    my $context = gdk_drag_begin_for_device($window, $device, $targets);
    self.bless(:$context);
  }

  method begin_from_point (
    GdkWindow() $window,
    GdkDevice() $device,
    GList $targets,
    Int() $x_root,
    Int() $y_root
  )
    is also<begin-from-point>
  {
    my @i = ($x_root, $y_root);
    my gint ($xr, $yr) = self.RESOLVE-INT(@i);
    my $context = gdk_drag_begin_from_point(
      $window, $device, $targets, $x_root, $y_root
    );
    self.bless(:$context);
  }

  # ↓↓↓↓ SIGNALS ↓↓↓↓

  # Is originally:
  # GdkDragContext, GdkDragAction, gpointer --> void
  method action-changed is also<action_changed> {
    self.connect-uint($!dc, 'action-changed');
  }

  # Is originally:
  # GdkDragContext, GdkDragCancelReason, gpointer --> void
  method cancel {
    self.connect-uint($!dc, 'cancel');
  }

  # Is originally:
  # GdkDragContext, gpointer --> void
  method dnd-finished is also<dnd_finished> {
    self.connect($!dc, 'dnd-finished');
  }

  # Is originally:
  # GdkDragContext, gint, gpointer --> void
  method drop-performed is also<drop_performed> {
    self.connect-int($!dc, 'drop-performed');
  }

  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  method device is rw {
    Proxy.new(
      FETCH => sub ($) {
        gdk_drag_context_get_device($!dc);
      },
      STORE => sub ($, GdkDevice() $device is copy) {
        gdk_drag_context_set_device($!dc, $device);
      }
    );
  }
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ PROPERTIES ↓↓↓↓
  # ↑↑↑↑ PROPERTIES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  method abort (Int() $time) {
    my guint $t = self.RESOLVE-UINT($time);
    gdk_drag_abort($!dc, $t);
  }

  method get_actions is also<get-actions actions> {
    gdk_drag_context_get_actions($!dc);
  }

  method get_dest_window is also<get-dest-window> {
    gdk_drag_context_get_dest_window($!dc);
  }

  method get_drag_window is also<get-drag-window> {
    gdk_drag_context_get_drag_window($!dc);
  }

  method get_protocol is also<get-protocol> {
    gdk_drag_context_get_protocol($!dc);
  }

  method get_selected_action is also<get-selected-action> {
    gdk_drag_context_get_selected_action($!dc);
  }

  method get_source_window is also<get-source-window> {
    gdk_drag_context_get_source_window($!dc);
  }

  method get_suggested_action is also<get-suggested-action> {
    gdk_drag_context_get_suggested_action($!dc);
  }

  method get_type is also<get-type> {
    gdk_drag_context_get_type();
  }

  method list_targets is also<list-targets> {
    gdk_drag_context_list_targets($!dc);
  }

  method manage_dnd (
    GdkWindow() $ipc_window,
    Int() $actions                  # GdkDragAction $actions
  )
    is also<manage-dnd>
  {
    my guint $a = self.RESOLVE-UINT($actions);
    gdk_drag_context_manage_dnd($!dc, $ipc_window, $a);
  }

  method set_hotspot (gint $hot_x, gint $hot_y)
    is also<set-hotspot>
  {
    gdk_drag_context_set_hotspot($!dc, $hot_x, $hot_y);
  }

  method drop (Int() $time) {
    my guint $t = self.RESOLVE-UINT($time);
    gdk_drag_drop($!dc, $t);
  }

  method drop_done (Int() $success) is also<drop-done> {
    my guint $s = self.RESOLVE-UINT($success);
    gdk_drag_drop_done($!dc, $s);
  }

  method drop_succeeded is also<drop-succeeded> {
    gdk_drag_drop_succeeded($!dc);
  }

  method find_window_for_screen (
    GdkWindow() $drag_win,
    GdkScreen() $screen,
    Int() $x_root,
    Int() $y_root,
    GdkWindow() $dest_win,
    Int() $protocol                 # GdkDragProtocol $protocol
  )
    is also<find-window-for-screen>
  {
    my @i = ($x_root, $y_root);
    my gint ($xr, $yr) = self.RESOLVE-INT(@i);
    my guint $p = self.RESOLVE-UINT($protocol);
    gdk_drag_find_window_for_screen(
      $!dc, $drag_win, $screen, $xr, $yr, $dest_win, $p
    );
  }

  method drop_finish (Int() $success, Int() $time)
    is also<drop-finish>
  {
    my gboolean $s = self.RESOLVE-BOOL($success);
    my guint32 $t = self.RESOLVE-UINT($time);
    gdk_drop_finish($!dc, $s, $t);
  }

  method drop_reply (Int() $accepted, Int() $time)
    is also<drop-reply>
  {
    my gboolean $a = self.RESOLVE-BOOL($accepted);
    my guint32 $t = self.RESOLVE-UINT($time);
    gdk_drop_reply($!dc, $a, $t);
  }

  method get_selection is also<get-selection> {
    gdk_drag_get_selection($!dc);
  }

  method motion (
    GdkWindow() $dest_win,
    Int() $protocol,                # GdkDragProtocol $protocol,
    Int() $x_root,
    Int() $y_root,
    Int() $suggested_action,        # GdkDragAction $suggested_action,
    Int() $possible_actions,        # GdkDragAction $possible_actions,
    Int() $time
  ) {
    my @i = ($x_root, $y_root);
    my @u = ($protocol, $suggested_action, $possible_actions, $time);
    my gint ($xr, $yr) = self.RESOLVE-INT(@i);
    my guint ($p, $sa, $pa, $t) = self.RESOLVE-UINT(@u);
    gdk_drag_motion($!dc, $dest_win, $p, $xr, $yr, $sa, $pa, $t);
  }

  method status (Int() $action, Int() $time) {
    my @u = ($action, $time);
    my guint ($a, $t) = self.RESOLVE-UINT(@u);
    gdk_drag_status($!dc, $a, $t);
  }

  # ↑↑↑↑ METHODS ↑↑↑↑

}
