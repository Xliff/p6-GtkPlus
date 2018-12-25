use v6.c;

use Cairo;

#use GTK::Compat::GList;
use GTK::Compat::Types;
use GTK::Raw::Types;
use GTK::Raw::Utils;

use GTK::Application;
use GTK::Box;
use GTK::DrawingArea;
use GTK::IconTheme;
use GTK::Render;
use GTK::StyleContext;
use GTK::WidgetPath;

my $da;

sub append_element($p, $s) {
  my %p = (
    active          => GTK_STATE_FLAG_ACTIVE,
    hover           => GTK_STATE_FLAG_PRELIGHT,
    selected        => GTK_STATE_FLAG_SELECTED,
    disabled        => GTK_STATE_FLAG_INSENSITIVE,
    indeterminate   => GTK_STATE_FLAG_INCONSISTENT,
    focus           => GTK_STATE_FLAG_FOCUSED,
    backdrop        => GTK_STATE_FLAG_BACKDROP,
    'dir(ltr)'      => GTK_STATE_FLAG_DIR_LTR,
    'dir(rtl)'      => GTK_STATE_FLAG_DIR_RTL,
    link            => GTK_STATE_FLAG_LINK,
    visited         => GTK_STATE_FLAG_VISITED,
    checked         => GTK_STATE_FLAG_CHECKED,
    'drop(active)'  => GTK_STATE_FLAG_DROP_ACTIVE
  );

  my ($w,  $r)  = $s.split('#');
  my ($c, $pc)  = ($r // $w).split(':');
  my ($fc, *@c) = ($c // $w).split('.');
  $p.append_type(G_TYPE_NONE);
  $p.iter_set_object_name(-1, $fc);
  $p.iter_add_class(-1, $_) for @c;
  if %p{$pc // ''}:exists {
    $p.iter_set_state(-1, %p{$pc});
  } else {
    warn "Pseudoclass '{ $pc }' does not exist!" with $pc;
  }
}

sub create_context_for_path ($p, $pp) {
  my $c = GTK::StyleContext.new;

  ($c.path, $c.parent) = ($p, $pp);
  $c.state = $p.iter_get_state(-1);
  $c;
}

sub common_draw($cc, $xx, $yy, $ww, $hh) {
  say 'CD: ' ~ ($xx, $yy, $ww, $hh).map({ $_ // ''}).join(',');

  $cc."get_{ $_ }"($cc.state, %*b{$_}) for %*b.keys;

  # GValues use "int", not "Int".
  my $mw = $cc.get($cc.state,  'min-width').int;
  my $mh = $cc.get($cc.state, 'min-height').int;

  $*cax += %*b<margin>.left;
  $*cay += %*b<margin>.top;
  $*caw -= %*b<margin>.left + %*b<margin>.right;
  $*cah -= %*b<margin>.top  + %*b<margin>.bottom;
  ($*caw, $*cah) = ( ($*caw, $mw).max, ($*cah, $mh).max );

  say "CA-X: {$*cax} / CA-Y: {$*cay} / CA-W: {$*caw} / CA-H {$*cah}";

  GTK::Render.background($cc, $*cr, $*cax, $*cay, $*caw, $*cah);
       GTK::Render.frame($cc, $*cr, $*cax, $*cay, $*caw, $*cah);
}
sub common_adjust($cx is rw, $cy is rw, $cw is rw, $ch is rw) {
  say 'CA: ' ~ ($*cax, $*cay, $*caw, $*cah).map({ $_ // ''}).join(',');
  $cx = $*cax + %*b<border>.left   + %*b<padding>.left;
  $cy = $*cay + %*b<border>.top    + %*b<padding>.top;
  $cw = $*caw - %*b<border>.left   - %*b<padding>.left -
                %*b<border>.right  - %*b<padding>.right;
  $ch = $*cah - %*b<border>.top    - %*b<padding>.top -
                %*b<border>.bottom - %*b<padding>.bottom;
  say 'C: ' ~ ($cx, $cy, $cw, $ch).map({ $_ // ''}).join(',');
}

multi sub draw_style_common-ro ($c, $w, $h) {
  samewith($c, $, $, $w, $h);
}
multi sub draw_style_common-ro ($c, $x, $y, $w, $h) {
  my %*b = (
    margin => GtkBorder.new, border => GtkBorder.new, padding => GtkBorder.new
  );
  my $*cax = $x // $*x;
  my $*cay = $y // $*y;
  my $*caw = $w // $*w;
  my $*cah = $h // $*h;
  say "X: {$x // ''} / \*X: $*x / CAX: $*cax";
  say "W: {$x // ''} / \*W: $*w / CAW: $*caw";
  common_draw($c, $*cax, $*cay, $*caw, $*cah);
}
multi sub draw_style_common ($c) {
  samewith($c,  $,  $,  $,  $, $, $, $, $);
}
multi sub draw_style_common ($c, $w, $h) {
  samewith($c,  $,  $, $w, $h, $, $, $, $);
}
multi sub draw_style_common ($c, $x, $y, $w, $h) {
  samewith($c, $x, $y,  $w, $h, $, $, $, $);
}
multi sub draw_style_common (
  $c, $x, $y, $w, $h,
  $cx is rw, $cy is rw, $cw is rw, $ch is rw
) {
  my $*cax = $x // $*x;
  my $*cay = $y // $*y;
  my $*caw = $w // $*w;
  my $*cah = $h // $*h;
  my %*b = (
    margin => GtkBorder.new, border => GtkBorder.new, padding => GtkBorder.new
  );
  common_draw($c, $*cax, $*cay, $*caw, $*cah);
  common_adjust($cx // $*cx, $cy // $*cy, $cw // $*cw, $ch // $*ch);
}

multi sub query_size($cc, $w is rw, $h is rw) {
  my %*b = (
    margin => GtkBorder.new, border => GtkBorder.new, padding => GtkBorder.new
  );
  # Warning: dynamic method call.
  $cc."get_{ $_ }"($cc.state, %*b{$_}) for %*b.keys;

  my $mw = $cc.get($cc.state,  'min-width').int;
  my $mh = $cc.get($cc.state, 'min-height').int;

  for ( $mw, <left right>, $mh, <top bottom> ) -> $min is rw, $bnds {
    for $bnds.flat X <margin border padding> -> ($m, $t) {
      # Warning: dynamic method call.
      $min += %*b{$t}."$m"();
    }
  }

  $w = ($mw, $w).max with $w;
  $h = ($mh, $h).max with $h;
}

sub get_style($pp, $s) {
  my $p = $pp.defined ??
    GTK::WidgetPath.copy( $pp.path ) !! GTK::WidgetPath.new;

  append_element($p, $s);
  create_context_for_path($p, $pp);
}

sub get_style_with_siblings ($pp, $s, @sibs, $pos) {
  my $p = $pp.defined ??
    GTK::WidgetPath.copy($pp.path) !! GTK::WidgetPath.new;

  my $sp = GTK::WidgetPath.new;
  append_element($sp, $_) for @sibs;
  $p.append_with_siblings($sp, $pos);
  $sp.downref;
  create_context_for_path($p, $pp);
}

sub draw_menu($w) {
  my ($mc, $mic, $hmc, $hac, $amc, $cmc, $dac, $dmc, $dcc, $rmc, $drc, $smc);
  my ($aw, $ah, $as, $tx, $ty, $tw, $th, @mh);
  my ($*cx, $*cy, $*cw, $*ch, $mx, $my, $mw, $mh) = (0 xx 8);

  $tx = $ty = $tw = $tx = 0;

  my $msc = $da.style_context;
  say "Menu Style: { $msc }";

  $mc  = get_style($msc, 'menu');
  $hmc = get_style( $mc, 'menuitem:hover');
  $hac = get_style($hmc, 'arrow.right:dir(ltr)');
  $mic = get_style( $mc, 'menuitem');
  $amc = get_style($mic, 'arrow:dir(rtl)');
  $dmc = get_style( $mc, 'menuitem:disabled');
  $dac = get_style($dmc, 'arrow:dir(rtl)');
  $cmc = get_style($mic, 'check:checked');
  $dcc = get_style($dmc, 'check');
  $smc = get_style( $mc, 'separator:disabled');
  $rmc = get_style($mic, 'radio:checked');
  $drc = get_style($dmc, 'radio');

  @mh = (0 xx 6);
  $*h = 0;
  query_size( $mc, $, $*h);
  query_size($hmc, $, @mh[1]);
  query_size($hac, $, @mh[1]);
  $*h += @mh[1];
  #query_size($_, $, $_ =:= $mc ?? @mh[5] !! @mh[2]) for $mc, $mic, $amc, $dac;
  query_size($mc,  $, @mh[5]);
  query_size($mic, $, @mh[2]);
  query_size($amc, $, @mh[2]);
  query_size($dac, $, @mh[2]);

  $*h += @mh[2];
  query_size($_, $, $_ =:= $mc ?? @mh[5] !! @mh[3]) for $mc, $mic, $cmc, $dcc;
  $*h += @mh[3];
  query_size($_, $, $_ =:= $mc ?? @mh[5] !! @mh[4]) for $mc, $smc;
  $*h += @mh[4];
  query_size($_, $, @mh[5]) for $mc, $mic, $rmc, $drc;
  draw_style_common($mc, $, $, $w, $, $mx, $my, $mw, $mh);

  say "MX: {$mx} / MY: {$my} / MW: {$mw} / MH: {$mh}";

  # Hovered with right arrow
  $as = ( $hac.get($hac.state,  'min-width').int,
          $hac.get($hac.state, 'min-height').int ).min;
  draw_style_common($hmc, $mx, $my, $mw, @mh[1]);
  GTK::Render.arrow(
    $hmc, $*cr, π/2, $*cx + $*cw - $as, $*cy + ($*ch - $as) / 2, $as
  );

  # Left arrow sensitive, and right arrow insensitive
  draw_style_common($mic, $mx, $my + @mh[1], $mw, @mh[2]);
  $as = ( $amc.get($amc.state,  'min-width').int,
          $amc.get($amc.state, 'min-height').int ).min;
  GTK::Render.arrow($amc, $*cr, π/2, $*cx, $*cy + ($*ch - $as) / 2, $as);
  $as = ( $dmc.get($dmc.state,  'min-width').int,
          $dmc.get($dmc.state, 'min-height').int ).min;
  GTK::Render.arrow(
    $dmc, $*cr, π/2, $*cx + $*cw - $as, $*cy + ($*ch - $as) / 2, $as
  );

  # Left check enabled, sensitive, and right check unchecked, insensitive
  draw_style_common($mic, $mx, $my + @mh[1..4].sum, $mw, @mh[5]);
  ($tw, $th) = ( $rmc.get($rmc.state, 'min-width').int,
                 $rmc.get($rmc.state, 'min-width').int );
  $tx = $ty = 0;
  draw_style_common($rmc, $*cx, $*cy, $tw, $th, $tx, $ty, $tw, $th);
  GTK::Render.check($rmc, $*cr, $tx, $ty, $tw, $th);
  ($tw, $th) = ( $drc.get($drc.state, 'min-width').int,
                 $drc.get($drc.state, 'min-width').int );
  draw_style_common($drc, $*cx + $*cw - $tw, $*cy, $tw, $th,
                    $tx, $ty, $tw, $th);
  GTK::Render.check($drc, $*cr, $tx, $ty, $tw, $th);

  # Separator
  draw_style_common-ro($smc, $mx, $my + @mh[1..3].sum, $mw, @mh[4]);

  .downref for  $mc, $mic, $hmc, $hac, $amc, $cmc, $dac, $dcc, $rmc, $dmc,
               $drc, $smc;
}


sub draw_menubar ($w) {
  my ($fc, $bc, $mc, $hc, $mic, $iw);
  my ($*cx, $*cy, $*cw, $*ch) = (0 xx 4);

  $fc  = get_style(Nil, 'frame');
  $bc  = get_style($fc, 'border');
  $mc  = get_style(Nil, 'menubar');
  $hc  = get_style($mc, 'menuitem:hover');
  $mic = get_style($mc, 'menuitem');

  $*h = 0;
  query_size($_, $, $*h) for $hc, $bc, $mc, $hc, $mic;

  draw_style_common-ro($fc, $w, $);
  draw_style_common($hc);
  draw_style_common-ro( $mc, $*cx, $*cy, $*cw, $*ch);
  $iw = $*cw / 3;
  draw_style_common-ro( $hc,           $*cx, $*cy, $iw, $*ch);
  draw_style_common-ro($mic, $*cw + $iw * 2, $*cy, $iw, $*ch);

  .downref for $mic, $hc, $mc, $bc, $fc;
}

sub draw_notebook($w, $h) {
  my ($nc, $hc, $tc, $t1c, $t2c, $sc, $hh);
  my ($*cx, $*cy, $*cw, $*ch) = (0 xx 4);

  $nc  = get_style(Nil, 'notebook.frame');
  $sc  = get_style($nc, 'stack');
  $hc  = get_style($nc, 'header.top');
  $tc  = get_style($hc, 'tabs');
  $t1c = get_style($tc, 'tab:checked');
  $t2c = get_style($tc, 'tab:hover');

  $hh = 0;
  query_size($_, $, $hh) for $nc, $hc, $tc, $t1c, $t2c;

  draw_style_common-ro($_, $w, $_ =:= $nc ?? $h !! $hh) for $nc, $hc, $tc;
  draw_style_common($t1c, $w/2, $hh);
  draw_style_common-ro($t2c,  $*x + $w/2,          $, $w/2,       $hh);
  draw_style_common-ro( $sc,         $*x,  $*y + $hh,   $w, $*h - $hh);

  .downref for $sc, $tc, $t1c, $t2c, $hc, $nc;
}

sub draw_horizontal_scrollbar($w, $p, $s) {
  my ($sc, $cc, $tc, $slc, $sw);
  my ($*cx, $*cy, $*cw, $*ch) = (0 xx 4);

  $sc  = get_style(Nil, 'scrollbar.horizontal.bottom');
  $cc  = get_style($sc, 'contents');
  $tc  = get_style($cc, 'trough');
  $slc = get_style($tc, 'slider');

  $*h = 0;
  for $sc, $cc, $tc, $slc {
    .state = $s;
    query_size($_, $, $*h);
  }
  $sw = $slc.get($slc.state, 'min-width').int;
  draw_style_common-ro($_, $w, $) for $sc, $cc;
  draw_style_common-ro($_, $w, $) for $tc;

  my $xp = $*x + $p;
  draw_style_common-ro($slc, $xp, $, $sw, $);

  .downref for $sc, $tc, $cc, $slc;
}

sub draw_text($w, $h, $t, $s) {
  my ($lc, $sc, $c, $l);
  my ($*cx, $*cy, $*cw, $*ch) = (0 xx 4);

  $lc = get_style(Nil, 'label.view');
  $sc = get_style($lc, 'selection');
  $c = ($s +& GTK_STATE_FLAG_SELECTED) ?? $sc !! $lc;
  $l = $da.create_pango_layout($t);
  GTK::Render.background($c, $*cr, $*x, $*y, $w, $h);
  GTK::Render.frame($c, $*cr, $*x, $*y, $w, $h);
  GTK::Render.layout($c, $*cr, $*x, $*y, $l);

  .downref for $sc, $lc;
}

sub _draw_checkradio($s, $t) {
  my ($bc, $cc);
  my ($*cx, $*cy, $*cw, $*ch) = (0 xx 4);

  $bc = get_style(Nil, "{ $t }button");
  $cc = get_style($bc, $t);
  $cc.state = $s;
  $*w = $*h = 0;
  query_size($_, $*w, $*h) for $bc, $cc;
  my ($w, $h) = ($*w, $*h);
  draw_style_common-ro($bc, $w, $h);
  draw_style_common($cc, $w, $h);
  GTK::Render.check($cc, $*cr, $*cx, $*cy, $*cw, $*ch);
  .downref for $cc, $bc;
}

sub draw_check($s) {
  _draw_checkradio($s, 'check');
}

sub draw_radio($s) {
  _draw_checkradio($s, 'radio');
}

sub draw_progress($w, $p) {
  my ($bc, $tc, $pc, $lh);

  $bc  = get_style( Nil, 'progressbar.horizontal');
  $tc  = get_style( $bc, 'trough');
  $pc  = get_style( $tc, 'progress.left');

  $*h = 0;
  query_size($_, $, $*y) for $bc, $tc, $pc;
  draw_style_common-ro($_, $, $, $_ =:= $pc ?? $p !! $w, $)
    for $bc, $tc, $pc;
  .downref for $bc, $tc, $pc;
}

sub draw_scale($w, $p) {
  my ($sc, $cc, $tc, $slc, $hc, $th, $sh);
  my ($*cx, $*cy, $*cw, $*ch) = (0 xx 4);

  $sc  = get_style( Nil, 'scale.horizontal');
  $cc  = get_style( $sc, 'contents');
  $tc  = get_style( $cc, 'trough');
  $slc = get_style( $tc, 'slider');
  $hc  = get_style($slc, 'highlight.top');

  $*h = 0;
  query_size($_, $, $*h) for $sc, $cc, $tc, $slc, $hc;

  say "0 ===== CX: {$*cx} / CY: {$*cy} / CW: {$*cw} / CH: {$*ch}";
  draw_style_common($sc, $w, $);
  say "1 ===== CX: {$*cx} / CY: {$*cy} / CW: {$*cw} / CH: {$*ch}";
  draw_style_common($cc, $*cx, $*cy, $*cw, $*ch);
  say "2 ===== CX: {$*cx} / CY: {$*cy} / CW: {$*cw} / CH: {$*ch}";

  $th = 0;
  query_size($tc, $, $th);
  $sh = 0;
  query_size($_, $, $sh) for $slc, $hc;
  $th += $sh;
  # Following coordinates are too large and too wide.
     draw_style_common( $tc,      $*cx, $*cy,     $*cw,  $th);
  draw_style_common-ro( $hc,      $*cx, $*cy, $*cw / 2, $*ch);
  draw_style_common-ro($slc, $*cx + $p, $*cy,     $*ch, $*ch);

  .downref for $sc, $cc, $tc, $slc,  $hc
}

sub draw_combobox($xx, $w, $he) {
  my $x := ($xx // $*cx);
  my ($ec, $btc, $bbc, $ac, $bw);
  my ($*cx, $*cy, $*cw, $*ch) = (0 xx 4);
  my $cc = get_style(Nil, 'combobox:focus');
  my $bc = get_style($cc, 'box.horizontal.linked');

  my @s = <button.combo>;
  if $he {
    @s.unshift: 'entry.combo:focus';
    $ec  = get_style_with_siblings($bc, @s[0], @s, 0);
    $btc = get_style_with_siblings($bc, @s[1], @s, 1);
  } else {
    $btc = get_style_with_siblings($bc, @s[0], @s, 0);
  }
  $bbc = get_style($btc, 'box.horizontal');
  $ac  = get_style($bbc, 'arrow');

  $*h = 0;
  my @c = ($cc, $bc, $btc, $bbc, $ac);
  @c.splice(2, 0, $ec) if $he;
  my $xxx;
  query_size($_, $xxx, $) for @c;

  my $as = ($ac.get($ac.state,  'min-width').int,
            $ac.get($ac.state, 'min-height').int ).min;
  draw_style_common($_, $x, $*y, $w, $*h) for $cc, $bc;

  if $he {
    $bw = $*h;
    draw_style_common($ec,            $x,  $, $w - $bw, $*h);
    draw_style_common($bc, $x + $w - $bw,  $,      $bw,   $);
  } else {
    $bw = $*w;
    draw_style_common($bc, $x + $w - $bw, $, $bw, $);
  }

  draw_style_common($bbc, $*cx, $*cy, $*cw, $*ch);
  draw_style_common( $ac, $*cx, $*cy, $*cw, $*ch);
  $ac.render_arrow($*cr, π/2, $*cx + $*cw - $as, $*cy + ($*ch - $as) / 2, $as);

  @c = $he ?? ($ac, $ec, $bc, $cc) !! ($ac, $bc, $cc);
  .downref for @c;
}

sub draw_spinbutton($w) {
  my ($sc, $ec, $uc, $dc, $it, $ii, $p);
  my ($iw, $ih, $is, $bw);
  my ($*cx, $*cy, $*cw, $*ch) = (0 xx 4);

  $sc = get_style(Nil, 'spinbutton.horizontal:focus');
  $ec = get_style($sc, 'entry:focus');
  $uc = get_style($ec, 'button.up:focus:active');
  $dc = get_style($uc, 'button.down:focus');

  $*h = 0;
  my $xxx;
  query_size($_, $xxx, $) for $sc, $ec, $uc, $dc;
  $bw = $*h;

  draw_style_common($_) for $sc, $ec;

  for <add remove> {
    $it = GTK::IconTheme.get_for_screen($da.screen);
    $is = ( $uc.get($uc.state,  'min-width').int,
            $uc.get($uc.state, 'min-height').int ).min ;
    $ii = $it.lookup_icon("list-{$_}-symbolic", $is, 0);
    $p  = $ii.load_symbolic_for_context($uc, $);
    {
      my $ctx = $_ eq 'add' ?? $uc !! $dc;
      my $x = $*x + $w - ($_ eq 'add' ?? 1 !! 2) * $bw;
      draw_style_common($ctx, $x, $, $bw, $);
      GTK::Render.icon($ctx, $*cr, $p, $*cw, $*cy + ($*ch - $is) / 2);
    }
  }

  .downref for $dc, $uc, $ec, $sc;
}

sub do_draw($ct) {
  my ($pw, $*w, $*h, $*x, $*y);
  my $*cr = $ct;
  my $cr = Cairo::Context.new( cast(Cairo::cairo_t, $*cr) );

  ($*w, $*h) = ($da.get_allocated_width, $da.get_allocated_height);
  $pw = $*w / 2;
  $cr.rectangle(0, 0, $*w, $*h);
  $cr.rgb(0.9, 0.9, 0.9);
  $cr.fill;

  say 'Scrollbar';
  $*x = $*y = 10;
  for (
    GTK_STATE_FLAG_NORMAL,
    GTK_STATE_FLAG_PRELIGHT,
    GTK_STATE_FLAG_ACTIVE +| GTK_STATE_FLAG_PRELIGHT
  ) {
    draw_horizontal_scrollbar($pw - 20, 30 + $++ * 10, $_);
    $*y += $*h + 8;
  }

  say 'Text';
  #$*y += $*h + 8;
  for (GTK_STATE_FLAG_NORMAL, GTK_STATE_FLAG_SELECTED) {
    my $l = ($_ == GTK_STATE_FLAG_NORMAL) ?? 'Not selected' !! 'Selected';
    draw_text($pw - 20, 20, $l, $_);
    $*y += 20 + 10 if $_ == GTK_STATE_FLAG_NORMAL;
  }

  $*x = 10;
  $*y += 20 + 10;
  for (&draw_check, &draw_radio) -> $func {
    say $func === &draw_check ?? 'Check' !! 'Radio';
    for <NORMAL CHECKED> {
      $func( ::("GTK_STATE_FLAG_$_") );
      $*x += $*w + 10;
    }
  }
  $*x = 10;

  say "Progress ({ $*y })";
  $*y += $*h + 10;
  draw_progress($pw - 20, 50);

  say "Scale ({ $*y }) / $pw";
  $*y += $*h + 10;
  draw_scale($pw - 20, 75);

  say "Notebook";
  $*y += $*h + 20;
  draw_notebook($pw - 20, 160);

  # Second column
  say "Menu";
  $*x += $pw;
  $*y = 10;
  draw_menu($pw - 20);

  say "Menubar";
  $*y += $*h + 10;
  draw_menubar($pw - 20);

  $*y += $*h + 20;
  draw_spinbutton($pw - 30);

  $*y += $*h + 30;
  draw_combobox(       $, $pw - 20, False);
  $*y += $*h + 10;
  draw_combobox(10 + $pw, $pw - 20,  True);

  1;
}

my $a = GTK::Application.new( title => 'org.genex.widgetpath' );
$a.activate.tap({
  CATCH { default { .message.say; $a.exit } }

  my $b  = GTK::Box.new-hbox(10);
  $da = GTK::DrawingArea.new;
  $da.set_size_request(400, 400);
  $da.hexpand = $da.vexpand = $da.app_paintable = True;
  $da.draw.tap(-> *@a { @a[*-1].r = do_draw(@a[1]) });
  $b.add($da);

  $a.window.title = 'Foreign Drawing';
  $a.window.add($b);
  $a.window.show_all;
});

$a.run;
