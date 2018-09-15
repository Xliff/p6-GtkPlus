use v6.c;

use NativeCall;

use GTK::Roles::Pointers;

unit package GTK::Compat::Types;

constant cairo_t        is export := OpaquePointer;
constant cairo_region_t is export := OpaquePointer;

constant gboolean      is export := uint32;
constant gchar         is export := Str;
constant gunichar      is export := uint32;
constant gconstpointer is export := OpaquePointer;
constant gdouble       is export := num64;
constant gfloat        is export := num32;
constant gint          is export := int32;
constant gpointer      is export := OpaquePointer;
constant gsize         is export := uint64;
constant GType         is export := uint32;
constant guint         is export := uint32;
constant guint16       is export := uint16;
constant va_list       is export := OpaquePointer;

constant PangoTabArray is export := CArray[gint];
constant GStrv         is export := CArray[Str];

class GError is repr('CStruct') does GTK::Roles::Pointers is export {
  has uint32        $.domain;
  has int32         $.code;
  has Str           $.message;
}

class GFile is repr('CPointer') does GTK::Roles::Pointers is export { }

class GList is repr('CStruct')  does GTK::Roles::Pointers is export {
  has OpaquePointer $.data;
  has GList         $.next;
  has GList         $.prev;
}

class GSList is repr('CStruct') does GTK::Roles::Pointers is export {
  has OpaquePointer $.data;
  has GSList        $.next;
}

class GTypeValueList is repr('CUnion') is export {
  has int32	          $.v_int     is rw;
  has uint32          $.v_uint    is rw;
  has long            $.v_long    is rw;
  has ulong           $.v_ulong   is rw;
  has int64           $.v_int64   is rw;
  has uint64          $.v_uint64  is rw;
  has num32           $.v_float   is rw;
  has num64           $.v_double  is rw;
  has OpaquePointer   $.v_pointer is rw;
};

class GValue is repr('CStruct') does GTK::Roles::Pointers is export {
  has ulong           $.g_type is rw;
  HAS GTypeValueList  $.data1  is rw;
  HAS GTypeValueList  $.data2;
}

our enum GTypeEnum is export (
  G_TYPE_INVALID   => 0,
  G_TYPE_NONE      => (1  +< 2),
  G_TYPE_INTERFACE => (2  +< 2),
  G_TYPE_CHAR      => (3  +< 2),
  G_TYPE_UCHAR     => (4  +< 2),
  G_TYPE_BOOLEAN   => (5  +< 2),
  G_TYPE_INT       => (6  +< 2),
  G_TYPE_UINT      => (7  +< 2),
  G_TYPE_LONG      => (8  +< 2),
  G_TYPE_ULONG     => (9  +< 2),
  G_TYPE_INT64     => (10 +< 2),
  G_TYPE_UINT64    => (11 +< 2),
  G_TYPE_ENUM      => (12 +< 2),
  G_TYPE_FLAGS     => (13 +< 2),
  G_TYPE_FLOAT     => (14 +< 2),
  G_TYPE_DOUBLE    => (15 +< 2),
  G_TYPE_STRING    => (16 +< 2),
  G_TYPE_POINTER   => (17 +< 2),
  G_TYPE_BOXED     => (18 +< 2),
  G_TYPE_PARAM     => (19 +< 2),
  G_TYPE_OBJECT    => (20 +< 2),
  G_TYPE_VARIANT   => (21 +< 2),

  G_TYPE_RESERVED_GLIB_FIRST => 22,
  G_TYPE_RESERVED_GLIB_LAST  => 31,
  G_TYPE_RESERVED_BSE_FIRST  => 32,
  G_TYPE_RESERVED_BSE_LAST   => 48,
  G_TYPE_RESERVED_USER_FIRST => 49
);


our enum GVariant is export <
  G_VARIANT_CLASS_BOOLEAN
  G_VARIANT_CLASS_BYTE
  G_VARIANT_CLASS_INT16
  G_VARIANT_CLASS_UINT16
  G_VARIANT_CLASS_INT32
  G_VARIANT_CLASS_UINT32
  G_VARIANT_CLASS_INT64
  G_VARIANT_CLASS_UINT64
  G_VARIANT_CLASS_HANDLE
  G_VARIANT_CLASS_DOUBLE
  G_VARIANT_CLASS_STRING
  G_VARIANT_CLASS_OBJECT_PATH
  G_VARIANT_CLASS_SIGNATURE
  G_VARIANT_CLASS_VARIANT
  G_VARIANT_CLASS_MAYBE
  G_VARIANT_CLASS_ARRAY
  G_VARIANT_CLASS_TUPLE
  G_VARIANT_CLASS_DICT_ENTRY
>;

