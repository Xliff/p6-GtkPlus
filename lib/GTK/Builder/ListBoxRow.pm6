use v6.c;

use GTK::Builder::Base;

class GTK::Builder::ListBoxRow is GTK::Builder::Base {

  method populate($o) {
    my @c;
    @c.push: "\${ $o<id> }.add(\${ $_<id> });"
      for $o<children>.map( *<objects> );
    @c;
  }

}
