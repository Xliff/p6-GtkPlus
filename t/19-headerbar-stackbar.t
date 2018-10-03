use v6.c;

# Ported from:
# https://mail.gnome.org/archives/gtk-list/2015-July/txtmxeqccFwH7.txt

use GTK::Raw::Types;

use GTK::Application;
use GTK::Box;
use GTK::Button;
use GTK::HeaderBar;
use GTK::Image;
use GTK::Label;
use GTK::Stack;

my @titles = (
  'Welcome to GTK+',
  'GtkStackSidebar Widget',
  'Automatic navigation',
  'Consistent appearance',
  'Scrolling',
  'Page 6',
  'Page 7',
  'Page 8',
  'Page 9'
);

my $a = GTK::Application.new(
  title  => 'org.genex.headerbar_sidebar',
  width  => 500,
  height => 350
);

$a.activate.tap({
  my ($h, $sb, $s, $b, $btn, $sp) = (
    GTK::HeaderBar.new,
    GTK::StackSidebar.new,
    GTK::Stack.new(:sidebar),
    GTK::Box.new-hbox,
    GTK::Button.new_with_label('Test Button'),
    GTK::Separator.new(:vertical)
  );

  $h.show_close_button = True;
  $s.transition_type = GTK_STACK_TRANSITION_TYPE_SLIDE_UP_DOWN;
  $a.window.title = 'Stack Sidebar';
  $b.pack_start($s.sidebar, False, False, 0);
  $b.pack_start($sp, False, False, 0);
  $b.pack_start($s, True, True, 0);

  my $e;
  my @pages;
  for @titles.kv -> $k, $v {
    my $w;

    if !$k {
      $w = GTK::Image.new_from_icon_name('help-about', GTK_ICON_SIZE_MENU);
      $w.pixel_size = 256;
    } else {
      $w = GTK::Label.new($v);
    }
    $s.add_named($w, $v);
    # cw: This is new code on my part. I wonder if this is the behavior
    # that was intended.
    @pages.push: $w;
    #$s.child_set($w, 'title', $v, Nil); # May be problematic.
  }

  my $cur_page = 1;
  $btn.clicked.tap({
    # cw - Original code:
    # say 'Hello World';
    # $s.visible_child = $e
    # cw - My interpretation:
    $s.visible_child = @pages[$cur_page++ % @pages];
  });
  $b.add($btn);
  $a.window.add($b);
  $a.window.show_all;
  $s.sidebar.hide;
});

$a.run;
