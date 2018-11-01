use v6.c;

use GTK::Builder::Base;

class GTK::Builder::Image is GTK::Builder::Base does GTK::Builder::Role {
  my @attributes = <
    icon-name
    icon-set
    pixel-size
    use-fallback
  >;

  multi method properties($v, $o) {
    my @c = self.properties($v, @attributes, $o, -> $prop is rw {
      # Per property special-cases
      given $prop {
        when 'icon-name' {
          $o<props><icon-name> = "'{ $$o<props><icon-name> }'";
        }
        when 'pixel-size' {
          $prop = 'pixel_size';
        }
      }
    });
    @c;
  }

}
