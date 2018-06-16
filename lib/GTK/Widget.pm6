use v6.c;

use NativeCall;

use GTK::Class::Pointers;
use GTK::Class::Widget;

sub g_type_check_class_cast (OpaquePointer $tc, int32 $it)
  returns OpaquePointer
  is native('glib')
  { * }


sub gtk_widget_get_type()
  returns int32
  is native('gtk')
  { * }

class GTK::Widget {
  has GTK::Class::Widget $!gwc;
  has GtkWidget          $!w;

  method BUILD(:$widget) {
    $!w = $widget;

    $!gwc = nativecast(
      GTK::Class::Widget,
      g_type_check_class_cast (
        nativecast(OpaquePointer, $widget),
        gtk_widget_get_type(),
      )
    );
  }
}
