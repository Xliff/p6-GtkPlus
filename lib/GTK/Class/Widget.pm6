use v6.c;

use NativeCall;

use GTK::Class::Pointers;

class GTypeClass is repr('CStruct') is export {
  # This will vary by platform type.
  #uint32 $.gclass;
  has uint64 $.g_class;
}

class GObjectClass is repr('CStruct') is export {
  HAS GTypeClass    $!g_type_class;
  has OpaquePointer $!construct_properties;

  has OpaquePointer $.constructor  ; # (GType type, guint n_construct_properties, GObjectConstructParam *construct_properties);
  has OpaquePointer $.set_property ; # (GType type, guint n_construct_properties, GObjectConstructParam *construct_properties);
  has OpaquePointer $.get_property ; # (GType type, guint n_construct_properties, GObjectConstructParam *construct_properties);
  has OpaquePointer $.dispose      ; # (GObject *object)
  has OpaquePointer $.finalize     ; # (GObject *object)

  has OpaquePointer $.dispatch_properties_changed   ; # (GObject *object, guint n_pspecs, GParamSpec  **pspecs);

  has OpaquePointer $.notify       ; # (GObject *object, GParamSpec *pspec);

  has OpaquePointer $.constructed  ; # (GObject *object)

  # This will vary by platform type.
  #has uint32       $.flags;
  has uint64        $.flags;

  has OpaquePointer $.pdummy1;
  has OpaquePointer $.pdummy2;
  has OpaquePointer $.pdummy3;
  has OpaquePointer $.pdummy4;
  has OpaquePointer $.pdummy5;
  has OpaquePointer $.pdummy6;
}

class GTK::Class::Widget is repr('CStruct') {
  HAS GObjectClass  $.parent_class;
  has uint64        $.activate_signal;

  has OpaquePointer $.dispatch_child_properties_changed; # (GtkWidget $w, int32 $np, OpaquePointer $p);

  has OpaquePointer $.destroy             ; #(GtkWidget $w);
  has OpaquePointer $.show                ; #(GtkWidget $w);
  has OpaquePointer $.show_all            ; #(GtkWidget $w);
  has OpaquePointer $.hide                ; #(GtkWidget $w);
  has OpaquePointer $.map                 ; #(GtkWidget $w);
  has OpaquePointer $.unmap               ; #(GtkWidget $w);
  has OpaquePointer $.realize             ; #(GtkWidget $w);
  has OpaquePointer $.unrealize           ; #(GtkWidget $w);
  has OpaquePointer $.size_allocate       ; #(GtkWidget $w, GtkAllocation $a);
  has OpaquePointer $.state_changed       ; #(GtkWidget $w, GtkStateType  $ps);
  has OpaquePointer $.state_flags_changed ; #(GtkWidget $w, GtkStateFlags $psf);
  has OpaquePointer $.parent_set          ; #(GtkWidget $w, GtkWidget $pp);
  has OpaquePointer $.hierarchy_changed   ; #(GtkWidget $w, GtkWidget $ptl);
  has OpaquePointer $.style_set           ; #(GtkWidget $w, GtkStyle $ps);
  has OpaquePointer $.direction_changed   ; #(GtkWidget $w, GtkTextDirection $pd);
  has OpaquePointer $.grab_notify         ; #(GtkWidget $w, int32 $wg);
  has OpaquePointer $.child_notify        ; #(GtkWidget $w, GParamSpec $cp);
  has OpaquePointer $.drawn               ; #(GtkWidget $w, int32 $cr --> int32);

  has OpaquePointer $.get_request_mode    ; #(GtkWidget $w, int32 $mh, int32 $nh --> GtkSizeRequestMode);

  has OpaquePointer $.get_preferred_height           ; #(GtkWidget $w,   int32 $mh, int32 $nh);
  has OpaquePointer $.get_preferred_width_for_height ; #(GtkWidget $w,   int32  $h, int32 $mw, int32 $nw);
  has OpaquePointer $.get_preferred_width            ; #(GtkWidget $w,   int32 $nw, int32 $nw);
  has OpaquePointer $.get_preferred_height_for_width ; #(GtkWidget $w,   int32 $wd, int32 $mh, int32 $nh);

  has OpaquePointer $.mnemonic_activate   ; #(GtkWidget $w, int32 $gc);

  has OpaquePointer $.grab_focus ; #(GtkWidget $w);
  has OpaquePointer $.focus      ; #(GtkWidget $w, GtkDirectionType $d);

  has OpaquePointer $.move_focus    ; #(GtkWidget $w, GtkDirectionType $d);
  has OpaquePointer $.keynav_failed ; #(GtkWidget $w, GtkDirectionType $d);

  has OpaquePointer $.event                   ; #(GtkWidget $w, GdkEvent $e            --> int32);
  has OpaquePointer $.button_press_event      ; #(GtkWidget $w, GdkEventButton $e      --> int32);
  has OpaquePointer $.button_release_event    ; #(GtkWidget $w, GdkEventButton $e      --> int32);
  has OpaquePointer $.scroll_event            ; #(GtkWidget $w, GdkEventScroll $e      --> int32);
  has OpaquePointer $.motion_notify_event     ; #(GtkWidget $w, GdkEventMotion $e      --> int32);
  has OpaquePointer $.delete_event            ; #(GtkWidget $w, GdkEventAny $e         --> int32);
  has OpaquePointer $.destroy_event           ; #(GtkWidget $w, GdkEventAny $e         --> int32);
  has OpaquePointer $.key_press_event         ; #(GtkWidget $w, GdkEventKey $e         --> int32);
  has OpaquePointer $.key_release_event       ; #(GtkWidget $w, GdkEventKey $e         --> int32);
  has OpaquePointer $.enter_notify_event      ; #(GtkWidget $w, GdkEventCrossing $e    --> int32);
  has OpaquePointer $.leave_notify_event      ; #(GtkWidget $w, GdkEventCrossing $e    --> int32);

