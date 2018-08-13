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

class GError is repr('CStruct') does GTK::Roles::Pointers is export {
  has uint32        $.domain;
  has int32         $.code;
  has Str           $.message;
}

class GList is repr('CStruct') does GTK::Roles::Pointers is export {
  has OpaquePointer $.data;
  has GList         $.next;
  has GList         $.prev;
}

class GTypeValueList is repr('CUnion') is export {
  has int32	          $.v_int;
  has uint32          $.v_uint;
  has long            $.v_long;
  has ulong           $.v_ulong;
  has int64           $.v_int64;
  has uint64          $.v_uint64;
  has num32           $.v_float;
  has num64           $.v_double;
  has OpaquePointer   $.v_pointer;
};

class GValue is repr('CStruct') does GTK::Roles::Pointers is export {
  has ulong           $.g_type;
  HAS GTypeValueList  $.data1;
  HAS GTypeValueList  $.data2;
}

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

our enum GdkDragAction is export <
  GDK_ACTION_DEFAULT
  GDK_ACTION_COPY
  GDK_ACTION_MOVE
  GDK_ACTION_LINK
  GDK_ACTION_PRIVATE
  GDK_ACTION_ASK
>;

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
class GdkEventKey           is repr('CPointer') is export { }
class GdkEventMask          is repr('CPointer') is export { }
class GdkEventMotion        is repr('CPointer') is export { }
class GdkEventScroll        is repr('CPointer') is export { }
class GdkEventSelection     is repr('CPointer') is export { }
class GdkEventVisibility    is repr('CPointer') is export { }
class GdkEventWindowState   is repr('CPointer') is export { }
class GdkFrameClock         is repr('CPointer') is export { }
class GdkGeometry           is repr('CPointer') is export { }
class GdkGravity            is repr('CPointer') is export { }
class GMenuModel            is repr('CPointer') is export { }
class GdkModifierIntent     is repr('CPointer') is export { }
class GdkModifierType       is repr('CPointer') is export { }
class GdkPixbuf             is repr('CPointer') is export { }
class GdkRectangle          is repr('CPointer') is export { }
class GdkRGBA               is repr('CPointer') is export { }
class GdkScreen             is repr('CPointer') is export { }
class GdkTouchEvent         is repr('CPointer') is export { }
# Probably should be its own class
class GtkTreeModel          is repr('CPointer') is export { }
class GdkVisual             is repr('CPointer') is export { }
class GdkWindow             is repr('CPointer') is export { }
class GdkWindowEdge         is repr('CPointer') is export { }
