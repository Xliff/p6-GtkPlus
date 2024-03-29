use v6.c;

use NativeCall;

role GTK::Roles::StructArray:ver<3.0.1146>[::T] does Positional {
 
  # Thank you, ctilmes!!!
  method AT-POS (Int $index) {
    die 'Must have CStruct repr when using GTK::Roles::StructArray'
      unless T.REPR eq 'CStruct';
      
    nativecast( 
      T, Pointer.new( self + $index * nativesizeof(T) ) 
    )
  }
  
}
