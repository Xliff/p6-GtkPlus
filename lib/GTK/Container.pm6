use v6.c;

use Method::Also;
use NativeCall;

use GTK::Compat::Types;

use GTK::Raw::Container;
use GTK::Raw::Subs;
use GTK::Raw::Types;

use GTK::Adjustment;
use GTK::Widget;

use GTK::Roles::LatchedContents;

our subset ContainerAncestry is export
  where GtkContainer | GtkBuildable | GtkWidget;

class GTK::Container is GTK::Widget {
  also does GTK::Roles::LatchedContents;

  # Maybe this should be done as the base class.
  has $!c;

  # Even though an abstract class, we have to be able to instantiate from
  # a lowest common denominator amongst descendants.
  submethod BUILD(:$container) {
    given $container {
      when Ancestry {
        self.setContainer($container);
      }
      default {
        # Can't die here since descendants depend on this getting through
        # the custom bless. This only applies for abstract classes.
      }
    }
  }

  #submethod DESTROY {
  #  g_object_unref($_.data) for self.get_children.Array;
  #  g_object_unref(self.widget);
  #}

  method setContainer($container) {
    my $to-parent;
    $!c = do given $container {
      when GtkContainer {
        $to-parent = nativecast(GtkWidget, $_);
        $_;
      }
      default {
        $to-parent = $_;
        nativecast(GtkContainer, $_);
      }
    }
    self.setWidget($to-parent);
  }

  method new (Ancestry $container) {
    my $o = self.bless(:$container);
    $o.upref;
    $o;
  }

