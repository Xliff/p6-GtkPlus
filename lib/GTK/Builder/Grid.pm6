use v6.c;

class GTK::Builder::Grid {

  method create($o) {
    my @c;
    @c.push: "\${ $o<id> } = GTK::Grid.new();";
    @c;
  }

  method properties($o) {
    my @c;
    for <GtkContainer GtkWidget> {
      @c.append: %widgets{$_}.properties($o)
        if %widgets{$_}.properties.defined;
    }
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