  has OpaquePointer $.configure_event         ; #(GtkWidget $w, GdkEventConfigure $e   --> int32);

  has OpaquePointer $.focus_in_event          ; #(GtkWidget $w, GdkEventFocus $e       --> int32);
  has OpaquePointer $.focus_out_event         ; #(GtkWidget $w, GdkEventFocus $e       --> int32);
  has OpaquePointer $.map_event               ; #(GtkWidget $w, GdkEventAny $e         --> int32);
  has OpaquePointer $.unmap_event             ; #(GtkWidget $w, GdkEventAny $e         --> int32);
  has OpaquePointer $.property_notify_event   ; #(GtkWidget $w, GdkEventProperty $e    --> int32);
  has OpaquePointer $.selection_clear_event   ; #(GtkWidget $w, GdkEventSelection $e   --> int32);
  has OpaquePointer $.selection_request_event ; #(GtkWidget $w, GdkEventSelection $e   --> int32);
  has OpaquePointer $.selection_notify_event  ; #(GtkWidget $w, GdkEventSelection $e   --> int32);
  has OpaquePointer $.proximity_in_event      ; #(GtkWidget $w, GdkEventSelection $e   --> int32);
  has OpaquePointer $.proximity_out_event     ; #(GtkWidget $w, GdkEventSelection $e   --> int32);
  has OpaquePointer $.visibility_notify_event ; #(GtkWidget $w, GdkEventVisibility $e  --> int32);
  has OpaquePointer $.widow_state_event       ; #(GtkWidget $w, GdkEventWindowState $e --> int32);
  has OpaquePointer $.damage_event            ; #(GtkWidget $w, GdkEventExpose $e      --> int32);
  has OpaquePointer $.grab_broken_event       ; #(GtkWidget $w, GdkEventGrabBroken $e  --> int32);

  has OpaquePointer $.selection_get           ; #(GtkWidget $w, GtkSelectionData $sd, int32 $i, int32 $t);
  has OpaquePointer $.selection_received      ; #(GtkWidget $w, GtkSelectionData $sd, int32 $t);

  has OpaquePointer $.drag_begin       ; #(GtkWidget $w, GtkDragContext $c);
  has OpaquePointer $.drag_end         ; #(GtkWidget $w, GtkDragContext $c);
  has OpaquePointer $.drag_data_get    ; #(GtkWidget $w, GtkDragContext $c, GtkSelectionData $sd, uint32 $i, uint32 $t);
  has OpaquePointer $.drag_data_delete ; #(GtkWidget $w, GtkDragContext $c);

  has OpaquePointer $.drag_leave         ; #(GtkWidget $w, GtkDragContext $c, uint32 $t);
  has OpaquePointer $.drag_motion        ; #(GtkWidget $w, GtkDragContext $c, int32 $x, int32 $y, uint32 $t);
  has OpaquePointer $.drag_drop          ; #(GtkWidget $w, GtkDragContext $c, int32 $x, int32 $y, uint32 $t --> int32);

  has OpaquePointer $.drag_data_received ; #(GtkWidget $w, GtkDragContext $c, int32 $x, int32 $y, GtkSelectionData $sd, uint32 $i, uint32 $t);

  has OpaquePointer $.drag_failed        ; #(GtkWidget $w, GtkDragContext $c, GtkDragResult $r --> int32);

  has OpaquePointer $.popup_menu         ; #(GtkWidget $w);

  has OpaquePointer $.show_help          ; #(GtkWidget $w, GtkWidgetHelpType $ht);

  has OpaquePointer $.get_accessible     ; #(GtkWidget $w --> AtkObject);

  has OpaquePointer $.screen_changed     ; #(GtkWidget $w, GdkScreen $ps);
  has OpaquePointer $.can_activate_accel ; #(GtkWidget $w, uint32 $s);
  has OpaquePointer $.composite_changed  ; #(GtkWidget $w);

  has OpaquePointer $.query_tooltip      ; #(GtkWidget $w, int32 $x, int32 $y, int32 $kt, GtkToolTip $tt);

  has OpaquePointer $.compute_expand     ; #(GtkWidget $w, int32 $hp, int32 $vp);

  has OpaquePointer $.adust_size_request     ; #(GtkWidget $w, GtkOrientation $o, int32, $ms, int32 $ns);
  has OpaquePointer $.adjust_size_allocation ; #(GtkWidget $w, GtkOrientation $o, int32, $ms, int32 $ns, int32 $ap, int32 $as);

  has OpaquePointer $.size_updated ; #(GtkWidget $w);
  has OpaquePointer $.touch_event  ; #(GtkWidget $w, GdkTouchEvent $e --> int32);

  has OpaquePointer $.get_prefrered_height_and_baseline_for_width ; # (GtkWidget $w, int32 $wd, int32 $mh, int32 $nh, int32 $mb, int32 $nb);
  has OpaquePointer $.adjust_baseline_request    ; #(GtkWidget $w, int32 $mb, int32 $nb);
  has OpaquePointer $.adjust_baseline_allocation ; #(GtkWidget $w, int32 $b);

  # const cairo_region_t $region [?]
  has OpaquePointer $.queue_draw_region ; #(GtkWidget $w, int32 $region)

  has OpaquePointer $.priv;

  has OpaquePointer $.gtk_reserved6;
  has OpaquePointer $.gtk_reserved7;
}
