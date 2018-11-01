use v6.c;

use Pluggable;

use GTK::Builder::Base;

class GTK::BuilderWidgets does Pluggable {
  has @!plugins;
  has %!widgets;
  has $!var;

  sub strip_mod($_) {
    my $a = $_.^name;
    $a ~~ s/^ 'GTK::Builder::' //;
    $a
  }

  submethod BUILD(:$var) {
    $!var = $var;
    @!plugins = plugins('GTK',
      plugins-namespace => 'Builder',
      name-matcher      => /^
        'GTK::Builder::'
        <!before 'Base' | 'MRO' | 'Role'>/
    );
    for @!plugins.map( &strip_mod ) {
      require ::("GTK::Builder::{ $_ }");
      %!widgets{$_} = ::("GTK::Builder::{ $_ }");
    }
  }

  method get-widget-list {
    %!widgets.keys;
  }

  method var-temp {
    "\%\%{ $!var }<\%s>"
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
      #say $w;
      @code.append: %!widgets{$w}.create(self.var-temp, $o<objects>);
      @code.append: %!widgets{$w}.properties(self.var-temp, $o<objects>);
      if $o<objects><children>.elems {
        @code.append: self.get-code-list($_) for $o<objects><children>;
        my $vc = $o<objects>.deepmap(-> $c is copy { $c });
        $vc<children> .= grep( *<objects>.elems );
        @code.append: %!widgets{$w}.populate(self.var-temp, $vc);
      }
    }
    @code;
  }

}
