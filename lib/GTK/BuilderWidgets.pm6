use v6.c;

use GTK::Raw::Types;

use Pluggable;

use GTK;
use GTK::Builder::Base;

class GTK::BuilderWidgets does Pluggable {
  has @!plugins;

  submethod BUILD {
    @!plugins = plugins('GTK',
      plugins-namespace => 'Builder',
      name-matcher      => /^ 'GTK::Builder::' <!before 'Base'>/
    );
  }

  method list-plugins {
    @!plugins.map({ my $a = $_.^name; $a ~~ s/^ 'GTK::Builder::' //; $a});
  }
}
