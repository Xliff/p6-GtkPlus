use v6.c;

use NativeCall;

role GLib::Roles::Pointers {

  method p {
    nativecast(Pointer, self);
  }

}
