use v6.c;

use Method::Also;


use GTK::Raw::Types:ver<3.0.1146>;
use GTK::Raw::StackSwitcher:ver<3.0.1146>;

use GTK::Box:ver<3.0.1146>;

our subset StackSwitcherAncestry is export
  where GtkStackSwitcher | GtkBoxAncestry;

class GTK::StackSwitcher:ver<3.0.1146> is GTK::Box {
  has GtkStackSwitcher $!ss is implementor;

  method bless(*%attrinit) {
    my $o = self.CREATE.BUILDALL(Empty, %attrinit);
    $o.setType(self.^name);
    $o;
  }

  submethod BUILD (:$switcher) {
    given $switcher {
      when StackSwitcherAncestry { self.setStackSwitcher($switcher) }
      when GTK::StackSwitcher    { }
      default                    { }
    }
  }

  method GTK::Raw::Definitions::GtkStackSwitcher
    is also<
      StackSwitcher
      GtkStackSwitcher
    >
  { $!ss }

  method setStackSwitcher (StackSwitcherAncestry $switcher) {
    self.IS-PROTECTED;

    my $to-parent;
    $!ss = do given $switcher {
      when GtkStackSwitcher {
        $to-parent = cast(GtkBox, $_);
        $_;
      }
      default {
        $to-parent = $_;
        cast(GtkStackSwitcher, $_);
      }
    }
    self.setBox($to-parent);
  }

  multi method new (StackSwitcherAncestry $switcher, :$ref = True) {
    return Nil unless $switcher;

    my $o = self.bless(:$switcher);
    $o.ref if $ref;
    $o;
  }
  multi method new {
    my $switcher = gtk_stack_switcher_new();

    $switcher ?? self.bless( :$switcher ) !! Nil;
  }

  method stack (:$raw = False) is rw {
    Proxy.new(
      FETCH => sub ($) {
        my $s = gtk_stack_switcher_get_stack($!ss);

        $s ??
          ( $raw ?? $s !! ::('GTK::Stack').new($s) )
          !!
          Nil;
      },
      STORE => sub ($, GtkStack() $stack is copy) {
        gtk_stack_switcher_set_stack($!ss, $stack);
      }
    );
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gtk_stack_switcher_get_type, $n, $t );
  }

}
