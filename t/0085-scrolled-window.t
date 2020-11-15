use v6.c;

use GTK::Raw::Types;

use GLib::String;
use GTK::Adjustment;
use GTK::Application;
use GTK::Box;
use GTK::Scrollbar;
use GTK::ScrolledWindow;
use GTK::TextBuffer;
use GTK::TextView;
use GTK::Widget;
use GTK::Window;

sub fill-text-view ($tv, $t) {
  my $s = GLib::String.new;
  $s.append("{ $t }: { $_ }\n") for ^200;
  $tv.text = $s.free;
}

sub MAIN {
  GTK::Application.init;

  my $win = GTK::Window.new(GTK_WINDOW_TOPLEVEL);
  $win.set-default-size(640, 480);

  my $box = GTK::Box.new-hbox(5);
  $win.add($box);

  my $sw-l = GTK::ScrolledWindow.new;
  $sw-l.set-policy(GTK_POLICY_NEVER, GTK_POLICY_EXTERNAL);
  $box.pack-start($sw-l, True, True);

  my $tv-l = GTK::TextView.new;
  fill-text-view($tv-l, 'Left');
  $sw-l.add($tv-l);

  my $adj = $sw-l.vadjustment;
  my $sw-m = GTK::ScrolledWindow.new(GtkAdjustment, $adj);
  $sw-m.set-policy(GTK_POLICY_NEVER, GTK_POLICY_EXTERNAL);
  $box.pack-start($sw-m, True, True);

  my $tv-m = GTK::TextView.new;
  fill-text-view($tv-m, 'Middle');
  $sw-m.add($tv-m);

  my $sw-r = GTK::ScrolledWindow.new(GtkAdjustment, $adj);
  $sw-r.set-policy(GTK_POLICY_NEVER, GTK_POLICY_EXTERNAL);
  $box.pack-start($sw-r, True, True);

  my $tv-r = GTK::TextView.new;
  fill-text-view($tv-r, 'Right');
  $sw-r.add($tv-r);

  my $sb = GTK::Scrollbar.new-vbar($adj);
  $box.add($sb);
  $win.show-all;

  GTK::Application.main;
}
