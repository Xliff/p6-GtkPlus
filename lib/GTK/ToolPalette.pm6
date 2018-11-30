use v6.c;

use Method::Also;
use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::ToolPalette;
use GTK::Raw::Types;

use GTK::Container;
use GTK::ToolItemGroup;
use GTK::ToolItem;

use GTK::Roles::Orientable;

my subset Ancestry where
  GtkToolPalette | GtkOrientable | GtkContainer | GtkBuildable |
  GtkWidget;

class GTK::ToolPalette is GTK::Container {
  also does GTK::Roles::Orientable;

  has GtkToolPalette $!tp;

  method bless(*%attrinit) {
    my $o = self.CREATE.BUILDALL(Empty, %attrinit);
    $o.setType('GTK::ToolItem');
    $o;
  }

  submethod BUILD(:$palette) {
    my $to-parent;
    given $palette {
      when Ancestry {
        $!tp = do {
          when GtkToolPalette  {
            $to-parent = nativecast(GtkContainer, $palette);
            $palette;
          }
          when GtkOrientable {
            $!or = $_;
            $to-parent = nativecast(GtkContainer, $palette);
            nativecast(GtkToolPalette, $palette);
          }
          default {
            $to-parent = $_;
            nativecast(GtkToolPalette, $palette);
          }
        }
        self.setContainer($to-parent);
      }
      when GTK::ToolPalette {
      }
      default {
      }
    }
    $!or //= nativecast(GtkOrientable, $palette); # GTK::Roles::Orientable
  }

  multi method new (Ancestry $palette) {
    my $o = self.bless(:$palette);
    $o.upref;
    $o;
  }
  multi method new {
    my $palette = gtk_tool_palette_new();
    self.bless(:$palette);
  }

  # ↓↓↓↓ SIGNALS ↓↓↓↓
  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓\
  method style is rw {
    Proxy.new(
      FETCH => -> $ {
        GtkToolbarStyle( gtk_tool_palette_get_style($!tp) );
      },
      STORE => -> $, Int() $val {
        my guint $v = self.RESOLVE-UINT($val);
        gtk_tool_palette_set_style($!tp, $v);
      }
    );
  }

  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ STATIC METHODS ↓↓↓↓
  method get_drag_target_group is also<get-drag-target-group> {
    gtk_tool_palette_get_drag_target_group();
  }

  method get_drag_target_item is also<get-drag-target-item> {
    gtk_tool_palette_get_drag_target_item();
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  multi method add_drag_dest (
    GtkWidget() $widget,
    Int() $flags,
    Int() $targets,
    Int() $actions
  )
    is also<add-drag-dest>
  {
    my @u = ($flags, $targets, $actions);
    my uint32 ($f, $t, $a) = self.RESOLVE-UINT(@u);
    gtk_tool_palette_add_drag_dest($!tp, $widget, $f, $t, $a);
  }

  method get_drag_item (GtkSelectionData $selection)
    is also<get-drag-item>
  {
    gtk_tool_palette_get_drag_item($!tp, $selection);
  }

  method get_drop_group (Int() $x, Int() $y) is also<get-drop-group> {
    my @u = ($x, $y);
    my gint ($xx, $yy) = self.RESOLVE-INT(@u);
    GTK::ToolItemGroup.new(
      gtk_tool_palette_get_drop_group($!tp, $xx, $yy)
    );
  }

  method get_drop_item (Int() $x, Int() $y) is also<get-drop-item> {
    my @u = ($x, $y);
    my gint ($xx, $yy) = self.RESOLVE-INT(@u);
    GTK::ToolItem.new( gtk_tool_palette_get_drop_item($!tp, $xx, $yy) );
  }

  method get_exclusive (GtkToolItemGroup() $group) is also<get-exclusive> {
    gtk_tool_palette_get_exclusive($!tp, $group);
  }

  method get_expand (GtkToolItemGroup() $group) is also<get-expand> {
    gtk_tool_palette_get_expand($!tp, $group);
  }

  method get_group_position (GtkToolItemGroup() $group)
    is also<get-group-position>
  {
    gtk_tool_palette_get_group_position($!tp, $group);
  }

  method get_hadjustment is also<get-hadjustment> {
    GTK::Adjustment.new( gtk_tool_palette_get_hadjustment($!tp) );
  }

  method get_icon_size is also<get-icon-size> {
    GtkIconSize( gtk_tool_palette_get_icon_size($!tp) );
  }

  method get_type is also<get-type> {
    gtk_tool_palette_get_type();
  }

  method get_vadjustment is also<get-vadjustment> {
    GTK::Adjustment.new( gtk_tool_palette_get_vadjustment($!tp) );
  }

  multi method set_drag_source (
    Int() $targets           # GtkToolPaletteDragTargets $targets
  )
    is also<set-drag-source>
  {
    my $t = self.RESOLVE-UINT($targets);
    gtk_tool_palette_set_drag_source($!tp, $t);
  }

  method set_exclusive (GtkToolItemGroup() $group, Int() $exclusive)
    is also<set-exclusive>
  {
    my gboolean $e = self.RESOLVE-BOOL($exclusive);
    gtk_tool_palette_set_exclusive($!tp, $group, $e);
  }

  method set_expand (GtkToolItemGroup() $group, Int() $expand)
    is also<set-expand>
  {
    my gboolean $e = self.RESOLVE-BOOL($expand);
    gtk_tool_palette_set_expand($!tp, $group, $e);
  }

  method set_group_position (GtkToolItemGroup() $group, Int() $position)
    is also<set-group-position>
  {
    my gint $p = self.RESOLVE-INT($position);
    gtk_tool_palette_set_group_position($!tp, $group, $p);
  }

  method unset_icon_size is also<unset-icon-size> {
    gtk_tool_palette_unset_icon_size($!tp);
  }

  method unset_style is also<unset-style> {
    gtk_tool_palette_unset_style($!tp);
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
