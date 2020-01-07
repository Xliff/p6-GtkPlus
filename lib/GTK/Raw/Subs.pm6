use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GTK::Raw::Definitions;

unit package GTK::Raw::Subs;

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

#
# WINDOW
#
sub gtk_application_window_new (GtkApplication $app)
  returns GtkWindow
  is native(gtk)
  is export
{ * }

sub gtk_window_set_title (GtkWindow $win, Str $title)
  is native(gtk)
  is export(:window)
{ * }

sub gtk_window_set_default_size (GtkWindow $win, int32 $w, int32 $h)
  is native(gtk)
  is export(:window)
{ * }


# cw:This signature is wrong, so go with something that works and circle back.
#sub gtk_init(uint32 is rw, CArray[Str])
sub gtk_init(CArray[uint32], CArray[Str])
  is native(gtk)
  is export
{ * }

sub gtk_init_check()
  is native(gtk)
  is export
{ * }

sub gtk_main()
  is native(gtk)
  is export
{ * }

sub gtk_main_quit()
  is native(gtk)
  is export
{ * }
