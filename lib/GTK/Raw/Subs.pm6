use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::Types;

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


#
# DEFAULT
#
sub g_object_new (uint64 $object_type, Str)
  returns gpointer
  is native(gobject)
  is export
  { * }

sub g_object_ref(Pointer $p)
  is native(gobject)
  is export
  { * }
sub g_object_unref(Pointer $p)
  is native(gobject)
  is export
  { * }

sub g_signal_connect_data(
  Pointer $p,
  Str $signal,
  &handler (Pointer, Pointer),
  Pointer $data
)
  returns uint64
  is native(gobject)
  is export
  { * }

sub g_object_set_string(Pointer $o, Str $key, Str $data)
  is native(gobject)
  is symbol('g_object_set_data')
  is export
  { * }

sub g_object_get_string(Pointer $o, Str $key)
  returns Str
  is native(gobject)
  is symbol('g_object_get_data')
  is export
  { * }

sub g_object_set_uint(Pointer $o, Str $key, uint32 $data is rw)
  is native(gobject)
  is symbol('g_object_set_data')
  is export
  { * }

sub g_object_get_ptr(Pointer $o, Str $key)
  returns Pointer
  is native(gobject)
  is symbol('g_object_get_data')
  is export
  { * }

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


sub g_signal_handler_disconnect(Pointer $app, uint64 $handler)
  is native(gobject)
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

#
# APPLICATION
#
sub g_application_run(Pointer, int32, CArray[Str])
  is native('gio-2.0')
  is export
  { * }

sub g_application_quit(Pointer)
  is native('gio-2.0')
  is export
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
