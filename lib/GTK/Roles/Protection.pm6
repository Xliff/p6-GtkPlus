use v6.c;

role GTK::Roles::Protection {
  has @!prefixes;

  # cw: This is a HACK, but it should work with careful use.
  method CALLING-METHOD($nf = 3) {
    my $c = callframe($nf).code;
    $c ~~ Routine ??
      "{ $c.package.^name }.{ $c.name }"
      !!
      die "Frame not a method or code!";
  }

  # Do NOT use this method unless you are adding a widget. If adding widgets,
  # please be sure to use a discrete namespace for them.
  #
  # For example:
  #   - It is not sufficient to self.ADD-PREFIX('YourProject') if
  #     the YourProject:: code has non-GTK derivative code. In that case, it
  #     would be appreciated if you would put all widgets into the
  #     YourProject::Widgets namespace and then you can do:
  #         self.ADD-PREFIX('YourProject::Widgets::')
  #     in submethod BUILD.
  #
  # THANKS!
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
    #my @p = @!prefixes;
    my $t = False;
    # Hardcoded 'GTK::'. There should be a better mechanism to do this, but
    # we use what works.
    for 'GTK::', |@!prefixes {
      last if ( $t = $c.starts-with($_) );
    }
    die "Cannot call method from outside of a GTK:: object ({ $c })"
      unless $t;
    True;
  }
}
