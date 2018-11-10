v6.c;

use Method::Also;
use NativeCall;

use GTK::Compat::Types;
use GTK::Compat::Value;
use GTK::Raw::StyleContext;
use GTK::Raw::Types;

use GTK::Roles::Signals::Generic;
use GTK::Roles::Types;

class GTK::StyleContext {
  also does GTK::Roles::Signals::Generic;
  also does GTK::Roles::Types;

  has GtkStyleContext $!sc;

  submethod BUILD(:$context) {
    $!sc = $context;
  }

  submethod DESTROY {
    self.disconnect-all($_) for %!signals;
  }

  # ↓↓↓↓ SIGNALS ↓↓↓↓

  # Is originally:
  # GtkStyleContext, gpointer --> void
  method changed {
    self.connect($!sc, 'changed');
  }

  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ PROPERTIES ↓↓↓↓

  # Type: GtkTextDirection
  method direction is rw {
    my GTK::Compat::Value $gv .= new( G_TYPE_ENUM );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get('direction', $gv)
        );
        GtkTextDirection( $gv.enum );
      },
      STORE => -> $, Int() $val is copy {
        $gv.enum = self.RESOLVE-UINT($val);
        self.prop_set('direction', $gv);
      }
    );
  }

  # Type: GdkFrameClock
  method paint-clock is rw is also<paint_clock> {
    my GTK::Compat::Value $gv .= new( G_TYPE_OBJECT );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get('paint-clock', $gv)
        );
        nativecast(GdkFrameClock, $gv.object);
      },
      STORE => -> $, GdkFrameClock $val is copy {
        $gv.object = $val;
        self.prop_set('paint-clock', $gv);
      }
    );
  }

  # Type: GtkStyleContext
  method parent is rw {
    my GTK::Compat::Value $gv .= new( G_TYPE_OBJECT );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get('parent', $gv)
        );
        GTK::StyleContext.new( nativecast(GtkStyleContext, $gv.object ) );
      },
      STORE => -> $, GtkStyleContext() $val is copy {
        $gv.object = $val;
        self.prop_set('parent', $gv);
      }
    );
  }

  # Type: GdkScreen
  method screen is rw {
    my GTK::Compat::Value $gv .= new( G_TYPE_OBJECT );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get('screen', $gv)
        );
        nativecast(GdkScreen, $gv.object);
      },
      STORE => -> $, GdkScreen $val is copy {
        $gv.object = $val;
        self.prop_set('screen', $gv);
      }
    );
  }

  # ↑↑↑↑ PROPERTIES ↑↑↑↑

  method render_activity (
    GtkStyleContext $context,
    cairo_t $cr,
    gdouble $x,
    gdouble $y,
    gdouble $width,
    gdouble $height
  )
    is also<render-activity>
  {
    gtk_render_activity($context, $cr, $x, $y, $width, $height);
  }

  method render_arrow  (
    GtkStyleContext() $context,
    cairo_t $cr,
    gdouble $angle,
    gdouble $x,
    gdouble $y,
    gdouble $size
  )
    is also<render-arrow>
  {
    gtk_render_arrow($context, $cr, $angle, $x, $y, $size);
  }

  method render_background (
    GtkStyleContext() $context,
    cairo_t $cr,
    gdouble $x,
    gdouble $y,
    gdouble $width,
    gdouble $height
  )
    is also<render-background>
  {
    gtk_render_background($context, $cr, $x, $y, $width, $height);
  }

  method render_background_get_clip  (
    GtkStyleContext() $context,
    gdouble $x,
    gdouble $y,
    gdouble $width,
    gdouble $height,
    GdkRectangle $out_clip
  )
    is also<render_background_get-clip>
  {
    gtk_render_background_get_clip(
      $context,
      $x, $y,
      $width, $height,
      $out_clip
    );
  }

  method render_check (
    GtkStyleContext() $context,
    cairo_t $cr,
    gdouble $x,
    gdouble $y,
    gdouble $width,
    gdouble $height
  )
    is also<render-check>
  {
    gtk_render_check($context, $cr, $x, $y, $width, $height);
  }

  method render_expander (
    GtkStyleContext() $context,
    cairo_t $cr,
    gdouble $x,
    gdouble $y,
    gdouble $width,
    gdouble $height
  )
    is also<render-expander>
  {
    gtk_render_expander($context, $cr, $x, $y, $width, $height);
  }

  method render_extension (
    GtkStyleContext() $context,
    cairo_t $cr,
    gdouble $x,
    gdouble $y,
    gdouble $width,
    gdouble $height,
    GtkPositionType $gap_side
  )
    is also<render-extension>
  {
    gtk_render_extension($context, $cr, $x, $y, $width, $height, $gap_side);
  }

  method render_focus (
    GtkStyleContext() $context,
    cairo_t $cr,
    gdouble $x,
    gdouble $y,
    gdouble $width,
    gdouble $height
  )
    is also<render-focus>
  {
    gtk_render_focus($context, $cr, $x, $y, $width, $height);
  }

  method render_frame (
    GtkStyleContext() $context,
    cairo_t $cr,
    gdouble $x,
    gdouble $y,
    gdouble $width,
    gdouble $height
  )
    is also<render-frame>
  {
    gtk_render_frame($context, $cr, $x, $y, $width, $height);
  }

  method render_frame_gap (
    GtkStyleContext() $context,
    cairo_t $cr,
    gdouble $x,
    gdouble $y,
    gdouble $width,
    gdouble $height,
    GtkPositionType $gap_side,
    gdouble $xy0_gap,
    gdouble $xy1_gap
  )
    is also<render_frame-gap>
  {
    gtk_render_frame_gap(
      $context,
      $cr,
      $x, $y,
      $width, $height,
      $gap_side,
      $xy0_gap, $xy1_gap
    );
  }

  method render_handle (
    GtkStyleContext() $context,
    cairo_t $cr,
    gdouble $x,
    gdouble $y,
    gdouble $width,
    gdouble $height
  )
   is also<render-handle>
  {
    gtk_render_handle($context, $cr, $x, $y, $width, $height);
  }

  method render_icon (
    GtkStyleContext() $context,
    cairo_t $cr,
    GdkPixbuf() $pixbuf,
    gdouble $x,
    gdouble $y
  )
    is also<render-icon>
  {
    gtk_render_icon($context, $cr, $pixbuf, $x, $y);
  }

  method render_icon_pixbuf (
    GtkStyleContext() $context,
    GtkIconSource $source,
    GtkIconSize $size
  )
    is also<render_icon-pixbuf>
  {
    gtk_render_icon_pixbuf($context, $source, $size);
  }

  method render_icon_surface (
    GtkStyleContext() $context,
    cairo_t $cr,
    cairo_surface_t $surface,
    gdouble $x,
    gdouble $y
  )
    is also<render_icon-surface>
  {
    gtk_render_icon_surface($context, $cr, $surface, $x, $y);
  }

  method render_layout  (
    GtkStyleContext() $context,
    cairo_t $cr,
    gdouble $x,
    gdouble $y,
    PangoLayout $layout
  )
    is also<render-layout>
  {
    gtk_render_layout($context, $cr, $x, $y, $layout);
  }

  method render_line (
    GtkStyleContext() $context,
    cairo_t $cr,
    gdouble $x0,
    gdouble $y0,
    gdouble $x1,
    gdouble $y1
  )
    is also<render-line>
  {
    gtk_render_line($context, $cr, $x0, $y0, $x1, $y1);
  }

  method render_option is (
    GtkStyleContext() $context,
    cairo_t $cr,
    gdouble $x,
    gdouble $y,
    gdouble $width,
    gdouble $height
  )
    is also<render-option>
  {
    gtk_render_option($context, $cr, $x, $y, $width, $height);
  }

  method render_slider (
    GtkStyleContext() $context,
    cairo_t $cr,
    gdouble $x,
    gdouble $y,
    gdouble $width,
    gdouble $height,
    GtkOrientation $orientation
  )
    is also<render-slider>
  {
    gtk_render_slider($context, $cr, $x, $y, $width, $height, $orientation);
  }


  # ↓↓↓↓ METHODS ↓↓↓↓
  method add_class (Str() $class_name) is also<add-class> {
    gtk_style_context_add_class($!sc, $class_name);
  }

  method add_provider (GtkStyleProvider $provider, guint $priority)
    is also<add-provider>
  {
    gtk_style_context_add_provider($!sc, $provider, $priority);
  }

  method add_provider_for_screen (
    GdkScreen $screen,
    GtkStyleProvider $provider,
    guint $priority
  )
    is also<add-provider-for-screen>
  {
    gtk_style_context_add_provider_for_screen($screen, $provider, $priority);
  }

  method add_region (
    Str() $region_name,
    GtkRegionFlags $flags
  )
    is also<add-region>
  {
    gtk_style_context_add_region($!sc, $region_name, $flags);
  }

  method cancel_animations (gpointer $region_id) is also<cancel-animations> {
    gtk_style_context_cancel_animations($!sc, $region_id);
  }

  method get_background_color (
    GtkStateFlags $state,
    GdkRGBA $color
  )
    is also<get-background-color>
  {
    gtk_style_context_get_background_color($!sc, $state, $color);
  }

  method get_border (GtkStateFlags $state, GtkBorder $border)
    is also<get-border>
  {
    gtk_style_context_get_border($!sc, $state, $border);
  }

  method get_border_color (GtkStateFlags $state, GdkRGBA $color)
    is also<get-border-color>
  {
    gtk_style_context_get_border_color($!sc, $state, $color);
  }

  method get_color (GtkStateFlags $state, GdkRGBA $color) is also<get-color> {
    gtk_style_context_get_color($!sc, $state, $color);
  }

  method get_font (GtkStateFlags $state) is also<get-font> {
    gtk_style_context_get_font($!sc, $state);
  }

  method get_margin (GtkStateFlags $state, GtkBorder $margin)
    is also<get-margin>
  {
    gtk_style_context_get_margin($!sc, $state, $margin);
  }

  method get_padding (GtkStateFlags $state, GtkBorder $padding)
    is also<get-padding>
  {
    gtk_style_context_get_padding($!sc, $state, $padding);
  }

  method get_property (
    Str() $property,
    GtkStateFlags $state,
    GValue $value
  )
    is also<get-property>
  {
    gtk_style_context_get_property($!sc, $property, $state, $value);
  }

  method get_section (Str() $property) is also<get-section> {
    gtk_style_context_get_section($!sc, $property);
  }

  method get_style_property (Str() $property_name, GValue $value)
    is also<get-style-property>
  {
    gtk_style_context_get_style_property($!sc, $property_name, $value);
  }

  method get_type is also<get-type> {
    gtk_style_context_get_type();
  }

  method gtk_draw_insertion_cursor (
    GtkWidget() $widget,
    cairo_t $cr,
    GdkRectangle $location,
    gboolean $is_primary,
    GtkTextDirection $direction,
    gboolean $draw_arrow
  )
    is also<gtk-draw-insertion-cursor>
  {
    gtk_draw_insertion_cursor(
      $widget,
      $cr,
      $location,
      $is_primary,
      $direction,
      $draw_arrow
    );
  }

  method gtk_icon_set_render_icon_pixbuf (
    GtkIconSet $set,
    GtkStyleContext $context,
    GtkIconSize $size
  )
    is also<gtk-icon-set-render-icon-pixbuf>
  {
    gtk_icon_set_render_icon_pixbuf($set, $context, $size);
  }

  method gtk_icon_set_render_icon_surface (
    GtkIconSet $set,
    GtkStyleContext $context,
    GtkIconSize $size,
    gint $scale,
    GdkWindow $for_window
  )
    is also<gtk-icon-set-render-icon-surface>
  {
    gtk_icon_set_render_icon_surface(
      $set,
      $context,
      $size,
      $scale,
      $for_window
    );
  }

  method gtk_render_insertion_cursor (
    cairo_t $cr,
    gdouble $x,
    gdouble $y,
    PangoLayout $layout,
    int $index,
    PangoDirection $direction
  )
    is also<gtk-render-insertion-cursor>
  {
    gtk_render_insertion_cursor(
      $!sc,
      $cr,
      $x,
      $y,
      $layout,
      $index,
      $direction
    );
  }

  method has_class (Str() $class_name) is also<has-class> {
    gtk_style_context_has_class($!sc, $class_name);
  }

  method has_region (Str() $region_name, GtkRegionFlags $flags_return)
    is also<has-region>
  {
    gtk_style_context_has_region($!sc, $region_name, $flags_return);
  }

  method invalidate {
    gtk_style_context_invalidate($!sc);
  }

  method list_classes is also<list-classes> {
    gtk_style_context_list_classes($!sc);
  }

  method list_regions is also<list-regions> {
    gtk_style_context_list_regions($!sc);
  }

  method lookup_color (Str() $color_name, GdkRGBA $color)
    is also<lookup-color>
  {
    gtk_style_context_lookup_color($!sc, $color_name, $color);
  }

  method lookup_icon_set (Str() $stock_id) is also<lookup-icon-set> {
    gtk_style_context_lookup_icon_set($!sc, $stock_id);
  }

  method new {
    gtk_style_context_new();
  }

  method notify_state_change (
    GdkWindow $window,
    gpointer $region_id,
    GtkStateType $state,
    gboolean $state_value
  )
    is also<notify-state-change>
  {
    gtk_style_context_notify_state_change(
      $!sc,
      $window,
      $region_id,
      $state,
      $state_value
    );
  }

  method pop_animatable_region is also<pop-animatable-region> {
    gtk_style_context_pop_animatable_region($!sc);
  }

  method push_animatable_region (gpointer $region_id)
    is also<push-animatable-region>
  {
    gtk_style_context_push_animatable_region($!sc, $region_id);
  }

  method remove_class (Str() $class_name) is also<remove-class> {
    gtk_style_context_remove_class($!sc, $class_name);
  }

  method remove_provider (GtkStyleProvider $provider)
    is also<remove-provider>
  {
    gtk_style_context_remove_provider($!sc, $provider);
  }

  method remove_provider_for_screen (
    GdkScreen $screen,
    GtkStyleProvider $provider
  )
    is also<remove-provider-for-screen>
  {
    gtk_style_context_remove_provider_for_screen($screen, $provider);
  }

  method remove_region (Str() $region_name) is also<remove-region> {
    gtk_style_context_remove_region($!sc, $region_name);
  }

  method reset_widgets(GdkScreen $screen) is also<reset-widgets> {
    gtk_style_context_reset_widgets($screen);
  }

  method restore {
    gtk_style_context_restore($!sc);
  }

  method save {
    gtk_style_context_save($!sc);
  }

  method scroll_animations (GdkWindow $window, gint $dx, gint $dy)
    is also<scroll-animations>
  {
    gtk_style_context_scroll_animations($!sc, $window, $dx, $dy);
  }

  method set_background (GdkWindow $window) is also<set-background> {
    gtk_style_context_set_background($!sc, $window);
  }

  method state_is_running (GtkStateType $state, gdouble $progress)
    is also<state-is-running>
  {
    gtk_style_context_state_is_running($!sc, $state, $progress);
  }

  method to_string (GtkStyleContextPrintFlags $flags) is also<to-string> {
    gtk_style_context_to_string($!sc, $flags);
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
