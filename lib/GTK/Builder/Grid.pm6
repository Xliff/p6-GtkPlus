use v6.c;

use GTK::Builder::Base;

class GTK::Builder::Grid is GTK::Builder::Base {
  my @attributes = <
    baseline-row
    column-homogeneous
    column-spacing
    row-homogeneous
    row-spacing
  >;

  method properties($o) {
    my @c = self.properties(@attributes, $o, -> $prop is rw {
      when @attributes.any {
        $prop ~~ s:g/ '-' / '_' /;
      }
    });
    @c;
  }

  method populate($o) {
    my @c;
    for $o<children> {
      @c.append: qq:to/ATTACH/.chomp;
\${ $o<id> }.attach(
  \${ $_<id> },
  { $_<packing><left-attach> // 0 },
  { $_<packing><top-attach>  // 0 },
  { $_<packing><width>       // 1 },
  { $_<packing><height>      // 1 }
);
ATTACH
    }
    @c;
  }

}
