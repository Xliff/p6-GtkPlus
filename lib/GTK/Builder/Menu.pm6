use v6.c;

use GTK::Builder::Base;

class GTK::Builder::Menu is GTK::Builder::Base does GTK::Builder::Role {

  method populate($o) {
    my @c;
    @c.push: "\${ $o<id> }.append(\${ $_<id> });"
      for $o<children>.map( *<objects> );
    @c;
  }

}
