use v6.c;

use NativeCall;

use GTK::Class::Pointers;

#
# CLASS
#
sub g_type_check_class_cast (OpaquePointer $tc, int32 $it)
  returns OpaquePointer
  is native('glib')
  is export(:class)
  { * }


#
# WIDGET
#
sub gtk_widget_get_type()
  returns int32
  is native('gtk')
  is export(:widget)
  { * }


#
# Application
#
sub g_signal_connect_object(
  GApplication $app,
  Str $name,
  &Handler,
  OpaquePointer $data,
  uint32 $connect_flags
)
  returns int32
  is export(:app)
  is native('glib')
  { * }

sub g_signal_handler_disconnect(GApplication $app, int32 $handler)
  is native('glib')
  is export(:app)
  { * }

sub gtk_application_new(Str $app_name, uint32 $f)
  returns GtkApplication
  is native('gtk-3')
  is export(:app)
  { * }

sub gtk_application_add_window(GtkApplication $app, GtkWindow $win)
  is native('gtk-3')
  is export(:app)
  { * }

sub gtk_main()
  is native('gtk-3')
  is export(:app)
  { * }

sub gtk_main_quit()
  is native('gtk-3')
  is export(:app)
  { * }
