use v6.c;

constant HEADER_HEIGHT = 10 * 72 / 25.4;
constant HEADER_GAP = 3 * 72 / 25.4;

use GTK::Application;
use GTK::PrintContext;
use GTK::PrintOperation;

sub begin_print ($op, $c, $d) {
  my $height = $c.height - HEADER_HEIGHT - HEADER_GAP;
  $d<lines_per_page> = ($height / $d<font_size>).floor;
  my $bytes = g_resources_lookup_data($d<resourcename>);
  $d<lines> = $bytes.decode.lines;
  $d<lines>.push: Str;
  $d<num_lines> = $d<lines>.elems;
  $d<num_pages> = ($d<num_lines> - 1) / $d<lines_per_page> + 1;
  $op.n_pages = $d<num_pages>;
}

sub draw_page ($op, $c, $page, $d) {
  my ($cr, $w) = ( Cairo::Context.new($c.get_cairo_context), $c.width );
  $cr.rectangle(0, 0, $w, HEADER_HEIGHT):
  $cr.rgb(0.8, 0.8, 0.8);
  $cr.fill(:preserve);
  $cr.line_width = 1;
  $cr.stroke;

  my $layout = $c.create_pango_layout;
  my $desc = Pango::FontDescription.new_from_string('sans 14');
  $layout.font_description = $desc;
  $layout.text = $d<resourcename>;

  my ($tw, $th) = $layout.get_pixel_size;
  if $tw > $w {
    $layout.width = $w;
    $layout.set_ellipsize = PANGO_ELLIPSIZE_START;
    ($tw, $th) = $layout.get_pixel_size;
  }

  my $pc = Pango::Cairo.new($cr);
  $cr.move_to( ($w - $tw) / 2, (HEADER_HEIGHT - $th) / 2 );
  $pc.show_layout($layout);

  $layout.text = "{ $page + 1 }/{ $d<num_pages> }";
  $layout.width = -1;
  ($tw, $h) = $layout.get_pixel_size;
  $cr.move_to($w - $tw - 4, (HEADER_HEIGHT - $th) / 2);
  $pc.show_layout($layout);

  $layout = $c.create_pango_layout;
  $desc = Pango::FontDescription.new_from_string('monospace');
  $desc.size = $d<font_size> * PANGO_SCALE;
  $layout.font_description = $desc;
  $cr.move_to(0, HEADER_HEIGHT + HEADER_GAP);

  my ($line, $i) = ( $page * $d<lines_per_page>, 0 );
  repeat {
    $layout.text = $d<line>[$line];
    $cr.move_to(0, $d<font_size>, :relative);
  } while ++$i < $d<lines_per_page> && ++$line < $d<num_lines>;
}

my $a = GTK::Application.new ( title => 'org.genex.printing' );

$a.activate.tap({
  my $op = GTK::PrintOperation.new;
  my %data = { resourcename => $?FILE, font_size => 12.0 };

  $op.begin-print.tap(-> *@a {
    begin_print($op, GTK::PrintContext.new(@a[1]), %data)
  });
  $op.draw-page.tap(  -> *@a {
    draw_page($op, GTK::PrintContext.new(@a[1]), %data)
  });
  #op.end-print.tap({...}) -- Not needed

  $op.use_full_page = False;
  $op.unit = GTK_UNIT_POINTS;
  $op.embed_page_setup = True;

  my $settings = GTK::PrintSettings.new;
  $settings.set(GTK_PRINT_SETTINGS_OUTPUT_BASENAME, 'gtk-demo');
  $op.print_settings = $settings;
  $op.run(GTK_PRINT_OPERATION_ACTION_PRINT_DIALOG, $a.window);
}
