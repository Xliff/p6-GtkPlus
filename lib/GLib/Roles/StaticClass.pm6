use v6.c;

use GTK::Compat::Types;

role GLib::Roles::StaticClass {

  multi method new (|) {
    self!staticWarning(::?CLASS);
  }

  method !staticWarning (\c) is export {
    warn "{ c.^name } is a static class and does not need to be instantiated!"
      if $DEBUG;

    c;
  }

}
