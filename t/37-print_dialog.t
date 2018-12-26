use v6.c;

use Cairo;

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
  my $bytes = g_resource_lookup_data($pd<resourcename);

  $pd<lines_per_page> = ($height / $data<font_size>).floor;
  $pd<lines> = $bytes.decode.lines;
  $pd<num_lines> = $pd<lines>.elems;
  $pd<num_pages> = ($pd<num_lines> - 1) / $pd<lines_per_page> + 1;
  $po.n_pages = $pd<num_pages>;
}

sub draw_page ($po, $pc, $pn, $ud) {
  my $cr = $pc.get_cairo_context;
  my $w = $pc.width;
  my $cc = Cairo::Context.new($cr);
  my $l = $pc.create_pango_layout;
  my $d = pango_font_description_from_string('sans 14');
  my gint ($tw, $th) = (0, 0);

  $cc.rectangle(0, 0, $w, HEADER_HEIGHT);
  $cc.rgb(0.8, 0.8, 0.8);
  $cc.fill_preserve;
  $cc.rgb(0, 0, 0);
  $cc.set_line_width(1);
  $cc.stroke;

  pango_layout_set_font_description($l, $d);
  pango_font_description_free($d);
  pango_layout_set_text($l, $pd<resourcename>, -1);
  pango_layout_get_pixel_size($l, $tw, $th);

  if $tw > $w {
    pango_layout_set_width($l, $w);
    pango_layout_set_ellipsize($l, PANGO_ELLIPSIZE_START);
    pango_layout_get_pixel_size($l, $tw, $th);
  }
  $cc.move_to( ($w - $tw) / 2, (HEADER_HEIGHT - $th) / 2 );
  pango_cairo_show_layout($cr, $l);
  pangpo_layout_set_text($l, "{ page_nr + 1 }/{ %pd<num_pages> }", -1);
  # g_object_unref($l);

  $l = $pc.create_pango_layout;
  $d = pango_font_description_from_string('monospace');
  pango_font_description_set_size($d, $pd<font_size> * PANGO_SCALE);
  pango_layout_set_font_description($l, $d);
  pango_font_description_free($d);

  $cc.move_to(0, HEADER_HEIGHT + HEADER_GAP);
  my $line = $pn * $pd<lines_per_page>;
  for ^$pd<lines_per_page> -> $cl {
    last if $line + $cl >= $pd<num_lines>;

    pango_layout_set_text($l, $pd<lines>[$line + $cl], -1);
    pango_cairo_show_layout($cr, $l);
    $cc.rel_move_to(0, $pd<font_size>);
  }
  #g_object_unref($l);
}

sub end_print($po, $pc, $pd) {
  g_free($_) for $pd<resourcename lines>;
  g_strfreev($pd<lines>);
}

sub do_print_settings {
  %pd<resourcename> = $?FILE;
  %pd<font_size> = 12;

  $ps.set(GTK_PRINT_SETTINGS_OUTPUT_BASENAME, $?FILE);
  $po.begin-print.tap(-> *@a { begin_print( |@a[1..2], %pd ) });
  $po.end-print.tap(-> *@a   {   end_print( |@a[1..2], %pd ) });
  $po.draw-page.tap(-> *@a   {   draw_page( |@a[1..3], %pd ) });
  $po.use_full_page = False;
  $po.unit = GTK_UNIT_POINTS;
  $po.embed_page_setup = True;
  $po.print_settings = $ps;

  $po.run(GTK_PRINT_OPERATION_ACTION_PRINT_DIALOG, $a.window, $err);
  with $err[0] {
    my $d = GTK::Dialog::Message.new($a.window, $err[0].message);
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
  my %pd, $err;
  my $po = GTK::PrintOperation.new;
  my $ps = GTK::PrintSettings.new;
  my $vb = GTK::Box.new-vbox(5);
  my  @b = GTK::Button.new xx 2;
  my $err = gerror;

  $a.window.add($vb);
  $vb.pack_start($_, True, True) for @b;
  @b[0].label = 'Print Settings';
  @b[1].label = 'Page Setup';

  @b[0].clicked.tap({ do_print_settings() });
  @b[1].clicked.tap({  do_page_settings() });

  $a.window.show_all;
});

$a.run;
