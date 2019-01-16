use v6.c;

use NativeCall;

role GTK::Roles::Pointers {
  #
  # Commented code is proposed for proper GC handling and puts it
  # on the pointers (where it should be) as opposed to the wrapper classes.

  # has &.up-ref   is rw;
  # has &.down-ref is rw;

  # submethod DESTROY {
  #   self.down-ref;
  # }

  # method up-ref {
  #   &.upref(self);
  # }
  #
  # method down-ref {
  #   &.downref(self);
  # }

  method p {
    nativecast(Pointer, self);
  }

}
