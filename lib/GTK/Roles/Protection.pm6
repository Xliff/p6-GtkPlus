use v6.c;

role GTK::Roles::Protection {
  has @!prefixes = ('GTK::');

  # cw: This is a HACK, but it should work with careful use.
  method CALLING-METHOD($nf = 2) {
    my $c = callframe($nf).code;
    $c ~~ Routine ??
      "{ $c.package.^name }.{ $c.name }"
      !!
      die "Frame not a method or code!";
  }

  method ADD-PREFIX($p) {
    @!prefixes.push: $p;
  }

  # Should never be called ouside of the GTK::Widget hierarchy, but
  # how can the watcher watch itself?
  method IS-PROTECTED {
    # Really kinda violates someone's idea of "object-oriented" somewhere,
    # but I am more results-oriened.
    my $c = self.CALLING-METHOD;
    # Must be done, otherwise error. Note: Regexes do not like attributes.
    my @p = @!prefixes;
    $c ~~ /^ @p/ ??
      True
      !!
      die "Cannot call method from outside of a GTK:: object";
  }
}
