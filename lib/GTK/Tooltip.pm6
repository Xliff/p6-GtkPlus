use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::Tooltip;
use GTK::Raw::Types;

class GTK::Tooltip {
  has GtkTooltip $!tt;

  submethod BUILD(:$tooltip) {
    $!tt = $tooltip
  }

  method new (GtkTooltip $tooltip) {
    self.bless(:$tooltip);
  }

  # ↓↓↓↓ SIGNALS ↓↓↓↓
  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ PROPERTIES ↓↓↓↓
  # ↑↑↑↑ PROPERTIES ↑↑↑↑

  # Static
  method gtk_tooltip_trigger_tooltip_query(GdkDisplay $display){
    gtk_tooltip_trigger_tooltip_query($display);
  }

  # ↓↓↓↓ METHODS ↓↓↓↓
  method gtk_tooltip_get_type {
    gtk_tooltip_get_type();
  }

  method gtk_tooltip_set_custom (GtkWidget() $custom_widget) {
    gtk_tooltip_set_custom($!tt, $custom_widget);
  }

  method gtk_tooltip_set_icon (GdkPixbuf() $pixbuf) {
    gtk_tooltip_set_icon($!tt, $pixbuf);
  }

  method gtk_tooltip_set_icon_from_gicon (
    GIcon $gicon,
    Int() $size
  ) {
    my guint $s = self.RESOLVE-UINT($size);
    gtk_tooltip_set_icon_from_gicon($!tt, $gicon, $s);
  }

  method gtk_tooltip_set_icon_from_icon_name (
    Str() $icon_name,
    Int() $size
  ) {
    my guint $s = self.RESOLVE-UINT($size);
    gtk_tooltip_set_icon_from_icon_name($!tt, $icon_name, $s);
  }

  method gtk_tooltip_set_icon_from_stock (
    Str() $stock_id,
    Int() $size
  ) {
    my guint $s = self.RESOLVE-UINT($size);
    gtk_tooltip_set_icon_from_stock($!tt, $stock_id, $s);
  }

  method gtk_tooltip_set_markup (Str() $markup) {
    gtk_tooltip_set_markup($!tt, $markup);
  }

  method gtk_tooltip_set_text (Str() $text) {
    gtk_tooltip_set_text($!tt, $text);
  }

  method gtk_tooltip_set_tip_area (GdkRectangle() $rect) {
    gtk_tooltip_set_tip_area($!tt, $rect);
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
