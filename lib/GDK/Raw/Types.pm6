use v6.c;

use CompUnit::Util :re-export;
use GLib::Raw::Types;
use Pango::Raw::Types

unit package GDK::Raw::Types;

need GLib::Raw::Definitions;
need GLib::Raw::Enums;
need GLib::Raw::Structs;
need GLib::Raw::Subs;
need Pango::Raw::Definitions;
need Pango::Raw::Enums;
need Pango::Raw::Structs;
need Pango::Raw::Subs;
need GDK::Raw::Definitions;
need GDK::Raw::Enums;
need GDK::Raw::Structs;
need GDK::Raw::Subs;

our @gdk-exports is export;
BEGIN {
  @gdk-exports = <
    GDK::Raw::Definitions
    GDK::Raw::Enums
    GDK::Raw::Structs
    GDK::Raw::Subs
  >;

  re-export($_) for |@glib-exports, |@pango-exports, |@gdk-exports;
}
