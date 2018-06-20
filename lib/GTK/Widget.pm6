use v6.c;

use NativeCall;

use GTK::Class::Pointers;
use GTK::Raw::Widget;

class GTK::Widget {
  has GtkWidget  $!w;

  has @!signals;

  submethod BUILD (GtkWidget :$widget) {
    $!w = $widget;
  }

  
}
