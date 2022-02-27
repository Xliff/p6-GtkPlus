use v6.c;

use Method::Also;

use GTK::Raw::StackSidebar:ver<3.0.1146>;
use GTK::Raw::Types:ver<3.0.1146>;

use GTK::Bin:ver<3.0.1146>;

our subset StackSidebarAncestry is export
  where GtkStackSidebar | BinAncestry;

class GTK::StackSidebar:ver<3.0.1146> is GTK::Bin {
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
            $to-parent = cast(GtkBin, $_);
            $_;
          }
          default {
            $to-parent = $_;
            cast(GtkStackSidebar, $_);
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

  method GTK::Raw::Definitions::GtkStackSidebar
    is also<
      StackSidebar
      GtkStackSidebar
    >
  { $!ss }

  multi method new (StackSidebarAncestry $sidebar, :$ref = True) {
    return Nil unless $sidebar;

    my $o = self.bless(:$sidebar);
    $o.ref if $ref;
    $o;
  }
  multi method new {
    my $sidebar = gtk_stack_sidebar_new();

    $sidebar ?? self.bless(:$sidebar) !! Nil;
  }

  # ↓↓↓↓ SIGNALS ↓↓↓↓
  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  method stack (:$raw = False) is rw {
    Proxy.new(
      FETCH => sub ($) {
        # Late binding to prevent possibility of circular dependency.
        # It might be possible to incorporate this object into
        # GTK::Stack, since it is so small.
        my $s = gtk_stack_sidebar_get_stack($!ss);

        $s ??
          ( $raw ?? $s !! ::('GTK::Stack').new($s) )
          !!
          Nil
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
