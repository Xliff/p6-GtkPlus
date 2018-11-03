use v6.c;

use Method::Also;
use NativeCall;

use GTK::Compat::Types;

use GTK::Raw::Container;
use GTK::Raw::Subs;
use GTK::Raw::Types;

use GTK::Adjustment;
use GTK::Widget;

class GTK::Container is GTK::Widget {
  # Maybe this should be done as the base class.
  has $!c;
  has $!add-latch;
  has @!start;
  has @!end;

  submethod BUILD (:$container) {
    given $container {
      when GtkContainer | GtkWidget {
        self.setContainer($container);
      }
      when GTK::Container {
      }
      default {
      }
    }
  }

  #submethod DESTROY {
  #  g_object_unref($_.data) for self.get_children.Array;
  #  g_object_unref(self.widget);
  #}

  # GTK::Container is abstract, so no need for new.

  method setContainer($container) {
    my $to-parent;
    $!c = do given $container {
      when GtkWidget {
        $to-parent = $_;
        nativecast(GtkContainer, $_);
      }
      when GtkContainer {
        $to-parent = nativecast(GtkWidget, $_);
        $_;
      }
    }
    self.setWidget($to-parent);
  }

  method GTK::Raw::Types::GtkContainer {
    $!c;
  }

  method SET-LATCH is also<SET_LATCH> {
    self.IS-PROTECTED;
    $!add-latch = True;
  }

  method UNSET-LATCH is also<UNSET_LATCH> {
    self.IS-PROTECTED;
    $!add-latch = False;
  }

  method IS-LATCHED is also<IS_LATCHED> {
    self.IS-PROTECTED;
    $!add-latch;
  }

  method INSERT-START ($child, $pos) is also<INSERT_START> {
    self.IS-PROTECTED;

    my $last = @!start.elems - 1;
    if $pos == 0 {
      self.prepend($child)
    } elsif $pos > $last {
      self.append($child);
    } else {
      @!start = (
        @!start[ 0..$pos-1 ],
        $child,
        @!start[ $pos..$last ]
      ).flat;
    }
  }

  method push-start($c) is also<push_start> {
    # Write @!start.elems to GtkWidget under key GTKPlus-ContainerStart
    @!start.push: $c;
  }

  method unshift-end($c) is also<unshift_end> {
    # Write @!end.elems to GtkWidget under key GTKPlus-ContainerEnd
    @!end.unshift: $c;
  }

  # Signal - First
  # Made multi to prevent a conflict with method add (GtkWidget)
  multi method add {
    self.connect-widget($!c, 'add');
  }

  # Signal - Last
  # Made multi to prevent a conflict with method remove (GtkWidget)
  multi method remove {
    self.connect-widget($!c, 'remove');
  }

  # Signal - Last
  method check-resize is also<check_resize> {
    self.connect($!c, 'check-resize');
  }

  # Signal - Last
  method set-focus-child is also<set_focus_child> {
    self.connect-widget($!c, 'set-focus-child');
  }


#Function definition finished, but detected no match:
#' void         gtk_container_add_with_properties                (GtkContainer      *container,                      GtkWidget          *widget,                                                      const gchar       *first_prop_name,                                                         ...) G_GNUC_NULL_TERMINATED;'
#Function definition finished, but detected no match:
#' void         gtk_container_child_set                  (GtkContainer      *container,                              GtkWidget          *child,                                                       const gchar       *first_prop_name,                                                         ...) G_GNUC_NULL_TERMINATED;'
#Function definition finished, but detected no match:
#' void         gtk_container_child_get                  (GtkContainer      *container,                              GtkWidget          *child,                                                       const gchar       *first_prop_name,                                                         ...) G_GNUC_NULL_TERMINATED;'

# cw: YYY - This is how you check the call chain - YYYs
#perl6 -e 'sub a { b(); }; sub b { c(); }; sub c { my @a = Backtrace.new.list; @a[*-2].gist.say }; a()'
#Backtrace::Frame.new(file => "-e", line => 1, code => sub a () { #`(Sub|93842260662800) ... }, subname => "a")

  # method resize_mode is rw {
  #   Proxy.new(
  #     FETCH => sub ($) {
  #       gtk_container_get_resize_mode($!c);
  #     },
  #     STORE => sub ($, $resize_mode is copy) {
  #       gtk_container_set_resize_mode($!c, $resize_mode);
  #     }
  #   );
  # }

  method focus_vadjustment is rw is also<focus-vadjustment> {
    Proxy.new(
      FETCH => sub ($) {
        my $adjustment = gtk_container_get_focus_vadjustment($!c);
        GTK::Adjustment.new(:$adjustment);
      },
      STORE => sub ($, GtkAdjustment() $adjustment is copy) {
        gtk_container_set_focus_vadjustment($!c, $adjustment);
      }
    );
  }

  method focus_child is rw is also<focus-child> {
    Proxy.new(
      FETCH => sub ($) {
        gtk_container_get_focus_child($!c);
      },
      STORE => sub ($, $child is copy) {
        gtk_container_set_focus_child($!c, $child);
      }
    );
  }

  method focus_hadjustment is rw is also<focus-hadjustment> {
    Proxy.new(
      FETCH => sub ($) {
        my $adjustment = gtk_container_get_focus_hadjustment($!c);
        GTK::Adjustment.new(:$adjustment);
      },
      STORE => sub ($, GtkAdjustment() $adjustment is copy) {
        gtk_container_set_focus_hadjustment($!c, $adjustment);
      }
    );
  }

