use v6.c;

use GTK::Raw::Types;

use Cairo;

use GLib::Rand;
use GDK::FrameClock;
use GTK::Application;
use GTK::Window;

constant RADIUS     = 64;
constant DIAMETER   = 2 * RADIUS;
constant JITTER     = 200;
constant CYCLE_TIME = 5;
constant WIDTH      = 600;
constant HEIGHT     = 600;
constant FACTOR     = 1e0;

my ($window-width, $window-height) = (WIDTH, HEIGHT);
my ($load-factor, $NO-RESIZE)      = (1, False);
my ($window, $source-surface);
my $angle;

sub ensure-resources ($t) {
  state @l = (^16).eager;

  return unless $t;

  $source-surface = Cairo::Surface.new(
    surface => $t.create_similar(
      CONTENT_COLOR_ALPHA,
      16 * DIAMETER,
      16 * DIAMETER
    )
  );

  my $c = Cairo::Context.new($source-surface);
  given $c {
    .save;
    .rgba(0, 0, 0, 0);
    ( .operator, .line_width ) = (OPERATOR_SOURCE, 1);
    .paint;
    .restore;

    for @l -> $j {
      for @l -> $i {
        my $l           = -> $m { (($i * $m) % 16) / 15 };
        my ($r, $g, $b) = ( $l(41), $l(31), $l(23) );

        use NativeCall;

        sub cairo_set_source_rgba (cairo_t, num64, num64, num64, num64)
           is native('t/cairo-wrapper.so')
           is symbol('cairo_set_source_rgba_wrapper')
           { * }

        #say "($j/$i) RGB: ({ $r }, { $g }, { $b })";

        my num64 ($rr, $gg, $bb) = ($r, $g, $b).map( *.Num );

        cairo_set_source_rgba( $c.context, $rr, $gg, $bb, 0.25.Num );
        .rgba(0, 0, 0, 0.25);
        .arc(
          $i * DIAMETER + RADIUS,
          $j * DIAMETER + RADIUS,
          RADIUS - 0.5,
          0,
          2 * π
        );
        .fill(:preserve);
        .rgba($r, $g, $b, 1);
        .stroke
      }
    }
  }
}

sub on-window-draw($w, $cr is copy) {
  my $r                = GLib::Rand.new-with-seed;
  my ($width, $height) = $w.allocated-wh;

  given $cr = Cairo::Context.new($cr) {
    ensure-resources( .get_target );
    .rgb(1, 1, 1);
    .paint;
    .rgb(0, 0, 0);
    .line_width = 1;
    .rectangle(0.5, 0.5, $width - 1, $height - 1);
    .stroke
  }

  # cw: Should be 150, not 10.
  for ^($load-factor * 10) {
    my $source         = $r.int-range(0, 255);
    my $phi            = $r.double-range(0, 2* π) + $angle;
    my $rad            = $r.double-range(0, $width / 2 - RADIUS);
    my ($sx, $sy)      = ($source % 16, $source / 16);
    my $x              = ($width  / 2 + $rad * $phi.cos - RADIUS).Int;
    my $y              = ($height / 2 - $rad * $phi.sin - RADIUS).Int;

    # cw: Causes clipping... must investigate!
    #$cr.set_source_surface($source-surface, $x - $sx, $y - $sy);
    $cr.set_source_surface($source-surface, $x, $y);
    $cr.rectangle($x, $y, DIAMETER, DIAMETER);
    $cr.fill
  }

  0;
}

sub on-frame ($p) {
  CATCH { default { .message.say; .backtrace.concise.say; } }

  my $jitter = JITTER * ($angle = 2 * π * $p).sin;
  ($window-width, $window-height) = $jitter «+« (WIDTH, HEIGHT)
    unless $NO-RESIZE;

  $window.resize($window-width, $window-height);
  $window.queue-draw;
}

sub tick-callback ($w, $fc) {
  state $start-frame-time = 0;
  my    $fco              = GDK::FrameClock.new($fc);
  my    $ft               = $fco.get-frame-time;

  $start-frame-time = $ft unless $start-frame-time;
  my $st  = ($ft - $start-frame-time) / (CYCLE_TIME * 1e6);
  on-frame($st - $st.floor);

  G_SOURCE_CONTINUE.Int;
}

sub MAIN (
  Num  :f(:$factor)     = FACTOR,    #= Load factor
  Bool :n(:$no-resize)  = False,     #= No resize
) {
  ($load-factor, $NO-RESIZE) = ($factor, $no-resize);

  say "# Load factor: { $load-factor }";
  say "#    Resizing: { $NO-RESIZE ?? 'no' !! 'yes' }";

  GTK::Application.init;

  $window = GTK::Window.new(GTK_WINDOW_TOPLEVEL);
  given $window {
    .set-keep-above(True);
    ( .gravity, .app-paintable ) = (GDK_GRAVITY_CENTER, True);

    .draw.tap(-> *@a --> gboolean {
      CATCH { default { .message.say; .backtrace.concise.say } }
      @a[* - 1].r = on-window-draw( |@a[^2] )
    });

    .destroy-signal.tap(-> *@a {
      CATCH { default { .message.say; .backtrace.concise.say } }
      GTK::Application.quit
    });

    .map-event.tap(-> *@a --> gboolean {
      CATCH { default { .message.say; .backtrace.concise.say } }

      $window.add-tick-callback(-> *@a --> guint32 {
        tick-callback( |@a[^2] )
      });
      @a[* - 1].r = G_SOURCE_REMOVE.Int;
    });

  }

  given $window.get-screen {
    my $mb = .get-monitor-geometry( .primary-monitor );
    $window.move(
      $mb.x + ($mb.width -  $window-width) / 2,
      $mb.y + ($mb.height - $window-height) / 2
    );
  }
  $window.show;
  GTK::Application.main;
}
