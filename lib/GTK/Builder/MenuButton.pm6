use v6.c;

use GTK::Builder::Base;

class GTK::Builder::MenuButton is GTK::Builder::Base {
  my @attributes = <
    align-widget
    align_widget
    direction
    menu-model
    menu_model
    popover
    popup
    use-popover
    use_popover
  >;

  multi method properties($o) {
    my @c = self.properties(@attributes, $o, -> $prop is rw {
      when / 'align' <[\-_]> 'widget' || 'menu' <[\-_]> 'model' / {
        warn "{ $_ } NYI";
      }
      when 'direction' {
        $o<props><direction> = do given $o<props><direction> {
          when 'up'    { 'GTK_ARROW_UP'    }
          when 'down'  { 'GTK_ARROW_DOWN'  }
          when 'left'  { 'GTK_ARROW_LEFT'  }
          when 'right' { 'GTK_ARROW_RIGHT' }
          when 'none'  { 'GTK_ARROW_NONE'  }

          default      {
            warn "Unknown 'direction' value left unchanged: '$_'";
            $_;
          }
        }
      }
      when 'popup' | 'popover' {
        # This should be in the definition, if not, at worse it will be
        # caught during compilation
        $o<props>{$_} = '$' ~ $o<props>{$_};
      }
      when 'use-popover' {
        $prop = 'use_popover';
      }
    });
    @c;
  }

}
