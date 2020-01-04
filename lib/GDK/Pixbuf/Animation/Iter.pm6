use v6.c;

use GDK::Raw::Types;
use GDK::Pixbuf::Raw::Animation;

class GDK::Pixbuf::Animation::Iter {
  has GdkPixbufAnimationIter $!pai is implementor;

  submethod BUILD (:$iter) {
    $!pai = $iter;
  }

  method GDK::Raw::Types::GdkPixbufAnimation
  { $!pai }

  method new (GdkPixbufAnimationIter $iter) {
    self.bless( :$iter );
  }

  method advance (GTimeVal $current_time) {
    so gdk_pixbuf_animation_iter_advance($!pai, $current_time);
  }

  method get_delay_time {
    gdk_pixbuf_animation_iter_get_delay_time($!pai);
  }

  method get_pixbuf (:$raw = False) {
    my $p = gdk_pixbuf_animation_iter_get_pixbuf($!pai);

    $p ??
      ( $raw ?? $p !! GDK::Pixbuf.new($p) )
      !!
      Nil;
  }

  method get_type {
    state ($n, $t);

    unstable_get_type( self.^name, &gdk_pixbuf_animation_iter_get_type, $n, $t);
  }

  method on_currently_loading_frame {
    so gdk_pixbuf_animation_iter_on_currently_loading_frame($!pai);
  }

}
