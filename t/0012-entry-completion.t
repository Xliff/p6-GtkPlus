use v6.c;

use GTK::Raw::Types;

use GLib::Value;
use GTK::Application;
use GTK::Box;
use GTK::Button;
use GTK::Entry;
use GTK::EntryCompletion;
use GTK::Label;
use GTK::ListStore;

my $a = GTK::Application.new( title => 'org.genex.entry-completion' );

$a.activate.tap({
  $a.wait-for-init;

  my $vbox   = GTK::Box.new-vbox;
  my $entry  = GTK::Entry.new;
  my $button = GTK::Button.new-with-label('Close');
  my $label  = GTK::Label.new(q:to/L/);
    Press a or b to see a list of possible completions and actions
    L

  given $button {
    .can_default = True;
    .clicked.tap({ $a.exit });
  }

  my $store = GTK::ListStore.new(
    G_TYPE_UINT,
    G_TYPE_STRING
  );

  my @names = «
    "Alan Zebedee"
    "Adrian Boo"
    "Bob McRoberts"
    "Bob McBob"
  »;

  for @names.kv -> $i, $n {
    $store.append-with-values({
      0 => gv-int($i + 1),
      1 => gv-str($n)
    });
  }

  my @actions = «
    'Use Wizard'
    'Browse for Filename'
  »;

  given (my $entry-completion = GTK::EntryCompletion.new) {
    for @actions.kv -> $k, $v {
      .insert-action-text($k, $v);
    }
    .model = $store;
    .text-column = 1;
    .action-activated.tap(-> *@a {
      say "Action selected: { @actions[ @a[1] ] }";
    });
  }
  
  $store.foreach(-> $m, $p, $i, $ud --> gboolean {
    my $model = GTK::Roles::TreeModel.new-treemodel-obj($m);

    $model.get_value($i, 1).value.say;
    0;
  });

  $entry.completion = $entry-completion;
  $vbox.pack_start($_) for $entry, $label, $button;

  # Emits a warning about widget not within a window!
  #$button.grab_default;

  $a.window.add($vbox);
  $a.window.title = 'GTK::EntryCompletion';
  $a.window.show_all;
});

$a.run;
