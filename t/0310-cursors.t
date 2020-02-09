use v6.c;

use GTK::Raw::Types;

use GDK::Cursor;

use GTK::Application;
use GTK::Box;
use GTK::Button;
use GTK::FlowBox;
use GTK::Image;
use GTK::Label;
use GTK::ScrolledWindow;

my $app;

sub add_section($b, $h) {
  my $l = GTK::Label.new($h);
  $l.xalign = 0;
  $l.margin_top  = $l.margin_bottom = 10;
  $b.pack_start($l, False, True);

  my $s = GTK::FlowBox.new;
  $s.halign = GTK_ALIGN_START;
  $s.selection_mode = GTK_SELECTION_NONE;
  ($s.min_children_per_line, $s.max_children_per_line) = (2, 20);
  $b.pack_start($s, False, True);
  $s;
}

sub add_button($s, $css) {
  my $i = GTK::Image.new_from_icon_name('image-missing', GTK_ICON_SIZE_MENU);
  my $d = $s.display;
  my $c = GDK::Cursor.new_from_name($d, $css);
  with $c {
    my $cn = "cursors/{ $css.subst('-', '_', :g) }_cursor.png";
    $cn = "t/{$cn}" unless $cn.IO.e;
    if $cn.IO.e {
      $i = GTK::Image.new_from_file($cn);
    } else {
      warn "Could not find icon file { $cn }";
    }
  }
  $i.set_size_request(32, 32);

  my $b = GTK::Button.new;
  $b.add($i);
  $b.style_context.add_class('image-button');
  $b.clicked.tap({
    say "A: { $app.window.getType }";
    say "W: { GTK::Widget.getType( cast( GObject, $b.toplevel(:raw) ) ) }";
    say "B: { $b.getType }";
    say "W0: { GTK::Window.new.getType }";
    say "A0: { GTK::ApplicationWindow.new($app).getType }";
    $b.toplevel.window.cursor = $c;
  });
  $b.tooltip_text = $css;
  $s.add($b);
}

$app = GTK::Application.new( title => 'org.genex.cursors', window => 'window' );

$app.activate.tap({
  $app.window.title = 'Cursors';
  $app.window.set_default_size(500, 500);

  my $sw = GTK::ScrolledWindow.new;
  $sw.set_policy(GTK_POLICY_NEVER, GTK_POLICY_AUTOMATIC);
  $app.window.add($sw);

  my $b = GTK::Box.new-vbox(0);
  ($b.margin_start, $b.margin_end, $b.margin_bottom) = (20, 20, 10);
  $sw.add($b);

  my @sections;
  my @h = (
    'General'            => <default none>,
    'Link & Status'      => <context-menu help pointer progress wait>,
    'Selection'          => <cell crosshair text vertical-text>,
    'Drag & Drop'        => <
      alias copy move no-drop not-allowed grab grabbing
    >,
    'Resize & Scrolling' => <
      all-scroll  col-resize  row-resize
      n-resize    e-resize    s-resize   w-resize
      ne-resize   nw-resize   se-resize  sw-resize   ns-resize
      nesw-resize nwse-resize
    >,
    'Zoom'               => <zoom-in zoom-out>
  );

  for @h.grep( *.key ne 'Resize & Scrolling' ) -> $p {
    @sections.push: add_section($b, $p.key);
    add_button(@sections[*-1], $_) for $p.value.List;
  }

  $app.window.show_all;
});

$app.run;
