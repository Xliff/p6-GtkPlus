use v6.c;

class GTK::Builder::Menu {

  method create($o) {
    my @c;
    @c.push: "\${ $o<id> } = GTK::Menu.new(};";
    @c;
  },

  method populate($o) {
    my @c;
    @c.push: "\${ $o<id> }.append(\${ $_<id> });"
      for $o<children>.map( *<objects> );
    @c;
  }

}
