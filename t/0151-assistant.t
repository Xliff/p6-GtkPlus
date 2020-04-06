use v6.c;

use GTK::Raw::Types;

use GTK::Application;
use GTK::Assistant;
use GTK::Calendar;
use GTK::Entry;
use GTK::TextView;

# Raku port of:
# https://github.com/bstpierre/gtk-examples/blob/master/python/assistant.py

my $a = GTK::Application.new( title => 'org.genex.assistant' );

$a.activate.tap({
  my $c = GTK::Calendar.new;
  my $e = GTK::Entry.new;
  my $t = GTK::TextView.new;
  my $assistant = GTK::Assistant.new;

  $t.editable  = False;
  $t.text = q:to/TEXT/;
  You chose to:
    * Frobnicate the foo.
    * Reverse the glop.
    * Enable future auto-frobnication.
  TEXT

  for $c, $e, $t {
    $assistant.append-page($_);
    .show;
  }

  given $assistant {
    .set-page-type($c, GTK_ASSISTANT_PAGE_INTRO);
    .set-page-title($c, 'This is an assistant.');

    .set-page-type($e, GTK_ASSISTANT_PAGE_CONTENT);
    .set-page-title($e, 'Enter some information on this page.');
    .set-page-complete($e, True);

    .set-page-type($t, GTK_ASSISTANT_PAGE_SUMMARY);
    .set-page-title($t, 'Congratulations, your done!');

    .cancel.tap({ $a.exit });
    .close.tap({ $a.exit });
  }

  # cw: Long experience has taught me that using $_ in closures is
  #     bad juju!
  $c.day-selected.tap(-> *@a { $assistant.set-page-complete($c, True) });

  $assistant.show;
});

$a.run;