our enum GApplicationFlags is export (
  G_APPLICATION_FLAGS_NONE           => 0,
  G_APPLICATION_IS_SERVICE           => 1,
  G_APPLICATION_IS_LAUNCHER          => 2,
  G_APPLICATION_HANDLES_OPEN         => 4,
  G_APPLICATION_HANDLES_COMMAND_LINE => 8,
  G_APPLICATION_SEND_ENVIRONMENT     => 16,
  G_APPLICATION_NON_UNIQUE           => 32,
  G_APPLICATION_CAN_OVERRIDE_APP_ID  => 64
);

our enum GdkDragAction is export (
  GDK_ACTION_DEFAULT => 1,
  GDK_ACTION_COPY    => 2,
  GDK_ACTION_MOVE    => (1 +< 2),
  GDK_ACTION_LINK    => (1 +< 3),
  GDK_ACTION_PRIVATE => (1 +< 4),
  GDK_ACTION_ASK     => (1 +< 5)
);

our enum GdkGravity is export (
  'GDK_GRAVITY_NORTH_WEST' => 1,
  'GDK_GRAVITY_NORTH',
  'GDK_GRAVITY_NORTH_EAST',
  'GDK_GRAVITY_WEST',
  'GDK_GRAVITY_CENTER',
  'GDK_GRAVITY_EAST',
  'GDK_GRAVITY_SOUTH_WEST',
  'GDK_GRAVITY_SOUTH',
  'GDK_GRAVITY_SOUTH_EAST',
  'GDK_GRAVITY_STATIC'
);

our enum GdkWindowHints is export <
  GDK_HINT_POS
  GDK_HINT_MIN_SIZE
  GDK_HINT_MAX_SIZE
  GDK_HINT_BASE_SIZE
  GDK_HINT_ASPECT
  GDK_HINT_RESIZE_INC
  GDK_HINT_WIN_GRAVITY
  GDK_HINT_USER_POS
  GDK_HINT_USER_SIZE
>;

our enum GdkWindowTypeHint is export <
  GDK_WINDOW_TYPE_HINT_NORMAL
  GDK_WINDOW_TYPE_HINT_DIALOG
  GDK_WINDOW_TYPE_HINT_MENU
  GDK_WINDOW_TYPE_HINT_TOOLBAR
  GDK_WINDOW_TYPE_HINT_SPLASHSCREEN
  GDK_WINDOW_TYPE_HINT_UTILITY
  GDK_WINDOW_TYPE_HINT_DOCK
  GDK_WINDOW_TYPE_HINT_DESKTOP
  GDK_WINDOW_TYPE_HINT_DROPDOWN_MENU
  GDK_WINDOW_TYPE_HINT_POPUP_MENU
  GDK_WINDOW_TYPE_HINT_TOOLTIP
  GDK_WINDOW_TYPE_HINT_NOTIFICATION
  GDK_WINDOW_TYPE_HINT_COMBO
  GDK_WINDOW_TYPE_HINT_DND
>;

our enum GdkModifierType is export (
  GDK_SHIFT_MASK                 => 1,
  GDK_LOCK_MASK                  => 1 +< 1,
  GDK_CONTROL_MASK               => 1 +< 2,
  GDK_MOD1_MASK                  => 1 +< 3,
  GDK_MOD2_MASK                  => 1 +< 4,
  GDK_MOD3_MASK                  => 1 +< 5,
  GDK_MOD4_MASK                  => 1 +< 6,
  GDK_MOD5_MASK                  => 1 +< 7,
  GDK_BUTTON1_MASK               => 1 +< 8,
  GDK_BUTTON2_MASK               => 1 +< 9,
  GDK_BUTTON3_MASK               => 1 +< 10,
  GDK_BUTTON4_MASK               => 1 +< 11,
  GDK_BUTTON5_MASK               => 1 +< 12,

  GDK_MODIFIER_RESERVED_13_MASK  => 1 +< 13,
  GDK_MODIFIER_RESERVED_14_MASK  => 1 +< 14,
  GDK_MODIFIER_RESERVED_15_MASK  => 1 +< 15,
  GDK_MODIFIER_RESERVED_16_MASK  => 1 +< 16,
  GDK_MODIFIER_RESERVED_17_MASK  => 1 +< 17,
  GDK_MODIFIER_RESERVED_18_MASK  => 1 +< 18,
  GDK_MODIFIER_RESERVED_19_MASK  => 1 +< 19,
  GDK_MODIFIER_RESERVED_20_MASK  => 1 +< 20,
  GDK_MODIFIER_RESERVED_21_MASK  => 1 +< 21,
  GDK_MODIFIER_RESERVED_22_MASK  => 1 +< 22,
  GDK_MODIFIER_RESERVED_23_MASK  => 1 +< 23,
  GDK_MODIFIER_RESERVED_24_MASK  => 1 +< 24,
  GDK_MODIFIER_RESERVED_25_MASK  => 1 +< 25,

  GDK_SUPER_MASK                 => 1 +< 26,
  GDK_HYPER_MASK                 => 1 +< 27,
  GDK_META_MASK                  => 1 +< 28,

  GDK_MODIFIER_RESERVED_29_MASK  => 1 +< 29,

  GDK_RELEASE_MASK               => 1 +< 30,
  GDK_MODIFIER_MASK              => 0x5c001fff
);

