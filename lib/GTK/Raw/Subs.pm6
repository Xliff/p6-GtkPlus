use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GTK::Raw::Definitions;

unit package GTK::Raw::Subs;

sub ReturnWidget ($w, $raw, $widget) {
  $w ?? ( $raw ?? $w
               !! ( $widget ?? GTK::Widget.new($w)
                            !! GTK::Widget.CreateObject($w) ) )
     !! Nil;
 }

# For signal handlers -- Didn't work because of missing closure, but it was
# a nice idea.
#
# sub signal-harness(%sig-hash, $obj, $signal-name, &c_call, &handler)
#   is export
# {
#   my $hid;
#   %sig-hash{$signal-name} //= do {
#     my $s = Supplier.new;
#     $hid = &c_call($obj, $signal-name, &handler, Pointer, 0);
#     [ $s.Supply, $obj, $hid];
#   };
#   %sig-hash{$signal-name}[0].tap(&handler) with &handler;
#   %sig-hash{$signal-name}[0];
# }

sub g_signal_connect_wd(
  Pointer $app,
  Str $name,
  &handler (GtkWidget $h_widget, Pointer $h_data),
  Pointer $data,
  uint32 $connect_flags
)
  returns uint64
  is native(gobject)
  is symbol('g_signal_connect_object')
  is export
{ * }

sub g_signal_connect_handler(
  Pointer $app,
  Str $name,
  Pointer $handler,
  Pointer $data,
  uint32 $connect_flags
)
  returns uint64
  is native(gobject)
  is symbol('g_signal_connect_object')
  is export
{ * }


# IDLE

sub g_idle_add_rint (
  &handler (--> gint),
  Pointer
)
  is native(glib)
  is symbol('g_idle_add')
  is export
{ * }

sub g_idle_add (
  &handler (Pointer --> gboolean),
  Pointer
)
  is native(glib)
  is export
{ * }

#
# CLASS
#
#sub g_type_check_class_cast (Pointer $tc, int32 $it)
#  returns Pointer
#  is native('glib-2.0')
#  is export(:class)
#  { * }
