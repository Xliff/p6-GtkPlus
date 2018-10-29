use v6.c;

class GTK::Builder::ListBoxRow {

  method create($o) {
    my @c;
    @c.push: "\${ $o<id> } = GTK::ListBoxRow.new()";
    @c;
  }

  method populate($o) {
    my @c;
    @c.push: "\${ $o<id> }.add(\${ $_<id> });"
      for $o<children>.map( *<objects> );
    @c;
  }

}
