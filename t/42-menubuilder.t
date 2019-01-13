use v6.c;

use GTK::Application;

use GTK::Utils::MenuBuilder;

my $a = GTK::Application.new(
  title => 'org.genex.menubuilder', width => 150, height => 30
);

$a.activate.tap({
  my $menu = GTK::Utils::MenuBuilder.new(:bar, TOP => [
    File => [
      'Open'   => { 'do' => -> { say 'Open'   } },
      'Save'   => { 'do' => -> { say 'Close'  } },
      '-'      => False,
      Close    => { 'do' => -> { say 'Close'  } },
      Quit     => { 'do' => -> { $a.exit      } },
    ],

    Types => [
      'Normal'         => { 'do' => -> { say 'Normal' } },
      'Click'          => { :check },
      '-'              => False,
      'Radio 1-1'      => { :group<1> },
      'Radio 1-2'      => { :group<1> },
      'Radio 1-3'      => { :group<1> }
    ]
  ]);

  $a.window.destroy-signal.tap({ $a.exit });
  $a.window.add($menu.menu);
  $a.window.show_all;

  # Last chance setup via GTK::Application? -- Would this work?
  # $a.ready
});

$a.run;
