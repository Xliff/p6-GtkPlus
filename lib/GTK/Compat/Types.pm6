use v6.c;

use NativeCall;

unit package GTK::Compat::Types;

class GList is repr('CStruct') is export {
  has OpaquePointer $.data;
  has GList         $.next;
  has GList         $.prev;
}
