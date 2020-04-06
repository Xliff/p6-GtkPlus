use v6.c;

unit package GTK::Raw::Exports;

our @gtk-exports is export;

BEGIN {
  @gtk-exports = <
    GTK::Raw::Definitions
    GTK::Raw::Enums
    GTK::Raw::Structs
    GTK::Raw::Subs
    GTK::Raw::Requisition
  >;
}
