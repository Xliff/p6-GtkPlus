use v6.c;

# Example ported from:
# https://github.com/sweckhoff/GTK-Cairo-Sinusoids/blob/master/gtk_cairo_sinusoid_plot.c

use GTK::Application;
use GTK::DrawingArea;
use GTK::Image;
use GTK::Label;
use GTK::Overlay;
use GTK::Window;

my $packet = (
  width => 400,
  height => 200,
  rad_step => 0.05,
  scale_factor => 75,
  y_zero => 100,
  x_step => 1,
  rads => 0.0,
  last_x => 0,
  last_y => 0,
  current_x => 0,
  current_y => 0,
  current_eraser_x => 150,
);

sub do_graph($packet) {
  my ($pi_rads, $label);

  $packet<rads> = 0 if $packet<rads> >= 2.0;
  $pi_rads = pi * $packet<rads>;
  $label = "Radians: { $packet<rads>.round(0.1) }pi";
  $packet<rads> += $packet<rad_step>;
  $packet<current_x> = 0 if $packet<current_x> > $packet<width>;
  $packet<last_x last_y> = $packet<current_x current_y>;
  $packet<current_x> += $packet<y0> - (
    $packet<scale_factor> * $packet<func>($pi_rads)
  );

  $packet<current_eraser_x> += $packet<x_step>;
  $packet<current_eraser_x> = 0 if $packet<current_eraser_x> > $packet<width>;
  $packet<widget>.queue_draw;
  True;
}

sub draw_callback($widget, $drawable, $packet) {
  # Erase Old
  cairo_move_to($packet<eraser>, $packet<current_eraser_x>, 0);
  cairo_line_to($packet<eraser>, $packet<current_eraser_x>, $packet<height>);
  cairo_stroke($packet<eraser>);
  # Plot New
  cairo_move_to($packet<plot>, $packet<last_x>, $packet<last_y>);
  cairo_line_to($packet<plot>, $packet<current_x>, $packet<current_y>);
  cairo_stroke($packet<plot>);

  cairo_set_source_surface($drawable, $packet<plot_surface>, 0.0, 0.0);
  cairo_paint($drawable);
  False;
}


# Make buttons
# sine
# cosine

$packet<func> = &sin;
my $a = GTK::Application.new( title => 'org.genex.overlay' );

$a.activate.tap({
  $packet<plot_surface> = cairo_image_surface_create(
    CAIRO_FORMAT_ARGB32,
    400,
    200
  );
  die 'Could not create plot surface' unless $packet<plot_surface>;

  $packet<plot> = cairo_create($packet<plot_surface>) or die;
  $packet<eraser> = cairo_create($packet<plot_surface>) or die;
  cairo_set_source_rgba ($packet<eraser>, 0.0, 0.0, 0.0, 0.0);
  cairo_set_operator($packet<eraser>, CAIRO_OPERATOR_CLEAR);
  $a.window.set_size_request(480, 200);
  $packet<window> = $a.window;

  my $overlay = GTK::Overlay.new or die;
  my $image = GTK::Image.new_from_file('plot_background.png');
  my $background = GTK::Image.new_from_file('pi_background.png')
  $packet<label> = GTK::Label.new('Radians: 0.0pi');
  $packet<label>.halign = GTK_ALIGN_START;
  $packet<label>.valign = GTK_ALIGN_END;

  my $drawing_area = GTK::DrawingArea.new;
  $drawing_area.set_size_request(400, 200);
  $drawing_area.draw.tap({ draw_callback($packet); });

  $overlay.add($background);
  $overlay.add_overlay($image);
  $overlay.add_overlay($drawing_area);
  $overlay.add_overlay($packet<label>);

  $a.window.show_all;

  Promise.in(0.1).then: { do_graph($packet); }
});

$a.run;
