use v6.c;

role GTK::Roles::Protection {
  # cw: This is a HACK, but it should work with careful use.
  method CALLING-METHOD($nf = 2) {
    my $c = callframe($nf).code;
    $c ~~ Routine ??
      "{ $c.package.^name }.{ $c.name }"
      !!
      die "Frame not a method or code!";
  }

  # Should never be called ouside of the GTK::Widget hierarchy, but
  # how can the watcher watch itself?
  method IS-PROTECTED {
    # Really kinda violates someone's idea of "object-oriented" somewhere,
    # but I am more results-oriened.
    my $c = self.CALLING-METHOD;
    $c ~~ /^ 'GTK::'/ ??
      True
      !!
      die "Cannot call method from outside of a GTK:: object";
  }
}
