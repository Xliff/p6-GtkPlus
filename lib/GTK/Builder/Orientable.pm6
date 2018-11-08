use v6.c;

use GTK::Builder::Base;

class GTK::Builder::Orientable is GTK::Builder::Base does GTK::Builder::Role {
  my @attributes = <
    orientation
  >;

  multi method properties($v, $o) {
    my @c = self.properties($v, @attributes, $o, -> $prop is rw {
      given $prop {
        when 'orientation' {
          $o<props><orientation> = do given $o<props><orientation> {
            when 'horizontal'  { 'GTK_ORIENTATION_HORIZONTAL' }
            when 'vertical'    { 'GTK_ORIENTATION_VERTICAL'   }
          }
        }
      }
    });
    @c;
  }

}
