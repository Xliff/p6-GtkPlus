use v6.c;

use NativeCall;

use Cairo;
use GTK::Roles::Pointers;

# Number of times I've had to force compile the whole project.
constant forced = 15;

our $DEBUG is export = 0;

unit package GTK::Compat::Types;

sub cast($cast-to, $obj) is export {
  nativecast($cast-to, $obj);
}

constant gtk      is export = 'gtk-3',v0;
constant gdk      is export = 'gdk-3',v0;
constant glib     is export = 'glib-2.0',v0;
constant gio      is export = 'gio-2.0',v0;
constant gobject  is export = 'gobject-2.0',v0;
constant cairo    is export = 'cairo',v2;

sub g_destroy_none(Pointer)
  is export
  { }

sub g_free (Pointer)
  is native(glib)
  is export
  { * }

class GError is repr('CStruct') does GTK::Roles::Pointers is export {
  has uint32        $.domain;
  has int32         $.code;
  has Str           $.message;
}

# Used ONLY in those situations where cheating is just plain REQUIRED.
class GObjectStruct is repr('CStruct') does GTK::Roles::Pointers is export {
  has uint64  $.g_type_instance;
  has uint32   $.ref_count;
}

our $ERROR is export;

sub gerror is export {
  my $cge = CArray[Pointer[GError]].new;
  $cge[0] = Pointer[GError];
  $cge;
}

sub g_error_free(GError $err)
  is native(glib)
  is export
  { *  }

sub clear_error($error = $ERROR) is export {
  g_error_free($error[0]) with $error[0];
  $ERROR = Nil;
}

constant GDK_MAX_TIMECOORD_AXES is export = 128;

constant cairo_t             is export := Cairo::cairo_t;
constant cairo_format_t      is export := Cairo::cairo_format_t;
constant cairo_pattern_t     is export := Cairo::cairo_pattern_t;
constant cairo_region_t      is export := Pointer;

constant gboolean            is export := uint32;
constant gchar               is export := Str;
constant gconstpointer       is export := Pointer;
constant gdouble             is export := num64;
constant gfloat              is export := num32;
constant gint                is export := int32;
constant gint8               is export := int8;
constant gint16              is export := int16;
constant gint32              is export := int32;
constant gint64              is export := int64;
constant glong               is export := int64;
constant gpointer            is export := Pointer;
constant gsize               is export := uint64;
constant gssize              is export := int64;
constant guchar              is export := Str;
constant gshort              is export := int8;
constant gushort             is export := uint8;
constant guint               is export := uint32;
constant guint8              is export := uint8;
constant guint16             is export := uint16;
constant guint32             is export := uint32;
constant guint64             is export := uint64;
constant gulong              is export := uint64;
constant gunichar            is export := uint32;
constant va_list             is export := Pointer;

constant GAsyncReadyCallback is export := Pointer;
constant GCallback           is export := Pointer;
constant GCancellable        is export := Pointer;
constant GClosure            is export := Pointer;
constant GCompareDataFunc    is export := Pointer;
constant GCompareFunc        is export := Pointer;
constant GCopyFunc           is export := Pointer;
constant GDestroyNotify      is export := Pointer;
constant GEqualFunc          is export := Pointer;
constant GQuark              is export := uint32;
constant GString             is export := Pointer;
constant GStrv               is export := CArray[Str];
constant GTimeSpan           is export := int64;
constant GType               is export := uint64;
constant GVariant            is export := Pointer;

constant GdkFilterFunc                  is export := Pointer;
constant GdkPixbufDestroyNotify         is export := Pointer;
constant GdkPixbufSaveFunc              is export := Pointer;
constant GdkSeatGrabPrepareFunc         is export := Pointer;
constant GdkWindowChildFunc             is export := Pointer;
constant GdkWindowInvalidateHandlerFunc is export := Pointer;
constant GdkWMFunction                  is export := Pointer;

class GTypeClass is repr('CStruct') is export {
  has GType      $.g_type;
}
class GTypeInstance is repr('CStruct') is export {
  has GTypeClass $.g_class;

  method checkType($compare_type) {
    $compare_type == $.g_class.g_type;
  }
  
  method getType {
    $.g_class.g_type;
  }
}

class GList is repr('CStruct') does GTK::Roles::Pointers is export {
  has Pointer $.data;
  has GList   $.next;
  has GList   $.prev;
}

class GPermission is repr('CStruct') does GTK::Roles::Pointers is export {
  has uint64 $.dummy1;
  has uint64 $.dummy2;
  has uint64 $.dummy3;
  has uint64 $.dummy4;
}

class GSList is repr('CStruct') does GTK::Roles::Pointers is export {
  has Pointer $!data;
  has GSList  $.next;
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
  HAS GTypeValueList  $.data2  is rw;
}

