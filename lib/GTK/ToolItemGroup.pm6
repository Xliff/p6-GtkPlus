use v6.c;

use Method::Also;
use NativeCall;

use Pango::Raw::Types;

use GTK::Raw::ToolItemGroup;
use GTK::Raw::Types;

use GTK::Container;
use GTK::Widget;

our subset ToolItemGroupAncestry is export
  where GtkToolItemGroup | GtkToolShell | ContainerAncestry;

use GTK::Roles::ToolShell;

class GTK::ToolItemGroup is GTK::Container {
  also does GTK::Roles::ToolShell;

  has GtkToolItemGroup $!tig is implementor;

  method bless(*%attrinit) {
    my $o = self.CREATE.BUILDALL(Empty, %attrinit);
    $o.setType($o.^name);
    $o;
  }

  submethod BUILD(:$toolgroup) {
    my $to-parent;
    given $toolgroup {
      when ToolItemGroupAncestry {
        $!tig = do {
          when GtkToolItemGroup  {
            $to-parent = nativecast(GtkContainer, $_);
            $_;
          }

          when GtkToolShell {
            $!shell = $_;
            $to-parent = nativecast(GtkContainer, $_);
            nativecast(GtkToolItemGroup, $_);
          }

          default {
            $to-parent = $_;
            nativecast(GtkToolItemGroup, $_);
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

  method GTK::Raw::Types::GtkToolItemGroup
    is also<
      ToolItemGroup
      GtkToolItemGroup
    >
    { $!tig }

  multi method new (ToolItemGroupAncestry $toolgroup) {
    return Nil unless $toolgroup;

    my $o = self.bless(:$toolgroup);
    $o.upref;
    $o;
  }
  multi method new(Str() $label = '') {
    my $toolgroup = gtk_tool_item_group_new($label);

    $toolgroup ?? self.bless(:$toolgroup) !! Nil;
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
        my gboolean $c = $collapsed.so.Int;

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
        my uint32 $e = $ellipsize;
        
        gtk_tool_item_group_set_ellipsize($!tig, $e);
      }
    );
  }

  method header_relief is rw is also<header-relief> {
    Proxy.new(
      FETCH => sub ($) {
        GtkReliefStyleEnum(
          gtk_tool_item_group_get_header_relief($!tig)
        );
      },
      STORE => sub ($, Int() $style is copy) {
        my uint32 $s = $style;

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

  method label_widget (
    :$raw = False,
    :$widget = False
  ) is rw is also<label-widget> {
    Proxy.new(
      FETCH => sub ($) {
        my $w = gtk_tool_item_group_get_label_widget($!tig);

        $w ??
          ( $raw
            ?? $w
            !! ( $widget ?? GTK::Widget.new($w)
                         !! GTK::Widget.CreateObject($w) )
          )
          !!
          Nil;
      },
      STORE => sub ($, GtkWidget() $label_widget is copy) {
        gtk_tool_item_group_set_label_widget($!tig, $label_widget);
      }
    );
  }
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  method get_drop_item (Int() $x, Int() $y) is also<get-drop-item> {
    my gint ($xx, $yy) = ($x, $y);

    gtk_tool_item_group_get_drop_item($!tig, $xx, $yy);
  }

  method get_item_position (GtkToolItem() $item) is also<get-item-position> {
    gtk_tool_item_group_get_item_position($!tig, $item);
  }

  method get_n_items
    is also<
      get-n-items
      n_items
      n-items
      elems
    >
  {
    gtk_tool_item_group_get_n_items($!tig);
  }

  method get_nth_item (Int() $index)
    is also<
      get-nth-item
      nth_item
      nth-item
    >
  {
    my guint $i = $index;

    GTK::ToolItem.new( gtk_tool_item_group_get_nth_item($!tig, $i) );
  }

  method get_type is also<get-type> {
    state ($n, $t);

    GTK::Widget.unstable_get_type( &gtk_tool_item_group_get_type, $n, $t );
  }

  multi method insert (GtkToolItem() $item, Int() $position) {
    my gint $p = $position;

    gtk_tool_item_group_insert($!tig, $item, $p);
  }

  method set_item_position (GtkToolItem() $item, Int() $position)
    is also<set-item-position>
  {
    my gint $p = $position;

    gtk_tool_item_group_set_item_position($!tig, $item, $p);
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

  method child-set(GtkWidget() $c, *@propval) {
    my @notfound;
    @notfound = gather for @propval -> $p, $v {
      given $p {
        when 'expand'     |
             'homogenous' |
             'fill'       |
             'new-row'    { self.child-set-bool($c, $p, $v)  }

        when 'position'   { self.child-set-int($c, $p, $v)   }

        default           { take $p; take $v;                }
      }
    }
    nextwith($c, @notfound) if +@notfound;
  }

}
