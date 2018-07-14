use v6.c;

use NativeCall;

unit package GTK::Compat::Types;

class GList is repr('CStruct') is export {
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

class GValue is repr('CStruct') is export {
  has ulong           $.g_type;
  HAS GTypeValueList  $.data1;
  HAS GTypeValueList  $.data2;
}

our enum GApplicationFlags is export (
  G_APPLICATION_FLAGS_NONE           => 0,
  G_APPLICATION_IS_SERVICE           => 1,
  G_APPLICATION_IS_LAUNCHER          => 2,
  G_APPLICATION_HANDLES_OPEN         => 4,
  G_APPLICATION_HANDLES_COMMAND_LINE => 8,
  G_APPLICATION_SEND_ENVIRONMENT     => 16,
  G_APPLICATION_NON_UNIQUE           => 32
);

class cairo_font_options_t  is repr('CPointer') is export { }

class AtkObject             is repr('CPointer') is export { }

class PangoContext          is repr('CPointer') is export { }
class PangoFontDescription  is repr('CPointer') is export { }
class PangoFontMap          is repr('CPointer') is export { }
class PangoLayout           is repr('CPointer') is export { }

class GActionGroup          is repr('CPointer') is export { }
class GApplication          is repr('CPointer') is export { }
class GParamSpec            is repr('CPointer') is export { }
class GDestroyNotify        is repr('CPointer') is export { }
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
class GdkModifierIntent     is repr('CPointer') is export { }
class GdkModifierType       is repr('CPointer') is export { }
class GdkPixbuf             is repr('CPointer') is export { }
class GdkRectangle          is repr('CPointer') is export { }
class GdkRGBA               is repr('CPointer') is export { }
class GdkScreen             is repr('CPointer') is export { }
class GdkTouchEvent         is repr('CPointer') is export { }
class GdkVisual             is repr('CPointer') is export { }
class GdkWindow             is repr('CPointer') is export { }
