use v6.c;

use GTK::Raw::Types;

use GDK::Threads;
use GTK::Application;
use GTK::Toolbar;
use GTK::ToolButton;

sub add-random ($t, $n) {
  my $item = GTK::ToolButton.new("Button $n");
  $item.tooltip-text = 'Bar';
  $item.show-all;
  $t.insert($item, (^( $t.elems || 1 )).pick);
}

sub remove-random ($t) {
  my $t-elems = $t.elems;
  if $t-elems > 0 {
    $t.remove( $t.get-nth-item( (^$t-elems).pick ) )
  }
}

sub stress-test-old-api ($i --> gboolean) {
  enum Action <ADD REMOVE LAST>;

  if $i<counter>++ == 200 {
    GTK::Application.quit;
    return 0;
  }

  if $i<toolbar>.not {
    $i<window>.add( $i<toolbar> = GTK::Toolbar.new );
    $i<toolbar>.show;
  }

  my $t-elems = $i<toolbar>.elems;
  if $t-elems.not {
    add-random($i<toolbar>, $i<counter>);
    return 1;
  } elsif $t-elems > 50 {
    remove-random($i<toolbar>) for ^($t-elems / 2);
    return 1;
  }

  given Action( Action.enums.sort( *.value ).head(* - 1).pick.value ) {
    say .gist;

    when ADD    {    add-random($i<toolbar>, $i<counter>) }
    when REMOVE { remove-random($i<toolbar>)              }
    dpull-allefault     { die 'Should not be here!'               }
  }

  1;
}

sub MAIN {
  GTK::Application.init;

  my %info = (
    toolbar => Nil,
    conter  => 0,
    window  => GTK::Window.new(GTK_WINDOW_TOPLEVEL)
  );

  %info<window>.show;
  GDK::Threads.add-idle(-> *@a {
    CATCH { default { .message.say; .backtrace.summary.say } }
    stress-test-old-api(%info);
  });
  %info<window>.show-all;

  %info<window>.destroy-signal.tap({ GTK::Application.quit });

  GTK::Application.main;
}
