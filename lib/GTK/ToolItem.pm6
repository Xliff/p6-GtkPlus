use v6.c;

use Method::Also;

use Pango::Raw::Types;

use GTK::Raw::ToolItem;
use GTK::Raw::Types;

use GTK::Bin;
use GTK::SizeGroup;

our subset ToolItemAncestry is export
  where GtkToolItem | BinAncestry;

class GTK::ToolItem is GTK::Bin {
  has GtkToolItem $!ti is implementor;

  method bless(*%attrinit) {
    my $o = self.CREATE.BUILDALL(Empty, %attrinit);
    $o.setType($o.^name);
    $o;
  }

  submethod BUILD(:$toolitem) {
    given $toolitem {
      when ToolItemAncestry { self.setToolItem($toolitem) }
      when GTK::ToolItem    { }
      default               { }
    }
  }

  method setToolItem(ToolItemAncestry $toolitem) {
    my $to-parent;
    $!ti = do given $toolitem {
      when GtkToolItem {
        $to-parent = cast(GtkBin, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GtkToolItem, $_);
      }
    }
    self.setBin($to-parent);
  }

  method GTK::Raw::Definitions::GtkToolItem
    is also<
      ToolItem
      GtkToolItem
    >
  { $!ti }

  multi method new (ToolItemAncestry $toolitem, :$ref = True) {
    return unless $toolitem;

    my $o = self.bless(:$toolitem);
    $o.ref if $ref;
    $o;
  }
  multi method new {
    my $toolitem = gtk_tool_item_new();

    $toolitem ?? self.bless(:$toolitem) !! Nil;
  }

  # ↓↓↓↓ SIGNALS ↓↓↓↓

  # Is originally:
  # GtkToolItem, gpointer --> gboolean
  method create-menu-proxy is also<create_menu_proxy> {
    self.connect-rbool($!ti, 'create-menu-proxy');
  }

  # Is originally:
  # GtkToolItem, gpointer --> void
  method toolbar-reconfigured is also<toolbar_reconfigured> {
    self.connect($!ti, 'toolbar-reconfigured');
  }
  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  method expand is rw {
    Proxy.new(
      FETCH => sub ($) {
        so gtk_tool_item_get_expand($!ti);
      },
      STORE => sub ($, Int() $expand is copy) {
        my gboolean $e = $expand;

        gtk_tool_item_set_expand($!ti, $e);
      }
    );
  }

  method homogeneous is rw {
    Proxy.new(
      FETCH => sub ($) {
        so gtk_tool_item_get_homogeneous($!ti);
      },
      STORE => sub ($, Int() $homogeneous is copy) {
        my gboolean $h = $homogeneous;

        gtk_tool_item_set_homogeneous($!ti, $h);
      }
    );
  }

  method is_important is rw is also<is-important> {
    Proxy.new(
      FETCH => sub ($) {
        so gtk_tool_item_get_is_important($!ti);
      },
      STORE => sub ($, Int() $is_important is copy) {
        my gboolean $ii = $is_important;

        gtk_tool_item_set_is_important($!ti, $ii);
      }
    );
  }

  method use_drag_window is rw is also<use-drag-window> {
    Proxy.new(
      FETCH => sub ($) {
        so gtk_tool_item_get_use_drag_window($!ti);
      },
      STORE => sub ($, Int() $use_drag_window is copy) {
        my gboolean $udw = $use_drag_window;

        gtk_tool_item_set_use_drag_window($!ti, $udw);
      }
    );
  }

  method visible_horizontal is rw is also<visible-horizontal> {
    Proxy.new(
      FETCH => sub ($) {
        so gtk_tool_item_get_visible_horizontal($!ti);
      },
      STORE => sub ($, Int() $visible_horizontal is copy) {
        my gboolean $vh = $visible_horizontal;

        gtk_tool_item_set_visible_horizontal($!ti, $vh);
      }
    );
  }