  method GTK::Raw::Types::GtkContainer {
    $!c;
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

  # EXPERIMENTAL! -- Do not use unless ready to test!
  method child-get(*@propval) is also<child_get> {
    die qq:to/D/.chomp if @propval.flat.elems % 2;
GTK::Container.child-get() must be a list containing <prop> followed by
<variable> elements.
D

    subset SignedInt of Int where * < 0;
    for @propval -> $p, $v is rw {
      given $v {
        when Str       { self.child-get-string($p, $v) }
        when SignedInt {    self.child-get-int($p, $v) }
        when Int       {   self.child-get-uint($p, $v) }
        when Bool      {   self.child-get-bool($p, $v) }

        when int64 | int32 | int16 | int8 {
          self.child-get-int($p, $v);
        }

        when uint64 | uint32 | uint16 | uint8 {
          self.child-get-uint($p, $v);
        }

        default {
          die qq:to/D/.chomp;
          Unsupported type { .^name } passed to GTK::Container.child-get
          D
        }
      }
    }
  }

  method child-set (GtkWidget(), *@propval) {
    die qq:to/D/.chomp
The following properties are not valid for GTK::Container.child-set:
{ @propval.rotor(1 => 1).map( "\t'*'" ).join("\n") }
D
  }

  # For child attributes.
  proto method child-get-string (|) is also<child_get_string> { * }

  multi method child-get-string(GtkWidget() $child, Str() $prop) {
    my Str $a = '';
    samewith($child, $prop, $a);
    $a
  }
  multi method child-get-string (
    GtkWidget() $child,
    Str() $prop,
    Str $val is rw
  ) {
    gtk_container_child_get_str($!c, $child, $prop, $val, Str);
  }

  method child-set-string(
    GtkWidget() $child,
    Str() $prop,
    Str() $v
  )
    is also<child_set_string>
  {
    gtk_container_child_set_str($!c, $child, $prop, $v, Str);
  }

  proto method child-get-bool (|) is also<child_get_bool> { * }

  multi method child-get-bool(GtkWidget() $child, Str() $prop) {
    my uint32 $b = 0;
    samewith($child, $prop, $b);
    $b;
  }
  multi method child-get-bool (
    GtkWidget() $child,
    Str() $prop,
    Int $val is rw
  ) {
    my guint $v = self.RESOLVE-BOOL($val);
    # CArray[guint]?
    gtk_container_child_get_uint($!c, $child, $prop, $v, Str);
    $val = $v;
  }

  method child-set-bool(
    GtkWidget() $child,
    Str() $prop,
    Int() $val
  )
    is also<child_set_bool>
  {
    my guint $v = self.RESOLVE-BOOL($val);
    gtk_container_child_set_uint($!c, $child, $prop, $v, Str);
  }

  proto method child-get-int (|) is also<child_get_int> { * }

  multi method child-get-int (GtkWidget() $child, Str() $prop) {
    my gint $i = 0;
    samewith($child, $prop, $i);
    $i;
  }

  multi method child-get-int (
    GtkWidget() $child,
    Str() $prop,
    Int $val is rw
  ) {
    my guint $v = self.RESOLVE-INT($val);
    # CArray[guint]?
    gtk_container_child_get_int($!c, $child, $prop, $v, Str);
    $val = $v
  }

  method child-set-int (
    GtkWidget() $child,
    Str() $prop,
    Int() $val
  )
    is also<child_set_int>
  {
    my gint $v = self.RESOLVE-INT($val);
    gtk_container_child_set_int($!c, $child, $prop, $v, Str);
  }

  proto method child-get-uint (|) is also<child_get_uint> { * }

  multi method child-get-uint (GtkWidget() $child, Str() $prop) {
    my guint $i = 0;
    samewith($child, $prop, $i);
    $i;
  }

  multi method child-get-uint (
    GtkWidget() $child,
    Str() $prop,
    Int $val is rw
  ) {
    my guint $v = self.RESOLVE-UINT($val);
    # CArray[guint]?
    gtk_container_child_get_uint($!c, $child, $prop, $v, Str);
    $val = $v;
  }

  method child-set-uint (
    GtkWidget() $child,
    Str() $prop,
    Int() $val
  )
    is also<child_set_uint>
  {
    my gint $v = self.RESOLVE-UINT($val);
    gtk_container_child_set_uint($!c, $child, $prop, $v, Str);
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

  multi method add (GTK::Widget $widget) {
    @!end.push: $widget;
    self.SET-LATCH;
    samewith($widget.widget);
  }
  multi method add (GtkWidget $widget) {
    @!end.push: $widget unless self.IS-LATCHED;
    self.UNSET-LATCH;
    gtk_container_add($!c, $widget);
  }

  method emit_check_resize is also<emit-check-resize> {
    gtk_container_check_resize($!c);
  }

  method child_get_property (
    GtkWidget() $child,
    Str() $property_name,
    GValue() $value
  )
    is also<child-get-property>
  {
    gtk_container_child_get_property($!c, $child, $property_name, $value);
  }

  # A method for working with va_list could be the following:
  #   gchar         $first_property_name
  #   CArray[gchar] $property_names
  # method child_get_valist (GtkWidget $child, Str() $first_property_name, va_list $var_args) {
  #   gtk_container_child_get_valist($!c, $child, $first_property_name, $var_args);
  # }
  # method child_get_valist (GTK::Widget $child, Str() $first_property_name, va_list $var_args)  {
  #   samewith($child.widget, $first_property_name, $var_args);
  # }

  method child_notify (GtkWidget() $child, Str() $child_property)
    is also<child-notify>
  {
    gtk_container_child_notify($!c, $child, $child_property);
  }

  method child_notify_by_pspec (GtkWidget() $child, GParamSpec $pspec)
    is also<child-notify-by-pspec>
  {
    gtk_container_child_notify_by_pspec($!c, $child, $pspec);
  }

  method child_set_property (
    GtkWidget() $child,
    Str() $property_name,
    GValue() $value
  )
    is also<child-set-property>
  {
    gtk_container_child_set_property($!c, $child, $property_name, $value);
  }

  # va_list:
  #   gchar         $first_property_name
  #   CArray[gchar] $property_names
  # method child_set_valist (GtkWidget $child, Str() $first_property_name, va_list $var_args) {
  #   gtk_container_child_set_valist($!c, $child, $first_property_name, $var_args);
  # }
  # method child_set_valist (GTK::Widget $child, Str() $first_property_name, va_list $var_args)  {
  #   samewith($child.widget, $first_property_name, $var_args);
  # }

  method child_type is also<child-type> {
     gtk_container_child_type($!c);
  }

  # All modules take a GtkContainerClass.
  # method class_find_child_property (Str() $property_name) {
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

  method get_focus_chain (GList $focusable_widgets)
    is also<get-focus-chain>
  {
    gtk_container_get_focus_chain($!c, $focusable_widgets);
  }

  method get_path_for_child (GtkWidget() $child)
    is also<get-path-for-child>
  {
    gtk_container_get_path_for_child($!c, $child);
  }

  method get_type is also<get-type> {
    gtk_container_get_type();
  }

  method propagate_draw (GtkWidget() $child, cairo_t $cr)
    is also<propagate-draw>
  {
    gtk_container_propagate_draw($!c, $child, $cr);
  }

  multi method remove (GtkWidget() $widget) {
    for (@!start, @!end) -> @l {
      @l .= grep({
        do {
          when GTK::Widget { +.widget.p != +$widget.p }
          when GtkWidget   {        +.p != +$widget.p }
        }
      });
    }
    gtk_container_remove($!c, $widget);
  }

  method resize_children is also<resize-children> {
    gtk_container_resize_children($!c);
  }

  method set_reallocate_redraws (Int() $needs_redraws)
    is also<set-reallocate-redraws>
  {
    my gboolean $nr = self.RESOLVE-BOOL($needs_redraws);
    gtk_container_set_reallocate_redraws($!c, $nr);
  }

  method unset_focus_chain is also<unset-focus-chain> {
    gtk_container_unset_focus_chain($!c);
  }
}
