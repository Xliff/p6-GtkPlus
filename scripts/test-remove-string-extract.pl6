#sub common-substring (Str() $a, Str() $b) {
#  my $l = 0;
#  for $a.comb Z $b.comb {
#    return $l unless .[0] eq .[1];
#    $l++
#  }
#  $l;
#}

my $text = q:to/TEXT/;
use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GStreamer::Raw::Definitions;
use GStreamer::Raw::Enums;
use GStreamer::Raw::Structs;

unit package GStreamer::Raw::Base::BaseSink;

### /usr/include/gstreamer-1.0/gst/base/gstbasesink.h

sub gst_base_sink_do_preroll (GstBaseSink $sink, GstMiniObject $obj)
  returns GstFlowReturn
  is native(gstreamer-base)
  is export
{ * }

sub gst_base_sink_get_blocksize (GstBaseSink $sink)
  returns guint
  is native(gstreamer-base)
  is export
{ * }

sub gst_base_sink_get_drop_out_of_segment (GstBaseSink $sink)
  returns uint32
  is native(gstreamer-base)
  is export
{ * }

sub gst_base_sink_get_last_sample (GstBaseSink $sink)
  returns CArray[GstSample]
  is native(gstreamer-base)
  is export
{ * }

sub gst_base_sink_get_latency (GstBaseSink $sink)
  returns GstClockTime
  is native(gstreamer-base)
  is export
{ * }

sub gst_base_sink_get_max_bitrate (GstBaseSink $sink)
  returns guint64
  is native(gstreamer-base)
  is export
{ * }

sub gst_base_sink_get_max_lateness (GstBaseSink $sink)
  returns gint64
  is native(gstreamer-base)
  is export
{ * }

sub gst_base_sink_get_processing_deadline (GstBaseSink $sink)
  returns GstClockTime
  is native(gstreamer-base)
  is export
{ * }

sub gst_base_sink_get_render_delay (GstBaseSink $sink)
  returns GstClockTime
  is native(gstreamer-base)
  is export
{ * }

sub gst_base_sink_get_sync (GstBaseSink $sink)
  returns uint32
  is native(gstreamer-base)
  is export
{ * }

sub gst_base_sink_get_throttle_time (GstBaseSink $sink)
  returns guint64
  is native(gstreamer-base)
  is export
{ * }

sub gst_base_sink_get_ts_offset (GstBaseSink $sink)
  returns GstClockTimeDiff
  is native(gstreamer-base)
  is export
{ * }

sub gst_base_sink_is_async_enabled (GstBaseSink $sink)
  returns uint32
  is native(gstreamer-base)
  is export
{ * }

sub gst_base_sink_is_last_sample_enabled (GstBaseSink $sink)
  returns uint32
  is native(gstreamer-base)
  is export
{ * }

sub gst_base_sink_is_qos_enabled (GstBaseSink $sink)
  returns uint32
  is native(gstreamer-base)
  is export
{ * }

sub gst_base_sink_query_latency (
  GstBaseSink $sink,
  gboolean $live,
  gboolean $upstream_live,
  GstClockTime $min_latency,
  GstClockTime $max_latency
)
  returns uint32
  is native(gstreamer-base)
  is export
{ * }

sub gst_base_sink_set_async_enabled (GstBaseSink $sink, gboolean $enabled)
  is native(gstreamer-base)
  is export
{ * }

sub gst_base_sink_set_blocksize (GstBaseSink $sink, guint $blocksize)
  is native(gstreamer-base)
  is export
{ * }

sub gst_base_sink_set_drop_out_of_segment (
  GstBaseSink $sink,
  gboolean $drop_out_of_segment
)
  is native(gstreamer-base)
  is export
{ * }

sub gst_base_sink_set_last_sample_enabled (GstBaseSink $sink, gboolean $enabled)
  is native(gstreamer-base)
  is export
{ * }

sub gst_base_sink_set_max_bitrate (GstBaseSink $sink, guint64 $max_bitrate)
  is native(gstreamer-base)
  is export
{ * }

sub gst_base_sink_set_max_lateness (GstBaseSink $sink, gint64 $max_lateness)
  is native(gstreamer-base)
  is export
{ * }

sub gst_base_sink_set_processing_deadline (
  GstBaseSink $sink,
  GstClockTime $processing_deadline
)
  is native(gstreamer-base)
  is export
{ * }

sub gst_base_sink_set_qos_enabled (GstBaseSink $sink, gboolean $enabled)
  is native(gstreamer-base)
  is export
{ * }

sub gst_base_sink_set_render_delay (GstBaseSink $sink, GstClockTime $delay)
  is native(gstreamer-base)
  is export
{ * }

sub gst_base_sink_set_sync (GstBaseSink $sink, gboolean $sync)
  is native(gstreamer-base)
  is export
{ * }

sub gst_base_sink_set_throttle_time (GstBaseSink $sink, guint64 $throttle)
  is native(gstreamer-base)
  is export
{ * }

sub gst_base_sink_set_ts_offset (GstBaseSink $sink, GstClockTimeDiff $offset)
  is native(gstreamer-base)
  is export
{ * }

sub gst_base_sink_wait (
  GstBaseSink $sink,
  GstClockTime $time,
  GstClockTimeDiff $jitter
)
  returns GstFlowReturn
  is native(gstreamer-base)
  is export
{ * }

sub gst_base_sink_wait_clock (
  GstBaseSink $sink,
  GstClockTime $time,
  GstClockTimeDiff $jitter
)
  returns GstClockReturn
  is native(gstreamer-base)
  is export
{ * }

sub gst_base_sink_wait_preroll (GstBaseSink $sink)
  returns GstFlowReturn
  is native(gstreamer-base)
  is export
{ * }
TEXT

# "Exhaustive" maximal...
multi max (:&by = {$_}, :$all!, *@list) {
    # Find the maximal value...
    my $max = max my @values = @list.map: &by;

    # Extract and return all values matching the maximal...
    @list[ @values.kv.map: {$^index unless $^value cmp $max} ];
}

my @strings = $text.words.grep( *.starts-with('gst_') );

say max :all, :by{.chars}, keys [∩] @strings».match(/.+/, :ex)».Str;

# Go through above list and compute longest common substring.
# first run through is the string itself,
#   take next item and if common string is shorted, that's the current return value
# return the value 
