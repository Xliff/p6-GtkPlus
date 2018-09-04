use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::ToolPalette;
use GTK::Raw::Types;

use GTK::Container;

class GTK::ToolPalette is GTK::Container {
  has GtkToolPalette $!tp;

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
            $to-parent = nativecast(GtkWidget, $palette);
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
    self.setType('GTK::ToolPalette');
  }

  method new {
    my $palette = gtk_tool_palette_new();
    self.bless(:$palette);
  }

  # ↓↓↓↓ SIGNALS ↓↓↓↓
  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  multi method add_drag_dest (
    GtkWidget $widget,
    Int() $flags,
    Int() $targets,
    Int() $actions
  ) {
    my uint32 ($f, $t, $a) = ($flags, $targets, $actions)
      >>+&<<
    (0xffff xx 3);
    gtk_tool_palette_add_drag_dest($!tp, $widget, $f, $t, $a);
  }
  multi method add_drag_dest (
    GTK::Widget $widget,
    Int() $flags,
    Int() $targets,
    Int() $actions
  ) {
    samewith($widget.widget, $flags, $targets, $actions);
  }

  multi method get_drag_item (GtkSelectionData $selection) {
    gtk_tool_palette_get_drag_item($!tp, $selection);
  }

  method get_drag_target_group {
    gtk_tool_palette_get_drag_target_group($!tp);
  }

  method get_drag_target_item {
    gtk_tool_palette_get_drag_target_item($!tp);
  }

  method get_drop_group (Int() $x, Int() $y) {
    my gint ($xx, $yy) = ($x, $y) >>+&<< (0xffff xx 2);
    gtk_tool_palette_get_drop_group($!tp, $xx, $yy);
  }

  method get_drop_item (Int() $x, Int() $y) {
    # -YYY- Note to self: It occurs to me that the method below
    # may NOT be the best way to handle signed integers.
    my gint ($xx, $yy) = ($x, $y) >>+&<< (0xffff xx 2);
    gtk_tool_palette_get_drop_item($!tp, $xx, $yy);
  }

  #multi
  method get_exclusive (GtkToolItemGroup $group) {
    gtk_tool_palette_get_exclusive($!tp, $group);
  }

  #multi
  method get_expand (GtkToolItemGroup $group) {
    gtk_tool_palette_get_expand($!tp, $group);
  }

  #multi
  method get_group_position (GtkToolItemGroup $group) {
    gtk_tool_palette_get_group_position($!tp, $group);
  }

  method get_hadjustment {
    GtkAdjustment( gtk_tool_palette_get_hadjustment($!tp) );
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
    GtkAdjustment( gtk_tool_palette_get_vadjustment($!tp) );
  }

  multi method set_drag_source (
    Int() $targets           # GtkToolPaletteDragTargets $targets
  ) {
    my $t = $targets +& 0xffff;
    gtk_tool_palette_set_drag_source($!tp, $t);
  }

  #multi
  method set_exclusive (GtkToolItemGroup $group, Int() $exclusive) {
    my $e = $exclusive == 0 ?? 0 !! 1
    gtk_tool_palette_set_exclusive($!tp, $group, $e);
  }

  #multi
  method set_expand (GtkToolItemGroup $group, Int() $expand) {
    my $e = $expand == 0 ?? 0 !! 1
    gtk_tool_palette_set_expand($!tp, $group, $e);
  }

  #multi
  method set_group_position (GtkToolItemGroup $group, Int() $position) {
    # See note on gint handling, above
    my gint $p = $position;
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
