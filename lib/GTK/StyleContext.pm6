v6.c;

use Method::Also;

use Pango::Raw::Types;
use Pango::FontDescription;

use GDK::RGBA;
use GDK::Screen;

use GTK::Raw::StyleContext:ver<3.0.1146>;
use GTK::Raw::Subs:ver<3.0.1146>;
use GTK::Raw::Types:ver<3.0.1146>;

use GLib::Value;
use GTK::Render:ver<3.0.1146>;
use GTK::WidgetPath:ver<3.0.1146>;

use GLib::Roles::Object;
use GTK::Roles::Signals::Generic:ver<3.0.1146>;

class GTK::StyleContext:ver<3.0.1146> {
  also does GLib::Roles::Object;
  also does GTK::Roles::Signals::Generic;

  has GtkStyleContext $!sc is implementor;

  submethod BUILD(:$context) {
    self!setObject($!sc = $context);
  }

  submethod DESTROY {
    self.disconnect-all($_) for %!signals;
  }

  method GTK::Raw::Definitions::GtkStyleContext
    is also<
      GtkStyleContext
      StyleContext
    >
  { $!sc }

  multi method new (GtkStyleContext $context) {
    $context ?? self.bless(:$context) !! Nil;
  }
  multi method new {
    my $context = gtk_style_context_new();

    $context ?? self.bless(:$context) !! Nil;
  }

  # ↓↓↓↓ SIGNALS ↓↓↓↓

  # Is originally:
  # GtkStyleContext, gpointer --> void
  method changed {
    self.connect($!sc, 'changed');
  }

  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  method direction is rw {
    Proxy.new(
      FETCH => sub ($) {
        GtkTextDirectionEnum( gtk_style_context_get_direction($!sc) );
      },
      STORE => sub ($, Int() $direction is copy) {
        my GtkTextDirection $d = $direction;

        gtk_style_context_set_direction($!sc, $d);
      }
    );
  }

