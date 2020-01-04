use v6.c;

use Method::Also;
use NativeCall;

use GDK::Raw::Types;
use GDK::Raw::FrameTimings;

class GDK::FrameTimings {
  has GdkFrameTimings $!ft is implementor;

  submethod BUILD(:$timings) {
    $!ft = $timings;
  }

  # ↓↓↓↓ SIGNALS ↓↓↓↓
  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ PROPERTIES ↓↓↓↓
  # ↑↑↑↑ PROPERTIES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  method get_complete is also<get-complete> {
    gdk_frame_timings_get_complete($!ft);
  }

  method get_frame_counter is also<get-frame-counter> {
    gdk_frame_timings_get_frame_counter($!ft);
  }

  method get_frame_time is also<get-frame-time> {
    gdk_frame_timings_get_frame_time($!ft);
  }

  method get_predicted_presentation_time
    is also<get-predicted-presentation-time>
  {
    gdk_frame_timings_get_predicted_presentation_time($!ft);
  }

  method get_presentation_time is also<get-presentation-time> {
    gdk_frame_timings_get_presentation_time($!ft);
  }

  method get_refresh_interval is also<get-refresh-interval> {
    gdk_frame_timings_get_refresh_interval($!ft);
  }

  method get_type is also<get-type> {
    gdk_frame_timings_get_type();
  }

  method upref {
    gdk_frame_timings_ref($!ft);
  }

  method downref {
    gdk_frame_timings_unref($!ft);
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