our enum GdkEventMask is export (
  GDK_EXPOSURE_MASK             => 1,
  GDK_POINTER_MOTION_MASK       => 1 +< 2,
  GDK_POINTER_MOTION_HINT_MASK  => 1 +< 3,
  GDK_BUTTON_MOTION_MASK        => 1 +< 4,
  GDK_BUTTON1_MOTION_MASK       => 1 +< 5,
  GDK_BUTTON2_MOTION_MASK       => 1 +< 6,
  GDK_BUTTON3_MOTION_MASK       => 1 +< 7,
  GDK_BUTTON_PRESS_MASK         => 1 +< 8,
  GDK_BUTTON_RELEASE_MASK       => 1 +< 9,
  GDK_KEY_PRESS_MASK            => 1 +< 10,
  GDK_KEY_RELEASE_MASK          => 1 +< 11,
  GDK_ENTER_NOTIFY_MASK         => 1 +< 12,
  GDK_LEAVE_NOTIFY_MASK         => 1 +< 13,
  GDK_FOCUS_CHANGE_MASK         => 1 +< 14,
  GDK_STRUCTURE_MASK            => 1 +< 15,
  GDK_PROPERTY_CHANGE_MASK      => 1 +< 16,
  GDK_VISIBILITY_NOTIFY_MASK    => 1 +< 17,
  GDK_PROXIMITY_IN_MASK         => 1 +< 18,
  GDK_PROXIMITY_OUT_MASK        => 1 +< 19,
  GDK_SUBSTRUCTURE_MASK         => 1 +< 20,
  GDK_SCROLL_MASK               => 1 +< 21,
  GDK_TOUCH_MASK                => 1 +< 22,
  GDK_SMOOTH_SCROLL_MASK        => 1 +< 23,
  GDK_TOUCHPAD_GESTURE_MASK     => 1 +< 24,
  GDK_TABLET_PAD_MASK           => 1 +< 25,
  GDK_ALL_EVENTS_MASK           => 0x3FFFFFE
);


our enum GdkEventType is export (
  GDK_NOTHING             => -1,
  GDK_DELETE              => 0,
  GDK_DESTROY             => 1,
  GDK_EXPOSE              => 2,
  GDK_MOTION_NOTIFY       => 3,
  GDK_BUTTON_PRESS        => 4,
  GDK_2BUTTON_PRESS       => 5,
  GDK_DOUBLE_BUTTON_PRESS => 5,
  GDK_3BUTTON_PRESS       => 6,
  GDK_TRIPLE_BUTTON_PRESS => 6,
  GDK_BUTTON_RELEASE      => 7,
  GDK_KEY_PRESS           => 8,
  GDK_KEY_RELEASE         => 9,
  GDK_ENTER_NOTIFY        => 10,
  GDK_LEAVE_NOTIFY        => 11,
  GDK_FOCUS_CHANGE        => 12,
  GDK_CONFIGURE           => 13,
  GDK_MAP                 => 14,
  GDK_UNMAP               => 15,
  GDK_PROPERTY_NOTIFY     => 16,
  GDK_SELECTION_CLEAR     => 17,
  GDK_SELECTION_REQUEST   => 18,
  GDK_SELECTION_NOTIFY    => 19,
  GDK_PROXIMITY_IN        => 20,
  GDK_PROXIMITY_OUT       => 21,
  GDK_DRAG_ENTER          => 22,
  GDK_DRAG_LEAVE          => 23,
  GDK_DRAG_MOTION         => 24,
  GDK_DRAG_STATUS         => 25,
  GDK_DROP_START          => 26,
  GDK_DROP_FINISHED       => 27,
  GDK_CLIENT_EVENT        => 28,
  GDK_VISIBILITY_NOTIFY   => 29,
  GDK_SCROLL              => 31,
  GDK_WINDOW_STATE        => 32,
  GDK_SETTING             => 33,
  GDK_OWNER_CHANGE        => 34,
  GDK_GRAB_BROKEN         => 35,
  GDK_DAMAGE              => 36,
  GDK_TOUCH_BEGIN         => 37,
  GDK_TOUCH_UPDATE        => 38,
  GDK_TOUCH_END           => 39,
  GDK_TOUCH_CANCEL        => 40,
  GDK_TOUCHPAD_SWIPE      => 41,
  GDK_TOUCHPAD_PINCH      => 42,
  GDK_PAD_BUTTON_PRESS    => 43,
  GDK_PAD_BUTTON_RELEASE  => 44,
  GDK_PAD_RING            => 45,
  GDK_PAD_STRIP           => 46,
  GDK_PAD_GROUP_MODE      => 47,
  'GDK_EVENT_LAST'
);

