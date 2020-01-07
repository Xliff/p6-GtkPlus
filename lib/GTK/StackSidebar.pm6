use v6.c;

use Method::Also;
use NativeCall;


use GTK::Raw::StackSidebar;
use GTK::Raw::Types;

use GTK::Bin;

our subset StackSidebarAncestry is export
  where GtkStackSidebar | BinAncestry;

class GTK::StackSidebar is GTK::Bin {
  has GtkStackSidebar $!ss is implementor;

  method bless(*%attrinit) {
    my $o = self.CREATE.BUILDALL(Empty, %attrinit);
    $o.setType($o.^name);
    $o;
  }

  submethod BUILD(:$sidebar) {
    my $to-parent;
    given $sidebar {
      when StackSidebarAncestry {
        $!ss = do {
          when GtkStackSidebar {
            $to-parent = nativecast(GtkBin, $_);
            $_;
          }
          default {
            $to-parent = $_;
            nativecast(GtkStackSidebar, $_);
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

  method GTK::Raw::Types::GtkStackSidebar is also<StackSidebar> { $!ss }

  multi method new (StackSidebarAncestry $sidebar) {
    my $o = self.bless(:$sidebar);
    $o.upref;
    $o;
  }
  multi method new {
    my $sidebar = gtk_stack_sidebar_new();
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
    state ($n, $t);
    GTK::Widget.unstable_get_type( &gtk_stack_sidebar_get_type, $n, $t );
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
