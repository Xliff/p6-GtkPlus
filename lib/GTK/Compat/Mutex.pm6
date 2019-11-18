use v6.c;

use GTK::Compat::Types;
use GTK::Compat::Raw::Thread;

class GTK::Compat::Mutex {
  has GMutex $!m is implementor;

  submethod BUILD (:$mutex) {
    $!m = $mutex;
  }

  method new {
    my $m = GMutex.new;
    
    GTK::Compat::Mutex.init($m);
    self.bless( mutex => $m );
  }

  method clear {
    g_mutex_clear($!m);
  }

  method init (GTK::Compat::Mutex:U: $mutex) {
    g_mutex_init($mutex);
  }

  method lock {
    g_mutex_lock($!m);
  }

  method trylock {
    g_mutex_trylock($!m);
  }

  method unlock {
    g_mutex_unlock($!m);
  }

}
