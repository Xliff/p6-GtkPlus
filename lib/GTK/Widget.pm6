use v6.c;

use NativeCall;

use GTK::Class::Pointers;
use GTK::Class::Subs :class, :widget;
use GTK::Class::Widget;

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
