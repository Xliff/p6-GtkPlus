use v6.c;

use lib <t .>;

use GTK::Application;
use GTK::Raw::Types;
use GTK::Compat::Types;
use GTK::Toolbar;
use GTK::ToolButton;
use GTK::ToolItem;

use toolbar_example;

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
  my $window = $a.window.window;
  my $full = False;
  my (@win_size, @screen_size);
  my $screen = gdk_screen_get_default();

  @screen_size = (
    gdk_screen_get_width($screen),
    gdk_screen_get_height($screen)
  );
  @win_size = $a.window.get_size;
  sprintf("Screen: %d x %d", @screen_size.List).say;
  sprintf("Window: %d x %d", @win_size.List).say;

  sub toggle-screen {
    if $full {
      $a.window.resize(|@win_size);
    } else {
      $a.window.resize(|@screen_size);
    }
    $full = !$full;
  }

  for <
    document-new
    document-open
    edit-undo
    view-fullscreen
    view-restore
  > {
    my $label = do {
      when 'document-new'    { 'New'  }
      when 'document-open'   { 'Open' }
      when 'edit-undo'       { 'Undo' }
      when 'view-fullscreen' { 'Full-Screen' }
      when 'view-restore'    { 'Restore' }
    }
    %icons{$_} = GTK::Image.new_from_icon_name($_, icon_size);
    %buttons{$_} = GTK::ToolButton.new(%icons{$_}, $label);
    %buttons{$_}.clicked.tap({ say "$label button clicked." });
    my $num = $++;
    $tb.insert(%buttons{$_}, $_ eq 'view-restore' ?? --$num !! $num);
  }
  %buttons<document-new>.is_important = True;
  %buttons<document-open>.is_important = True;
  %buttons<edit-undo>.is_important = True;
  %buttons<view-fullscreen>.is_important = True;
  %buttons<view-restore>.is_important = True;

  %buttons<view-fullscreen>.clicked.tap({
    toggle-screen;
    %buttons<view-fullscreen>.hide;
    %buttons<view-restore>.show;
  });

  %buttons<view-restore>.clicked.tap({
    toggle-screen;
    %buttons<view-restore>.hide;
    %buttons<view-fullscreen>.show;
  });

  $a.window.title = 'ToolBar Example';
  $tb.hexpand = True;
  $g.attach($tb, 1, 1, 1, 1);
  $a.window.destroy-signal.tap({ $a.exit; });
  $a.window.add($g);
  $a.window.show_all;
  %buttons<view-restore>.hide;
});

$a.run;