class GPtrArray is repr('CStruct') does GTK::Roles::Pointers is export {
  has CArray[Pointer] $.pdata;
  has guint           $.len;
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

our enum GVariantType is export <
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

our enum GdkWindowEdge is export <
  GDK_WINDOW_EDGE_NORTH_WEST
  GDK_WINDOW_EDGE_NORTH
  GDK_WINDOW_EDGE_NORTH_EAST
  GDK_WINDOW_EDGE_WEST
  GDK_WINDOW_EDGE_EAST
  GDK_WINDOW_EDGE_SOUTH_WEST
  GDK_WINDOW_EDGE_SOUTH
  GDK_WINDOW_EDGE_SOUTH_EAST
>;

our enum GAppInfoCreateFlags is export (
  G_APP_INFO_CREATE_NONE                           => 0,         # nick=none
  G_APP_INFO_CREATE_NEEDS_TERMINAL                 => 1,         # nick=needs-terminal
  G_APP_INFO_CREATE_SUPPORTS_URIS                  => (1 +< 1),  # nick=supports-uris
  G_APP_INFO_CREATE_SUPPORTS_STARTUP_NOTIFICATION  => (1 +< 2)   # nick=supports-startup-notification
);

our enum GTlsCertificateFlags is export (
  G_TLS_CERTIFICATE_UNKNOWN_CA    => (1 +< 0),
  G_TLS_CERTIFICATE_BAD_IDENTITY  => (1 +< 1),
  G_TLS_CERTIFICATE_NOT_ACTIVATED => (1 +< 2),
  G_TLS_CERTIFICATE_EXPIRED       => (1 +< 3),
  G_TLS_CERTIFICATE_REVOKED       => (1 +< 4),
  G_TLS_CERTIFICATE_INSECURE      => (1 +< 5),
  G_TLS_CERTIFICATE_GENERIC_ERROR => (1 +< 6),
  G_TLS_CERTIFICATE_VALIDATE_ALL  => 0x007f
);


our enum GdkCursorType is export (
  GDK_X_CURSOR            => 0,
  GDK_ARROW               => 2,
  GDK_BASED_ARROW_DOWN    => 4,
  GDK_BASED_ARROW_UP      => 6,
  GDK_BOAT                => 8,
  GDK_BOGOSITY            => 10,
  GDK_BOTTOM_LEFT_CORNER  => 12,
  GDK_BOTTOM_RIGHT_CORNER => 14,
  GDK_BOTTOM_SIDE         => 16,
  GDK_BOTTOM_TEE          => 18,
  GDK_BOX_SPIRAL          => 20,
  GDK_CENTER_PTR          => 22,
  GDK_CIRCLE              => 24,
  GDK_CLOCK               => 26,
  GDK_COFFEE_MUG          => 28,
  GDK_CROSS               => 30,
  GDK_CROSS_REVERSE       => 32,
  GDK_CROSSHAIR           => 34,
  GDK_DIAMOND_CROSS       => 36,
  GDK_DOT                 => 38,
  GDK_DOTBOX              => 40,
  GDK_DOUBLE_ARROW        => 42,
  GDK_DRAFT_LARGE         => 44,
  GDK_DRAFT_SMALL         => 46,
  GDK_DRAPED_BOX          => 48,
  GDK_EXCHANGE            => 50,
  GDK_FLEUR               => 52,
  GDK_GOBBLER             => 54,
  GDK_GUMBY               => 56,
  GDK_HAND1               => 58,
  GDK_HAND2               => 60,
  GDK_HEART               => 62,
  GDK_ICON                => 64,
  GDK_IRON_CROSS          => 66,
  GDK_LEFT_PTR            => 68,
  GDK_LEFT_SIDE           => 70,
  GDK_LEFT_TEE            => 72,
  GDK_LEFTBUTTON          => 74,
  GDK_LL_ANGLE            => 76,
  GDK_LR_ANGLE            => 78,
  GDK_MAN                 => 80,
  GDK_MIDDLEBUTTON        => 82,
  GDK_MOUSE               => 84,
  GDK_PENCIL              => 86,
  GDK_PIRATE              => 88,
  GDK_PLUS                => 90,
  GDK_QUESTION_ARROW      => 92,
  GDK_RIGHT_PTR           => 94,
  GDK_RIGHT_SIDE          => 96,
  GDK_RIGHT_TEE           => 98,
  GDK_RIGHTBUTTON         => 100,
  GDK_RTL_LOGO            => 102,
  GDK_SAILBOAT            => 104,
  GDK_SB_DOWN_ARROW       => 106,
  GDK_SB_H_DOUBLE_ARROW   => 108,
  GDK_SB_LEFT_ARROW       => 110,
  GDK_SB_RIGHT_ARROW      => 112,
  GDK_SB_UP_ARROW         => 114,
  GDK_SB_V_DOUBLE_ARROW   => 116,
  GDK_SHUTTLE             => 118,
  GDK_SIZING              => 120,
  GDK_SPIDER              => 122,
  GDK_SPRAYCAN            => 124,
  GDK_STAR                => 126,
  GDK_TARGET              => 128,
  GDK_TCROSS              => 130,
  GDK_TOP_LEFT_ARROW      => 132,
  GDK_TOP_LEFT_CORNER     => 134,
  GDK_TOP_RIGHT_CORNER    => 136,
  GDK_TOP_SIDE            => 138,
  GDK_TOP_TEE             => 140,
  GDK_TREK                => 142,
  GDK_UL_ANGLE            => 144,
  GDK_UMBRELLA            => 146,
  GDK_UR_ANGLE            => 148,
  GDK_WATCH               => 150,
  GDK_XTERM               => 152,
  GDK_LAST_CURSOR         => 153,
  GDK_BLANK_CURSOR        => -2,
  GDK_CURSOR_IS_PIXMAP    => -1
);

our enum GdkVisibilityState is export <
  GDK_VISIBILITY_UNOBSCURED
  GDK_VISIBILITY_PARTIAL
  GDK_VISIBILITY_FULLY_OBSCURED
>;

our enum GdkCrossingMode is export <
  GDK_CROSSING_NORMAL
  GDK_CROSSING_GRAB
  GDK_CROSSING_UNGRAB
  GDK_CROSSING_GTK_GRAB
  GDK_CROSSING_GTK_UNGRAB
  GDK_CROSSING_STATE_CHANGED
  GDK_CROSSING_TOUCH_BEGIN
  GDK_CROSSING_TOUCH_END
  GDK_CROSSING_DEVICE_SWITCH
>;

our enum GdkNotifyType is export (
  GDK_NOTIFY_ANCESTOR           => 0,
  GDK_NOTIFY_VIRTUAL            => 1,
  GDK_NOTIFY_INFERIOR           => 2,
  GDK_NOTIFY_NONLINEAR          => 3,
  GDK_NOTIFY_NONLINEAR_VIRTUAL  => 4,
  GDK_NOTIFY_UNKNOWN            => 5
);

our enum GdkWindowState is export (
  GDK_WINDOW_STATE_WITHDRAWN        => 1,
  GDK_WINDOW_STATE_ICONIFIED        => 1 +< 1,
  GDK_WINDOW_STATE_MAXIMIZED        => 1 +< 2,
  GDK_WINDOW_STATE_STICKY           => 1 +< 3,
  GDK_WINDOW_STATE_FULLSCREEN       => 1 +< 4,
  GDK_WINDOW_STATE_ABOVE            => 1 +< 5,
  GDK_WINDOW_STATE_BELOW            => 1 +< 6,
  GDK_WINDOW_STATE_FOCUSED          => 1 +< 7,
  GDK_WINDOW_STATE_TILED            => 1 +< 8,
  GDK_WINDOW_STATE_TOP_TILED        => 1 +< 9,
  GDK_WINDOW_STATE_TOP_RESIZABLE    => 1 +< 10,
  GDK_WINDOW_STATE_RIGHT_TILED      => 1 +< 11,
  GDK_WINDOW_STATE_RIGHT_RESIZABLE  => 1 +< 12,
  GDK_WINDOW_STATE_BOTTOM_TILED     => 1 +< 13,
  GDK_WINDOW_STATE_BOTTOM_RESIZABLE => 1 +< 14,
  GDK_WINDOW_STATE_LEFT_TILED       => 1 +< 15,
  GDK_WINDOW_STATE_LEFT_RESIZABLE   => 1 +< 16
);


our enum GKeyFileFlags is export (
  G_KEY_FILE_NONE              => 0,
  G_KEY_FILE_KEEP_COMMENTS     => 1,
  G_KEY_FILE_KEEP_TRANSLATIONS => 2
);

our enum GFileCreateFlags is export (
  G_FILE_CREATE_NONE                => 0,
  G_FILE_CREATE_PRIVATE             => 1,
  G_FILE_CREATE_REPLACE_DESTINATION => 2
);


class cairo_content_t       is repr('CPointer') is export does GTK::Roles::Pointers { }
class cairo_font_options_t  is repr('CPointer') is export does GTK::Roles::Pointers { }
class cairo_surface_t       is repr('CPointer') is export does GTK::Roles::Pointers { }

class AtkObject             is repr('CPointer') is export does GTK::Roles::Pointers { }

class GAction               is repr('CPointer') is export does GTK::Roles::Pointers { }
class GActionGroup          is repr('CPointer') is export does GTK::Roles::Pointers { }
class GAppInfo              is repr('CPointer') is export does GTK::Roles::Pointers { }
class GAppInfoMonitor       is repr('CPointer') is export does GTK::Roles::Pointers { }
class GAppLaunchContext     is repr('CPointer') is export does GTK::Roles::Pointers { }
class GApplication          is repr('CPointer') is export does GTK::Roles::Pointers { }
class GAsyncResult          is repr('CPointer') is export does GTK::Roles::Pointers { }
class GByteArray            is repr('CPointer') is export does GTK::Roles::Pointers { }
class GBytes                is repr('CPointer') is export does GTK::Roles::Pointers { }
class GFile                 is repr('CPointer') is export does GTK::Roles::Pointers { }
class GFunc                 is repr('CPointer') is export does GTK::Roles::Pointers { }
class GHashTable            is repr('CPointer') is export does GTK::Roles::Pointers { }
class GIcon                 is repr('CPointer') is export does GTK::Roles::Pointers { }
class GInputStream          is repr('CPointer') is export does GTK::Roles::Pointers { }
class GKeyFile              is repr('CPointer') is export does GTK::Roles::Pointers { }
class GListModel            is repr('CPointer') is export does GTK::Roles::Pointers { }
class GMarkupParser         is repr('CPointer') is export does GTK::Roles::Pointers { }
class GMenu                 is repr('CPointer') is export does GTK::Roles::Pointers { }
class GMenuItem             is repr('CPointer') is export does GTK::Roles::Pointers { }
class GMenuAttributeIter    is repr('CPointer') is export does GTK::Roles::Pointers { }
class GMenuLinkIter         is repr('CPointer') is export does GTK::Roles::Pointers { }
class GMenuModel            is repr('CPointer') is export does GTK::Roles::Pointers { }
class GMountOperation       is repr('CPointer') is export does GTK::Roles::Pointers { }
class GObject               is repr('CPointer') is export does GTK::Roles::Pointers { }
class GOutputStream         is repr('CPointer') is export does GTK::Roles::Pointers { }
class GParamSpec            is repr('CPointer') is export does GTK::Roles::Pointers { }
class GTlsCertificate       is repr('CPointer') is export does GTK::Roles::Pointers { }
class GVolume               is repr('CPointer') is export does GTK::Roles::Pointers { }

class GdkAppLaunchContext   is repr('CPointer') is export does GTK::Roles::Pointers { }
class GdkAtom               is repr('CPointer') is export does GTK::Roles::Pointers { }
class GdkCursor             is repr('CPointer') is export does GTK::Roles::Pointers { }
class GdkDevice             is repr('CPointer') is export does GTK::Roles::Pointers { }
class GdkDeviceTool         is repr('CPointer') is export does GTK::Roles::Pointers { }
class GdkDeviceManager      is repr('CPointer') is export does GTK::Roles::Pointers { }
class GdkDisplay            is repr('CPointer') is export does GTK::Roles::Pointers { }
class GdkDisplayManager     is repr('CPointer') is export does GTK::Roles::Pointers { }
class GdkDragContext        is repr('CPointer') is export does GTK::Roles::Pointers { }
class GdkDrawingContext     is repr('CPointer') is export does GTK::Roles::Pointers { }
class GdkEventSequence      is repr('CPointer') is export does GTK::Roles::Pointers { }
class GdkFrameClock         is repr('CPointer') is export does GTK::Roles::Pointers { }
class GdkFrameTimings       is repr('CPointer') is export does GTK::Roles::Pointers { }
class GdkGLContext          is repr('CPointer') is export does GTK::Roles::Pointers { }
class GdkKeymap             is repr('CPointer') is export does GTK::Roles::Pointers { }
class GdkMonitor            is repr('CPointer') is export does GTK::Roles::Pointers { }
class GdkPixbuf             is repr('CPointer') is export does GTK::Roles::Pointers { }
class GdkPixbufAnimation    is repr('CPointer') is export does GTK::Roles::Pointers { }
class GdkScreen             is repr('CPointer') is export does GTK::Roles::Pointers { }
class GdkSeat               is repr('CPointer') is export does GTK::Roles::Pointers { }
class GdkStyleProvider      is repr('CPointer') is export does GTK::Roles::Pointers { }
class GdkVisual             is repr('CPointer') is export does GTK::Roles::Pointers { }
class GdkWindow             is repr('CPointer') is export does GTK::Roles::Pointers { }

sub gdk_atom_name(GdkAtom)
  returns Str
  is native(gdk)
  is export
  { * }

class GdkColor is repr('CStruct') does GTK::Roles::Pointers is export {
  has guint   $.pixel;
  has guint16 $.red;
  has guint16 $.green;
  has guint16 $.blue;
}

class GdkEventAny is repr('CStruct') does GTK::Roles::Pointers is export {
  has uint32       $.type;              # GdkEventType
  has GdkWindow    $.window;
  has int8         $.send_event;
}

constant GdkEvent is export := GdkEventAny;

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
  has guint      $.win_gravity;         # GdkGravity
}

