use v6.c;

use GTK::Raw::Types;

use GTK::Application;
use GTK::Box;
use GTK::Button;
use GTK::FlowBox;
use GTK::FlowBoxChild;

my $app = GTK::Application.new(
  title  => 'org.genex.test.widget',
  width  => 400,
  height => 400
);

my %sort-order;

$app.activate.tap({
  CATCH { default { .message.say; $app.exit } }

  my GTK::Button $exit .= new_with_label: <exit>;
  my GTK::Button $swap .= new_with_label: <swap>;
  $exit.clicked.tap: { $app.exit  };

  my GTK::Button $a .= new_with_label: <a>;
  my GTK::Button $b .= new_with_label: <b>;
  my GTK::Button $c .= new_with_label: <c>;
  my GTK::Button $d .= new_with_label: <d>;
  my GTK::Button $e .= new_with_label: <e>;
  my GTK::Button $f .= new_with_label: <f>;

  my @fbc;
  my @buttons = ($a, $b, $c, $d, $e, $f);
  @buttons.map({ .relief = GTK_RELIEF_NONE });

  my GTK::FlowBox $flowbox .= new;
  $flowbox.min_children_per_line = 3;
  $flowbox.max_children_per_line = 3;
  $flowbox.halign = GTK_ALIGN_START;
  $flowbox.valign = GTK_ALIGN_START;
  $flowbox.homogeneous = True;
  $flowbox.selection-mode = GTK_SELECTION_MULTIPLE;

  for @buttons -> $btn {
    @fbc.push: (my $fbc = GTK::FlowBoxChild.new);
    $fbc.add($btn);
    $flowbox.add: $fbc;
  }

  my $box = GTK::Box.new-vbox();
  $box.pack_start($flowbox, False, False, 0);
  $box.pack_start($swap, False, False, 0);
  $box.pack_start($exit, False, False, 0);

  sub reset-order {
    my $c = 0;
    for @fbc {
      %sort-order{ +.FlowBoxChild.p } = $c++;
      .changed;
    }
  }

  $swap.clicked.tap({
    @fbc = (@fbc[3..5], @fbc[0..2]).flat;
    reset-order();
  });

  reset-order();
  $flowbox.set-sort-func(-> $c1, $c2, $ --> gint {
    CATCH { default { .message.say } }
    my gint $r = %sort-order{ +$c1.p } <=> %sort-order{ +$c2.p };
    $r;
  });
  $app.window.add: $box;
  $app.show_all;
});

$app.run;
