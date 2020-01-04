use v6.c;

use NativeCall;

use Cairo;

use GLib::Raw::Definitions;
use GLib::Roles::Pointers;

unit package GDK::Raw::Definitions;

# Number of times I've had to force compile the whole project.
constant forced = 0;

constant GDK_MAX_TIMECOORD_AXES is export = 128;

constant cairo_t                        is export := Cairo::cairo_t;
constant cairo_format_t                 is export := Cairo::cairo_format_t;
constant cairo_pattern_t                is export := Cairo::cairo_pattern_t;
constant cairo_region_t                 is export := Pointer;

our subset CairoContext is export of Mu
  where Cairo::cairo_t | Cairo::Context;
our subset CairoSurface is export of Mu
  where Cairo::cairo_surface_t | Cairo::Surface;

constant GdkFilterFunc                  is export := Pointer;
constant GdkPixbufDestroyNotify         is export := Pointer;
constant GdkPixbufSaveFunc              is export := Pointer;
constant GdkSeatGrabPrepareFunc         is export := Pointer;
constant GdkWindowChildFunc             is export := Pointer;
constant GdkWindowInvalidateHandlerFunc is export := Pointer;
constant GdkWMFunction                  is export := Pointer;

class cairo_font_options_t   is repr('CPointer') is export does GLib::Roles::Pointers { }
class cairo_surface_t        is repr('CPointer') is export does GLib::Roles::Pointers { }

# --- GDK TYPES ---
class GdkAppLaunchContext    is repr('CPointer') is export does GLib::Roles::Pointers { }
class GdkAtom                is repr('CPointer') is export does GLib::Roles::Pointers { }
class GdkCursor              is repr('CPointer') is export does GLib::Roles::Pointers { }
class GdkDevice              is repr('CPointer') is export does GLib::Roles::Pointers { }
class GdkDeviceManager       is repr('CPointer') is export does GLib::Roles::Pointers { }
class GdkDeviceTool          is repr('CPointer') is export does GLib::Roles::Pointers { }
class GdkDisplay             is repr('CPointer') is export does GLib::Roles::Pointers { }
class GdkDisplayManager      is repr('CPointer') is export does GLib::Roles::Pointers { }
class GdkDragContext         is repr('CPointer') is export does GLib::Roles::Pointers { }
class GdkDrawingContext      is repr('CPointer') is export does GLib::Roles::Pointers { }
class GdkEventSequence       is repr('CPointer') is export does GLib::Roles::Pointers { }
class GdkFrameClock          is repr('CPointer') is export does GLib::Roles::Pointers { }
class GdkFrameTimings        is repr('CPointer') is export does GLib::Roles::Pointers { }
class GdkGLContext           is repr('CPointer') is export does GLib::Roles::Pointers { }
class GdkKeymap              is repr('CPointer') is export does GLib::Roles::Pointers { }
class GdkMonitor             is repr('CPointer') is export does GLib::Roles::Pointers { }
class GdkPixbuf              is repr('CPointer') is export does GLib::Roles::Pointers { }
class GdkPixbufAnimation     is repr('CPointer') is export does GLib::Roles::Pointers { }
class GdkPixbufAnimationIter is repr('CPointer') is export does GLib::Roles::Pointers { }
class GdkScreen              is repr('CPointer') is export does GLib::Roles::Pointers { }
class GdkSeat                is repr('CPointer') is export does GLib::Roles::Pointers { }
class GdkStyleProvider       is repr('CPointer') is export does GLib::Roles::Pointers { }
class GdkVisual              is repr('CPointer') is export does GLib::Roles::Pointers { }
class GdkWindow              is repr('CPointer') is export does GLib::Roles::Pointers { }