  method visible_vertical is rw is also<visible-vertical> {
    Proxy.new(
      FETCH => sub ($) {
        so gtk_tool_item_get_visible_vertical($!ti);
      },
      STORE => sub ($, Int() $visible_vertical is copy) {
        my gboolean $vv = $visible_vertical;

        gtk_tool_item_set_visible_vertical($!ti, $vv);
      }
    );
  }
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  method get_ellipsize_mode
    is also<
      get-ellipsize-mode
      ellipsize_mode
      ellipsize-mode
    >
  {
    PangoEllipsizeModeEnum( gtk_tool_item_get_ellipsize_mode($!ti) );
  }

  method get_icon_size
    is also<
      get-icon-size
      icon_size
      icon-size
    >
  {
    GtkIconSizeEnum( gtk_tool_item_get_icon_size($!ti) );
  }

  method get_orientation
    is also<
      get-orientation
      orientation
    >
  {
    GtkOrientationEnum( gtk_tool_item_get_orientation($!ti) );
  }

  method get_proxy_menu_item (
    Str() $menu_item_id,
    :$raw = False,
    :$widget = False
  )
    is also<
      get-proxy-menu-item
      proxy_menu_item
      proxy-menu-item
    >
  {
    my $w = gtk_tool_item_get_proxy_menu_item($!ti, $menu_item_id);

    self.ReturnWidget($w, $raw, $widget);
  }

  method get_relief_style
    is also<
      get-relief-style
      relief_style
      relief-style
    >
  {
    GtkReliefStyleEnum( gtk_tool_item_get_relief_style($!ti) );
  }

  method get_text_alignment
    is also<
      get-text-alignment
      text_alignment
      text-alignment
    >
  {
    gtk_tool_item_get_text_alignment($!ti);
  }

  method get_text_orientation
    is also<
      get-text-orientation
      text_orientation
      text-orientation
    >
  {
    GtkOrientationEnum( gtk_tool_item_get_text_orientation($!ti) );
  }

  method get_text_size_group (:$raw = False)
    is also<
      get-text-size-group
      text_size_group
      text-size-group
      text_sizegroup
      text-sizegroup
    >
  {
    my $s = gtk_tool_item_get_text_size_group($!ti);

    $s ??
      ( $raw ?? $s !! GTK::SizeGroup.new($s) )
      !!
      Nil;
  }

  method get_toolbar_style
    is also<
      get-toolbar-style
      toolbar_style
      toolbar-style
    >
  {
    GtkToolbarStyleEnum( gtk_tool_item_get_toolbar_style($!ti) );
  }

  method get_type is also<get-type> {
    state ($n, $t);

    GTK::Widget.unstable_get_type( &gtk_tool_item_get_type, $n, $t );
  }

  method rebuild_menu is also<rebuild-menu> {
    gtk_tool_item_rebuild_menu($!ti);
  }

  method retrieve_proxy_menu_item (:$raw = False)
    is also<retrieve-proxy-menu-item>
  {
    my $mi = gtk_tool_item_retrieve_proxy_menu_item($!ti);

    $mi ??
      ( $raw ?? $mi !! GTK::MenuItem.new($mi) )
      !!
      Nil;
  }

  method set_proxy_menu_item (
    Str() $menu_item_id,
    GtkWidget() $menu_item
  )
    is also<set-proxy-menu-item>
  {
    gtk_tool_item_set_proxy_menu_item($!ti, $menu_item_id, $menu_item);
  }

  method set_tooltip_markup (Str() $markup) is also<set-tooltip-markup> {
    gtk_tool_item_set_tooltip_markup($!ti, $markup);
  }

  method set_tooltip_text (Str() $text) is also<set-tooltip-text> {
    gtk_tool_item_set_tooltip_text($!ti, $text);
  }

  method emit_toolbar_reconfigured is also<emit-toolbar-reconfigured> {
    gtk_tool_item_toolbar_reconfigured($!ti);
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
