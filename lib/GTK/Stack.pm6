use v6.c;

use Method::Also;

use GTK::Raw::Types;
use GTK::Raw::Stack;

use GTK::Container;
use GTK::StackSwitcher;
use GTK::StackSidebar;
use GTK::Widget;

our subset StackAncestry is export
  where GtkStack | ContainerAncestry;

class GTK::Stack is GTK::Container {
  has GtkStack $!s is implementor;
  has GTK::StackSwitcher $!ss;
  has GTK::StackSidebar $!sb;
  has %!by-name;
  has %!by-title;

  method bless(*%attrinit) {
    my $o = self.CREATE.BUILDALL(Empty, %attrinit);
    $o.setType($o.^name);
    $o;
  }

  submethod BUILD(:$stack, :$switcher) {
    my $to-parent;
    given $stack {
      when StackAncestry {
        $!s = do {
          when GtkStack  {
            $to-parent = cast(GtkContainer, $_);
            $_;
          }
          default {
            $to-parent = $_;
            cast(GtkStack, $_);
          }
        }
        self.setContainer($to-parent);
      }
      when GTK::Stack {
      }
      default {
      }
    }

    with $switcher {
      my $s = $switcher ??
        ($!ss = GTK::StackSwitcher.new) !! ($!sb = GTK::StackSidebar.new);
      $s.stack = $!s;
    }
  }

  method GTK::Raw::Definitions::GtkStack
    is also<
      Stack
      GtkStack
    >
  { $!s }

  multi method new (StackAncestry $stack, :$ref = True) {
    return Nil unless $stack;

    my $o = self.bless(:$stack);
    $o.ref if $ref;
    $o;
  }

  #
  # Until we can get types directly from the pointer without something like
  # GTK::Widget.setType, then we cannot reliably determine what control to
  # use when pulling a GtkStack from its pointer form.
  #
  # multi method new (GtkStack $stack) {
  #   my $switcher = True;
  #   self.bless(:$stack, :$switcher);
  # }
  #
  # Use setType, and default to Widget with a warning on creating if
  # setType gives us nothing.

  multi method new(:$switcher is copy = True, :$sidebar is copy = False) {
    $switcher = $sidebar.not with $sidebar;

    my $stack = gtk_stack_new();

    $stack ?? self.bless(:$stack, :$switcher) !! Nil;
  }

  # ↓↓↓↓ SIGNALS ↓↓↓↓
  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  method hhomogeneous is rw {
    Proxy.new(
      FETCH => sub ($) {
        so gtk_stack_get_hhomogeneous($!s);
      },
      STORE => sub ($, Int() $hhomogeneous is copy) {
        my gboolean $hh = $hhomogeneous.so.Int;

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
        my gboolean $h = $homogeneous.so.Int;

        gtk_stack_set_homogeneous($!s, $h);
      }
    );
  }

  method interpolate_size is rw is also<interpolate-size> {
    Proxy.new(
      FETCH => sub ($) {
        so gtk_stack_get_interpolate_size($!s);
      },
      STORE => sub ($, Int() $interpolate_size is copy) {
        my gboolean $is = $interpolate_size.so.Int;

        gtk_stack_set_interpolate_size($!s, $is);
      }
    );
  }

  method transition_duration is rw is also<transition-duration> {
    Proxy.new(
      FETCH => sub ($) {
        gtk_stack_get_transition_duration($!s);
      },
      STORE => sub ($, Int() $duration is copy) {
        my uint32 $d = $duration;

        gtk_stack_set_transition_duration($!s, $d);
      }
    );
  }

  method transition_type is rw is also<transition-type> {
    Proxy.new(
      FETCH => sub ($) {
        GtkStackTransitionTypeEnum( gtk_stack_get_transition_type($!s) );
      },
      STORE => sub ($, Int() $transition is copy) {
        my GtkStackTransitionType $t = $transition;

        gtk_stack_set_transition_type($!s, $t);
      }
    );
  }

  method vhomogeneous is rw {
    Proxy.new(
      FETCH => sub ($) {
        so gtk_stack_get_vhomogeneous($!s);
      },
      STORE => sub ($, Int() $vhomogeneous is copy) {
        my gboolean $vh = $vhomogeneous.so.Int;

        gtk_stack_set_vhomogeneous($!s, $vh);
      }
    );
  }

