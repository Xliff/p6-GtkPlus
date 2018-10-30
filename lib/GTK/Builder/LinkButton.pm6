use v6.c;

use GTK::Builder::Base;

class GTK::Builder::LinkButton is GTK::Builder::Base {
  my @attributes = <uri visited>;

  multi method properties($o) {
    my @c = self.properties(@attributes, $o, -> $prop is rw {
      when 'uri' {
        $o<props><uri> = "'$o<props><uri>'";
      }
    });
    @c;
  }
  
}