our enum PangoWrapMode is export <
  PANGO_WRAP_WORD
  PANGO_WRAP_CHAR
  PANGO_WRAP_WORD_CHAR
>;

our enum PangoEllipsizeMode is export <
  PANGO_ELLIPSIZE_NONE
  PANGO_ELLIPSIZE_START
  PANGO_ELLIPSIZE_MIDDLE
  PANGO_ELLIPSIZE_END
>;

class cairo_font_options_t  is repr('CPointer') is export { }
class cairo_surface_t       is repr('CPointer') is export { }

class AtkObject             is repr('CPointer') is export { }

class PangoAttrList         is repr('CPointer') is export { }
class PangoContext          is repr('CPointer') is export { }
class PangoFontDescription  is repr('CPointer') is export { }
class PangoFontMap          is repr('CPointer') is export { }
class PangoLayout           is repr('CPointer') is export { }

class GActionGroup          is repr('CPointer') is export { }
class GApplication          is repr('CPointer') is export { }
class GCompareDataFunc      is repr('CPointer') is export { }
class GCompareFunc          is repr('CPointer') is export { }
class GCopyFunc             is repr('CPointer') is export { }
class GFunc                 is repr('CPointer') is export { }
class GIcon                 is repr('CPointer') is export { }
class GParamSpec            is repr('CPointer') is export { }
class GDestroyNotify        is repr('CPointer') is export { }
class GMenu                 is repr('CPointer') is export { }
class GObject               is repr('CPointer') is export { }

class GdkAtom               is repr('CPointer') is export { }
class GdkDevice             is repr('CPointer') is export { }
class GdkDisplay            is repr('CPointer') is export { }
class GdkEvent              is repr('CPointer') is export { }
class GdkEventAny           is repr('CPointer') is export { }
class GdkEventButton        is repr('CPointer') is export { }
class GdkEventConfigure     is repr('CPointer') is export { }
class GdkEventCrossing      is repr('CPointer') is export { }
class GdkEventExpose        is repr('CPointer') is export { }
class GdkEventFocus         is repr('CPointer') is export { }
class GdkEventGrabBroken    is repr('CPointer') is export { }
class GdkEventMotion        is repr('CPointer') is export { }
class GdkEventScroll        is repr('CPointer') is export { }
class GdkEventSelection     is repr('CPointer') is export { }
class GdkEventVisibility    is repr('CPointer') is export { }
class GdkEventWindowState   is repr('CPointer') is export { }
class GdkFrameClock         is repr('CPointer') is export { }
class GMenuModel            is repr('CPointer') is export { }
class GdkModifierIntent     is repr('CPointer') is export { }
class GdkPixbuf             is repr('CPointer') is export { }
class GdkPixbufAnimation    is repr('CPointer') is export { }
class GdkRectangle          is repr('CPointer') is export { }
class GdkRGBA               is repr('CPointer') is export { }
class GdkScreen             is repr('CPointer') is export { }
class GdkTouchEvent         is repr('CPointer') is export { }
# Probably should be its own class
class GtkTreeModel          is repr('CPointer') is export { }
class GdkVisual             is repr('CPointer') is export { }
class GdkWindow             is repr('CPointer') is export { }
class GdkWindowEdge         is repr('CPointer') is export { }

class GdkEventKey is repr('CStruct') does GTK::Roles::Pointers is export {
  has uint32       $.type;      # GdkEventType
  has GdkWindow    $.window;
  has int8         $.send_event;
  has uint32       $.time;
  has uint32       $.state;
  has uint32       $.keyval;
  has int32        $.length;
  has Str          $.string;
  has uint16       $.hardware_keycode;
  has uint8        $.group;
  has uint32       $.is_modifier;
}

class GdkGeometry is repr('CStruct') does GTK::Roles::Pointers is export {
  has gint       $.min_width;
  has gint       $.min_height;
  has gint       $.max_width;
  has gint       $.max_height;
  has gint       $.base_width;
  has gint       $.base_height;
  has gint       $.width_inc;
  has gint       $.height_inc;
  has gdouble    $.min_aspect;
  has gdouble    $.max_aspect;
  has guint      $.win_gravity;       # GdkGravity
};
