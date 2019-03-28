use v6.c;

role GTK::Roles::StructArray[::T] does Positional {
 
  # Thank you, ctilmes!!!
  method AT-POS (Int $index) {
    nativecast( T, self + $index * nativesizeof(T) )
  }
  
}
