use v6.c;

use GTK::Application;
use GTK::Raw::Types;
use GTK::Toolbar;
use GTK::ToolButton;
use GTK::ToolItem;

use Data::Dump::Tree;

constant icon_size := GTK_ICON_SIZE_LARGE_TOOLBAR;

my $a = GTK::Application.new(
  title => 'org.genex.toolbar',
  width => 400,
  height => 50
);

$a.activate.tap({
  my %buttons;
  my %icons;
  my $tb = GTK::Toolbar.new;
  my $g = GTK::Grid.new;

  for <document-new document-open edit-undo view-fullscreen> {
    my $label = do {
      when 'document-new'    { 'New'  }
      when 'document-open'   { 'Open' }
      when 'edit-undo'       { 'Undo' }
      when 'view-fullscreen' { 'Full-Screen' }
    }
    %icons{$_} = GTK::Image.new_from_icon_name($_, icon_size);
    %buttons{$_} = GTK::ToolButton.new(%icons{$_}, $label);
    %buttons{$_}.clicked.tap({ say "$label button clicked." });
    $tb.insert(%buttons{$_}, $++);
  }
  %buttons<document-new>.is_important = True;
  %buttons<document-open>.is_important = True;
  %buttons<edit-undo>.is_important = True;
  %buttons<view-fullscreen>.is_important = True;
  $tb.hexpand = True;
  $g.attach($tb, 1, 1, 1, 1);
  $a.window.destroy-signal.tap({ $a.exit; });
  $a.window.add($g);
  $a.window.show_all;
});

$a.run;