  method visible_child (:$raw = False, :$widget = False)
    is rw
    is also<visible-child>
  {
    Proxy.new(
      FETCH => sub ($) {
        my $w = gtk_stack_get_visible_child($!s);

        ReturnWidget($w, $raw, $widget);
      },
      STORE => sub ($, GtkWidget() $child is copy) {
        gtk_stack_set_visible_child($!s, $child);
      }
    );
  }

  method visible_child_name is rw is also<visible-child-name> {
    Proxy.new(
      FETCH => sub ($) {
        gtk_stack_get_visible_child_name($!s);
      },
      STORE => sub ($, Str() $name is copy) {
        gtk_stack_set_visible_child_name($!s, $name);
      }
    );
  }

  # YYY - Add attribute for 'control' to add either GtkStackSwitcher or
  #       GtkStackSidebar
  #       For now...control will return either the sidebar or the stack
  #       switcher object.
  method control {
    $!sb // $!ss
  }

  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  multi method add-named (GtkWidget $child, Str() $name) {
    self.add_named($child, $name);
  }
  multi method add_named (GtkWidget $child, Str() $name) {
    unless self.IS-LATCHED {
      %!by-name{$name} = $child;
      self.push-start($child);
    }
    gtk_stack_add_named($!s, $child, $name);
    self.UNSET-LATCH;
  }
  multi method add-named (GTK::Widget $child, Str() $name) {
    self.add_named($child, $name);
  }
  multi method add_named (GTK::Widget $child, Str() $name) {
    self.SET-LATCH;
    %!by-name{$name} = $child;
    self.push-start($child);
    samewith($child.Widget, $name);
  }

  multi method add-titled (GtkWidget $child, Str() $name, Str() $title) {
    self.add_titled($child, $name, $title);
  }
  multi method add_titled (GtkWidget $child, Str() $name, Str() $title) {
    unless self.IS-LATCHED {
      %!by-title{$name} = $child;
      self.push-start($child);
    }
    gtk_stack_add_titled($!s, $child, $name, $title);
    self.UNSET-LATCH;
  }
  multi method add-titled (GTK::Widget $child, Str() $name, Str() $title) {
    self.add_titled($child, $name, $title);
  }
  multi method add_titled (GTK::Widget $child, Str() $name, Str() $title) {
    self.SET-LATCH;
    %!by-title{$name} = $child;
    self.push-start($child);
    samewith($child.Widget, $name, $title);
  }

  method get_child_by_name (Str() $name) is also<get-child-by-name> {
    %!by-name{$name}
    //
    %!by-name{$name} = gtk_stack_get_child_by_name($!s, $name);
  }

  method get_child_by_title (Str $title) is also<get-child-by-title> {
    %!by-title{$title};
  }

  method get_transition_running is also<get-transition-running> {
    gtk_stack_get_transition_running($!s);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    GTK::Widget.unstable_get_type( &gtk_stack_get_type, $n, $t );
  }

  method set_visible_child_full (
    Str() $name,
    Int() $transition
  )
    is also<set-visible-child-full>
  {
    my uint32 $t = $transition;

    gtk_stack_set_visible_child_full($!s, $name, $t);
  }

  # The window on these methods is closing.
  #
  # Expose the Stack Switcher widget as GtkStackSwitcher
  method switcher {
    $!ss;
  }
  # Expose the StackSidebar object
  method sidebar {
    $!sb;
  }

  # ↑↑↑↑ METHODS ↑↑↑↑
  method child-set(GtkWidget() $c, *@propval) {
    my @notfound;
    @notfound = gather for @propval -> $p, $v {
      given $p {
        when 'icon-name'        |
             'name'             |
             'title'            { self.child-set-string($c, $p, $v) }

        when 'needs-attention'  { self.child-set-bool($c, $p, $v)   }

        when 'position'         { self.child-set-int($c, $p, $v)    }

        default                 { take $p; take $v;                 }
      }
    }
    nextwith($c, @notfound) if +@notfound;
  }

}
