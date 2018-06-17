use v6.c;

use NativeCall;

use GTK::Class::Pointers;
use GTK::Class::Subs :class, :widget;
use GTK::Class::Widget;

class GTK::Widget {
  has GTK::Class::Widget $!gwc;
  has GtkWidget          $!w;

  has @!signals;

  method BUILD(:$widget) {
    $!w = $widget;
    @!signals;

    $!gwc = nativecast(
      GTK::Class::Widget,
      g_type_check_class_cast (
        nativecast(OpaquePointer, $widget),
        gtk_widget_get_type(),
      )
    );
  }

  #
  # Auto generated makeMethod routines.
  #
  method destroy () {
    $!gwc.destroy($!w)
  }

  method show () {
    $!gwc.show($!w)
  }

  method show_all () {
    $!gwc.show_all($!w)
  }

  method hide () {
    $!gwc.hide($!w)
  }

  method map () {
    $!gwc.map($!w)
  }

  method unmap () {
    $!gwc.unmap($!w)
  }

  method realize () {
    $!gwc.realize($!w)
  }

  method unrealize () {
    $!gwc.unrealize($!w)
  }

  method size_allocate (GtkAllocation $a) {
    $!gwc.size_allocate($!w, $a)
  }

  method state_changed (GtkStateType $ps) {
    $!gwc.state_changed($!w, $ps)
  }

  method state_flags_changed (GtkStateFlags $psf) {
    $!gwc.state_flags_changed($!w, $psf)
  }

  method parent_set (GtkWidget $pp) {
    $!gwc.parent_set($!w, $pp)
  }

  method hierarchy_changed (GtkWidget $ptl) {
    $!gwc.hierarchy_changed($!w, $ptl)
  }

  method style_set (GtkStyle $ps) {
    $!gwc.style_set($!w, $ps)
  }

  method direction_changed (GtkTextDirection $pd) {
    $!gwc.direction_changed($!w, $pd)
  }

  method grab_notify (int32 $wg) {
    $!gwc.grab_notify($!w, $wg)
  }

  method child_notify (GParamSpec $cp) {
    $!gwc.child_notify($!w, $cp)
  }

  method drawn (int32 $cr) {
    $!gwc.drawn($!w, $cr)
  }

  method get_request_mode (int32 $mh, int32 $nh) {
    $!gwc.get_request_mode($!w, $mh, $nh)
  }

  method get_preferred_height (int32 $mh, int32 $nh) {
    $!gwc.get_preferred_height($!w, $mh, $nh)
  }

  method get_preferred_width_for_height (int32 $h, int32 $mw, int32 $nw) {
    $!gwc.get_preferred_width_for_height($!w, $h, $mw, $nw)
  }

  method get_preferred_width (int32 $nw, int32 $nw) {
    $!gwc.get_preferred_width($!w, $nw, $nw)
  }

  method get_preferred_height_for_width (int32 $wd, int32 $mh, int32 $nh) {
    $!gwc.get_preferred_height_for_width($!w, $wd, $mh, $nh)
  }

  method mnemonic_activate (int32 $gc) {
    $!gwc.mnemonic_activate($!w, $gc)
  }

  method grab_focus () {
    $!gwc.grab_focus($!w)
  }

  method focus (GtkDirectionType $d) {
    $!gwc.focus($!w, $d)
  }

  method move_focus (GtkDirectionType $d) {
    $!gwc.move_focus($!w, $d)
  }

  method keynav_failed (GtkDirectionType $d) {
    $!gwc.keynav_failed($!w, $d)
  }

  method event (GdkEvent $e) {
    $!gwc.event($!w, $e)
  }

  method button_press_event (GdkEventButton $e) {
    $!gwc.button_press_event($!w, $e)
  }

  method button_release_event (GdkEventButton $e) {
    $!gwc.button_release_event($!w, $e)
  }

  method scroll_event (GdkEventScroll $e) {
    $!gwc.scroll_event($!w, $e)
  }

  method motion_notify_event (GdkEventMotion $e) {
    $!gwc.motion_notify_event($!w, $e)
  }

  method delete_event (GdkEventAny $e) {
    $!gwc.delete_event($!w, $e)
  }

  method destroy_event (GdkEventAny $e) {
    $!gwc.destroy_event($!w, $e)
  }

  method key_press_event (GdkEventKey $e) {
    $!gwc.key_press_event($!w, $e)
  }

  method key_release_event (GdkEventKey $e) {
    $!gwc.key_release_event($!w, $e)
  }

  method enter_notify_event (GdkEventCrossing $e) {
    $!gwc.enter_notify_event($!w, $e)
  }

  method leave_notify_event (GdkEventCrossing $e) {
    $!gwc.leave_notify_event($!w, $e)
  }

  method configure_event (GdkEventConfigure $e) {
    $!gwc.configure_event($!w, $e)
  }

