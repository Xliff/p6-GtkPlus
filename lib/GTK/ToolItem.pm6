use v6.c;

use Method::Also;
use NativeCall;

use Pango::Raw::Types;

use GTK::Compat::Types;
use GTK::Raw::ToolItem;
use GTK::Raw::Types;

use GTK::Bin;
use GTK::SizeGroup;

our subset ToolItemAncestry is export
  where GtkToolItem | BinAncestry;

class GTK::ToolItem is GTK::Bin {
  has GtkToolItem $!ti;

  method bless(*%attrinit) {
    my $o = self.CREATE.BUILDALL(Empty, %attrinit);
    $o.setType('GTK::ToolItem');
    $o;
  }

  submethod BUILD(:$toolitem) {
    given $toolitem {
      when ToolItemAncestry {
        self.setToolItem($toolitem);
      }
      when GTK::ToolItem {
      }
      default {
      }
    }
  }

  method setToolItem(ToolItemAncestry $toolitem) {
    my $to-parent;
    $!ti = do given $toolitem {
      when GtkToolItem {
        $to-parent = nativecast(GtkBin, $_);
        $_;
      }

      default {
        $to-parent = $_;
        nativecast(GtkToolItem, $_);
      }
    }
    self.setBin($to-parent);
  }

  multi method new (ToolItemAncestry $toolitem) {
    my $o = self.bless(:$toolitem);
    $o.upref;
    $o;
  }
  multi method new {
    my $toolitem = gtk_tool_item_new();
    self.bless(:$toolitem);
  }

  method GTK::Raw::Types::GtkToolItem is also<ToolItem> { $!ti }

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
        my gboolean $e = self.RESOLVE-BOOL($expand);
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
        my gboolean $h = self.RESOLVE-BOOL($homogeneous);
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
        my gboolean $ii = self.RESOLVE-BOOL($is_important);
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
        my gboolean $udw = self.RESOLVE-BOOL($use_drag_window);
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
        my gboolean $vh = self.RESOLVE-BOOL($visible_horizontal);
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
        my gboolean $vv = self.RESOLVE-BOOL($visible_vertical);
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
    PangoEllipsizeMode( gtk_tool_item_get_ellipsize_mode($!ti) );
  }

  method get_icon_size 
    is also<
      get-icon-size
      icon_size
      icon-size
    > 
  {
    GtkIconSize( gtk_tool_item_get_icon_size($!ti) );
  }

  method get_orientation 
    is also<
      get-orientation
      orientation
    > 
  {
    GtkOrientation( gtk_tool_item_get_orientation($!ti) );
  }

  # EXample mechanism to return widget pointer for MenuItem subclases
  method get_proxy_menu_item (Str() $menu_item_id, :$object = True)
    is also<
      get-proxy-menu-item
      proxy_menu_item
      proxy-menu-item
    >
  {
    my $widget = gtk_tool_item_get_proxy_menu_item($!ti, $menu_item_id);
    return $widget unless $object;
    GTK::MenuItem.new($widget);
  }

  method get_relief_style 
    is also<
      get-relief-style
      relief_style
      relief-style
    > 
  {
    GtkReliefStyle( gtk_tool_item_get_relief_style($!ti) );
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
    GtkOrientation( gtk_tool_item_get_text_orientation($!ti) );
  }

  method get_text_size_group 
    is also<
      get-text-size-group
      text_size_group
      text-size-group
      text_sizegroup
      text-sizegroup
    > 
  {
    GTK::SizeGroup.new( gtk_tool_item_get_text_size_group($!ti) );
  }

  method get_toolbar_style 
    is also<
      get-toolbar-style
      toolbar_style
      toolbar-style
    > 
  {
    GtkToolbarStyle( gtk_tool_item_get_toolbar_style($!ti) );
  }

  method get_type is also<get-type> {
    gtk_tool_item_get_type();
  }

  method rebuild_menu is also<rebuild-menu> {
    gtk_tool_item_rebuild_menu($!ti);
  }

  method retrieve_proxy_menu_item is also<retrieve-proxy-menu-item> {
    GTK::MenuItem.new( gtk_tool_item_retrieve_proxy_menu_item($!ti) );
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
