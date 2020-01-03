use v6;

use CompUnit::Util :re-export;

unit package GIO::Raw::Types;

need GLib::Raw::Definitions;
need GLib::Raw::Enums;
need GLib::Raw::Structs;
need GLib::Raw::Subs;
need GIO::Raw::Definitions;
need GIO::Raw::DBus::Types;
need GIO::Raw::Enums;
need GIO::Raw::Structs;
need GIO::Raw::Subs;

our @gio-exports is export;

BEGIN {
  @glib-exports = <
    GIO::Raw::Definitions
    GIO::Raw::DBus::Types
    GIO::Raw::Enums
    GIO::Raw::Structs
    GIO::Raw::Subs
  >;
  re-export($_) for |@glib-exports, |@gio-exports;
}
