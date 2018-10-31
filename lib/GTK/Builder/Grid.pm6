use v6.c;

use GTK::Builder::Base;

class GTK::Builder::Grid is GTK::Builder::Base does GTK::Builder::Role {
  my @attributes = <
    baseline-row
    column-homogeneous
    column-spacing
    row-homogeneous
    row-spacing
  >;

  multi method properties($o) {
    my @c = self.properties(@attributes, $o, -> $prop is rw {
      given $prop {
        when @attributes.any {
          $prop ~~ s:g/ '-' / '_' /;
        }
      }
    });
    @c;
  }

  method populate($o) {
    my @c;
    for $o<objects><children> {
      my $attach = qq:to/ATTACH/.chomp;
\${ $o<id> }.attach(
  \${ $_<id> },
  { $_<packing><left-attach> // 0 },
  { $_<packing><top-attach>  // 0 },
  { $_<packing><width>       // 1 },
  { $_<packing><height>      // 1 }
);
ATTACH
      $attach ~~ s:g/\r?\n//;
      @c.append: $attach;
    }
    @c;
  }

}
