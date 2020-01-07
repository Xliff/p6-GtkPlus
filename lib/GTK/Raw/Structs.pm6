use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use Pango::Raw::Definitions;
use GDK::Raw::Definitions;
use GLib::Raw::Structs;
use GDK::Raw::Structs;
use Pango::Raw::Structs;
use GTK::Raw::Definitions;

use GDK::RGBA;

unit package GTK::Raw::Structs;

class GtkBorder is repr('CStruct') does GLib::Roles::Pointers is export {
  has int16 $.left;
  has int16 $.right;
  has int16 $.top;
  has int16 $.bottom;
}

class GtkTargetEntry is repr('CStruct') does GLib::Roles::Pointers is export {
  has Str   $.target;
  has guint $.flags;
  has guint $.info;
}

class GtkTargetPair is repr('CStruct') does GLib::Roles::Pointers is export {
  has GdkAtom $.target;
  has guint   $.flags;
  has guint   $.info;
}

class GtkTreeIter is repr('CStruct') does GLib::Roles::Pointers is export {
  has gint     $.stamp;
  has gpointer $.user_data;
  has gpointer $.user_data2;
  has gpointer $.user_data3;
}

class GtkTextAppearance is repr('CStruct') does GLib::Roles::Pointers is export {
  HAS GdkColor $.bg_color;
  HAS GdkColor $.fg_color;
  has gint     $.rise;
  has guint    $.underline;        # :4
  has guint    $.strikethru;       # :1
  has guint    $.draw_bg;          # :1
  has guint    $.inside_selection; # :1
  has guint    $.is_text;          # :1
  has GdkRGBA  $.rgba1;
  has GdkRGBA  $.rgba2;
}

class GtkTextAttributes is repr('CStruct') does GLib::Roles::Pointers is export {
  HAS GtkTextAppearance    $.appearance;
  has uint32               $.justification;   # GtkTextJustification
  has uint32               $.direction;       # GtkTextDirection
  has PangoFontDescription $.font;
  has gdouble              $.font_scale;
  has gint                 $.left_margin;
  has gint                 $.right_margin;
  has gint                 $.ident;
  has gint                 $.pixels_above_lines;
  has gint                 $.pixels_below_lines;
  has gint                 $.pixels_inside_wrap;
  has PangoTabArray        $.tabs;
  has uint32               $.wrap_mode;       # GtkWrapMode
  has Pointer              $.language;        # PangoLanguage
  has guint                $.invisible;       # :1
  has guint                $.bg_bull_height;  # :1
  has guint                $.editable;        # :1
  has guint                $.no_fallback;     # :1
  has GdkRGBA              $.pg_bg_rgba;
  has gint                 $.letter_spacing;
  has Str                  $.font_features;
  has guint                $.padding;
}

class GtkTextIter is repr('CStruct') does GLib::Roles::Pointers is export {
  # Opaque struct, but memory needs to be initialized.
  has gpointer $.dummy1;
  has gpointer $.dummy2;
  has gint     $.dummy3;
  has gint     $.dummy4;
  has gint     $.dummy5;
  has gint     $.dummy6;
  has gint     $.dummy7;
  has gint     $.dummy8;
  has gpointer $.dummy9;
  has gpointer $.dummy10;
  has gint     $.dummy11;
  has gint     $.dummy12;
  has gint     $.dummy13;
  has gpointer $.dummy14;
}
class GtkRequisition is repr('CStruct') does GLib::Roles::Pointers is export {
  has uint32 $.width  is rw;
  has uint32 $.height is rw;
}

class GtkFileFilterInfo is repr('CStruct') does GLib::Roles::Pointers is export {
  has uint32  $.contains;       # GtkFileFilterFlags
  has Str     $.filename;
  has Str     $.uri;
  has Str     $.display_name;
  has Str     $.mime_type;
};

class GtkRecentFilterInfo is repr('CStruct') does GLib::Roles::Pointers is export {
  has uint32      $.contains;   # GtkRecentFilterFlags contains;
  has Str         $.uri;
  has Str         $.display_name;
  has Str         $.mime_type;
  has CArray[Str] $.applications;
  has CArray[Str] $.groups;
  has gint        $.age;
};

class GtkAccelKey is repr('CStruct') does GLib::Roles::Pointers is export {
  has guint  $.accel_key;
  has uint32 $.accel_mods;      # GdkModifierType accel_mods;
  has uint32 $.accel_flags;     # : 16;
};

class GtkPageRange is repr('CStruct') does GLib::Roles::Pointers is export {
  has gint $.start;
  has gint $.end;
};

class GtkSettingsValue is repr('CStruct') does GLib::Roles::Pointers is export {
  has Str     $.origin;
  HAS GValue  $.value;
}

class GtkRecentData is repr('CStruct') does GLib::Roles::Pointers is export {
  has Str      $.display_name;
  has Str      $.description;
  has Str      $.mime_type;
  has Str      $.app_name;
  has Str      $.app_exec;
  has Str      $.groups;
  has gboolean $.is_private;
}

our constant GtkAllocation is export := GdkRectangle;
