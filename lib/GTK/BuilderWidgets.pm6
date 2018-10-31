use v6.c;

use Pluggable;

use GTK::Builder::Base;

class GTK::BuilderWidgets does Pluggable {
  has @!plugins;
  has %!widgets;

  sub strip_mod($_) {
    my $a = $_.^name;
    $a ~~ s/^ 'GTK::Builder::' //;
    $a
  }

  submethod BUILD {
    @!plugins = plugins('GTK',
      plugins-namespace => 'Builder',
      name-matcher      => /^ 'GTK::Builder::' <!before 'Base' | 'Role'>/
    );
    for @!plugins.map( &strip_mod ) {
      require ::("GTK::Builder::{ $_ }");
      %!widgets{$_} = ::("GTK::Builder::{ $_ }");
    }
  }

  method list-plugins {
    %!widgets.keys;
  }

  method get-code-list($parser) {
    use Data::Dump::Tree;

    my @code;
    for $parser.List -> $o {
      # Skip any object that doesn't define its class.
      next without $o<objects><class>;
      #print 'P: ';
      #ddt $o;
      (my $w = $o<objects><class>) ~~ s/^ 'Gtk' //;
      # say $w;
      @code.append: %!widgets{$w}.create($o<objects>);
      @code.append: %!widgets{$w}.properties($o<objects>);
      if $o<objects><children>.elems {
        @code.append: self.get-code-list($_) for $o<objects><children>;
        my $vc = $o<objects>.deepmap(-> $c is copy { $c });
        $vc<children> .= grep( *<objects>.elems );
        @code.append: %!widgets{$w}.populate($vc);
      }
    }
    @code;
  }

}
