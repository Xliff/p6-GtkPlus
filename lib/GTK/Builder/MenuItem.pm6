use v6.c;

use GTK::Builder::Base;

class GTK::Builder::MenuItem is GTK::Builder::Base {
  my @attributes = <use-underline>;

  method create($o) {
    my @c;
    # We don't do anything with the "translatable" attribute, yet.
    @c.push: qq:to/MI/.chomp;
\${ $o<id> } = GTK::MenuItem.new_with_label("{ $o<props><label><value> }");
MI

    @c;
  }

  multi method properties($o) {
    my @c = self.properties(@attributes, $o, -> $prop is rw {
      given $prop {
        when 'use-underline' {
          $prop = 'use_underline';
        }
      }
    });
    @c;
  }

}