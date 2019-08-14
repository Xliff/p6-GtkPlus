use v6.c;

use Method::Also;

use GTK::Compat::Types;
use GTK::Compat::Raw::Main;

use GTK::Raw::Utils;

class GTK::Compat::MainLoop {
  has GMainLoop $!ml;

  submethod BUILD (:$mainloop) {
    $!ml = $mainloop;
  }

  method GTK::Compat::Types::GMainLoop
    is also<
      GMainLoop
      MainLoop
    >
  { $!ml }
  
  multi method new (Int() $is_running) {
    samewith(GMainContext, $is_running);
  }
  multi method new (GMainContext() $context, Int() $is_running) {
    my gboolean $ir = resolve-bool($is_running);
    
    self.bless( mainloop => g_main_loop_new($context, $ir) );
  }
  multi method new(|) {
    die 'No valid candidates found.';
  }

  method get_context is also<get-context> {
    g_main_loop_get_context($!ml);
  }

  method is_running is also<is-running> {
    g_main_loop_is_running($!ml);
  }

  method quit {
    g_main_loop_quit($!ml);
  }

  method ref {
    g_main_loop_ref($!ml);
  }

  method run {
    g_main_loop_run($!ml);
  }

  method unref {
    g_main_loop_unref($!ml);
  }
  
  method poll (gpointer $fds, Int() $nfds, Int() $timeout) {
    my guint $nf = resolve-uint($nfds);
    my gint $t = resolve-int($timeout);
    
    g_poll($fds, $nf, $t);
  }

}
