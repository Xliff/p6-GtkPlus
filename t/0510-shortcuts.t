use v6.c;

use GTK::Application;
use GTK::Builder;

my $prefix;
BEGIN {
  $prefix = 'shortcuts'.IO;
  $prefix = 't'.IO.add('shortcuts') unless $prefix.e;
}

# Port of the shortcuts exmaple from the GTK3 demo located in its source
# package at demos/gtk-demo/

my %callback-called;

sub show-shortcuts ($w, $id, $v) {
  # Not using resources locations.
  my $sid = $id.split('_')[0];
  my $c = 'shortcuts-' ~ $sid;

  my $b = GTK::Builder.new-from-file( $prefix.add("{$c}.ui") );
  my $o = $b{$c};

  $o.transient-for = $w;
  $o.prop_set_string('view-name', $v // Str);
  $o.show;
  $o.destroy-signal.tap({ %callback-called{$id} = Nil });
}

my $a = GTK::Application.new( title => 'org.genex.shortcuts-builder' );

$a.activate.tap({
  CATCH { default { .message.say; } }

  # Not using resources locations.
  my $b = GTK::Builder.new-from-file( $prefix.IO.add('shortcuts.ui') );

  my @callbacks = <
    builder_shortcuts
    gedit_shortcuts
    clocks_shortcuts
    clocks_shortcuts_stopwatch
    boxes_shortcuts
    boxes_shortcuts_wizard
    boxes_shortcuts_display
  >;

  # Debouncing signal mechanism.
  my $l = Lock.new;
  for @callbacks {
    .say;
    # Convert loop var to lexical!
    my $sym = $_;

    $b.add-callback-symbol($sym, -> *@a {
      CATCH { default { .message.say; } }

      my $i-set-it = False;
      $l.protect: {
        $i-set-it = %callback-called{$sym} = 1 unless %callback-called{$sym};
      };

      unless $i-set-it && %callback-called{$sym} {
        my $view = $sym.split('_')[2] // Nil;
        show-shortcuts($a.window, $sym, $view);
      }
    });
  }

  $b.connect-signals;
  $b<window1>.destroy-signal.tap({ $a.exit });
  $b<window1>.show_all;
});

$a.run;
