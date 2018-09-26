use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::Stack;
use GTK::Raw::Types;

use GTK::Container;

class GTK::Stack is GTK::Container {
  has GtkStack $!s;
  has GtkStackSwitcher $!ss;
  has $!by-name;
  has $!by-title;

  method bless(*%attrinit) {
    use nqp;
    my $o = nqp::create(self).BUILDALL(Empty, %attrinit);
    $o.setType('GTK::Stack');
    $o;
  }

  submethod BUILD(:$stack ) {
    my $to-parent;
    given $stack {
      when GtkStack | GtkWidget {
        $!s = do {
          when GtkWidget {
            $to-parent = $_;
            nativecast(GtkStack, $_);
          }
          when GtkStack  {
            $to-parent = nativecast(GtkContainer, $_);
            $_;
          }
        }
        self.setContainer($to-parent);
      }
      when GTK::Stack {
      }
      default {
      }
    }
    $!ss = gtk_stack_switcher_new();
    gtk_stack_switcher_set_stack($!ss, $!s);
  }

  multi method new {
    my $stack = gtk_stack_new();
    self.bless(:$stack);
  }
  multi method new (GtkWidget $stack);
    self.bless(:$stack);
  }

  # ↓↓↓↓ SIGNALS ↓↓↓↓
  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  method hhomogeneous is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_stack_get_hhomogeneous($!s);
      },
      STORE => sub ($, Int() $hhomogeneous is copy) {
        my uint32 $hh = $hhomogeneous;
        gtk_stack_set_hhomogeneous($!s, $hh);
      }
    );
  }

  method homogeneous is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_stack_get_homogeneous($!s);
      },
      STORE => sub ($, Int() $homogeneous is copy) {
        my uint32 $h = $homogeneous;
        gtk_stack_set_homogeneous($!s, $h);
      }
    );
  }

  method interpolate_size is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_stack_get_interpolate_size($!s);
      },
      STORE => sub ($, Int() $interpolate_size is copy) {
        my uint32 $is = self.RESOLVE-UINT($interpolate_size);
        gtk_stack_set_interpolate_size($!s, $is);
      }
    );
  }

  method transition_duration is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_stack_get_transition_duration($!s);
      },
      STORE => sub ($, Int() $duration is copy) {
        my uint32 $d = self.RESOLVE-UINT($duration);
        gtk_stack_set_transition_duration($!s, $d);
      }
    );
  }

  method transition_type is rw {
    Proxy.new(
      FETCH => sub ($) {
        GtkTransitionType( gtk_stack_get_transition_type($!s) );
      },
      STORE => sub ($, Int() $transition is copy) {
        my uint32 $t = self.RESOLVE-UINT($transition);
        gtk_stack_set_transition_type($!s, $t);
      }
    );
  }

  method vhomogeneous is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_stack_get_vhomogeneous($!s);
      },
      STORE => sub ($, Int() $vhomogeneous is copy) {
        my uint32 $vh = self.RESOLVE-UINT($vhomogeneous);
        gtk_stack_set_vhomogeneous($!s, $vh);
      }
    );
  }

  method visible_child is rw {
    Proxy.new(
      FETCH => sub ($) {
        # Resolve widget to object based on stored children.
        gtk_stack_get_visible_child($!s);
      },
      STORE => sub ($, GtkWidget() $child is copy) {
        gtk_stack_set_visible_child($!s, $child);
      }
    );
  }

  method visible_child_name is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_stack_get_visible_child_name($!s);
      },
      STORE => sub ($, Str() $name is copy) {
        gtk_stack_set_visible_child_name($!s, $name);
      }
    );
  }
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  multi method add_named (GtkWidget $child, gchar $name) {
    unless self.IS-LATCHED {
      %!by-name{$name} = $child;
      self.push-start($child);
    }
    gtk_stack_add_named($!s, $child, $name);
    self.UNSET-LATCH;
  }
  multi method add_named (GTK::Widget $child, gchar $name)  {
    self.SET-LATCH;
    %!by-name{$name} = $child;
    self.push-start($child);
    samewith($child.widget, $name);
  }

  multi method add_titled (GtkWidget $child, gchar $name, gchar $title) {
    unless self.IS-LATCHED {
      $!by-title{$name} = $child;
      self.push-start($child);
    }
    gtk_stack_add_titled($!s, $child, $name, $title);
    self.UNSET-LATCH;
  }
  multi method add_titled (GTK::Widget $child, gchar $name, gchar $title)  {
    self.SET-LATCH;
    %!by-title{$name} = $child;
    self.push-start($child);
    samewith($child.widget, $name, $title);
  }

  method get_child_by_name (gchar $name) {
    %!by-name{$name} // gtk_stack_get_child_by_name($!s, $name);
  }

  method get_child_by_title (Str $title) {
    %!by-title{$name};
  }

  method get_transition_running {
    gtk_stack_get_transition_running($!s);
  }

  method get_type {
    gtk_stack_get_type();
  }

  method set_visible_child_full (
    gchar $name,
    Int() $transition
  ) {
    my uint32 $t = self.RESOLVE-UINT($transition);
    gtk_stack_set_visible_child_full($!s, $name, $t);
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
