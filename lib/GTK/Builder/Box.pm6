use v6.c;

use GTK::Builder::Base;

class GTK::Builder::Box is GTK::Builder::Base does GTK::Builder::Role {
  my @attributes = <
    baseline-position
    homogeneous
    spacing
  >;

  multi method properties($o) {
    my @c = self.properties(@attributes, $o, -> $prop is rw {
      given $prop {
        when 'baseline-position' {
          $prop = 'baseline_position';
          $o<props><baseline-position> = do
            given $o<props><baseline-position> {
              when 'top'     { 'GTK_BASELINE_POSITION_TOP'    }
              when 'center'  { 'GTK_BASELINE_POSITION_CENTER' }
              when 'bottom'  { 'GTK_BASELINE_POSITION_BOTTOM' }
            }
          }
      }
    });
    @c;
  }

  method populate($o) {
    my @c;
    for $o<children>.sort({
      $_<packing><position>.defined ??
        $_<packing><position>.Int
        !!
        0
    }).List {
      my $pack = qq:to/PACK/.chomp;
\${ $o<id> }.pack_start(
\${ $_<objects><id> },
  { $_<packing><fill>    // 'False' },
  { $_<packing><expand>  // 'False' },
  { $_<packing><padding> // 0 }
);
PACK

      $pack ~~ s:g/\r?\n//;
      @c.push: $pack;
    }
    @c;
  }

}
