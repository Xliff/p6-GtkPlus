use v6.c;

use Cairo;

use GTK::Application;
use GTK::Compat::Cairo;
use GTK::Compat::FrameClock;
use GTK::Compat::Pixbuf;
use GTK::Compat::Rectangle;
use GTK::Compat::Types;
use GTK::Dialog::Message;
use GTK::DrawingArea;
use GTK::Raw::Types;

constant CYCLE_TIME = 3000000;
subset Odd of Int where * % 2;

my (%pix, $err, @images, %pix_files, $bw, $bh);
my $dir = 'pixbufs';

$dir = "t/{$dir}" unless $dir.IO.d;
die 'Cannot find images directory!' unless $dir.IO.d;
for $dir.IO.dir {
  my $b = .basename;
  $b ~~ s/[ '.png' | '.jpg' ]$//;
  %pix_files{$b} = $_;
}


sub load_pix {
  return True if %pix<background>;

  for %pix_files.keys {
    %pix{$_} = GTK::Compat::Pixbuf.new_from_file(%pix_files{$_});
    unless %pix{$_}  {
      $err = "Could not load image '{ %pix_files{$_} }'";
      return False;
    }
  }
  ($bw, $bh) = %pix<background>.size;
  True;
}

my $start;
sub do_tick($da, $frame, $fc) {
  my ($ct, $f, $i, $clk, $ni, $xmid, $ymid, $r);

  %pix<background>.copy_area(0, 0, $bw, $bh, $frame, 0, 0);
  $clk = GTK::Compat::FrameClock.new($fc);
  $start = $clk.get_frame_time without $start;
  $ct = $clk.get_frame_time;
  $f = (($ct - $start) % CYCLE_TIME) / CYCLE_TIME;
  ($xmid, $ymid) = ($bw / 2, $bh / 2);
  $r = ($xmid, $ymid).min / 2;
  $ni = %pix.elems - 1;
  for %pix.keys.kv -> $idx, $i {
    next if $i eq 'background';

    my ($a, $xp, $yp, $lr, $k);
    my ($r1, $r2, $dest) = (GdkRectangle.new xx 3);
    my ($iw, $ih) = %pix{$i}.size;
    my $fang = $f * 2 * π;

    $a  = 2 * π * $idx / $ni - $fang;
    $lr =  $r + ($r / 3) * $fang.sin;
    $xp = ($xmid + $lr * $a.cos - $iw / 2 + 0.5).floor;
    $yp = ($ymid + $lr * $a.sin - $ih / 2 + 0.6).floor;
    $k = ( 0.25, 2 * ($idx ~~ Odd ?? $fang.sin !! $fang.cos)² ).max;
    ($r1.x, $r1.y, $r1.width, $r1.height) =
      ($xp, $yp, $iw * $k, $ih * $k).map( *.Int );
    ($r2.x, $r2.y, $r2.width, $r2.height) = (0, 0, $bw, $bh).map( *.Int );
    if $dest = $r1 ∩ $r2 {
      %pix{$i}.composite(
        $frame, $dest.x, $dest.y, $dest.width, $dest.height,
        $xp, $yp,
        $k, $k,
        GDK_INTERP_NEAREST,
        $idx ~~ Odd ?? (127, 255 * $fang.sin).max !! (127, 255 * $fang.cos).max
      );
    }
    $da.queue-draw;
  }

  1; # G_SOURCE_CONTINUE;
}

my $a = GTK::Application.new( title => 'org.genex.pixbufs' );
$a.activate.tap({
  $a.window.title = 'Pixbufs';
  $a.window.resizable = False;
  # Error handling.
  if load_pix().not {
    my $md = GTK::Dialog::Message.new(
      GTK_DIALOG_DESTROY_WITH_PARENT,
      GTK_MESSAGE_ERROR,
      GTK_BUTTONS_CLOSE,
      "Error: $err";
    );
    $md.run;
    $a.exit;
  } else {
    $a.window.set_size_request($bw, $bh);
    my $da = GTK::DrawingArea.new;
    my $frame = GTK::Compat::Pixbuf.new(
      GDK_COLORSPACE_RGB, False, 8, $bw, $bh
    );

    $da.draw.tap(-> *@a {
      my $cr = Cairo::Context.new( cast(Cairo::cairo_t, @a[1]) );
      GTK::Compat::Cairo.set_source_pixbuf(@a[1], $frame, 0, 0);
      $cr.paint;
      @a[*-1].r = 1;
    });
    $da.add_tick_callback(-> *@a { do_tick($da, $frame, @a[1]) });

    $a.window.add($da);
    $a.window.show_all;
  }

});

$a.run;
