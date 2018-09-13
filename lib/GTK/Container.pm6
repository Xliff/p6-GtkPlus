use v6.c;

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
    self.setType('GTK::Container');
  }

  submethod DESTROY {
    g_object_unref($_.data) for self.get_children.Array;
    g_object_unref(self.p);
  }

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

  method SET-LATCH {
    self.IS-PROTECTED;
    $!add-latch = True;
  }

  method UNSET-LATCH {
    self.IS-PROTECTED;
    $!add-latch = False;
  }

  method IS-LATCHED {
    self.IS-PROTECTED;
    $!add-latch;
  }

  method push-start($c) {
    # Write @!start.elems to GtkWidget under key GTKPlus-ContainerStart
    @!start.push: $c;
  }

  method unshift-end($c) {
    # Write @!end.elems to GtkWidget under key GTKPlus-ContainerEnd
    @!end.unshift: $c;
  }

  # Signal - First
  # Made multi to prevent a conflict with method add (GtkWidget)
  multi method add {
    self.connect($!c, 'add');
  }

  # Signal - Last
  multi method remove {
    self.connect($!c, 'remove');
  }

  # Signal - Last
  method check-resize {
    self.connect($!c, 'check-resize');
  }

  # Signal - Last
  method set-focus-child {
    self.connect($!c, 'set-focus-child');
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

  method focus_vadjustment is rw {
    Proxy.new(
      FETCH => sub ($) {
        my $adjustment = gtk_container_get_focus_vadjustment($!c);
        GTK::Adjustment.new(:$adjustment);
      },
      STORE => sub ($, $adjustment is copy) {
        gtk_container_set_focus_vadjustment($!c, $adjustment);
      }
    );
  }

  method focus_child is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_container_get_focus_child($!c);
      },
      STORE => sub ($, $child is copy) {
        gtk_container_set_focus_child($!c, $child);
      }
    );
  }

  method focus_hadjustment is rw {
    Proxy.new(
      FETCH => sub ($) {
        my $adjustment = gtk_container_get_focus_hadjustment($!c)
        GTK::Adjustment.new(:$adjustment);
      },
      STORE => sub ($, $adjustment is copy) {
        my GtkAdjustment $a = do given $adjustment {
          when GtkAdjustment   { $_; }
          when GTK::Adjustment { .adjustment; }
        };
        gtk_container_set_focus_hadjustment($!c, $a);
      }
    );
  }

  method border_width is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_container_get_border_width($!c);
      },
      STORE => sub ($, Int() $border_width is copy) {
        my $bw = self.RESOLVE-UINT($border_width, &?ROUTINE.name);
        gtk_container_set_border_width($!c, $bw);
      }
    );
  }

  multi method add (GtkWidget $widget) {
    gtk_container_add($!c, $widget);
  }
  multi method add (GTK::Widget $widget)  {
    samewith($widget.widget);
  }

  method check_resize {
    gtk_container_check_resize($!c);
  }

  multi method child_get_property (GtkWidget $child, gchar $property_name, GValue $value) {
    gtk_container_child_get_property($!c, $child, $property_name, $value);
  }
  multi method child_get_property (GTK::Widget $child, gchar $property_name, GValue $value)  {
    samewith($child.widget, $property_name, $value);
  }

  # A method for working with va_list could be the following:
  #   gchar         $first_property_name
  #   CArray[gchar] $property_names
  # multi method child_get_valist (GtkWidget $child, gchar $first_property_name, va_list $var_args) {
  #   gtk_container_child_get_valist($!c, $child, $first_property_name, $var_args);
  # }
  # multi method child_get_valist (GTK::Widget $child, gchar $first_property_name, va_list $var_args)  {
  #   samewith($child.widget, $first_property_name, $var_args);
  # }

  multi method child_notify (GtkWidget $child, gchar $child_property) {
    gtk_container_child_notify($!c, $child, $child_property);
  }
  multi method child_notify (GTK::Widget $child, gchar $child_property)  {
    samewith($child.widget, $child_property);
  }

  multi method child_notify_by_pspec (GtkWidget $child, GParamSpec $pspec) {
    gtk_container_child_notify_by_pspec($!c, $child, $pspec);
  }
  multi method child_notify_by_pspec (GTK::Widget $child, GParamSpec $pspec)  {
    samewith($child.widget, $pspec);
  }

  multi method child_set_property (GtkWidget $child, gchar $property_name, GValue $value) {
    gtk_container_child_set_property($!c, $child, $property_name, $value);
  }
  multi method child_set_property (GTK::Widget $child, gchar $property_name, GValue $value)  {
    samewith($child.widget, $property_name, $value);
  }

  # va_list:
  #   gchar         $first_property_name
  #   CArray[gchar] $property_names
  # multi method child_set_valist (GtkWidget $child, gchar $first_property_name, va_list $var_args) {
  #   gtk_container_child_set_valist($!c, $child, $first_property_name, $var_args);
  # }
  # multi method child_set_valist (GTK::Widget $child, gchar $first_property_name, va_list $var_args)  {
  #   samewith($child.widget, $first_property_name, $var_args);
  # }

  method child_type {
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

  method get_children(:$obj = True) {
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

  method get_focus_chain (GList $focusable_widgets) {
    gtk_container_get_focus_chain($!c, $focusable_widgets);
  }

  multi method get_path_for_child (GtkWidget $child) {
    gtk_container_get_path_for_child($!c, $child);
  }
  multi method get_path_for_child (GTK::Widget $child)  {
    samewith($child.widget);
  }

  method get_type {
    gtk_container_get_type();
  }

  multi method propagate_draw (GtkWidget $child, cairo_t $cr) {
    gtk_container_propagate_draw($!c, $child, $cr);
  }
  multi method propagate_draw (GTK::Widget $child, cairo_t $cr)  {
    samewith($child.widget, $cr);
  }

  multi method remove (GtkWidget $widget) {
    gtk_container_remove($!c, $widget);
  }
  multi method remove (GTK::Widget $widget)  {
    samewith($widget.widget);
  }

  method resize_children () {
    gtk_container_resize_children($!c);
  }

  method set_reallocate_redraws (Int() $needs_redraws) {
    my gboolean $nr = self.RESOLVE-BOOL($needs_redraws, &?ROUTINE.name);
    gtk_container_set_reallocate_redraws($!c, $nr);
  }

  method unset_focus_chain {
    gtk_container_unset_focus_chain($!c);
  }
}
