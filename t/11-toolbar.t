use v6.c;

use lib <t .>;

use GTK::Raw::Types;
use GTK::Compat::Types;

use GTK::Application;
use GTK::Grid;
use GTK::Image;
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

  for (
    ['document-new', 'New'],
    ['document-open', 'Open'],
    ['edit-undo', 'Undo'],
    ['view-fullscreen', 'Full-Screen'],
    ['view-restore', 'Restore']
  ) {
    %buttons{$_[0]} = GTK::ToolButton.new(
      GTK::Image.new_from_icon_name($_[0], icon_size),
      $_[1]
    );
    %buttons{$_[0]}.is_important = True;
    # Use of $_ in closures is STILL a bad idea.
    my $a = $_;
    %buttons{$_[0]}.clicked.tap({ say "$a[1] button clicked." });
    # Insure view buttons are inserted at the same position.
    my $num = $++;
    $tb.insert(%buttons{$_[0]}, $_[0] eq 'view-restore' ?? --$num !! $num);
  }

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
  $a.window.add($g);
  $a.window.show_all;
  %buttons<view-restore>.hide;
});

$a.run;
