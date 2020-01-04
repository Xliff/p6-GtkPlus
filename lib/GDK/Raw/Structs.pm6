use v6.c;

use NativeCall;

use Cairo;

use GLib::Raw::Pointers;
use GLib::Raw::Definitions;
use GDK::Raw::Definitions;

unit package GDK::Raw::Structs;

class GdkColor is repr('CStruct') does GLib::Roles::Pointers is export {
  has guint   $.pixel;
  has guint16 $.red;
  has guint16 $.green;
  has guint16 $.blue;
}

class GdkGeometry is repr('CStruct') does GLib::Roles::Pointers is export {
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

class GdkRectangle is repr('CStruct') does GLib::Roles::Pointers is export {
  has gint $.x is rw;
  has gint $.y is rw;
  has gint $.width is rw;
  has gint $.height is rw;
}

class GdkPixbufModulePattern is repr('CStruct') does GLib::Roles::Pointers is export {
	has Str $.prefix;
	has Str $.mask;
	has int $.relevance;
}

class GdkPixbufFormat is repr('CStruct') does GLib::Roles::Pointers is export {
  has Str                     $.name;
  has GdkPixbufModulePattern  $.signature;
  has Str                     $.domain;
  has Str                     $.description;
  has CArray[Str]             $.mime_types;
  has CArray[Str]             $.extensions;
  has guint32                 $.flags;
  has gboolean                $.disabled;
  has Str                     $.license;
}

class GdkPoint is repr('CStruct') does GLib::Roles::Pointers is export {
  has gint $.x is rw;
  has gint $.y is rw;
}

# class GdkEvent is repr<CUnion> does GLib::Roles::Pointers is export {

class GdkEventAny is repr('CStruct') does GLib::Roles::Pointers is export {
  has uint32       $.type;              # GdkEventType
  has GdkWindow    $.window;
  has int8         $.send_event;
}

class GdkEventKey is repr('CStruct') does GLib::Roles::Pointers is export {
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

class GdkEventButton is repr('CStruct') does GLib::Roles::Pointers is export {
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

class GdkEventExpose   is repr('CStruct') does GLib::Roles::Pointers is export {
  has uint32         $.type;            # GdkEventType
  has GdkWindow      $.window;
  has int8           $.send_event;
  has GdkRectangle   $.area;
  has cairo_region_t $.region;
  has int32          $.count;
}

class GdkEventCrossing is repr('CStruct') does GLib::Roles::Pointers is export {
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

class GdkEventFocus    is repr('CStruct') does GLib::Roles::Pointers is export {
  has uint32         $.type;            # GdkEventType
  has GdkWindow      $.window;
  has int8           $.send_event;
  has int16          $.in;
}

class GdkEventConfigure is repr('CStruct') does GLib::Roles::Pointers is export {
  has uint32         $.type;            # GdkEventType
  has GdkWindow      $.window;
  has int8           $.send_event;
  has int32          $.x;
  has int32          $.y;
  has int32          $.width;
  has int32          $.height;
}

class GdkEventProperty is repr('CStruct') does GLib::Roles::Pointers is export {
  has uint32         $.type;            # GdkEventType
  has GdkWindow      $.window;
  has int8           $.send_event;
  has GdkAtom        $.atom;
  has uint32         $.time;
  has uint32         $.state;
}

class GdkEventScroll is repr('CStruct') does GLib::Roles::Pointers is export {
  has GdkEventType       $.type;
  has GdkWindow          $.window;
  has gint8              $.send_event;
  has guint32            $.time;
  has gdouble            $.x;
  has gdouble            $.y;
  has guint              $.state;
  has GdkScrollDirection $.direction;
  has GdkDevice          $.device;
  has gdouble            $.x_root;
  has gdouble            $.y_root;
  has gdouble            $.delta_x;
  has gdouble            $.delta_y;
  has guint              $.is_stop;   # : 1;
};

class GdkEventSelection is repr('CStruct') does GLib::Roles::Pointers is export {
  has uint32         $.type;            # GdkEventType
  has GdkWindow      $.window;
  has int8           $.send_event;
  has GdkAtom        $.selection;
  has GdkAtom        $.target;
  has GdkAtom        $.property;
  has uint32         $.time;
  has GdkWindow      $.requestor;
}

class GdkEventDnD is repr('CStruct') does GLib::Roles::Pointers is export {
  has uint32         $.type;            # GdkEventType
  has GdkWindow      $.window;
  has int8           $.send_event;
  has GdkDragContext $.context;
  has uint32         $.time;
  has int16          $.x_root;
  has int16          $.y_root;
}

class GdkEventProximity is repr('CStruct') does GLib::Roles::Pointers is export {
  has uint32         $.type;            # GdkEventType
  has GdkWindow      $.window;
  has int8           $.send_event;
  has uint32         $.time;
  has GdkDevice      $.device;
}

class GdkEventWindowState is repr('CStruct') does GLib::Roles::Pointers is export {
  has uint32         $.type;            # GdkEventType
  has GdkWindow      $.window;
  has int8           $.send_event;
  has uint32         $.changed_mask;
  has uint32         $.new_window_state;
}

class GdkEventSetting is repr('CStruct') does GLib::Roles::Pointers is export {
  has uint32         $.type;            # GdkEventType
  has GdkWindow      $.window;
  has int8           $.send_event;
  has uint32         $.action;
  has Str            $.name;
}

class GdkEventOwnerChange is repr('CStruct') does GLib::Roles::Pointers is export {
  has uint32         $.type;            # GdkEventType
  has GdkWindow      $.window;
  has int8           $.send_event;
  has GdkWindow      $.owner;
  has uint32         $.reason;          # GdkOwnerChange
  has GdkAtom        $.selection;
  has uint32         $.time;
  has uint32         $.selection_time;
}

class GdkEventMotion is repr('CStruct') does GLib::Roles::Pointers is export {
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

class GdkEventGrabBroken is repr('CStruct') does GLib::Roles::Pointers is export {
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
  GdkEventKey        | GdkEventScroll

class GdkWindowAttr is repr('CStruct') does GLib::Roles::Pointers is export {
  has Str       $!title;
  has gint      $.event_mask        is rw;
  has gint      $.x                 is rw;
  has gint      $.y                 is rw;
  has gint      $.width             is rw;
  has gint      $.height            is rw;
  has uint32    $.wclass            is rw;    # GdkWindowWindowClass
  has GdkVisual $!visual                 ;
  has uint32    $.window_type       is rw;    # GdkWindowType
  has GdkCursor $!cursor;
  has Str       $!wmclass_name;
  has Str       $!wmclass_class;
  has gboolean  $.override_redirect is rw;
  has uint32    $.type_hint         is rw;    # GdkWindowTypeHint

