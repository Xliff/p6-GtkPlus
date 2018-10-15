use v6.c;

use GTK::Compat::Value;
use GTK::Compat::Types;
use GTK::Raw::Types;

use GTK::Application;
use GTK::Box;
use GTK::CellRendererText;
use GTK::Statusbar;
use GTK::TreeView;
use GTK::TreeViewColumn;
use GTK::TreeSelection;
use GTK::TreeStore;

# Dynamic variables do not apply in closures?
my ($ts, $sb);

sub on_changed($s) {
  my ($model, $iter) = $s.get_selected;
  if $model.defined && $iter.defined {
    my $gv = $ts.get_value($iter, 0);
    $sb.push( $sb.get_context_id($gv.string), $gv.string );
  }
}

sub create_and_fill {
  my ($toplevel, $child) = (GtkTreeIter.new, GtkTreeIter.new);

  $ts = GTK::TreeStore.new(G_TYPE_STRING);
  $ts.append($toplevel);
  $ts.set_value( $toplevel, 0, g_str('Scripting Languages') );
  for <Python Perl PHP> {
    $ts.append($child, $toplevel);
    $ts.set_value( $child, 0,  g_str($_) );
  }

  $ts.append($toplevel);
  $ts.set_value( $toplevel, 0, g_str('Compiled Languages') );
  for <C C++ Java Perl6> {
    $ts.append($child, $toplevel);
    $ts.set_value( $child, 0,  g_str($_) );
  }
}

sub create_view_model {
  my $r =  GTK::CellRendererText.new;
  my $col = GTK::TreeViewColumn.new;
  $*v   = GTK::TreeView.new;
  $col.title = 'Programming Languages';
  $*v.append_column($col);
  $col.pack_start($r, True);
  $col.add_attribute($r, 'text', 0);
  create_and_fill;
  $*v.model = $ts;
}

my $a = GTK::Application.new(
  title  => 'org.genex.treeview',
  width  => 350,
  height => 300
);

$a.activate.tap({
  my ($*v, $*col, $*r, $vbox, $s);

  $a.window.set_position(GTK_WIN_POS_CENTER);
  $a.window.title = 'Tree view';
  $vbox = GTK::Box.new-vbox(2);
  $a.window.add($vbox);
  create_view_model;
  $s = $*v.get_selection;
  $vbox.pack_start($*v, True, True, 1);
  $sb = GTK::Statusbar.new;
  $vbox.pack_start($sb, False, True, 1);
  $s.changed.tap({ on_changed($s); });

  $a.window.show_all;
});

$a.run;