  method border_width is rw is also<border-width> {
    Proxy.new(
      FETCH => sub ($) {
        gtk_container_get_border_width($!c);
      },
      STORE => sub ($, Int() $border_width is copy) {
        my $bw = self.RESOLVE-UINT($border_width);
        gtk_container_set_border_width($!c, $bw);
      }
    );
  }

  multi method add (GtkWidget $widget) {
    @!end.push: $widget unless self.IS-LATCHED;
    self.UNSET-LATCH;
    gtk_container_add($!c, $widget);
  }
  multi method add (GTK::Widget $widget) {
    @!end.push: $widget;
    self.SET-LATCH;
    samewith($widget.widget);
  }

  method emit_check_resize is also<emit-check-resize> {
    gtk_container_check_resize($!c);
  }

  method child_get_property (
    GtkWidget() $child,
    gchar $property_name,
    GValue $value
  ) is also<child-get-property> {
    gtk_container_child_get_property($!c, $child, $property_name, $value);
  }

  # A method for working with va_list could be the following:
  #   gchar         $first_property_name
  #   CArray[gchar] $property_names
  # method child_get_valist (GtkWidget $child, gchar $first_property_name, va_list $var_args) {
  #   gtk_container_child_get_valist($!c, $child, $first_property_name, $var_args);
  # }
  # method child_get_valist (GTK::Widget $child, gchar $first_property_name, va_list $var_args)  {
  #   samewith($child.widget, $first_property_name, $var_args);
  # }

  method child_notify (GtkWidget() $child, gchar $child_property) is also<child-notify> {
    gtk_container_child_notify($!c, $child, $child_property);
  }

  method child_notify_by_pspec (GtkWidget() $child, GParamSpec $pspec) is also<child-notify-by-pspec> {
    gtk_container_child_notify_by_pspec($!c, $child, $pspec);
  }

  method child_set_property (
    GtkWidget() $child,
    gchar $property_name,
    GValue $value
  ) is also<child-set-property> {
    gtk_container_child_set_property($!c, $child, $property_name, $value);
  }

  # va_list:
  #   gchar         $first_property_name
  #   CArray[gchar] $property_names
  # method child_set_valist (GtkWidget $child, gchar $first_property_name, va_list $var_args) {
  #   gtk_container_child_set_valist($!c, $child, $first_property_name, $var_args);
  # }
  # method child_set_valist (GTK::Widget $child, gchar $first_property_name, va_list $var_args)  {
  #   samewith($child.widget, $first_property_name, $var_args);
  # }

  method child_type is also<child-type> {
     gtk_container_child_type($!c);
  }

  # All modules take a GtkContainerClass.
  # method class_find_child_property (gchar $property_name) {
  #   gtk_container_class_find_child_property($!c, $property_name);
  # }
  #
  # method class_handle_border_width {
  #   gtk_container_class_handle_border_width($!c);
  # }
  #
  # method class_install_child_properties (guint $n_pspecs, GParamSpec $pspecs) {
  #   gtk_container_class_install_child_properties($!c, $n_pspecs, $pspecs);
  # }
  #
  # method class_install_child_property (guint $property_id, GParamSpec $pspec) {
  #   gtk_container_class_install_child_property($!c, $property_id, $pspec);
  # }
  #
  # method class_list_child_properties (guint $n_properties) {
  #   gtk_container_class_list_child_properties($!c, $n_properties);
  # }

  method forall (GtkCallback $callback, gpointer $callback_data) {
    gtk_container_forall($!c, $callback, $callback_data);
  }

  method foreach (GtkCallback $callback, gpointer $callback_data) {
    gtk_container_foreach($!c, $callback, $callback_data);
  }

  method get_children(:$obj = True) is also<get-children> {
    # my @children;
    # my $list = gtk_container_get_children($!c);
    # say "List start: { $list }";
    # while $list {
    #   @children.push: GTK::Widget.new($list.data);
    #   $list = $list.next;
    #   say "List next: { $list }";
    # }
    # @children;
    (@!start, @!end).flat;
  }

  method get_focus_chain (GList $focusable_widgets) is also<get-focus-chain> {
    gtk_container_get_focus_chain($!c, $focusable_widgets);
  }

  method get_path_for_child (GtkWidget() $child) is also<get-path-for-child> {
    gtk_container_get_path_for_child($!c, $child);
  }

  method get_type is also<get-type> {
    gtk_container_get_type();
  }

  method propagate_draw (GtkWidget() $child, cairo_t $cr) is also<propagate-draw> {
    gtk_container_propagate_draw($!c, $child, $cr);
  }

  multi method remove (GtkWidget() $widget) {
    @!end .= grep({
      do {
        when GtkWidget   {        $_ !== $widget }
        when GTK::Widget { $_.widget !== $widget }
      }
    });
    gtk_container_remove($!c, $widget);
  }

  method resize_children is also<resize-children> {
    gtk_container_resize_children($!c);
  }

  method set_reallocate_redraws (Int() $needs_redraws) is also<set-reallocate-redraws> {
    my gboolean $nr = self.RESOLVE-BOOL($needs_redraws, &?ROUTINE.name);
    gtk_container_set_reallocate_redraws($!c, $nr);
  }

  method unset_focus_chain is also<unset-focus-chain> {
    gtk_container_unset_focus_chain($!c);
  }
}