  method title is rw {
    Proxy.new:
      FETCH => -> $ { $!title },
      STORE => -> $, Str() $new {
        self.^attributes[0].set_value(self, $new)
      }
  }

  method visual is rw {
    Proxy.new:
      FETCH => -> $ { $!visual },
      STORE => -> $, GdkVisual() $new {
        self.^attributes[7].set_value(self, $new)
      }
  }

  method cursor is rw {
		Proxy.new:
			FETCH => -> $ { $.cursor },
			STORE => -> $, GdkCursor() $val {
				self.^attributes[9].set_value(self, $val);
      }
	}

  method wmclass_name is rw {
		Proxy.new:
			FETCH => -> $ { $.wmclass_name },
			STORE => -> $, Str() $val {
				self.^attributes[10].set_value(self, $val);
      }
	}

  method wmclass_class is rw {
    Proxy.new:
      FETCH => -> $ { $.label_name },
      STORE => -> $, Str() $val {
        self.^attributes[11].set_value(self, $val);
      }
  }

}

class GdkTimeCoord is repr('CStruct') does GLib::Roles::Pointers is export {
  has uint32        $.time;
  has CArray[num64] $.axes;
}

class GdkKeymapKey is repr('CStruct') does GLib::Roles::Pointers is export {
  has guint $.keycode;
  has gint  $.group;
  has gint  $.level;
}
