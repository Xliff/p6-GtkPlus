use v6.c;

use GTK::Builder::Base;

class GTK::Builder::ListBoxRow is GTK::Builder::Base does GTK::Builder::Role {

  multi method populate($v, $o) {
    my @c;
    @c.push: "{ sprintf($v, $o<id>) }.add({ sprintf($v, $_<id>) });"
      for $o<children>.map( *<objects> );
    @c;
  }

}
