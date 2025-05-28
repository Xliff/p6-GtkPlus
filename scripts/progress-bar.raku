#!/usr/bin/env raku

#| A command-line program to display a customizable, colorful progress bar
#| Usage: raku progress-bar.raku <percentage>
#| Example: raku progress-bar.raku 75

use v6;

use Color;
use Terminal::Print <T>;
use Terminal::Print;
use Terminal::QuickCharts;

sub getHues ($n) {
  my $hues = (0...360).rotor(360 / $n, :partial).map( *.head );

  $hues.map({ Color.new( hsl => ($_, 78, 60) ) });
}

class ProgressLine {
  has $!row    is built;
  has $!color  is built;
  has $!text   is built;
  has $!value;

  submethod TWEAK {
    $!color //= 'white';
  }

  method set-label ($t is copy, :$draw = False) {
    $t = '…' ~ $t.substr(* - 29, 29)  if $t.chars > 30;
    $!text = $t;
    T.current-grid.set-span-text(0, $!row, ' ' x 30 );
    T.current-grid.set-span-text(0, $!row, $!text);
    self!draw if $draw;
    self;
  }

  method set-value ($v, :$draw = False) {
    $!value = $v;

    my $b = hbar-chart(
      $!value.Array,
      min       => 0,
      max       => 100,
      style     => %(
        max-width => 40
      )
    );

    T.current-grid.set-span( 32, $!row, $b.head, "{ $!color } on_75,75,75" );

    self!draw if $draw;
    self;
  }

  method !draw {
    print T.current-grid;
  }

}

#| Main entry point - parse arguments and display progress bar
multi sub MAIN {
    my $nc      = $*KERNEL.cpu-cores;
    my @rainbow = getHues($nc);
    my @values  = (25..100).pick($nc);
    T.initialize-screen;

    #try {
      #CATCH { default { } }

      my $k = 1;
      for @rainbow Z @values -> ($c, $v) {
        ProgressLine.new(
          color => $c.rgb.join(','),
          row   => $k.pred
        ).set-label("My Progress { $k++ }").set-value($v);
      }
      print T.current-grid;

      sleep 4;
    #}

    T.shutdown-screen;
}
