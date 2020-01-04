use v6.c;

use NativeCall;

use GLib::Roles::Pointers;

unit package GDK::X11_Types;

our constant XID         is export := uint64;
our constant X11Window   is export := uint64; # XID
our constant X11Font     is export := uint64; # XID
our constant X11Pixmap   is export := uint64; # XID
our constant X11Drawable is export := uint64; # XID
our constant X11Cursor   is export := uint64; # XID
our constant X11Colormap is export := uint64; # XID
our constant X11KeySym   is export := uint64; # XID
our constant GContext    is export := uint64; # XID

our class X11Display is repr<CPointer> does GLib::Roles::Pointers is export {}
our class X11Screen  is repr<CPointer> does GLib::Roles::Pointers is export {}
