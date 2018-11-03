use v6.c;

use Method::Also;
use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::StackSidebar;
use GTK::Raw::Types;

use GTK::Bin;

class GTK::StackSidebar is GTK::Bin {
  has GtkStackSidebar $!ss;

  method bless(*%attrinit) {
    my $o = self.CREATE.BUILDALL(Empty, %attrinit);
    $o.setType('GTK::StackSidebar');
    $o;
  }

  submethod BUILD(:$sidebar) {
    my $to-parent;
    given $sidebar {
      when GtkStackSidebar | GtkWidget {
        $!ss = do {
          when GtkWidget {
            $to-parent = $_;
            nativecast(GtkStackSidebar, $_);
          }
          when GtkStackSidebar {
            $to-parent = nativecast(GtkBin, $_);
            $_;
          }
        }
        self.setBin($to-parent);
      }
      when GTK::StackSidebar {
      }
      default {
      }
    }
  }

  multi method new {
    my $sidebar = gtk_stack_sidebar_new();
    self.bless(:$sidebar);
  }
  multi method new (GtkWidget $sidebar) {
    self.bless(:$sidebar);
  }

  # ↓↓↓↓ SIGNALS ↓↓↓↓
  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  method stack is rw {
    Proxy.new(
      FETCH => sub ($) {
        # Late binding to prevent possibility of circular dependency.
        # It might be possible to incorporate this object into
        # GTK::Stack, since it is so small.
        ::('GTK::Stack').new( gtk_stack_sidebar_get_stack($!ss) );
      },
      STORE => sub ($, GtkStack() $stack is copy) {
        gtk_stack_sidebar_set_stack($!ss, $stack);
      }
    );
  }
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  method get_type is also<get-type> {
    gtk_stack_sidebar_get_type();
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}

