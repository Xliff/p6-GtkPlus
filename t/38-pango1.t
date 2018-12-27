use v6.c;

use Cairo;

use Pango::Cairo;
use Pango::FontDescription;
use Pango::Layout;

use GTK::Application;
use GTK::DrawingArea;

sub draw_text($da, $cr, $ud, $r) {
  $cr.save;

  # Will eventually be baked into GTK, once Pango is released.
  my $layout = Pango::Layout.new(
    $da.create_pango_layout( ("Pango Power" xx 3).join("\n") )
  );
  my $desc = Pango::FontDescription.new_from_string('sans bold 34');
  $layout.font_description = $desc;
  $cr.move_to(30.Num, 20.Num);
  Pango::Cairo.new($cr, :!update).layout_path($layout);

  my $pattern = Cairo::Pattern::Gradient::Linear.create(
    0, 0, |$da.get_allocated_wh
  );
  my @r = (0.0, 0.2, 0.3, 0.4, 0.6, 0.7, 0.8, 1.0).map( *.Num );
  my @g = (  1,   1,   1,   0,   0,   0,   1,   1).map( *.Num );
  my @b = (  0,   0,   1,   1,   1,   0,   0,   0).map( *.Num );
  my @a = (0 xx 4, 1 xx 4).flat.map( *.Num );
  $pattern.add_color_stop_rgb(|$_) for [Z](@r, @g, @b, @a);
  $cr.set_source($pattern.pattern);
  $cr.fill_preserve;
  $cr.set_source_rgb(0.Num, 0.Num, 0.Num);
  $cr.set_line_width(0.5.Num);
  $cr.stroke_preserve;
  $cr.restore;
  $r.r = 1;
}

my $a = GTK::Application.new(
  title => 'org.genex.pango_power', width => 400, height => 200
);

$a.activate.tap({
  CATCH { default { .message.say; $a.exit } }

  my $da = GTK::DrawingArea.new;
  # Alternative callback method: Returned value set in draw_text
  $da.draw.tap(-> *@a { draw_text( |@a ) });
  $a.window.resizable = True;
  $a.window.title = 'Text Mask';
  $a.window.destroy-signal.tap({ $a.exit });
  $a.window.add($da);
  $a.window.show_all;
});

$a.run;
