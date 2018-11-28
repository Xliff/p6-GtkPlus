use v6.c;

use Method::Also;
use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::ToolItemGroup;
use GTK::Raw::Types;

use GTK::Container;

my subset Ancestry
  where GtkToolItemGroup | GtkContainer | GtkBuildable | GtkToolShell |
        GtkWidget;

use GTK::Roles::ToolShell;

class GTK::ToolItemGroup is GTK::Container {
  also does GTK::Roles::ToolShell;

  has GtkToolItemGroup $!tig;

  method bless(*%attrinit) {
    my $o = self.CREATE.BUILDALL(Empty, %attrinit);
    $o.setType('GTK::ToolItemGroup');
    $o;
  }

  submethod BUILD(:$toolgroup) {
    my $to-parent;
    given $toolgroup {
      when Ancestry {
        $!tig = do {
          when GtkWidget | GtkContainer | GtkBuilder {
            $to-parent = $_;
            nativecast(GtkToolItemGroup, $_);
          }
          when GtkToolShell {
            $!shell = $_;
            $to-parent = nativecast(GtkContainer, $_);
            nativecast(GtkToolItemGroup, $_);
          }
          when GtkToolItemGroup  {
            $to-parent = nativecast(GtkContainer, $_);
            $_;
          }
        }
        $!shell //= nativecast(GtkToolShell, $toolgroup);
        self.setContainer($to-parent);
      }
      when GTK::ToolItemGroup {
      }
      default {
      }
    }
  }

  multi method new(Str() $label = '') {
    my $toolgroup = gtk_tool_item_group_new($label);
    self.bless(:$toolgroup);
  }
  multi method new (Ancestry $toolgroup) {
    self.bless(:$toolgroup);
  }

  method GTK::Raw::Types::GtkToolItemGroup {
    $!tig;
  }

  # ↓↓↓↓ SIGNALS ↓↓↓↓
  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  method collapsed is rw {
    Proxy.new(
      FETCH => sub ($) {
        so gtk_tool_item_group_get_collapsed($!tig);
      },
      STORE => sub ($, Int() $collapsed is copy) {
        my gboolean $c = self.RESOLVE-BOOL($collapsed);
        gtk_tool_item_group_set_collapsed($!tig, $c);
      }
    );
  }

  method ellipsize is rw {
    Proxy.new(
      FETCH => sub ($) {
        PangoEllipsizeMode(
          gtk_tool_item_group_get_ellipsize($!tig)
        );
      },
      STORE => sub ($, Int() $ellipsize is copy) {
        my uint32 $e = self.RESOLVE-UINT($ellipsize);
        gtk_tool_item_group_set_ellipsize($!tig, $e);
      }
    );
  }

  method header_relief is rw is also<header-relief> {
    Proxy.new(
      FETCH => sub ($) {
        GtkReliefStyle(
          gtk_tool_item_group_get_header_relief($!tig)
        );
      },
      STORE => sub ($, Int() $style is copy) {
        my uint32 $s = self.RESOLVE-UINT($style);
        gtk_tool_item_group_set_header_relief($!tig, $s);
      }
    );
  }

  method label is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_tool_item_group_get_label($!tig);
      },
      STORE => sub ($, Str() $label is copy) {
        gtk_tool_item_group_set_label($!tig, $label);
      }
    );
  }

  method label_widget is rw is also<label-widget> {
    Proxy.new(
      FETCH => sub ($) {
        gtk_tool_item_group_get_label_widget($!tig);
      },
      STORE => sub ($, GtkWidget() $label_widget is copy) {
        gtk_tool_item_group_set_label_widget($!tig, $label_widget);
      }
    );
  }
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  method get_drop_item (Int() $x, Int() $y) is also<get-drop-item> {
    my @i = ($x, $y);
    my gint ($xx, $yy) = self.RESOLVE-INT(@i);
    gtk_tool_item_group_get_drop_item($!tig, $xx, $yy);
  }

  method get_item_position (GtkToolItem() $item) is also<get-item-position> {
    gtk_tool_item_group_get_item_position($!tig, $item);
  }

  method get_n_items is also<get-n-items> {
    gtk_tool_item_group_get_n_items($!tig);
  }

  method get_nth_item (guint $index) is also<get-nth-item> {
    my guint $i = self.RESOLVE-UINT($index);
    gtk_tool_item_group_get_nth_item($!tig, $i);
  }

  method get_type is also<get-type> {
    gtk_tool_item_group_get_type();
  }

  multi method insert (GtkToolItem() $item, Int() $position) {
    my gint $p = self.RESOLVE-INT($position);
    gtk_tool_item_group_insert($!tig, $item, $p);
  }

  method set_item_position (GtkToolItem() $item, Int() $position) is also<set-item-position> {
    my gint $p = self.RESOLVE-INT($position);
    gtk_tool_item_group_set_item_position($!tig, $item, $p);
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
