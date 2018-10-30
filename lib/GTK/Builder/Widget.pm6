use v6.c;

use GTK::Builder::Base;

class GTK::Builder::Widget is GTK::Builder::Base {
  my @attributes;

  multi method properties($o) {
    my @c;
    my ($height, $width) = (
      $o<props><height-request> // -1,
      $o<props><width-request> // -1
    );
    @c.push: "\${ $o<id> }.set_size_request($width, $height);"
      if ($height, $width).any > 0;
    $o<props><height-request width-request>:delete;

    @c.append: self.properties(@attributes, $o, -> $prop is rw {
      when <valign halign>.any {
        $o<props>{$_} = do given $o<props>{$_} {
          when 'fill'     { 'GTK_ALIGN_FILL'     }
          when 'start'    { 'GTK_ALIGN_START'    }
          when 'end'      { 'GTK_ALIGN_END'      }
          when 'center'   { 'GTK_ALIGN_CENTER'   }
          when 'baseline' { 'GTK_ALIGN_BASELINE' }
        }
      }
    });
    @c;
  }

}
