use v6.c;

use GTK::Builder::Base;

class GTK::Builder::Button is GTK::Builder::Base {
  my @attributes = <relief>;

  multi method properties($o) {
    my @c = self.properties(@attributes, $o, -> $prop is rw {
      # Per property special-cases
      when 'relief' {
        $o<props><relief> = do given $o<props><relief> {
          when 'none'    { 'GTK_RELIEF_NONE'   }
          when 'normal'  { 'GTK_RELIEF_NORMAL' }
          when 'half'    { 'GTK_RELIEF_HALF'   }
        };
      }
    });
    @c;
  }

}
