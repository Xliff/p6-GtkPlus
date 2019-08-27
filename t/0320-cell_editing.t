use v6.c;

use GTK::Compat::Types;
use GTK::Raw::Types;

use GTK::Application;
use GTK::Box;
use GTK::Button;
use GTK::CellRendererCombo;
use GTK::CellRendererProgress;
use GTK::CellRendererText;
use GTK::Label;
use GTK::ListStore;
use GTK::ScrolledWindow;
use GTK::TreeIter;
use GTK::TreePath;
use GTK::TreeView;

my enum Cols <COLUMN_ITEM_NUMBER COLUMN_ITEM_PRODUCT COLUMN_ITEM_YUMMY>;

sub set_values($model, $iter, $i) {
  my $idx = 0;
  for $i.Array -> $e {
    my $v = GTK::Compat::Value.new(do given $e {
      when Str { G_TYPE_STRING }
      default  { G_TYPE_UINT   }
    });
    given $idx {
      when 0 | 2 {   $v.uint = $e }
      default    { $v.string = $e }
    }
    $model.set_value($iter, $idx++, $v)
  }
}

sub create_items_model {
  my @items = (
    [ 3,                    'bottles of coke', 20],
    [ 5,                'packages of noodles', 50],
    [ 2, 'packages of chocolate chip cookies', 90],
    [ 1,           'can of vanilla ice cream', 60],
    [ 6,                               'eggs', 10]
  );

  my $model = GTK::ListStore.new(
    G_TYPE_INT, G_TYPE_STRING, G_TYPE_INT, G_TYPE_BOOLEAN
  );
  for @items -> $i {
    my $iter = $model.append;
    set_values($model, $iter, $i);
  }
  $model;
}

sub create_numbers_model {
  my $model = GTK::ListStore.new(G_TYPE_STRING, G_TYPE_INT);
  for ^10 {
    my $iter = $model.append;
    my $v = GTK::Compat::Value.new(G_TYPE_STRING);

    $v.string = $_;
    $model.set_value($iter, 0, $v);
  }
  $model;
}

sub add_item ($v, $m) {
  # GTK::TreeView.get_cursor() returns list, so assignment must be list.
  my $iter = GtkTreeIter.new;

  my ($p, $) = $v.get_cursor;
  given $p {
    when .defined {
      my $c = $m.get_iter($$p);
      $m.insert_after($iter, $c);
    }
    default {
      $m.insert($iter, -1);
    }
  }
  set_values( $m, $iter, [0, 'Description here', 50] );
  $p = $m.get_path($iter);

  my $col = $v.get_column(0);
  $v.set_cursor($p, $col, False);
  $p.free;
}

sub remove_item($v, $m) {
  my $iter = GtkTreeIter.new;
  my $s = $v.selection;

  # GTK::TreeSelection returns a list, so assignment must be, as well. Note
  # that this list will be pointers and not objects!
  ($, $iter) = $s.selected;
  with $iter {
    # Commented lines removed because they serve no purpose in THIS example.
    #my $p = $m.get_path($iter);
    #my $i = $p.get_indices()[1];
    $m.remove($iter);
    #$p.free;
  }
}

sub cell_edited($c, $m, $col, $ps, $nt) {
  my $p = GTK::TreePath.new_from_string($ps);
  my $iter = $m.get_iter($p);
  # Still not sure why this does not work, but it can be worked around, in
  # this instance.
  #my $col = $c.get_data_uint('column');
  my $idx = $p.get_indices()[1];

  my $v = GTK::Compat::Value.new($col == 0 ?? G_TYPE_INT !! G_TYPE_STRING);
  if $col == 0 {
    $v.int = $nt;
  } elsif $col == 1 {
    # Should free the old value, but currently can't get the direct pointer.
    $v.string = $nt;
  }
  $m.set_value($iter, $col, $v);
  $p.free;
}

sub add_columns($v, $mi, $mn) {
  my $r1 = GTK::CellRendererCombo.new;
  $r1.model = $mn;
  $r1.text-column = 0;
  $r1.has-entry = False;
  $r1.editable = True;
  $r1.edited.tap(-> *@a {
    cell_edited( $r1, $mi, COLUMN_ITEM_NUMBER, |@a[1..2] )
  });
  $r1.editing-started.tap(-> *@a {
    GTK::ComboBox.new(@a[1]).set_row_separator_func(-> *@b --> guint {
      my $p = $mn.get_path(@b[1]);
      # This is NOT supposed to be a 1-based array, but somehow that's what
      # we are given. This still might be an issue with CArray, and the
      # valgrind tests may happen sooner, rather than later.
      my $idx = ($p.get_indices())[1];
      $p.free;
      ($idx == 5).Int;
    })
  });
  #$r1.set_data_uint('column', COLUMN_ITEM_NUMBER);
  $v.insert_column_with_attributes(
    -1, 'Number', $r1, 'text', COLUMN_ITEM_NUMBER
  );

  my $r2 = GTK::CellRendererText.new;
  $r2.editable = True;
  $r2.edited.tap(-> *@a {
    cell_edited($r2, $mi, COLUMN_ITEM_PRODUCT, |@a[1..2] )
  });
  #$r2.set_data_uint('column', COLUMN_ITEM_PRODUCT);
  $v.insert_column_with_attributes(
    -1, 'Product', $r2, 'text', COLUMN_ITEM_PRODUCT
  );

  my $r3 = GTK::CellRendererProgress.new;
  #$r3.set_data_uint('column', COLUMN_ITEM_YUMMY);
  $v.insert_column_with_attributes(
    -1, 'Yummy', $r3, 'value', COLUMN_ITEM_YUMMY
  );

}

my $a = GTK::Application.new( title => 'org.genex.editable_cells' );
$a.activate.tap({
  my $vbox = GTK::Box.new-vbox(5);
  my $sw = GTK::ScrolledWindow.new;
  my $hbox = GTK::Box.new-hbox(4);
  my $ab = GTK::Button.new-with-label('Add item');
  my $rb = GTK::Button.new-with-label('Remove item');
  my $l = GTK::Label.new( 'Shopping list (you can edit the cells!)' );

  $a.window.title = 'Editable Cells';
  $a.window.border-width = 5;
  $a.window.set_default_size(320, 200);
  $a.window.add($vbox);

  $sw.shadow_type = GTK_SHADOW_ETCHED_IN;
  $sw.set_policy(GTK_POLICY_AUTOMATIC, GTK_POLICY_AUTOMATIC);
  $vbox.pack_start($l);
  $vbox.pack_start($sw, True, True);
  $vbox.pack_start($hbox);

  my ($mi, $mn) = ( create_items_model(), create_numbers_model() );
  my $tv = GTK::TreeView.new_with_model($mi);
  $tv.selection.mode = GTK_SELECTION_SINGLE;
  add_columns($tv, $mi, $mn);
  $sw.add($tv);
  $hbox.homogeneous = True;
  $hbox.pack_start($_, True, True) for $ab, $rb;
  $ab.clicked.tap({ add_item($tv, $mi)    });
  $rb.clicked.tap({ remove_item($tv, $mi) });

  $a.window.show_all;
});

$a.run;
