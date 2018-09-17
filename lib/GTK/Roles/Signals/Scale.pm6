use v6.c;

use NativeCall;

use GTK::Compat::Types;

role GTK::Roles::Signals::Scale does GTK::Roles::Signals {

  method connect-fv ($obj, &handler(gdouble $value, Poiner $d --> Str) {
    my $signal = 'format-value';

    # Forcing the use of tap on a signal name is nice an elegant if EVERY signal
    # is a Supply.
    #
    # This may not always be the case, so it may be best to ABSTRACT OUT the
    # signal implementtion.\

    # -XYX- Handle signal reassignment
    # -XYX- Handle garbage collection of previous handler.

    %!signals{$signal} //= do {
      my $rc = connect-format-value($obj, $signal, &handler, $d, 0);
      [ &handler, $obj ];
    };

    # -XYX- What do we want to ALWAYS return. In the case of the supply, it was
    # easy: Something we could always re-tap. Now it is more complex since not
    # all signals will be Supplies. We may need to adopt GTK::Signal to abstract
    # away the initial abstraction. Whee!

    #%!signals{$signal};
    Nil;
  }

  sub connect-format-value(
    Pointer,
    Str,
    &handler(gdouble, Pointer --> Str),
    Pointer,
    uint32
  )
    returns uint32
    is native('gobject-2.0')
    is symbol('g_signal_connect_object')
    is export
    { * }

}
