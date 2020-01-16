use v6.c;

use Method::Also;

use GTK::Raw::DnD;
use GTK::Raw::Types;

use GTK::Widget;

use GLib::Roles::Object;

# TO BE USED WITH GDK::DragContext.

class GTK::DragContext {
  also does GLib::Roles::Object;

  has GdkDragContext $!dc is implementor;

  submethod BUILD(:$context) {
    self!setObject($!dc = $context);
  }

  method GDK::Raw::Definitions::GdkDragContext
    is also<
      GdkDragContext
      GTK::Raw::Definitions::GtkDragContext
      GtkDragContext
    >
  { $!dc }

  method new (GdkDragContext() $context) {
    $context ?? self.bless(:$context) !! Nil;
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
    my ($s, $d) = ($success, $del);
    my guint $t = $time;

    gtk_drag_finish($!dc, $s, $d, $t);
  }

  method get_source_widget (:$raw = False, :$widget = False)
    is also<
      get-source-widget
      source-widget
      source_widget
    >
  {
    # Returns GtkWidget.
    # May need to use GTK::Widget.CreateObject for this. For now, leave
    # up to the caller.
    my $w = gtk_drag_get_source_widget($!dc);

    ReturnWidget($w, $raw, $widget);
  }

  method set_icon_default is also<set-icon-default> {
    gtk_drag_set_icon_default($!dc);
  }

  method set_icon_gicon (GIcon() $icon, Int() $hot_x, Int() $hot_y)
    is also<set-icon-gicon>
  {
    my gint ($hx, $hy) = ($hot_x, $hot_y);

    gtk_drag_set_icon_gicon($!dc, $icon, $hx, $hy);
  }

  method set_icon_name (Str() $icon_name, Int() $hot_x, Int() $hot_y)
    is also<set-icon-name>
  {
    my gint ($hx, $hy) = ($hot_x, $hot_y);

    gtk_drag_set_icon_name($!dc, $icon_name, $hx, $hy);
  }

  method set_icon_pixbuf (GdkPixbuf() $pixbuf, Int() $hot_x, Int() $hot_y)
    is also<set-icon-pixbuf>
  {
    my gint ($hx, $hy) = ($hot_x, $hot_y);

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
    my gint ($hx, $hy) = ($hot_x, $hot_y);

    gtk_drag_set_icon_widget($!dc, $widget, $hx, $hy);
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
