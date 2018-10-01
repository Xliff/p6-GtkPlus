use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::ToolPalette;
use GTK::Raw::Types;

use GTK::Container;

class GTK::ToolPalette is GTK::Container {
  has GtkToolPalette $!tp;

  method bless(*%attrinit) {
    my $o = self.CREATE.BUILDALL(Empty, %attrinit);
    $o.setType('GTK::ToolItem');
    $o;
  }

  submethod BUILD(:$palette) {
    my $to-parent;
    given $palette {
      when GtkToolPalette | GtkWidget {
        $!tp = do {
          when GtkWidget {
            $to-parent = $_;
            nativecast(GtkToolPalette, $palette);
          }
          when GtkToolPalette  {
            $to-parent = nativecast(GtkContainer, $palette);
            $palette;
          }
        }
        self.setContainer($to-parent);
      }
      when GTK::ToolPalette {
      }
      default {
      }
    }
  }

  multi method new {
    my $palette = gtk_tool_palette_new();
    self.bless(:$palette);
  }
  multi method new (GtkWidget $palette) {
    self.bless(:$palette);
  }

  # ↓↓↓↓ SIGNALS ↓↓↓↓
  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  multi method add_drag_dest (
    GtkWidget() $widget,
    Int() $flags,
    Int() $targets,
    Int() $actions
  ) {
    my @u = ($flags, $targets, $actions);
    my uint32 ($f, $t, $a) = self.RESOLVE-UINT(@u);
    gtk_tool_palette_add_drag_dest($!tp, $widget, $f, $t, $a);
  }

  method get_drag_item (GtkSelectionData $selection) {
    gtk_tool_palette_get_drag_item($!tp, $selection);
  }

  method get_drag_target_group {
    gtk_tool_palette_get_drag_target_group($!tp);
  }

  method get_drag_target_item {
    gtk_tool_palette_get_drag_target_item($!tp);
  }

  method get_drop_group (Int() $x, Int() $y) {
    my @u = ($x, $y);
    my gint ($xx, $yy) = self.RESOLVE-INT(@u);
    gtk_tool_palette_get_drop_group($!tp, $xx, $yy);
  }

  method get_drop_item (Int() $x, Int() $y) {
    my @u = ($x, $y);
    my gint ($xx, $yy) = self.RESOLVE-INT(@u);
    gtk_tool_palette_get_drop_item($!tp, $xx, $yy);
  }

  method get_exclusive (GtkToolItemGroup() $group) {
    gtk_tool_palette_get_exclusive($!tp, $group);
  }

  method get_expand (GtkToolItemGroup() $group) {
    gtk_tool_palette_get_expand($!tp, $group);
  }

  method get_group_position (GtkToolItemGroup() $group) {
    gtk_tool_palette_get_group_position($!tp, $group);
  }

  method get_hadjustment {
    GTK::Adjustment.new( gtk_tool_palette_get_hadjustment($!tp) );
  }

  method get_icon_size {
    GtkIconSize( gtk_tool_palette_get_icon_size($!tp) );
  }

  method get_style {
    GtkToolbarStyle( gtk_tool_palette_get_style($!tp) );
  }

  method get_type {
    gtk_tool_palette_get_type();
  }

  method get_vadjustment {
    GTK::Adjustment.new( gtk_tool_palette_get_vadjustment($!tp) );
  }

  multi method set_drag_source (
    Int() $targets           # GtkToolPaletteDragTargets $targets
  ) {
    my $t = self.RESOLVE-UINT($targets);
    gtk_tool_palette_set_drag_source($!tp, $t);
  }

  method set_exclusive (GtkToolItemGroup() $group, Int() $exclusive) {
    my gboolean $e = self.RESOLVE-BOOL($exclusive);
    gtk_tool_palette_set_exclusive($!tp, $group, $e);
  }

  method set_expand (GtkToolItemGroup() $group, Int() $expand) {
    my gboolean $e = self.RESOLVE-BOOL($expand);
    gtk_tool_palette_set_expand($!tp, $group, $e);
  }

  method set_group_position (GtkToolItemGroup() $group, Int() $position) {
    my gint $p = self.RESOLVE-INT($position);
    gtk_tool_palette_set_group_position($!tp, $group, $p);
  }

  method unset_icon_size {
    gtk_tool_palette_unset_icon_size($!tp);
  }

  method unset_style {
    gtk_tool_palette_unset_style($!tp);
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
