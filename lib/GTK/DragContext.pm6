use v6.c;

use Method::Also;
use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::DnD;
use GTK::Raw::Types;

use GTK::Roles::Types;
use GLib::Roles::Object;

# TO BE USED WITH GTK::Compat::DragContext.

class GTK::DragContext {
  also does GTK::Roles::Types;
  also does GLib::Roles::Object;

  has GdkDragContext $!dc is implementor;

  submethod BUILD(:$context) {
    self!setObject($!dc = $context);
  }
  
  method GTK::Compat::Types::GdkDragContext
    is also<DragContext>
    { $!dc }

  method new (GdkDragContext() $context) {
    self.bless(:$context);
  }

  # ↓↓↓↓ SIGNALS ↓↓↓↓
  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ PROPERTIES ↓↓↓↓
  # ↑↑↑↑ PROPERTIES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  method cancel {
    gtk_drag_cancel($!dc);
  }

  method finish (Int() $success, Int() $del, Int() $time) {
    my @b = ($success, $del);
    my ($s, $d) = self.RESOLVE-BOOL(@b);
    my guint $t = self.RESOLVE-UINT($time);
    gtk_drag_finish($!dc, $s, $d, $t);
  }

  method get_source_widget
    is also<
      get-source-widget
      source-widget
      source_widget
    >
  {
    # Returns GtkWidget.
    # May need to use GTK::Widget.CreateObject for this. For now, leave
    # up to the caller.
    gtk_drag_get_source_widget($!dc);
  }

  method set_icon_default is also<set-icon-default> {
    gtk_drag_set_icon_default($!dc);
  }

  method set_icon_gicon (GIcon $icon, Int() $hot_x, Int() $hot_y)
    is also<set-icon-gicon>
  {
    my @i = ($hot_x, $hot_y);
    my gint ($hx, $hy) = self.RESOLVE-INT(@i);
    gtk_drag_set_icon_gicon($!dc, $icon, $hx, $hy);
  }

  method set_icon_name (Str() $icon_name, Int() $hot_x, Int() $hot_y)
    is also<set-icon-name>
  {
    my @i = ($hot_x, $hot_y);
    my gint ($hx, $hy) = self.RESOLVE-INT(@i);
    gtk_drag_set_icon_name($!dc, $icon_name, $hx, $hy);
  }

  method set_icon_pixbuf (GdkPixbuf() $pixbuf, Int() $hot_x, Int() $hot_y)
    is also<set-icon-pixbuf>
  {
    my @i = ($hot_x, $hot_y);
    my gint ($hx, $hy) = self.RESOLVE-INT(@i);
    gtk_drag_set_icon_pixbuf($!dc, $pixbuf, $hx, $hy);
  }

  # method set_icon_stock (gchar $stock_id, gint $hot_x, gint $hot_y) {
  #   gtk_drag_set_icon_stock($!dc, $stock_id, $hot_x, $hot_y);
  # }

  method set_icon_surface (cairo_surface_t $surface)
    is also<set-icon-surface>
  {
    gtk_drag_set_icon_surface($!dc, $surface);
  }

  method set_icon_widget (GtkWidget() $widget, Int() $hot_x, Int() $hot_y)
    is also<set-icon-widget>
  {
    my @i = ($hot_x, $hot_y);
    my gint ($hx, $hy) = self.RESOLVE-INT(@i);
    gtk_drag_set_icon_widget($!dc, $widget, $hx, $hy);
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
