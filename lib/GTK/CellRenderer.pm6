use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::CellRenderer;
use GTK::Raw::Types;

class GTK::CellRenderer {
  has GtkCellRenderer $!cr;

  method setCellRenderer($renderer) {
    $!cr = $renderer;
  }

  # ↓↓↓↓ SIGNALS ↓↓↓↓
  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  method sensitive is rw {
    Proxy.new(
      FETCH => sub ($) {
        so gtk_cell_renderer_get_sensitive($!cr);
      },
      STORE => sub ($, Int() $sensitive is copy) {
        my gboolean $s = self.RESOLVE-BOOL($sensitive);
        gtk_cell_renderer_set_sensitive($!cr, $s);
      }
    );
  }

  method visible is rw {
    Proxy.new(
      FETCH => sub ($) {
        so gtk_cell_renderer_get_visible($!cr);
      },
      STORE => sub ($, Int() $visible is copy) {
        my gboolean $v = self.RESOLVE-BOOL($visible);
        gtk_cell_renderer_set_visible($!cr, $v);
      }
    );
  }
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  method activate (
    GdkEvent() $event,
    GtkWidget() $widget,
    Str() $path,
    GdkRectangle() $background_area,
    GdkRectangle() $cell_area,
    Int() $flags                # GtkCellRendererState $flags
  ) {
    my uint32 $f = self.RESOLVE-UINT($flags);
    gtk_cell_renderer_activate(
      $!cr,
      $event,
      $widget,
      $path,
      $background_area,
      $cell_area,
      $f
    );
  }

  # method class_set_accessible_type (GType $type) {
  #   gtk_cell_renderer_class_set_accessible_type($!cr, $type);
  # }

  method get_aligned_area (
    GtkWidget() $widget,
    Int() $flags,               # GtkCellRendererState $flags,
    GdkRectangle() $cell_area,
    GdkRectangle() $aligned_area
  ) {
    my uint32 $f = self.RESOLVE-UINT($flags);
    gtk_cell_renderer_get_aligned_area(
      $!cr,
      $widget,
      $f,
      $cell_area,
      $aligned_area
    );
  }

  method get_alignment (Num() $xalign, Num() $yalign) {
    my gfloat ($xa, $ya) = ($xalign, $yalign);
    gtk_cell_renderer_get_alignment($!cr, $xa, $ya);
  }

  method get_fixed_size (Int() $width, Int() $height) {
    my @i = ($width, $height);
    my gint ($w, $h) = self.RESOLVE-INT(@i);
    gtk_cell_renderer_get_fixed_size($!cr, $w, $h);
  }

  method get_padding (Int() $xpad, Int() $ypad) {
    my @i = ($xpad, $ypad);
    my gint ($x, $y) = self.RESOLVE-INT(@i);
    gtk_cell_renderer_get_padding($!cr, $x, $y);
  }

  method get_preferred_height (
    GtkWidget() $widget,
    Int() $minimum_size,
    Int() $natural_size
  ) {
    my @i = ($minimum_size, $natural_size);
    my ($ms, $ns) = self.RESOLVE-INT(@i);
    gtk_cell_renderer_get_preferred_height(
      $!cr,
      $widget,
      $ms,
      $ns
    );
  }

  method get_preferred_height_for_width (
    GtkWidget $widget,
    Int() $width,
    Int() $minimum_height,
    Int() $natural_height
  ) {
    my @i = ($width, $minimum_height, $natural_height);
    my gint ($w, $mh, $nh) = self.RESOLVE-INT(@i);
    gtk_cell_renderer_get_preferred_height_for_width(
      $!cr,
      $widget,
      $w,
      $mh,
      $nh
    );
  }

  method get_preferred_size (
    GtkWidget() $widget,
    GtkRequisition $minimum_size,
    GtkRequisition $natural_size
  ) {
    gtk_cell_renderer_get_preferred_size(
      $!cr,
      $widget,
      $minimum_size,
      $natural_size
    );
  }

  method get_preferred_width (
    GtkWidget() $widget,
    Int() $minimum_size,
    Int() $natural_size
  ) {
    my @i = ($minimum_size, $natural_size);
    my ($ms, $ns) = self.RESOLVE-INT(@i);
    gtk_cell_renderer_get_preferred_width($!cr, $widget, $ms, $ns);
  }

  method get_preferred_width_for_height (
    GtkWidget() $widget,
    Int() $height,
    Int() $minimum_width,
    Int() $natural_width
  ) {
    my @i = ($height, $minimum_width, $natural_width);
    my gint ($h, $mw, $nw) = self.RESOLVE-INT(@i);
    gtk_cell_renderer_get_preferred_width_for_height(
      $!cr,
      $widget,
      $w,
      $mw,
      $nw
    );
  }

  method get_request_mode {
    gtk_cell_renderer_get_request_mode($!cr);
  }

  method get_size (
    GtkWidget() $widget,
    GdkRectangle() $cell_area,
    Int() $x_offset,
    Int() $y_offset,
    Int() $width,
    Int() $height
  ) {
    my @i = ($x_offset, $y_offset, $width, $height);
    my gint ($x, $y, $w, $h) = self.RESOLVE-INT(@i);
    gtk_cell_renderer_get_size($!cr, $widget, $cell_area, $xo, $yo, $w, $h);
  }

  method get_state (
    GtkWidget() $widget,
    Int() $cell_state           # GtkCellRendererState $cell_state
  ) {
    my guint $cs = self.RESOLVE-UINT($cell_state);
    gtk_cell_renderer_get_state($!cr, $widget, $cs);
  }

  method get_type {
    gtk_cell_renderer_get_type();
  }

  method is_activatable {
    gtk_cell_renderer_is_activatable($!cr);
  }

  method render (
    cairo_t $cr,
    GtkWidget() $widget,
    GdkRectangle() $background_area,
    GdkRectangle() $cell_area,
    Int() $flags                # GtkCellRendererState $flags
  ) {
    my uint32 $f = self.RESOLVE-UINT($flags);
    gtk_cell_renderer_render(
      $!cr,
      $cr,
      $widget,
      $background_area,
      $cell_area,
      $f
    );
  }

  method set_alignment (Num() $xalign, Num() $yalign) {
    my gfloat ($xa, $ya) = ($xalign, $yalign);
    gtk_cell_renderer_set_alignment($!cr, $xa, $ya);
  }

  method set_fixed_size (Int() $width, Int() $height) {
    my @i = ($width, $height);
    my gint ($w, $h) = self.RESOLVE-INT(@i);
    gtk_cell_renderer_set_fixed_size($!cr, $w, $h);
  }

  method set_padding (Int() $xpad, Int() $ypad) {
    my @i = ($xpad, $ypad);
    my gint ($x, $y) = self.RESOLVE-INT(@i);
    gtk_cell_renderer_set_padding($!cr, $x, $y);
  }

  method start_editing (
    GdkEvent $event,
    GtkWidget() $widget,
    Str() $path,
    GdkRectangle() $background_area,
    GdkRectangle() $cell_area,
    guint $flags                # GtkCellRendererState $flags
  ) {
    my uint32 $f = self.RESOLVE-UINT($flags);
    gtk_cell_renderer_start_editing(
      $!cr,
      $event,
      $widget,
      $path,
      $background_area,
      $cell_area,
      $f
    );
  }

  method stop_editing (Int() $canceled) {
    my gboolean $c = self.RESOLVE-BOOL($canceled);
    gtk_cell_renderer_stop_editing($!cr, $c);
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