  method focus_in_event (GdkEventFocus $e) {
    $!gwc.focus_in_event($!w, $e)
  }

  method focus_out_event (GdkEventFocus $e) {
    $!gwc.focus_out_event($!w, $e)
  }

  method map_event (GdkEventAny $e) {
    $!gwc.map_event($!w, $e)
  }

  method unmap_event (GdkEventAny $e) {
    $!gwc.unmap_event($!w, $e)
  }

  method property_notify_event (GdkEventProperty $e) {
    $!gwc.property_notify_event($!w, $e)
  }

  method selection_clear_event (GdkEventSelection $e) {
    $!gwc.selection_clear_event($!w, $e)
  }

  method selection_request_event (GdkEventSelection $e) {
    $!gwc.selection_request_event($!w, $e)
  }

  method selection_notify_event (GdkEventSelection $e) {
    $!gwc.selection_notify_event($!w, $e)
  }

  method proximity_in_event (GdkEventSelection $e) {
    $!gwc.proximity_in_event($!w, $e)
  }

  method proximity_out_event (GdkEventSelection $e) {
    $!gwc.proximity_out_event($!w, $e)
  }

  method visibility_notify_event (GdkEventVisibility $e) {
    $!gwc.visibility_notify_event($!w, $e)
  }

  method widow_state_event (GdkEventWindowState $e) {
    $!gwc.widow_state_event($!w, $e)
  }

  method damage_event (GdkEventExpose $e) {
    $!gwc.damage_event($!w, $e)
  }

  method grab_broken_event (GdkEventGrabBroken $e) {
    $!gwc.grab_broken_event($!w, $e)
  }

  method selection_get (GtkSelectionData $sd, int32 $i, int32 $t) {
    $!gwc.selection_get($!w, $sd, $i, $t)
  }

  method selection_received (GtkSelectionData $sd, int32 $t) {
    $!gwc.selection_received($!w, $sd, $t)
  }

  method drag_begin (GtkDragContext $c) {
    $!gwc.drag_begin($!w, $c)
  }

  method drag_end (GtkDragContext $c) {
    $!gwc.drag_end($!w, $c)
  }

  method drag_data_get (GtkDragContext $c, GtkSelectionData $sd, uint32 $i, uint32 $t) {
    $!gwc.drag_data_get($!w, $c, $sd, $i, $t)
  }

  method drag_data_delete (GtkDragContext $c) {
    $!gwc.drag_data_delete($!w, $c)
  }

  method drag_leave (GtkDragContext $c, uint32 $t) {
    $!gwc.drag_leave($!w, $c, $t)
  }

  method drag_motion (GtkDragContext $c, int32 $x, int32 $y, uint32 $t) {
    $!gwc.drag_motion($!w, $c, $x, $y, $t)
  }

  method drag_drop (GtkDragContext $c, int32 $x, int32 $y, uint32 $t) {
    $!gwc.drag_drop($!w, $c, $x, $y, $t)
  }

  method drag_data_received (GtkDragContext $c, int32 $x, int32 $y, GtkSelectionData $sd, uint32 $i, uint32 $t) {
    $!gwc.drag_data_received($!w, $c, $x, $y, $sd, $i, $t)
  }

  method drag_failed (GtkDragContext $c, GtkDragResult $r) {
    $!gwc.drag_failed($!w, $c, $r)
  }

  method popup_menu () {
    $!gwc.popup_menu($!w)
  }

  method show_help (GtkWidgetHelpType $ht) {
    $!gwc.show_help($!w, $ht)
  }

  method get_accessible () {
    $!gwc.get_accessible($!w)
  }

  method screen_changed (GdkScreen $ps) {
    $!gwc.screen_changed($!w, $ps)
  }

  method can_activate_accel (uint32 $s) {
    $!gwc.can_activate_accel($!w, $s)
  }

  method composite_changed () {
    $!gwc.composite_changed($!w)
  }

  method query_tooltip (int32 $x, int32 $y, int32 $kt, GtkToolTip $tt) {
    $!gwc.query_tooltip($!w, $x, $y, $kt, $tt)
  }

  method compute_expand (int32 $hp, int32 $vp) {
    $!gwc.compute_expand($!w, $hp, $vp)
  }

  method size_updated () {
    $!gwc.size_updated($!w)
  }

  method touch_event (GdkTouchEvent $e) {
    $!gwc.touch_event($!w, $e)
  }

  method get_prefrered_height_and_baseline_for_width (int32 $wd, int32 $mh, int32 $nh, int32 $mb, int32 $nb) {
    $!gwc.get_prefrered_height_and_baseline_for_width($!w, $wd, $mh, $nh, $mb, $nb)
  }

  method adjust_baseline_request (int32 $mb, int32 $nb) {
    $!gwc.adjust_baseline_request($!w, $mb, $nb)
  }

  method adjust_baseline_allocation (int32 $b) {
    $!gwc.adjust_baseline_allocation($!w, $b)
  }

}
