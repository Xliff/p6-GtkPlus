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

  multi method properties($v, $o) {
    my @c = self.properties($v, @attributes, $o, -> $prop is rw {
      given $prop {
        when @attributes.any {
          $prop ~~ s:g/ '-' / '_' /;
        }
      }
    });
    @c;
  }

  method populate($v, $o) {
    my @c;

    use Data::Dump::Tree;

    for $o<children>.List {
      my $attach = qq:to/ATTACH/.chomp;
{ sprintf($v, $o<id>) }.attach(
{ sprintf($v, $_<objects><id>) },
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
