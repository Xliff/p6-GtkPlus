use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GDK::Raw::Definitions;

unit package GDK::Raw::Subs;

sub gdk_atom_name(GdkAtom)
  returns Str
  is native(gdk)
  is export
{ * }

sub gdkMakeAtom($i) is export {
  my gint $ii = $i +& 0x7fff;
  my $c = CArray[int64].new($ii);
  nativecast(GdkAtom, $c);
}
