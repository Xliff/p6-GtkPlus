use v6.c;

use Method::Also;
use NativeCall;

use GTK::Compat::Types;
use GTK::Compat::Raw::FrameClock;

use GTK::Roles::Signals::Generic;

class GTK::Compat::FrameClock  {
  also does GTK::Roles::Signals::Generic;

  has GdkFrameClock $!fc is implementor;

  submethod BUILD(:$clock) {
    $!fc = $clock;
  }

  submethod DESTROY {
    self.disconnect-all($_) for %!signals;
  }

  method GTK::Compat::Types::GdkFrameClock {
    $!fc;
  }

  method new (GdkFrameClock $clock) {
    self.bless(:$clock);
  }

  # ↓↓↓↓ SIGNALS ↓↓↓↓

  # Is originally:
  # GdkFrameClock, gpointer --> void
  method after-paint {
    self.connect($!fc, 'after-paint');
  }

  # Is originally:
  # GdkFrameClock, gpointer --> void
  method before-paint is also<before_paint> {
    self.connect($!fc, 'before-paint');
  }

  # Is originally:
  # GdkFrameClock, gpointer --> void
  method flush-events is also<flush_events> {
    self.connect($!fc, 'flush-events');
  }

  # Is originally:
  # GdkFrameClock, gpointer --> void
  method layout {
    self.connect($!fc, 'layout');
  }

  # Is originally:
  # GdkFrameClock, gpointer --> void
  method paint {
    self.connect($!fc, 'paint');
  }

  # Is originally:
  # GdkFrameClock, gpointer --> void
  method resume-events is also<resume_events> {
    self.connect($!fc, 'resume-events');
  }

  # Is originally:
  # GdkFrameClock, gpointer --> void
  method update {
    self.connect($!fc, 'update');
  }

  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ PROPERTIES ↓↓↓↓
  # ↑↑↑↑ PROPERTIES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  method begin_updating is also<begin-updating> {
    gdk_frame_clock_begin_updating($!fc);
  }

  method end_updating is also<end-updating> {
    gdk_frame_clock_end_updating($!fc);
  }

  method get_current_timings is also<get-current-timings> {
    gdk_frame_clock_get_current_timings($!fc);
  }

  method get_frame_counter is also<get-frame-counter> {
    gdk_frame_clock_get_frame_counter($!fc);
  }

  method get_frame_time is also<get-frame-time> {
    gdk_frame_clock_get_frame_time($!fc);
  }

  method get_history_start is also<get-history-start> {
    gdk_frame_clock_get_history_start($!fc);
  }

  method get_refresh_info (
    Int() $base_time,
    Int() $refresh_interval_return,
    Int() $presentation_time_return
  )
    is also<get-refresh-info>
  {
    my @ul = ($base_time, $refresh_interval_return, $presentation_time_return);
    my ($bt, $rir, $ptr) = self.RESOLVE-ULINT($@ul);
    gdk_frame_clock_get_refresh_info($!fc, $bt, $rir, $ptr);
  }

  method get_timings (Num() $frame_counter) is also<get-timings> {
    my gdouble $fc = $frame_counter;
    gdk_frame_clock_get_timings($!fc, $frame_counter);
  }

  method get_type is also<get-type> {
    gdk_frame_clock_get_type();
  }

  method request_phase (Int() $phase) is also<request-phase> {
    my guint $p = self.RESOLVE-UINT($phase);
    gdk_frame_clock_request_phase($!fc, $p);
  }

  # ↑↑↑↑ METHODS ↑↑↑↑

}
