use v6.c;

use GTK::Builder::Base;

class GTK::Builder::Widget is GTK::Builder::Base {

  multi method properties($o) {
    my @c;
    my ($height, $width) = (
      $o<props><height-request> // -1,
      $o<props><width-request>  // -1
    );
    @c.push: "\${ $o<id> }.set_size_request($width, $height);"
      if ($height, $width).any > 0;
    $o<props><height-request width-request>:delete;

    my ($left, $right, $top, $bottom, $start, $end) = (
      $o<props><margin-left>   // -1,
      $o<props><margin-right>  // -1,
      $o<props><margin-top>    // -1,
      $o<props><margin-bottom> // -1,
    );
    my @sides = <margin-top margin-bottom margin-left margin-right>;
    my $min = $o<props>{@sides}.min;
    if $o<props>{@sides}.all > 0 && $min == $o<props>{@sides}.max {
      @c.push: "\${ $o<id> }.margins = { $min };";
      $o<props>{@sides}:delete;
    }

    @c.append: self.properties( (), $o, -> $prop is rw {
      given $prop {
        when / 'margin-' (
            'left'   |
            'right'  |
            'bottom' |
            'top'    |
            'start'  |
            'end'
        ) / {
          $prop = "margin_{ $/[0] }";
        }
        when <valign halign>.any {
          $o<props>{$_} = do given $o<props>{$_} {
            when 'fill'     { 'GTK_ALIGN_FILL'     }
            when 'start'    { 'GTK_ALIGN_START'    }
            when 'end'      { 'GTK_ALIGN_END'      }
            when 'center'   { 'GTK_ALIGN_CENTER'   }
            when 'baseline' { 'GTK_ALIGN_BASELINE' }
          }
        }
      }
    });
    @c;
  }

}
