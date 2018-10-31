use v6.c;

use Pluggable;

use GTK::Builder::Widgets;

class GTK::BuilderWidgets does Pluggable {
  has @!plugins;
  has %!widgets;

  submethod BUILD {
    @!plugins = plugins('GTK',
      plugins-namespace => 'Builder',
      name-matcher      => /^ 'GTK::Builder::' <!before 'Base'>/
    );
    for GTK::Builder::Base.mro.keys {
      %!widgets{$_} = ::("GTK::Builder::{ $_ }");
    }
  }

  method list-plugins {
    @!plugins.map({ my $a = $_.^name; $a ~~ s/^ 'GTK::Builder::' //; $a});
  }

  method get-code-list($parser) {
    my @code;
    for $parser -> $o {
      (my $w = $o<class>) ~~ s/^ 'Gtk' //;
      @code.append: %!widgets{$w}.create($o);
      @code.append: $!widgets{$w}.properties($o);
      if $parser<children>.elems {
        @code.append: self.get-code-list($_<objects>) for $parser<children>;
        @code.append: %!widgets{$w}.packing($o);
      }
    }
    @code;
  }

}
