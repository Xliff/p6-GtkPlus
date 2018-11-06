use v6.c;

use NativeCall;

role GTK::Roles::Pointers {

  method p {
    nativecast(Pointer, self);
  }

}
