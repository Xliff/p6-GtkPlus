use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::Stack;
use GTK::Raw::Types;

use GTK::Container;

class GTK::Stack is GTK::Container {
  has GtkStack $!s;

  submethod BUILD(:$stack ) {
    given $stack {
      when GtkStack | GtkWidget {
        $!s = do {
          when GtkWidget { nativecast(Gtk , $!); }
          when GtkStack  { $stack }
        }
        self.setContainer($stack);
      }
      when GTK::Stack {
      }
      default {
      }
    }
    self.setType('GTK::Stack');
  }

  method new {
    my $stack = gtk_stack_new();
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
      STORE => sub ($, $hhomogeneous is copy) {
        gtk_stack_set_hhomogeneous($!s, $hhomogeneous);
      }
    );
  }

  method homogeneous is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_stack_get_homogeneous($!s);
      },
      STORE => sub ($, $homogeneous is copy) {
        gtk_stack_set_homogeneous($!s, $homogeneous);
      }
    );
  }

  method interpolate_size is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_stack_get_interpolate_size($!s);
      },
      STORE => sub ($, $interpolate_size is copy) {
        gtk_stack_set_interpolate_size($!s, $interpolate_size);
      }
    );
  }

  method transition_duration is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_stack_get_transition_duration($!s);
      },
      STORE => sub ($, $duration is copy) {
        gtk_stack_set_transition_duration($!s, $duration);
      }
    );
  }

  method transition_type is rw {
    Proxy.new(
      FETCH => sub ($) {
        GtkTransitionType( gtk_stack_get_transition_type($!s) );
      },
      STORE => sub ($, Int() $transition is copy) {
        my uint32 $t = $transition +& 0xffff;
        gtk_stack_set_transition_type($!s, $t);
      }
    );
  }

  method vhomogeneous is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_stack_get_vhomogeneous($!s);
      },
      STORE => sub ($, $vhomogeneous is copy) {
        gtk_stack_set_vhomogeneous($!s, $vhomogeneous);
      }
    );
  }

  method visible_child is rw {
    Proxy.new(
      FETCH => sub ($) {
        # Resolve widget to object based on stored children.
        gtk_stack_get_visible_child($!s);
      },
      STORE => sub ($, $child is copy) {
        my $c = given $child {
          when GtkWidget   { $child };
          when GTK::Widget { $child.widget; }
        };
        gtk_stack_set_visible_child($!s, $c);
      }
    );
  }

  method visible_child_name is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_stack_get_visible_child_name($!s);
      },
      STORE => sub ($, $name is copy) {
        gtk_stack_set_visible_child_name($!s, $name);
      }
    );
  }
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  multi method add_named (GtkWidget $child, gchar $name) {
    gtk_stack_add_named($!s, $child, $name);
  }
  multi method add_named (GTK::Widget $child, gchar $name)  {
    samewith($child.widget, $name);
  }

  multi method add_titled (GtkWidget $child, gchar $name, gchar $title) {
    gtk_stack_add_titled($!s, $child, $name, $title);
  }
  multi method add_titled (GTK::Widget $child, gchar $name, gchar $title)  {
    samewith($child.widget, $name, $title);
  }

  method get_child_by_name (gchar $name) {
    gtk_stack_get_child_by_name($!s, $name);
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
    my uint32 $t = $translation +& 0xffff;
    gtk_stack_set_visible_child_full($!s, $name, $t);
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