  method frame_clock is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_style_context_get_frame_clock($!sc);
      },
      STORE => sub ($, $frame_clock is copy) {
        gtk_style_context_set_frame_clock($!sc, $frame_clock);
      }
    );
  }

  method junction_sides is rw {
    Proxy.new(
      FETCH => sub ($) {
        GtkJunctionSidesEnum( gtk_style_context_get_junction_sides($!sc) );
      },
      STORE => sub ($, Int() $sides is copy) {
        my GtkJunctionSides $s = $sides;

        gtk_style_context_set_junction_sides($!sc, $s);
      }
    );
  }

  method parent (:$raw = False) is rw {
    Proxy.new(
      FETCH => sub ($) {
        my $sc = gtk_style_context_get_parent($!sc);

        $sc ??
          ( $raw ?? $sc !! GTK::StyleContext.new($sc) )
          !!
          Nil;
      },
      STORE => sub ($, GtkStyleContext() $parent is copy) {
        gtk_style_context_set_parent($!sc, $parent);
      }
    );
  }

  method path (:$raw = False) is rw {
    Proxy.new(
      FETCH => sub ($) {
        my $wp = gtk_style_context_get_path($!sc);

        $wp ??
          ( $raw ?? $wp !! GTK::WidgetPath.new($wp) )
          !!
          Nil;
      },
      STORE => sub ($, GtkWidgetPath() $path is copy) {
        gtk_style_context_set_path($!sc, $path);
      }
    );
  }

  method scale is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_style_context_get_scale($!sc);
      },
      STORE => sub ($, Int() $scale is copy) {
        my gint $s = $scale;

        gtk_style_context_set_scale($!sc, $s);
      }
    );
  }

  method screen (:$raw = False) is rw {
    Proxy.new(
      FETCH => sub ($) {
        my $s = gtk_style_context_get_screen($!sc);

        $s ??
          ( $raw ?? $s !! GDK::Screen.new($s) )
          !!
          Nil;
      },
      STORE => sub ($, GdkScreen() $screen is copy) {
        gtk_style_context_set_screen($!sc, $screen);
      }
    );
  }

  method state is rw {
    Proxy.new(
      FETCH => sub ($) {
        # Flag/Mask means NO use of the enum.
        gtk_style_context_get_state($!sc);
      },
      STORE => sub ($, Int() $flags is copy) {
        my guint $f = $flags;

        gtk_style_context_set_state($!sc, $f);
      }
    );
  }

  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ PROPERTIES ↓↓↓↓

  # Type: GdkFrameClock
  method paint-clock is rw is also<paint_clock> {
    my GLib::Value $gv .= new( G_TYPE_OBJECT );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('paint-clock', $gv)
        );
        cast(GdkFrameClock, $gv.object);
      },
      STORE => -> $, GdkFrameClock() $val is copy {
        $gv.object = $val;
        self.prop_set('paint-clock', $gv);
      }
    );
  }
  # ↑↑↑↑ PROPERTIES ↑↑↑↑

  proto method render_activity(|) is also<render-activity> { * }

  multi method render_activity(
    GTK::StyleContext:D:
    cairo_t $cr,
    Num() $x,
    Num() $y,
    Num() $width,
    Num() $height
  ) {
    samewith($!sc, $cr, $x, $y, $width, $height);
  }
  multi method render_activity (
    GtkStyleContext() $context,
    cairo_t $cr,
    Num() $x,
    Num() $y,
    Num() $width,
    Num() $height
  ) {
    my gdouble ($xx, $yy, $ww, $hh) = ($x, $y, $width, $height);

    GTK::Render.activity($context, $cr, $xx, $yy, $ww, $hh);
  }

  proto method render_arror (|) is also<render-arrow> { * }

  multi method render_arrow  (
    GTK::StyleContext:D:
    cairo_t $cr,
    Num() $angle,
    Num() $x,
    Num() $y,
    Num() $size
  ) {
    samewith($!sc, $cr, $angle, $x, $y, $size);
  }
  multi method render_arrow  (
    GtkStyleContext() $context,
    cairo_t $cr,
    Num() $angle,
    Num() $x,
    Num() $y,
    Num() $size
  ) {
    my gdouble ($aa, $xx, $yy, $ss) = ($angle, $x, $y, $size);

    GTK::Render.arrow($context, $cr, $angle, $xx, $yy, $ss);
  }

  proto method render_background (|) is also<render-background> { * }

  multi method render_background (
    GTK::StyleContext:D:
    cairo_t $cr,
    Num() $x,
    Num() $y,
    Num() $width,
    Num() $height
  ) {
    my gdouble ($xx, $yy, $w, $h) = ($x, $y, $width, $height);

    samewith($!sc, $cr, $xx, $yy, $w, $h);
  }
  multi method render_background (
    GtkStyleContext() $context,
    cairo_t $cr,
    Num() $x,
    Num() $y,
    Num() $width,
    Num() $height
  ) {
    my num64 ($xx, $yy, $w, $h) = ($x, $y, $width, $height);

    GTK::Render.background($context, $cr, $xx, $yy, $w, $h);
  }

  proto method render_background_get_clip (|)
    is also<render-background-get-clip>
    { * }

  multi method render_background_get_clip  (
    GTK::StyleContext:D:
    Num() $x,
    Num() $y,
    Num() $width,
    Num() $height,
    GdkRectangle() $out_clip
  ) {
    samewith($!sc, $x, $y, $width, $height, $out_clip);
  }

  multi method render_background_get_clip  (
    GtkStyleContext() $context,
    Num() $x,
    Num() $y,
    Num() $width,
    Num() $height,
    GdkRectangle() $out_clip
  ) {
    my num64 ($xx, $yy, $w, $h) = ($x, $y, $width, $height);

    GTK::Render.background_get_clip($context, $xx, $yy, $w, $h, $out_clip);
  }

  proto method render_check (|) is also<render-check> { * }

  multi method render_check (
    GTK::StyleContext:D:
    cairo_t $cr,
    Num() $x,
    Num() $y,
    Num() $width,
    Num() $height
  ) {
    samewith($!sc, $cr, $x, $y, $width, $height);
  }
  multi method render_check (
    GtkStyleContext() $context,
    cairo_t $cr,
    Num() $x,
    Num() $y,
    Num() $width,
    Num() $height
  ) {
    my num64 ($xx, $yy, $ww, $hh) = ($x, $y, $width, $height);

    GTK::Render.check($context, $cr, $x, $y, $width, $height);
  }

  proto method render_expander (|) is also<render-expander> { * }

  multi method render_expander (
    GTK::StyleContext:D:
    cairo_t $cr,
    Num() $x,
    Num() $y,
    Num() $width,
    Num() $height
  ) {
    samewith($!sc, $cr, $x, $y, $width, $height);
  }
  multi method render_expander (
    GtkStyleContext() $context,
    cairo_t $cr,
    Num() $x,
    Num() $y,
    Num() $width,
    Num() $height
  ) {
    my num64 ($xx, $yy, $w, $h) = ($x, $y, $width, $height);

    GTK::Render.expander($context, $cr, $xx, $yy, $w, $h);
  }

  proto method render_extension (|) is also<render-extension> { * }

  multi method render_extension (
    GTK::StyleContext:D:
    cairo_t $cr,
    Num() $x,
    Num() $y,
    Num() $width,
    Num() $height,
    Int() $gap_side           # GtkPositionType $gap_side
  ) {
    samewith($!sc, $cr, $x, $y, $width, $height, $gap_side);
  }
  multi method render_extension (
    GtkStyleContext() $context,
    cairo_t $cr,
    Num() $x,
    Num() $y,
    Num() $width,
    Num() $height,
    Int() $gap_side
  ) {
    my num64 ($xx, $yy, $w, $h) = ($x, $y, $width, $height);
    my guint $gs = $gap_side;

    GTK::Render.extension($context, $cr, $xx, $yy, $w, $h, $gs);
  }

  proto method render_focus (|) is also<render-focus> { * }

  multi method render_focus (
    GTK::StyleContext:D:
    cairo_t $cr,
    Num() $x,
    Num() $y,
    Num() $width,
    Num() $height
  ) {
    samewith($!sc, $cr, $x, $y, $width, $height);
  }
  multi method render_focus (
    GtkStyleContext() $context,
    cairo_t $cr,
    Num() $x,
    Num() $y,
    Num() $width,
    Num() $height
  ) {
    my num64 ($xx, $yy, $w, $h) = ($x, $y, $width, $height);

    GTK::Render.focus($context, $cr, $xx, $yy, $w, $h);
  }

  proto method render_frame (|) is also<render-frame> { * }

  multi method render_frame (
    GTK::StyleContext:D: $context,
    cairo_t $cr,
    Num() $x,
    Num() $y,
    Num() $width,
    Num() $height
  ) {
    samewith($!sc, $cr, $x, $y, $width, $height);
  }
  multi method render_frame (
    GtkStyleContext() $context,
    cairo_t $cr,
    Num() $x,
    Num() $y,
    Num() $width,
    Num() $height
  ) {
    my num64 ($xx, $yy, $w, $h) = ($x, $y, $width, $height);

    GTK::Render.frame($context, $cr, $xx, $yy, $w, $h);
  }

  proto method render_frame_gap (|) is also<render-frame-gap> { * }

  multi method render_frame_gap (
    GTK::StyleContext:D:
    cairo_t $cr,
    Num() $x,
    Num() $y,
    Num() $width,
    Num() $height,
    Int() $gap_side,
    Num() $xy0_gap,
    Num() $xy1_gap
  ) {
    samewith(
      $!sc,
      $cr,
      $x, $y,
      $width, $height,
      $gap_side,
      $xy0_gap, $xy1_gap
    );
  }
  multi method render_frame_gap (
    GtkStyleContext() $context,
    cairo_t $cr,
    Num() $x,
    Num() $y,
    Num() $width,
    Num() $height,
    Int() $gap_side,          # GtkPositionType $gap_side,
    Num() $xy0_gap,
    Num() $xy1_gap
  ) {
    my num64 ($xx, $yy, $w, $h, $g0, $g1)
      = ($x, $y, $width, $height, $xy0_gap, $xy1_gap);
    my guint $gs = $gap_side;

    GTK::Render.frame_gap($context, $cr, $xx, $yy, $w, $h, $gs, $g0, $g1);
  }

  proto method render_handle (|) is also<render-handle> { * }

  multi method render_handle (
    GTK::StyleContext:D:
    cairo_t $cr,
    Num() $x,
    Num() $y,
    Num() $width,
    Num() $height
  ) {
    samewith($!sc, $cr, $x, $y, $width, $height);
  }
  multi method render_handle (
    GtkStyleContext() $context,
    cairo_t $cr,
    Num() $x,
    Num() $y,
    Num() $width,
    Num() $height
  ) {
    my num64 ($xx, $yy, $w, $h) = ($x, $y, $width, $height);

    GTK::Render.handle($context, $cr, $xx, $yy, $w, $h);
  }

  proto method render_icon (|) is also<render-icon> { * }

  multi method render_icon (
    GTK::StyleContext:D:
    cairo_t $cr,
    GdkPixbuf() $pixbuf,
    Num() $x,
    Num() $y
  ) {
    samewith($!sc, $cr, $pixbuf, $x, $y);
  }
  multi method render_icon (
    GtkStyleContext() $context,
    cairo_t $cr,
    GdkPixbuf() $pixbuf,
    Num() $x,
    Num() $y
  ) {
    my num64 ($xx, $yy) = ($x, $y);

    GTK::Render.icon($context, $cr, $pixbuf, $xx, $yy);
  }

  proto method render_icon_pixbuf (|) is also<render-icon-pixbuf> { * }

  multi method render_icon_pixbuf (
    GTK::StyleContext:D:
    GtkIconSource $source,
    Int() $size               # GtkIconSize $size
  ) {
    samewith($!sc, $source, $size);
  }
  multi method render_icon_pixbuf (
    GtkStyleContext() $context,
    GtkIconSource $source,
    Int() $size               # GtkIconSize $size
  )
    is also<render_icon-pixbuf>
  {
    my guint $s = $size;

    GTK::Render.icon_pixbuf($context, $source, $s);
  }

  proto method render_icon_surface (|) is also<render-icon-surface> { * }

  multi method render_icon_surface (
    GTK::StyleContext:D:
    cairo_t $cr,
    cairo_surface_t $surface,
    Num() $x,
    Num() $y
  ) {
    samewith($!sc, $cr, $surface, $x, $y);
  }
  multi method render_icon_surface (
    GtkStyleContext() $context,
    cairo_t $cr,
    cairo_surface_t $surface,
    Num() $x,
    Num() $y
  ) {
    my num64 ($xx, $yy) = ($x, $y);

    GTK::Render.icon_surface($context, $cr, $surface, $xx, $yy);
  }

  proto method render_insertion_cursor is also<render-insertion-cursor> { * }

  multi method render_insertion_cursor(
    GtkStyleContext:D:
    cairo_t $cr,
    Num() $x,
    Num() $y,
    Int() $l,                 # PangoLayout $l,
    Int() $i,
    Int() $d                  # PangoDirection $d
  ) {
    samewith($!sc, $cr, $x, $y, $l, $i, $d);
  }
  multi method render_insertion_cursor(
    GtkStyleContext() $context,
    cairo_t $cr,
    Num() $x,
    Num() $y,
    Int() $l,                 # PangoLayout $l,
    Int() $i,
    Int() $d                  # PangoDirection $d
  ) {
    my guint ($ll, $dd) = ($l, $d);
    my gdouble ($xx, $yy) = ($x, $y);
    my gint $ii = $i;

    GTK::Render.insertion_cursor($context, $cr, $xx, $yy, $ll, $ii, $dd);
  }

  proto method render_layout (|) is also<render-layout> { * }

  multi method render_layout  (
    GTK::StyleContext:D:
    cairo_t $cr,
    Num() $x,
    Num() $y,
    Int() $l                  # PangoLayout $l,
  ) {
    samewith($!sc, $cr, $x, $y, $l);
  }
  multi method render_layout  (
    GtkStyleContext() $context,
    cairo_t $cr,
    Num() $x,
    Num() $y,
    Int() $l                  # PangoLayout $l
  ) {
    my gdouble ($xx, $yy) = ($x, $y);
    my guint $ll = $l;

    GTK::Render.layout($context, $cr, $xx, $yy, $ll);
  }

  proto method render_line (|) is also<render-line> { * }

  multi method render_line (
    GTK::StyleContext:D:
    cairo_t $cr,
    Num() $x0,
    Num() $y0,
    Num() $x1,
    Num() $y1
  ) {
    samewith($!sc, $cr, $x0, $y0, $x1, $y1);
  }
  multi method render_line (
    GtkStyleContext() $context,
    cairo_t $cr,
    Num() $x0,
    Num() $y0,
    Num() $x1,
    Num() $y1
  ) {
    my gdouble ($xx0, $yy0, $xx1, $yy1);

    GTK::Render.line($context, $cr, $xx0, $yy0, $xx1, $yy1);
  }

  proto method render_option (|) is also<render-option> { * }

  multi method render_option (
    GTK::StyleContext:D:
    cairo_t $cr,
    Num() $x,
    Num() $y,
    Num() $width,
    Num() $height
  ) {
    samewith($!sc, $cr, $x, $y, $width, $height);
  }
  multi method render_option (
    GtkStyleContext() $context,
    cairo_t $cr,
    Num() $x,
    Num() $y,
    Num() $width,
    Num() $height
  ) {
    my num64 ($xx, $yy, $w, $h) = ($x, $y, $width, $height);

    GTK::Render.option($context, $cr, $xx, $yy, $w, $h);
  }

  proto method render_slider (|) is also<render-slider> { * }

  multi method render_slider (
    GTK::StyleContext:D:
    cairo_t $cr,
    Num() $x,
    Num() $y,
    Num() $width,
    Num() $height,
    Int() $orientation
  ) {
    samewith($!sc, $cr, $x, $y, $width, $height, $orientation);
  }
  multi method render_slider (
    GtkStyleContext() $context,
    cairo_t $cr,
    Num() $x,
    Num() $y,
    Num() $width,
    Num() $height,
    Int() $orientation
  ) {
    my num64 ($xx, $yy, $w, $h) = ($x, $y, $width, $height);
    my guint $o = $orientation;

    GTK::Render.slider($context, $cr, $xx, $yy, $w, $h, $o);
  }


  # ↓↓↓↓ METHODS ↓↓↓↓
  method add_class (Str() $class_name) is also<add-class> {
    gtk_style_context_add_class($!sc, $class_name);
  }

  method add_provider (GtkStyleProvider() $provider, Int() $priority)
    is also<add-provider>
  {
    my guint $p = $priority;

    gtk_style_context_add_provider($!sc, $provider, $p);
  }

  method add_provider_for_screen (
    GTK::StyleContext:U:
    GdkScreen() $screen,
    GtkStyleProvider() $provider,
    Int() $priority
  )
    is also<add-provider-for-screen>
  {
    my guint $p = $priority;

    gtk_style_context_add_provider_for_screen($screen, $provider, $p);
  }

  method add_region (
    Str() $region_name,
    Int() $flags
  )
    is also<add-region>
  {
    my GtkRegionFlags $f = $flags;

    gtk_style_context_add_region($!sc, $region_name, $f);
  }

  method cancel_animations (gpointer $region_id) is also<cancel-animations> {
    gtk_style_context_cancel_animations($!sc, $region_id);
  }

  proto method get_background_color (|)
    is also<get-background-color>
  { * }

  multi method get_background_color (Int() $state) {
    my $c = GdkRGBA.new;

    samewith($state, $c);
    $c;
  }
  multi method get_background_color (Int() $state, GdkRGBA $color) {
    my guint $s = $state;

    gtk_style_context_get_background_color($!sc, $s, $color);
  }

  proto method get_border (|)
    is also<get-border>
  { * }

  multi method get_border (Int() $state) {
    my $b = GtkBorder.new;

    samewith($state, $b);
    $b;
  }
  multi method get_border (Int() $state, GtkBorder $border) {
    my guint $s = $state;

    gtk_style_context_get_border($!sc, $s, $border);
  }

  method get_border_color (Int() $state, GdkRGBA $color)
    is also<get-border-color>
  {
    my guint $s = $state;

    gtk_style_context_get_border_color($!sc, $s, $color);
  }

  proto method get_color(|)
    is also<get-color>
  { * }

  multi method get_color (Int() $state)  {
    my $c = GdkRGBA.new;

    samewith($state, $c);
    $c;
  }
  multi method get_color (Int() $state, GdkRGBA $color)  {
    my guint $s = $state;

    gtk_style_context_get_color($!sc, $s, $color);
  }

  method get_font (Int() $state, :$raw = False) is also<get-font> {
    my guint $s = $state;
    my $f = gtk_style_context_get_font($!sc, $s);

    $f ??
      ( $raw ?? $f !! Pango::FontDescription.new($f) )
      !!
      Nil;
  }

  proto method get_margin (|)
    is also<get-margin>
  { * }

  multi method get_margin (Int() $state) {
    my $b = GtkBorder.new;

    samewith($state, $b);
    $b;
  }
  multi method get_margin (Int() $state, GtkBorder $margin) {
    my guint $s = $state;

    gtk_style_context_get_margin($!sc, $s, $margin);
  }

  proto method get_padding (|)
    is also<get-padding>
  { * }

  multi method get_padding (Int() $state) {
    my $b = GtkBorder.new;

    samewith($state, $b);
    $b;
  }
  multi method get_padding (Int() $state, GtkBorder $padding) {
    my guint $s = $state;

    gtk_style_context_get_padding($!sc, $s, $padding);
  }

  # Replaces valist version, but returns GValue
  method get (Int() $state, Str() $property, :$raw = False) {
    self.get_property($property, $state, :$raw);
  }

  proto method get_property (|)
    is also<get-property>
  { * }

  multi method get_property (
    Str() $property,
    Int() $state,
    :$raw = False
  ) {
    samewith($property, $state, $, :$raw);
  }
  multi method get_property (
    Str() $property,
    Int() $state,
    $value is rw,
    :$raw = False
  ) {
    my gint $s = $state;

    my $gv = $value // GValue.new;
    $gv .= GValue if $gv ~~ GLib::Value;
    die 'Cannot obtain proper value object!' unless $gv ~~ GValue;

    gtk_style_context_get_property($!sc, $property, $s, $gv);

    # Only assign to value if not already an object.
    $value ??
      $value
      !!
      $value = ( $raw ?? $gv !! GLib::Value.new($gv) )
  }

  method get_section (Str() $property) is also<get-section> {
    gtk_style_context_get_section($!sc, $property);
  }

  method get_style_property (Str() $property_name, GValue() $value)
    is also<get-style-property>
  {
    gtk_style_context_get_style_property($!sc, $property_name, $value);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gtk_style_context_get_type, $n, $t );
  }

  method has_class (Str() $class_name) is also<has-class> {
    so gtk_style_context_has_class($!sc, $class_name);
  }

  method has_region (Str() $region_name, Int() $flags_return)
    is also<has-region>
  {
    my guint $fr = $flags_return;

    so gtk_style_context_has_region($!sc, $region_name, $fr);
  }

  method invalidate {
    gtk_style_context_invalidate($!sc);
  }

  method list_classes (:$glist = False) is also<list-classes> {
    my $sl = gtk_style_context_list_classes($!sc);

    return Nil unless $sl;
    return $sl if     $glist;

    $sl = GLib::GList.new($sl) but GLib::Roles::ListData[Str];
    $sl.Array;
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

  method notify_state_change (
    GdkWindow() $window,
    gpointer $region_id,
    Int() $state,             # GtkStateType $state,
    Int() $state_value
  )
    is also<notify-state-change>
  {
    my guint ($s, $sv) = ($state, $state_value);

    gtk_style_context_notify_state_change($!sc, $window, $region_id, $s, $sv);
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

  method remove_provider (GtkStyleProvider() $provider)
    is also<remove-provider>
  {
    gtk_style_context_remove_provider($!sc, $provider);
  }

  method remove_provider_for_screen (
    GdkScreen() $screen,
    GtkStyleProvider() $provider
  )
    is also<remove-provider-for-screen>
  {
    gtk_style_context_remove_provider_for_screen($screen, $provider);
  }

  method remove_region (Str() $region_name) is also<remove-region> {
    gtk_style_context_remove_region($!sc, $region_name);
  }

  method reset_widgets(GdkScreen() $screen) is also<reset-widgets> {
    gtk_style_context_reset_widgets($screen);
  }

  method restore {
    gtk_style_context_restore($!sc);
  }

  method save {
    gtk_style_context_save($!sc);
  }

  method scroll_animations (GdkWindow() $window, Int() $dx, Int() $dy)
    is also<scroll-animations>
  {
    my gint ($ddx, $ddy) = ($dx, $dy);

    gtk_style_context_scroll_animations($!sc, $window, $ddx, $ddy);
  }

  method set_background (GdkWindow() $window) is also<set-background> {
    gtk_style_context_set_background($!sc, $window);
  }

  method state_is_running (Int() $state, Num() $progress)
    is also<state-is-running>
  {
    my gdouble $pp = $progress;
    my guint $s = $state;

    gtk_style_context_state_is_running($!sc, $s, $pp);
  }

  method to_string (Int() $flags = self.state) is also<to-string> {
    my guint $f = $flags;

    gtk_style_context_to_string($!sc, $f);
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
