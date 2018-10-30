use v6.c;

use GTK::Builder::Base;

class GTK::Builder::Image is GTK::Builder::Base {
  my @attributes = <
    icon-name
    icon-set
    pixel-size
    use-fallback
  >;

  multi method properties($o) {
    my @c = self.properties(@attributes, $o, -> $prop is rw {
      # Per property special-cases
      when 'icon-name' {
        $o<prop><icon-name> = "'{ $$o<prop><icon-name> }'";
      }
      when 'pixel-size' {
        $prop = 'pixel_size';
      }
    });
    @c;
  }

}
