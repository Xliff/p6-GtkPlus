use v6.c;

use Cairo;
use Pango::Cairo;
use Pango::FontDescription;
use Pango::Layout;
use Pango::Raw::Types;

use GTK::Compat::Types;
use GTK::Raw::Types;

use GTK::PrintOperation;
use GTK::PrintContext;

use GTK::Application;
use GTK::Box;
use GTK::Button;
use GTK::Dialog::Message;
use GTK::Dialog::PageSetupUnix;

constant HEADER_HEIGHT = 10 * 72 / 25.4;
constant HEADER_GAP    =  3 * 72 / 25.4;

sub begin_print ($po, $pc, $pd) {
  my $height = $pc.height - HEADER_HEIGHT - HEADER_GAP;

  $pd<lines> = $pd<resourcename>.IO.slurp.lines;
  $pd<lines>.push: Str;
  $pd<lines_per_page> = ($height / $pd<font_size>).floor;
  $pd<num_lines> = $pd<lines>.elems;
  $pd<num_pages> = ($pd<num_lines> - 1) / $pd<lines_per_page> + 1;
  $po.n_pages = $pd<num_pages>;
}

sub draw_page ($po, $c, $pn, $pd) {
  my ($cr, $w) = ( Cairo::Context.new($c.get_cairo_context), $c.width );
  $cr.rectangle(0, 0, $w, HEADER_HEIGHT);
  $cr.rgb(0.8, 0.8, 0.8);
  $cr.fill(:preserve);
  $cr.line_width = 1;
  $cr.stroke;

  my $layout = $c.create_pango_layout;
  my $desc = Pango::FontDescription.new_from_string('sans 14');
  $layout.font_description = $desc;
  $layout.text = $pd<resourcename>;

  my ($tw, $th) = $layout.get_pixel_size;
  if $tw > $w {
    $layout.width = $w;
    $layout.set_ellipsize = PANGO_ELLIPSIZE_START;
    ($tw, $th) = $layout.get_pixel_size;
  }

  my $pc = Pango::Cairo.new($cr);
  $cr.move_to( ($w - $tw) / 2, (HEADER_HEIGHT - $th) / 2 );
  $pc.show_layout($layout);

  $layout.text = "{ $pn + 1 }/{ $pd<num_pages> }";
  $layout.width = -1;
  ($tw, $th) = $layout.get_pixel_size;
  $cr.move_to($w - $tw - 4, (HEADER_HEIGHT - $th) / 2);
  $pc.show_layout($layout);

  $layout = $c.create_pango_layout;
  $desc = Pango::FontDescription.new_from_string('monospace');
  $desc.size = $pd<font_size> * PANGO_SCALE;
  $layout.font_description = $desc;
  $cr.move_to(0, HEADER_HEIGHT + HEADER_GAP);

  my ($line, $i) = ( $pn * $pd<lines_per_page>, 0 );
  repeat {
    $layout.text = $pd<line>[$line];
    $cr.move_to(0, $pd<font_size>, :relative);
  } while ++$i < $pd<lines_per_page> && ++$line < $pd<num_lines>;
}

sub do_print_settings ($po, $ps, $w) {
  my (%pd, $err);
  %pd<resourcename> = $?FILE;
  %pd<font_size> = 12;

  $ps.set(GTK_PRINT_SETTINGS_OUTPUT_BASENAME, $?FILE);
  $po.begin-print.tap(-> *@a { begin_print( |@a[1..2], %pd ) });
  $po.draw-page.tap(->   *@a {   draw_page( |@a[1..3], %pd ) });
  $po.use_full_page = False;
  $po.unit = GTK_UNIT_POINTS;
  $po.embed_page_setup = True;
  $po.print_settings = $ps;

  $po.run(GTK_PRINT_OPERATION_ACTION_PRINT_DIALOG, $w, $err);
  with $err[0] {
    my $d = GTK::Dialog::Message.new($w, $err[0].message);
    $d.response.tap({ $d.hide });
    $d.show;
  }
}

sub do_page_settings {
  my $pd = GTK::Dialog::PageSetupUnix.new('Page Setup');
  $pd.respone.tap({ $pd.hide });
  $pd.show;
}

my $a = GTK::Application.new( title => 'org.genex.unix_print' );
$a.activate.tap({
  my $po  = GTK::PrintOperation.new;
  my $ps  = GTK::PrintSettings.new;
  my $vb  = GTK::Box.new-vbox(5);
  my @b   = GTK::Button.new xx 2;
  my $err = gerror;

  $a.window.add($vb);
  $vb.pack_start($_, True, True) for @b;
  @b[0].label = 'Print Settings';
  @b[1].label = 'Page Setup';

  @b[0].clicked.tap({ do_print_settings($po, $ps, $a.window) });
  @b[1].clicked.tap({  do_page_settings() });

  $a.window.show_all;
});

$a.run;
