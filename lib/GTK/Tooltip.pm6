use v6.c;

use Method::Also;
use NativeCall;

use GTK::Raw::Tooltip:ver<3.0.1146>;
use GTK::Raw::Types:ver<3.0.1146>;

use GLib::Roles::Object;

class GTK::Tooltip:ver<3.0.1146> {
  also does GLib::Roles::Object;

  has GtkTooltip $!tt is implementor;

  submethod BUILD(:$tooltip) {
    self!setObject($!tt = $tooltip);
  }

  method GTK::Raw::Definitions::GtkTooltip
    is also<
      Tooltip
      GtkTooltip
    >
    { $!tt }

  method new (GtkTooltip $tooltip) {
    $tooltip ?? self.bless(:$tooltip) !! Nil;
  }

  # ↓↓↓↓ SIGNALS ↓↓↓↓
  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ PROPERTIES ↓↓↓↓
  # ↑↑↑↑ PROPERTIES ↑↑↑↑

  # Static
  method gtk_tooltip_trigger_tooltip_query(GdkDisplay() $display)
    is also<gtk-tooltip-trigger-tooltip-query>
  {
    gtk_tooltip_trigger_tooltip_query($display);
  }

  # ↓↓↓↓ METHODS ↓↓↓↓
  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gtk_tooltip_get_type, $n, $t );
  }

  method gtk_tooltip_set_custom (GtkWidget() $custom_widget)
    is also<gtk-tooltip-set-custom>
  {
    gtk_tooltip_set_custom($!tt, $custom_widget);
  }

  method gtk_tooltip_set_icon (GdkPixbuf() $pixbuf)
    is also<gtk-tooltip-set-icon>
  {
    gtk_tooltip_set_icon($!tt, $pixbuf);
  }

  # Use of GIcon is deprecated!
  method gtk_tooltip_set_icon_from_gicon (
    GIcon $gicon,
    Int() $size
  )
    is also<gtk-tooltip-set-icon-from-gicon>
  {
    my guint $s = $size;

    gtk_tooltip_set_icon_from_gicon($!tt, $gicon, $s);
  }

  method gtk_tooltip_set_icon_from_icon_name (
    Str() $icon_name,
    Int() $size
  )
    is also<gtk-tooltip-set-icon-from-icon-name>
  {
    my guint $s = $size;

    gtk_tooltip_set_icon_from_icon_name($!tt, $icon_name, $s);
  }

  method gtk_tooltip_set_icon_from_stock (
    Str() $stock_id,
    Int() $size
  )
    is also<gtk-tooltip-set-icon-from-stock>
  {
    my guint $s = $size;

    gtk_tooltip_set_icon_from_stock($!tt, $stock_id, $s);
  }

  method gtk_tooltip_set_markup (Str() $markup)
    is also<gtk-tooltip-set-markup>
  {
    gtk_tooltip_set_markup($!tt, $markup);
  }

  method gtk_tooltip_set_text (Str() $text)
    is also<gtk-tooltip-set-text>
  {
    gtk_tooltip_set_text($!tt, $text);
  }

  method gtk_tooltip_set_tip_area (GdkRectangle() $rect)
    is also<gtk-tooltip-set-tip-area>
  {
    gtk_tooltip_set_tip_area($!tt, $rect);
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
