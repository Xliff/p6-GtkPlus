use v6.c;

use GTK::Builder::Base;

class GTK::Builder::Button is GTK::Builder::Base does GTK::Builder::Role {
  my @attributes = <
    label
    relief
  >;

  multi method properties($v, $o) {
    my @c = self.properties($v, @attributes, $o, -> $prop is rw {
      # Per property special-cases
      given $prop {
        when 'label' {
          $o<props><label> = "\"{ self.label_from_attributes($o) }\"";
        }
        when 'relief' {
          $o<props><relief> = do given $o<props><relief> {
            when 'none'    { 'GTK_RELIEF_NONE'   }
            when 'normal'  { 'GTK_RELIEF_NORMAL' }
            when 'half'    { 'GTK_RELIEF_HALF'   }
          };
        }
      }
    });
    @c;
  }

}
