use v6.c;

use GTK::Compat::Value;
use GTK::Raw::Types;

use GTK::Application;
use GTK::Box;
use GTK::CellRendererText;
use GTK::Statusbar;
use GTK::TreeView;
use GTK::TreeViewColumn;
use GTK::TreeSelection;
use GTK::TreeStore;

sub on_changed {
  my GtkTreeIter $iter .= new;
  my $v = GTK::Compat::Value(G_TYPE_STRING);

  if $*ts.get_selected($*model, $iter) {
    $*model.get_value($iter, 0, $gv);
    $*sb.push( $*sb.get_context($gv.string) );
  }
}

sub create_and_fill {
  my ($toplevel, $child) = (GtkTreeIter.new, GtkTreeIter.new);

  sub g_str(Str $s) {
    my $gv = GTK::Compat::Value.new( G_TYPE_STRING );
    $gv.string = $s;
    $gv;
  }

  $*ts = GTK::TreeStore.new(1, G_TYPE_STRING);
  $*ts.append($toplevel);
  $*ts.set_value( $toplevel, 0, g_str('Scripting Languages') );
  for <Python Perl PHP> {
    $*ts.append($child, $toplevel);
    $*ts.set_value( $child, 0,  g_str($_) );
  }

  $*ts.append($toplevel);
  $*ts.set_value( $toplevel, 0, g_str('Compiled Languages') );
  for <C C++ Java Perl6> {
    $*ts.append($child, $toplevel);
    $*ts.set_value( $child, 0,  g_str($_) );
  }
}

sub create_view_model {
  $*v   = GTK::TreeView.new;
  $*col = GTK::TreeViewColumn.new;
  $*r   = GTK::CellRendererText.new;
  $*col.title = 'Programming Languages';
  $*v.append_column($*col);
  $*col.pack_start($*r, True);
  $*col.add_attribute($*r, 'text', 0);
  create_and_fill;
  $*v.model = $*ts;
}

my $a = GTK::Application.new(
  title  => 'org.genex.treeview',
  width  => 350,
  height => 300
);

$a.activate.tap({
  $a.window.position = GTK_WIN_POS_CENTER;
  $a.window.title = 'Tree view';
  $*vbox = GTK::Box.new-vbox(2);
  $a.window.add($*vbox);
  create_view_model;
  $*s = $*v.get_sleection;
  $vbox.pack_start($*v, True, True, 1);
  $*sb.changed.tap({ on_changed; });

  $a.window.show_all;
});

$a.run;
