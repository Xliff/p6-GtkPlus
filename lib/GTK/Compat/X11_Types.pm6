use v6.c;

use NativeCall;

use GTK::Roles::Pointers;

unit package GTK::Compat::X11_Types;

our constant XID is export := uint64;

our class X11Display is repr<CPointer> does GTK::Roles::Pointers is export {}
our class X11Screen  is repr<CPointer> does GTK::Roles::Pointers is export {}
our class X11Window  is repr<CPointer> does GTK::Roles::Pointers is export {}
