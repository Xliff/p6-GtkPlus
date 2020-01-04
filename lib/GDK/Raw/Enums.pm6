use v6.c;

use GLib::Roles::Definitions;

unit package GDK::Raw::Enums;

constant GdkDragAction is export := guint32;
our enum GdkDragActionEnumEnum is export (
  GDK_ACTION_DEFAULT => 1,
  GDK_ACTION_COPY    => 2,
  GDK_ACTION_MOVE    => (1 +< 2),
  GDK_ACTION_LINK    => (1 +< 3),
  GDK_ACTION_PRIVATE => (1 +< 4),
  GDK_ACTION_ASK     => (1 +< 5)
);

constant GdkGravity is export := guint32;
our enum GdkGravityEnum is export (
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

constant GdkWindowTypeHint is export := guint32;
our enum GdkWindowTypeHintEnum is export <
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

constant GdkModifierType is export := guint32;
our enum GdkModifierTypeEnum is export (
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

constant GdkEventMask is export := guint32;
our enum GdkEventMaskEnum is export (
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

constant GdkEventType is export := guint32;
our enum GdkEventTypeEnum is export (
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

constant GdkWindowEdge is export := guint32;
our enum GdkWindowEdgeEnum is export <
  GDK_WINDOW_EDGE_NORTH_WEST
  GDK_WINDOW_EDGE_NORTH
  GDK_WINDOW_EDGE_NORTH_EAST
  GDK_WINDOW_EDGE_WEST
  GDK_WINDOW_EDGE_EAST
  GDK_WINDOW_EDGE_SOUTH_WEST
  GDK_WINDOW_EDGE_SOUTH
  GDK_WINDOW_EDGE_SOUTH_EAST
>;

constant GdkCursorType is export := gint32;
our enum GdkCursorTypeEnum is export (
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

constant GdkVisibilityState is export := guint32;
our enum GdkVisibilityStateEnum is export <
  GDK_VISIBILITY_UNOBSCURED
  GDK_VISIBILITY_PARTIAL
  GDK_VISIBILITY_FULLY_OBSCURED
>;

constant GdkCrossingMode is export := guint32;
our enum GdkCrossingModeEnum is export <
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

constant GdkNotifyType is export := guint32;
our enum GdkNotifyTypeEnum is export (
  GDK_NOTIFY_ANCESTOR           => 0,
  GDK_NOTIFY_VIRTUAL            => 1,
  GDK_NOTIFY_INFERIOR           => 2,
  GDK_NOTIFY_NONLINEAR          => 3,
  GDK_NOTIFY_NONLINEAR_VIRTUAL  => 4,
  GDK_NOTIFY_UNKNOWN            => 5
);

constant GdkWindowState is export := guint32;
our enum GdkWindowStateEnum is export (
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

constant GdkWindowWindowClass is export := guint32;
our enum GdkWindowWindowClassEnum is export (
  'GDK_INPUT_OUTPUT',             # nick=input-output
  'GDK_INPUT_ONLY'                # nick=input-only
);

constant GdkWindowHints is export := guint32;
our enum GdkWindowHintsEnum is export (
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

constant GdkWMDecoration is export := guint32;
our enum GdkWMDecorationEnum is export (
  GDK_DECOR_ALL         => 1,
  GDK_DECOR_BORDER      => 1 +< 1,
  GDK_DECOR_RESIZEH     => 1 +< 2,
  GDK_DECOR_TITLE       => 1 +< 3,
  GDK_DECOR_MENU        => 1 +< 4,
  GDK_DECOR_MINIMIZE    => 1 +< 5,
  GDK_DECOR_MAXIMIZE    => 1 +< 6
);

constant GdkWindowType is export := guint32;
our enum GdkWindowTypeEnum is export <
  GDK_WINDOW_ROOT
  GDK_WINDOW_TOPLEVEL
  GDK_WINDOW_CHILD
  GDK_WINDOW_TEMP
  GDK_WINDOW_FOREIGN
  GDK_WINDOW_OFFSCREEN
  GDK_WINDOW_SUBSURFACE
>;

constant GdkAnchorHints is export := guint32;
our enum GdkAnchorHintsEnum is export (
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

constant GdkFullscreenMode is export := guint32;
our enum GdkFullscreenModeEnum is export <
  GDK_FULLSCREEN_ON_CURRENT_MONITOR
  GDK_FULLSCREEN_ON_ALL_MONITORS
>;

constant GdkWindowAttributesType is export := guint32;
our enum GdkWindowAttributesTypeEnum is export (
  GDK_WA_TITLE     => 1,
  GDK_WA_X         => 1 +< 2,
  GDK_WA_Y         => 1 +< 3,
  GDK_WA_CURSOR    => 1 +< 4,
  GDK_WA_VISUAL    => 1 +< 5,
  GDK_WA_WMCLASS   => 1 +< 6,
  GDK_WA_NOREDIR   => 1 +< 7,
  GDK_WA_TYPE_HINT => 1 +< 8
);

constant GdkVisualType is export := guint32;
our enum GdkVisualTypeEnum is export <
  GDK_VISUAL_STATIC_GRAY
  GDK_VISUAL_GRAYSCALE
  GDK_VISUAL_STATIC_COLOR
  GDK_VISUAL_PSEUDO_COLOR
  GDK_VISUAL_TRUE_COLOR
  GDK_VISUAL_DIRECT_COLOR
>;

constant GdkByteOrder is export := guint32;
our enum GdkByteOrderEnum is export <
  GDK_LSB_FIRST
  GDK_MSB_FIRST
>;

constant GdkSubpixelLayout is export := guint32;
our enum GdkSubpixelLayoutEnum is export <
  GDK_SUBPIXEL_LAYOUT_UNKNOWN
  GDK_SUBPIXEL_LAYOUT_NONE
  GDK_SUBPIXEL_LAYOUT_HORIZONTAL_RGB
  GDK_SUBPIXEL_LAYOUT_HORIZONTAL_BGR
  GDK_SUBPIXEL_LAYOUT_VERTICAL_RGB
  GDK_SUBPIXEL_LAYOUT_VERTICAL_BGR
>;

constant GdkDragProtocol is export := guint32;
our enum GdkDragProtocolEnum is export (
  GDK_DRAG_PROTO_NONE => 0,
  'GDK_DRAG_PROTO_MOTIF',
  'GDK_DRAG_PROTO_XDND',
  'GDK_DRAG_PROTO_ROOTWIN',
  'GDK_DRAG_PROTO_WIN32_DROPFILES',
  'GDK_DRAG_PROTO_OLE2',
  'GDK_DRAG_PROTO_LOCAL',
  'GDK_DRAG_PROTO_WAYLAND'
);

constant GdkSelectionAtom is export := guint32;
our enum GdkSelectionAtomEnum is export (
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

constant GdkButtons is export := guint32;
our enum GdkButtonsEnum is export (
  GDK_BUTTON_PRIMARY           => 1,
  GDK_BUTTON_MIDDLE            => 2,
  GDK_BUTTON_SECONDARY         => 3
);

constant GdkColorspace is export := guint32;
our enum GdkColorspaceEnum is export <
  GDK_COLORSPACE_RGB
>;

constant GdkPixbufError is export := guint32;
our enum GdkPixbufErrorEnum is export (
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

constant GdkPixbufAlphaMode is export := guint32;
our enum GdkPixbufAlphaModeEnum is export <
  GDK_PIXBUF_ALPHA_BILEVEL
  GDK_PIXBUF_ALPHA_FULL
>;

constant GdkInterpType is export := guint32;
our enum GdkInterpTypeEnum is export <
  GDK_INTERP_NEAREST
  GDK_INTERP_TILES
  GDK_INTERP_BILINEAR
  GDK_INTERP_HYPER
>;

constant GdkPixbufRotation is export := guint32;
our enum GdkPixbufRotationEnum is export (
  GDK_PIXBUF_ROTATE_NONE             =>   0,
  GDK_PIXBUF_ROTATE_COUNTERCLOCKWISE =>  90,
  GDK_PIXBUF_ROTATE_UPSIDEDOWN       => 180,
  GDK_PIXBUF_ROTATE_CLOCKWISE        => 270
);

constant GdkDragCancelReason is export := guint32;
our enum GdkDragCancelReasonEnum is export <
  GDK_DRAG_CANCEL_NO_TARGET
  GDK_DRAG_CANCEL_USER_CANCELLED
  GDK_DRAG_CANCEL_ERROR
>;

constant GdkInputSource is export := guint32;
our enum GdkInputSourceEnum is export <
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

constant GdkInputMode is export := guint32;
our enum GdkInputModeEnum is export <
  GDK_MODE_DISABLED
  GDK_MODE_SCREEN
  GDK_MODE_WINDOW
>;

constant GdkDeviceType is export := guint32;
our enum GdkDeviceTypeEnum is export <
  GDK_DEVICE_TYPE_MASTER
  GDK_DEVICE_TYPE_SLAVE
  GDK_DEVICE_TYPE_FLOATING
>;

constant GdkAxisUse is export := guint32;
our enum GdkAxisUseEnum is export <
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

constant GdkAxisFlags is export := guint32;
our enum GdkAxisFlagsEnum is export (
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

constant GdkModifierIntent is export := guint32;
our enum GdkModifierIntentEnum is export <
  GDK_MODIFIER_INTENT_PRIMARY_ACCELERATOR
  GDK_MODIFIER_INTENT_CONTEXT_MENU
  GDK_MODIFIER_INTENT_EXTEND_SELECTION
  GDK_MODIFIER_INTENT_MODIFY_SELECTION
  GDK_MODIFIER_INTENT_NO_TEXT_INPUT
  GDK_MODIFIER_INTENT_SHIFT_GROUP
  GDK_MODIFIER_INTENT_DEFAULT_MOD_MASK
>;

constant GdkSeatCapabilities is export := guint32;
our enum GdkSeatCapabilitiesEnum is export (
  GDK_SEAT_CAPABILITY_NONE          => 0,
  GDK_SEAT_CAPABILITY_POINTER       => 1,
  GDK_SEAT_CAPABILITY_TOUCH         => 1 +< 1,
  GDK_SEAT_CAPABILITY_TABLET_STYLUS => 1 +< 2,
  GDK_SEAT_CAPABILITY_KEYBOARD      => 1 +< 3,
  GDK_SEAT_CAPABILITY_ALL_POINTING  => (1 +| 1 +< 1 +| 1 +< 2),
  GDK_SEAT_CAPABILITY_ALL           => (1 +| 1 +< 1 +| 1 +< 2 +| 1 +< 3)
);

constant GdkGrabStatus is export := guint32;
our enum GdkGrabStatusEnum is export (
  GDK_GRAB_SUCCESS         => 0,
  GDK_GRAB_ALREADY_GRABBED => 1,
  GDK_GRAB_INVALID_TIME    => 2,
  GDK_GRAB_NOT_VIEWABLE    => 3,
  GDK_GRAB_FROZEN          => 4,
  GDK_GRAB_FAILED          => 5
);
