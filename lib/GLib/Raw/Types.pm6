use v6;

use GLib::Raw::Definitions;
use GLib::Raw::Enums;
use GLib::Raw::Structs;
use GLib::Raw::Subs;

sub EXPORT {
  %(
    GLib::Raw::Definitions::EXPORT::DEFAULT::,
    GLib::Raw::Enums::EXPORT::DEFAULT::,
    GLib::Raw::Structs::EXPORT::DEFAULT::
    GLib::Raw::Subs::EXPORT::DEFAULT::
  )
}
