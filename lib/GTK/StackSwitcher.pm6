use v6.c;

use Method::Also;
use NativeCall;

use GTK::Compat::Types;

use GTK::Raw::Types;
use GTK::Raw::StackSwitcher;

use GTK::Box;

our subset StackSwitcherAncestry is export
  where GtkStackSwitcher | BoxAncestry;

class GTK::StackSwitcher is GTK::Box {
  has GtkStackSwitcher $!ss;

  method bless(*%attrinit) {
    my $o = self.CREATE.BUILDALL(Empty, %attrinit);
    $o.setType(self.^name);
    $o;
  }

  submethod BUILD (:$switcher) {
    given $switcher {
      when StackSwitcherAncestry {
        self.setStackSwitcher($switcher);
      }
      when GTK::StackSwitcher {
      }
      default {
      }
    }
  }

  method GTK::Raw::Types::GtkStackSwitcher is also<StackSwitcher> { $!ss }

  method setStackSwitcher (StackSwitcherAncestry $switcher) {
    self.IS-PROTECTED;

    my $to-parent;
    $!ss = do given $switcher {
      when GtkStackSwitcher {
        $to-parent = nativecast(GtkBox, $_);
        $_;
      }
      default {
        $to-parent = $_;
        nativecast(GtkStackSwitcher, $_);
      }
    }
    self.setBox($to-parent);
  }

  multi method new (StackSwitcherAncestry $switcher) {
    self.bless(:$switcher);
  }
  multi method new {
    self.bless( switcher => gtk_stack_switcher_new() );
  }

  method stack is rw {
    Proxy.new(
      FETCH => sub ($) {
        ::('GTK::Stack').new( gtk_stack_switcher_get_stack($!ss) );
      },
      STORE => sub ($, GtkStack() $stack is copy) {
        gtk_stack_switcher_set_stack($!ss, $stack);
      }
    );
  }

  method get_type is also<get-type> {
    gtk_stack_switcher_get_type();
  }

}
