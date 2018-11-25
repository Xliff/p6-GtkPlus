use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::Types;

unit package GTK::Compat::Raw::FrameClock;

sub gdk_frame_clock_begin_updating (GdkFrameClock $frame_clock)
  is native(gdk)
  is export
  { * }

sub gdk_frame_clock_end_updating (GdkFrameClock $frame_clock)
  is native(gdk)
  is export
  { * }

sub gdk_frame_clock_get_current_timings (GdkFrameClock $frame_clock)
  returns GdkFrameTimings
  is native(gdk)
  is export
  { * }

sub gdk_frame_clock_get_frame_counter (GdkFrameClock $frame_clock)
  returns gint64
  is native(gdk)
  is export
  { * }

sub gdk_frame_clock_get_frame_time (GdkFrameClock $frame_clock)
  returns gint64
  is native(gdk)
  is export
  { * }

sub gdk_frame_clock_get_history_start (GdkFrameClock $frame_clock)
  returns gint64
  is native(gdk)
  is export
  { * }

sub gdk_frame_clock_get_refresh_info (
  GdkFrameClock $frame_clock,
  gint64 $base_time,
  gint64 $refresh_interval_return,
  gint64 $presentation_time_return
)
  is native(gdk)
  is export
  { * }

sub gdk_frame_clock_get_timings (
  GdkFrameClock $frame_clock,
  gint64 $frame_counter
)
  returns GdkFrameTimings
  is native(gdk)
  is export
  { * }

sub gdk_frame_clock_get_type ()
  returns GType
  is native(gdk)
  is export
  { * }

sub gdk_frame_clock_request_phase (
  GdkFrameClock $frame_clock,
  guint $phase                    # GdkFrameClockPhase $phase
)
  is native(gdk)
  is export
  { * }