class GdkRectangle is repr('CStruct') does GTK::Roles::Pointers is export {
  has gint $.x is rw;
  has gint $.y is rw;
  has gint $.width is rw;
  has gint $.height is rw;
}

class GdkPoint is repr('CStruct') does GTK::Roles::Pointers is export {
  has gint $.x is rw;
  has gint $.y is rw;
}

class GdkEventKey is repr('CStruct') does GTK::Roles::Pointers is export {
  has uint32       $.type;              # GdkEventType
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

class GdkEventButton is repr('CStruct') does GTK::Roles::Pointers is export {
  has uint32         $.type;            # GdkEventType
  has GdkWindow      $.window;
  has int8           $.send_event;
  has guint32        $.time;
  has gdouble        $.x;
  has gdouble        $.y;
  has gdouble        $.axes is rw;
  has guint          $.state;
  has guint          $.button;
  has GdkDevice      $.device;
  has gdouble        $.x_root;
  has gdouble        $.y_root;
}

class GdkEventExpose is repr('CStruct') does GTK::Roles::Pointers is export {
  has uint32         $.type;            # GdkEventType
  has GdkWindow      $.window;
  has int8           $.send_event;
  has GdkRectangle   $.area;
  has cairo_region_t $.region;
  has int32          $.count;
}

class GdkEventCrossing is repr('CStruct')
  does GTK::Roles::Pointers
  is export
{
  has uint32         $.type;            # GdkEventType
  has GdkWindow      $.window;
  has int8           $.send_event;
  has GdkWindow      $.subwindow;
  has uint32         $.time;
  has num64          $.x;
  has num64          $.y;
  has num64          $.x_root;
  has num64          $.y_root;
  has uint32         $.mode;            # GdkCrossingMode
  has uint32         $.detail;          # GdkNotifyType
  has gboolean       $.focus;
  has guint          $.state;
}

class GdkEventFocus is repr('CStruct') does GTK::Roles::Pointers is export {
  has uint32         $.type;            # GdkEventType
  has GdkWindow      $.window;
  has int8           $.send_event;
  has int16          $.in;
}

class GdkEventConfigure is repr('CStruct')
  does GTK::Roles::Pointers
  is export
{
  has uint32         $.type;            # GdkEventType
  has GdkWindow      $.window;
  has int8           $.send_event;
  has int32          $.x;
  has int32          $.y;
  has int32          $.width;
  has int32          $.height;
}

class GdkEventProperty is repr('CStruct')
  does GTK::Roles::Pointers
  is export
{
  has uint32         $.type;            # GdkEventType
  has GdkWindow      $.window;
  has int8           $.send_event;
  has GdkAtom        $.atom;
  has uint32         $.time;
  has uint32         $.state;
}

class GdkEventSelection is repr('CStruct')
  does GTK::Roles::Pointers
  is export
{
  has uint32         $.type;            # GdkEventType
  has GdkWindow      $.window;
  has int8           $.send_event;
  has GdkAtom        $.selection;
  has GdkAtom        $.target;
  has GdkAtom        $.property;
  has uint32         $.time;
  has GdkWindow      $.requestor;
}

class GdkEventDnD is repr('CStruct')
  does GTK::Roles::Pointers
  is export
{
  has uint32         $.type;            # GdkEventType
  has GdkWindow      $.window;
  has int8           $.send_event;
  has GdkDragContext $.context;
  has uint32         $.time;
  has int16          $.x_root;
  has int16          $.y_root;
}

class GdkEventProximity is repr('CStruct')
  does GTK::Roles::Pointers
  is export
{
  has uint32         $.type;            # GdkEventType
  has GdkWindow      $.window;
  has int8           $.send_event;
  has uint32         $.time;
  has GdkDevice      $.device;
}

class GdkEventWindowState is repr('CStruct')
  does GTK::Roles::Pointers
  is export
{
  has uint32         $.type;            # GdkEventType
  has GdkWindow      $.window;
  has int8           $.send_event;
  has uint32         $.changed_mask;
  has uint32         $.new_window_state;
}

class GdkEventSetting is repr('CStruct')
  does GTK::Roles::Pointers
  is export
{
  has uint32         $.type;            # GdkEventType
  has GdkWindow      $.window;
  has int8           $.send_event;
  has uint32         $.action;
  has Str            $.name;
}

class GdkEventOwnerChange is repr('CStruct')
  does GTK::Roles::Pointers
  is export
{
  has uint32         $.type;            # GdkEventType
  has GdkWindow      $.window;
  has int8           $.send_event;
  has GdkWindow      $.owner;
  has uint32         $.reason;          # GdkOwnerChange
  has GdkAtom        $.selection;
  has uint32         $.time;
  has uint32         $.selection_time;
}

class GdkEventMotion is repr('CStruct')
  does GTK::Roles::Pointers
  is export
{
  has uint32         $.type;            # GdkEventType
  has GdkWindow      $.window;
  has int8           $.send_event;
  has guint32        $.time;
  has gdouble        $.x;
  has gdouble        $.y;
  has gdouble        $.axes;
  has guint          $.state;
  has gint16         $.is_hint;
  has GdkDevice      $.device;
  has gdouble        $.x_root;
  has gdouble        $.y_root;
}

class GdkEventGrabBroken is repr('CStruct')
  does GTK::Roles::Pointers
  is export
{
  has uint32         $.type;            # GdkEventType
  has GdkWindow      $.window;
  has int8           $.send_event;
  has gboolean       $.keyboard;
  has gboolean       $.implicit;
  has GdkWindow      $.grab_window;
}

# class GdkEventTouchpadSwipe
# class GdkEventTouchpadPinch
# class GdkEventPadButton
# class GdkEventPadAxis
# class GdkEventPadGroupMode

our subset GdkEvents is export where
  GdkEventAny        | GdkEventButton      | GdkEventExpose    |
  GdkEventDnD        | GdkEventProperty    | GdkEventFocus     |
  GdkEventSetting    | GdkEventProximity   | GdkEventSelection |
  GdkEventConfigure  | GdkEventWindowState | GdkEventCrossing  |
  GdkEventGrabBroken | GdkEventOwnerChange | GdkEventMotion    |
  GdkEventKey;

class GdkWindowAttr is repr('CStruct')
  does GTK::Roles::Pointers
  is export
{
  has Str       $.title             is rw;
  has gint      $.event_mask        is rw;
  has gint      $.x                 is rw;
  has gint      $.y                 is rw;
  has gint      $.width             is rw;
  has gint      $.height            is rw;
  has uint32    $.wclass            is rw;    # GdkWindowWindowClass
  has GdkVisual $!visual                 ;
  has uint32    $.window_type       is rw;    # GdkWindowType
  has GdkCursor $.cursor            is rw;
  has Str       $.wmclass_name      is rw;
  has Str       $.wmclass_class     is rw;
  has gboolean  $.override_redirect is rw;
  has uint32    $.type_hint         is rw;    # GdkWindowTypeHint

  method visual is rw {
    Proxy.new(
      FETCH => -> $ {
        $!visual
      },
      STORE => -> $, $new {
        use nqp;
        nqp::bindattr(
          nqp::decont(self), GdkWindowAttr, '$!visual', nqp::decont($new)
        )
      }
    )
  }
}

class GArray is repr('CStruct') does GTK::Roles::Pointers is export {
  has Str    $.data;
  has uint32 $.len;
}

class GdkTimeCoord is repr('CStruct') does GTK::Roles::Pointers is export {
  has uint32        $.time;
  has CArray[num64] $.axes;
}

class GdkKeymapKey is repr('CStruct') does GTK::Roles::Pointers is export {
  has guint $.keycode;
  has gint  $.group;
  has gint  $.level;
}

our enum GSourceReturn is export <
  G_SOURCE_REMOVE
  G_SOURCE_CONTINUE
>;

our enum GdkWindowWindowClass is export (
  'GDK_INPUT_OUTPUT',             # nick=input-output
  'GDK_INPUT_ONLY'                # nick=input-only
);

our enum GdkWindowHints is export (
  GDK_HINT_POS         => 1,
  GDK_HINT_MIN_SIZE    => 1 +< 1,
  GDK_HINT_MAX_SIZE    => 1 +< 2,
  GDK_HINT_BASE_SIZE   => 1 +< 3,
  GDK_HINT_ASPECT      => 1 +< 4,
  GDK_HINT_RESIZE_INC  => 1 +< 5,
  GDK_HINT_WIN_GRAVITY => 1 +< 6,
  GDK_HINT_USER_POS    => 1 +< 7,
  GDK_HINT_USER_SIZE   => 1 +< 8
);

our enum GdkWMDecoration is export (
  GDK_DECOR_ALL         => 1,
  GDK_DECOR_BORDER      => 1 +< 1,
  GDK_DECOR_RESIZEH     => 1 +< 2,
  GDK_DECOR_TITLE       => 1 +< 3,
  GDK_DECOR_MENU        => 1 +< 4,
  GDK_DECOR_MINIMIZE    => 1 +< 5,
  GDK_DECOR_MAXIMIZE    => 1 +< 6
);

our enum GdkWindowType is export <
  GDK_WINDOW_ROOT
  GDK_WINDOW_TOPLEVEL
  GDK_WINDOW_CHILD
  GDK_WINDOW_TEMP
  GDK_WINDOW_FOREIGN
  GDK_WINDOW_OFFSCREEN
  GDK_WINDOW_SUBSURFACE
>;

our enum GdkAnchorHints is export (
  GDK_ANCHOR_FLIP_X   => 1,
  GDK_ANCHOR_FLIP_Y   => 1 +< 1,
  GDK_ANCHOR_SLIDE_X  => 1 +< 2,
  GDK_ANCHOR_SLIDE_Y  => 1 +< 3,
  GDK_ANCHOR_RESIZE_X => 1 +< 4,
  GDK_ANCHOR_RESIZE_Y => 1 +< 5,
  GDK_ANCHOR_FLIP     =>        1 +| (1 +< 1),
  GDK_ANCHOR_SLIDE    => (1 +< 2) +| (1 +< 3),
  GDK_ANCHOR_RESIZE   => (1 +< 4) +| (1 +< 4)
);

our enum GdkFullscreenMode is export <
  GDK_FULLSCREEN_ON_CURRENT_MONITOR
  GDK_FULLSCREEN_ON_ALL_MONITORS
>;

our enum GdkWindowAttributesType is export (
  GDK_WA_TITLE     => 1,
  GDK_WA_X         => 1 +< 2,
  GDK_WA_Y         => 1 +< 3,
  GDK_WA_CURSOR    => 1 +< 4,
  GDK_WA_VISUAL    => 1 +< 5,
  GDK_WA_WMCLASS   => 1 +< 6,
  GDK_WA_NOREDIR   => 1 +< 7,
  GDK_WA_TYPE_HINT => 1 +< 8
);

our enum GdkVisualType is export <
  GDK_VISUAL_STATIC_GRAY
  GDK_VISUAL_GRAYSCALE
  GDK_VISUAL_STATIC_COLOR
  GDK_VISUAL_PSEUDO_COLOR
  GDK_VISUAL_TRUE_COLOR
  GDK_VISUAL_DIRECT_COLOR
>;

our enum GdkByteOrder is export <
  GDK_LSB_FIRST
  GDK_MSB_FIRST
>;

our enum GdkSubpixelLayout is export <
  GDK_SUBPIXEL_LAYOUT_UNKNOWN
  GDK_SUBPIXEL_LAYOUT_NONE
  GDK_SUBPIXEL_LAYOUT_HORIZONTAL_RGB
  GDK_SUBPIXEL_LAYOUT_HORIZONTAL_BGR
  GDK_SUBPIXEL_LAYOUT_VERTICAL_RGB
  GDK_SUBPIXEL_LAYOUT_VERTICAL_BGR
>;

our enum GdkDragProtocol is export (
  GDK_DRAG_PROTO_NONE => 0,
  'GDK_DRAG_PROTO_MOTIF',
  'GDK_DRAG_PROTO_XDND',
  'GDK_DRAG_PROTO_ROOTWIN',
  'GDK_DRAG_PROTO_WIN32_DROPFILES',
  'GDK_DRAG_PROTO_OLE2',
  'GDK_DRAG_PROTO_LOCAL',
  'GDK_DRAG_PROTO_WAYLAND'
);

sub gdkMakeAtom($i) is export {
  my gint $ii = $i +& 0x7fff;
  my $c = CArray[int64].new($ii);
  nativecast(GdkAtom, $c);
}

our enum GdkSelectionAtom is export (
  GDK_SELECTION_PRIMARY        => 1,
  GDK_SELECTION_SECONDARY      => 2,
  GDK_SELECTION_CLIPBOARD      => 69,
  GDK_TARGET_BITMAP            => 5,
  GDK_TARGET_COLORMAP          => 7,
  GDK_TARGET_DRAWABLE          => 17,
  GDK_TARGET_PIXMAP            => 20,
  GDK_TARGET_STRING            => 31,
  GDK_SELECTION_TYPE_ATOM      => 4,
  GDK_SELECTION_TYPE_BITMAP    => 5,
  GDK_SELECTION_TYPE_COLORMAP  => 7,
  GDK_SELECTION_TYPE_DRAWABLE  => 17,
  GDK_SELECTION_TYPE_INTEGER   => 19,
  GDK_SELECTION_TYPE           => 20,
  GDK_SELECTION_TYPE_WINDOW    => 33,
  GDK_SELECTION_TYPE_STRING    => 31,
);

our enum GdkButtons is export (
  GDK_BUTTON_PRIMARY           => 1,
  GDK_BUTTON_MIDDLE            => 2,
  GDK_BUTTON_SECONDARY         => 3
);

our enum GdkColorspace is export <GDK_COLORSPACE_RGB>;

our enum GdkPixbufError is export (
  # image data hosed */
  'GDK_PIXBUF_ERROR_CORRUPT_IMAGE',
  # no mem to load image
  'GDK_PIXBUF_ERROR_INSUFFICIENT_MEMORY',
  # bad option passed to save routine
  'GDK_PIXBUF_ERROR_BAD_OPTION',
  # unsupported image type (sort of an ENOSYS)
  'GDK_PIXBUF_ERROR_UNKNOWN_TYPE',
  # unsupported operation (load, save) for image type
  'GDK_PIXBUF_ERROR_UNSUPPORTED_OPERATION',
  'GDK_PIXBUF_ERROR_FAILED',
  'GDK_PIXBUF_ERROR_INCOMPLETE_ANIMATION'
);

our enum GdkPixbufAlphaMode is export <
  GDK_PIXBUF_ALPHA_BILEVEL
  GDK_PIXBUF_ALPHA_FULL
>;

our enum GdkInterpType is export <
  GDK_INTERP_NEAREST
  GDK_INTERP_TILES
  GDK_INTERP_BILINEAR
  GDK_INTERP_HYPER
>;

our enum GdkPixbufRotation is export (
  GDK_PIXBUF_ROTATE_NONE             =>   0,
  GDK_PIXBUF_ROTATE_COUNTERCLOCKWISE =>  90,
  GDK_PIXBUF_ROTATE_UPSIDEDOWN       => 180,
  GDK_PIXBUF_ROTATE_CLOCKWISE        => 270
);

our enum GdkDragCancelReason is export <
  GDK_DRAG_CANCEL_NO_TARGET
  GDK_DRAG_CANCEL_USER_CANCELLED
  GDK_DRAG_CANCEL_ERROR
>;

our enum GdkInputSource is export <
  GDK_SOURCE_MOUSE
  GDK_SOURCE_PEN
  GDK_SOURCE_ERASER
  GDK_SOURCE_CURSOR
  GDK_SOURCE_KEYBOARD
  GDK_SOURCE_TOUCHSCREEN
  GDK_SOURCE_TOUCHPAD
  GDK_SOURCE_TRACKPOINT
  GDK_SOURCE_TABLET_PAD
>;

our enum GdkInputMode is export <
  GDK_MODE_DISABLED
  GDK_MODE_SCREEN
  GDK_MODE_WINDOW
>;

our enum GdkDeviceType is export <
  GDK_DEVICE_TYPE_MASTER
  GDK_DEVICE_TYPE_SLAVE
  GDK_DEVICE_TYPE_FLOATING
>;

our enum GdkAxisUse is export <
  GDK_AXIS_IGNORE
  GDK_AXIS_X
  GDK_AXIS_Y
  GDK_AXIS_PRESSURE
  GDK_AXIS_XTILT
  GDK_AXIS_YTILT
  GDK_AXIS_WHEEL
  GDK_AXIS_DISTANCE
  GDK_AXIS_ROTATION
  GDK_AXIS_SLIDER
  GDK_AXIS_LAST
>;

our enum GdkAxisFlags is export (
  GDK_AXIS_FLAG_X        => 1 +< GDK_AXIS_X,
  GDK_AXIS_FLAG_Y        => 1 +< GDK_AXIS_Y,
  GDK_AXIS_FLAG_PRESSURE => 1 +< GDK_AXIS_PRESSURE,
  GDK_AXIS_FLAG_XTILT    => 1 +< GDK_AXIS_XTILT,
  GDK_AXIS_FLAG_YTILT    => 1 +< GDK_AXIS_YTILT,
  GDK_AXIS_FLAG_WHEEL    => 1 +< GDK_AXIS_WHEEL,
  GDK_AXIS_FLAG_DISTANCE => 1 +< GDK_AXIS_DISTANCE,
  GDK_AXIS_FLAG_ROTATION => 1 +< GDK_AXIS_ROTATION,
  GDK_AXIS_FLAG_SLIDER   => 1 +< GDK_AXIS_SLIDER,
);

our enum GdkModifierIntent is export <
  GDK_MODIFIER_INTENT_PRIMARY_ACCELERATOR
  GDK_MODIFIER_INTENT_CONTEXT_MENU
  GDK_MODIFIER_INTENT_EXTEND_SELECTION
  GDK_MODIFIER_INTENT_MODIFY_SELECTION
  GDK_MODIFIER_INTENT_NO_TEXT_INPUT
  GDK_MODIFIER_INTENT_SHIFT_GROUP
  GDK_MODIFIER_INTENT_DEFAULT_MOD_MASK
>;

our enum GdkSeatCapabilities is export (
 GDK_SEAT_CAPABILITY_NONE          => 0,
 GDK_SEAT_CAPABILITY_POINTER       => 1,
 GDK_SEAT_CAPABILITY_TOUCH         => 1 +< 1,
 GDK_SEAT_CAPABILITY_TABLET_STYLUS => 1 +< 2,
 GDK_SEAT_CAPABILITY_KEYBOARD      => 1 +< 3,
 GDK_SEAT_CAPABILITY_ALL_POINTING  => (1 +| 1 +< 1 +| 1 +< 2),
 GDK_SEAT_CAPABILITY_ALL           => (1 +| 1 +< 1 +| 1 +< 2 +| 1 +< 3)
);

our enum GdkGrabStatus is export (
  GDK_GRAB_SUCCESS         => 0,
  GDK_GRAB_ALREADY_GRABBED => 1,
  GDK_GRAB_INVALID_TIME    => 2,
  GDK_GRAB_NOT_VIEWABLE    => 3,
  GDK_GRAB_FROZEN          => 4,
  GDK_GRAB_FAILED          => 5
);
