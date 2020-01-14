use v6.c;

# Shamelessly ripped off from:
# https://github.com/davidt/gtk/blob/master/demos/gtk-demo/iconview.c

use GTK::Raw::Types;

use GDK::Pixbuf;
use GTK::Application;
use GTK::Box;
use GTK::IconView;
use GTK::Image;
use GTK::ListStore;
use GTK::TreeIter;
use GTK::TreePath;
use GTK::ScrolledWindow;
use GTK::Toolbar;
use GTK::ToolButton;
use GTK::Window;

my enum Columns <
  COL_PATH
  COL_DISPLAY_NAME
  COL_PIXBUF
  COL_IS_DIRECTORY
  NUM_COLS
>;

my @nd_types = (G_TYPE_STRING, G_TYPE_BOOLEAN);
my @nd_cols = (COL_DISPLAY_NAME, COL_IS_DIRECTORY);

my ($parent, %pixbufs, $store, $icon_view, $up_button, $pb_type);

sub load_pixbufs {
  return if %pixbufs;

  my  $dir-image = 'gnome-fs-directory.png';
  my $file-image = 'gnome-fs-regular.png';
  $file-image = "t/{$file-image}" unless $file-image.IO.e;
   $dir-image = "t/{$dir-image}" unless $dir-image.IO.e;

  %pixbufs<file>   = GTK::Image.new_from_file($file-image);
  %pixbufs<folder> = GTK::Image.new_from_file($dir-image);
}

sub fill_store {
  my $iter = GtkTreeIter.new;

  $store.clear;
  for dir($parent.path) {
    my %data = (
      0 => GLib::Value.new(G_TYPE_STRING) ,
      1 => GLib::Value.new(G_TYPE_STRING) ,
      #2 => GLib::Value.new($pb_type),
      2 => GLib::Value.new(G_TYPE_OBJECT) ,
      3 => GLib::Value.new(G_TYPE_BOOLEAN),
    );
    %data<0>.string  = .path;
    %data<1>.string  = .basename;
    %data<2>.object  = .d ??
      %pixbufs<folder>.get_pixbuf !! %pixbufs<file>.get_pixbuf;
    %data<3>.boolean = .d;

    $store.append($iter);
    # $store.set_values($iter, %data);
    $store.set_value($iter, $_, %data{$_}) for %data.keys;
  }
}

sub sort_func ($m, $a, $b --> gint) {
  my ($da, $db, $na, $nb);

  ($na, $da) = $m.get($a, @nd_types, @nd_cols);
  ($nb, $db) = $m.get($b, @nd_types, @nd_cols);

  return  1 if !$da.value &&  $db.value;
  return -1 if  $da.value && !$db.value;

  return ($na.value // '') cmp ($nb.value // '');
}

sub create_store {
  my @types = (
    G_TYPE_STRING,
    G_TYPE_STRING,
    GTK::Compat::Pixbuf.get_type(),
    G_TYPE_BOOLEAN
  );

  $store = GTK::ListStore.new(@types);
  $store.set_default_sort_func(-> $, $a, $b, $ {
    sort_func($store, $a, $b);
  });
  $store.set_sort_column_id(
    GTK_TREE_SORTABLE_DEFAULT_SORT_COLUMN_ID, GTK_SORT_ASCENDING
  );
}

sub item_activated ($iv, $tp, $ud, $r) {
  my $iter = GtkTreeIter.new;
  my @ndc = (COL_PATH, COL_IS_DIRECTORY);

  $store.get_iter($iter, $tp);
  my ($p, $d) = $store.get($iter, @nd_types, @ndc);
  return unless $d.value;

  $parent = $p.value.IO;
  fill_store();
  $up_button.sensitive = True;
}

sub up_clicked {
  $parent = $parent.parent;
  fill_store();
  $up_button.sensitive = $parent.path ne '/';
}

sub home_clicked {
  $parent = $*HOME;
  fill_store();
  $up_button.sensitive = $parent.path ne '/';
}

my $a = GTK::Application.new( title => 'org.genex.iconview' );

$a.activate.tap({
  my ($vbox, $toolbar, $home_button, $sw);

  $a.window.title = 'GtkIconView Demo';
  $a.window.set_size_request(750,300);
  load_pixbufs;

  $vbox = GTK::Box.new-vbox();
  $a.window.add($vbox);
  $toolbar = GTK::Toolbar.new();
  $vbox.pack_start($toolbar);
  $up_button = GTK::ToolButton.new(
    GTK::Image.new_from_icon_name('go-up', GTK_ICON_SIZE_SMALL_TOOLBAR),
    ''
  );
  $up_button.is_important = True;
  $up_button.sensitive = False;
  $toolbar.insert($up_button);
  $home_button = GTK::ToolButton.new(
    GTK::Image.new_from_icon_name('gtk-home', GTK_ICON_SIZE_SMALL_TOOLBAR),
    ''
  );
  $home_button.is_important = True;
  $toolbar.insert($home_button);
  $sw = GTK::ScrolledWindow.new;
  $sw.set_policy(GTK_POLICY_AUTOMATIC, GTK_POLICY_AUTOMATIC);
  $vbox.pack_start($sw, True, True);

  $parent = '/'.IO;
  create_store;
  fill_store;
  $icon_view = GTK::IconView.new_with_model($store);
  $icon_view.selection_mode = GTK_SELECTION_MULTIPLE;

    $up_button.clicked.tap({ up_clicked   });
  $home_button.clicked.tap({ home_clicked });

  $icon_view.item-activated.tap(-> *@a { item_activated(|@a) });

  $icon_view.text_column = COL_DISPLAY_NAME;
  $icon_view.pixbuf_column = COL_PIXBUF;

  $sw.add($icon_view);
  $icon_view.grab_focus;

  $a.window.show_all;
});

$a.run;
