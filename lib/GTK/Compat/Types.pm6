use v6.c;

use NativeCall;

unit package GTK::Compat::Types;

class GList is repr('CStruct') is export {
  has OpaquePointer $.data;
  has GList         $.next;
  has GList         $.prev;
}

class GTypeValueList is repr('CUnion') is export {
    has int32	          $.v_int;
    has uint32          $.v_uint;
    has long            $.v_long;
    has ulong           $.v_ulong;
    has int64           $.v_int64;
    has uint64          $.v_uint64;
    has num32           $.v_float;
    has num64           $.v_double;
    has OpaquePointer   $.v_pointer;
};

class GValue is repr('CStruct') is export {
    has ulong           $.g_type;
    HAS GTypeValueList  $.data1;
    HAS GTypeValueList  $.data2;
}
