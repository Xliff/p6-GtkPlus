use v6.c;

use GTK::Builder::Base;

class GTK::Builder::Actionable is GTK::Builder::Base does GTK::Builder::Role {
  my @attributes = <
    action-name
  >;

  multi method properties($v, $o) {
    my @c = self.properties($v, @attributes, $o, -> $prop is rw {
      given $prop {
        when 'action-name' {
          $o<props><action-name> = "\"{ $o<props><action-name>}\"";
        }
      }
    });
    @c;
  }

}
