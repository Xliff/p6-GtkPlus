use v6.c;

class GTK::Builder::MenuItem {

  method create($o) {
    my @c;
    # We don't do anything with the "translatable" attribute, yet.
    @c.push: qq:to/MI/.chomp;
\${ $o<id> } = GTK::MenuItem.new_with_label("{ $o<props><label><value> }");
MI

    @c;
  }

  method properties($o) {
    my @c;
    @c.push: "\${ $o<id> }.use_underline = $o<props><use-underline>;"
      if $o<props><use-underline>.defined;
    @c;
  }

}
