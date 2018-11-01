use v6.c;

use GTK::Builder::Base;

class GTK::Builder::ListBoxRow is GTK::Builder::Base does GTK::Builder::Role {

  multi method populate($o) {
    my @c;
    @c.push: ".add(\${ $_<id> });"
      for $o<children>.map( *<objects> );
    @c;
  }

}
