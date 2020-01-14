use v6.c;

use Method::Also;
use NativeCall;

use GTK::Raw::ToolPalette;
use GTK::Raw::Types;

use GTK::Roles::Orientable;

use GTK::Container;
use GTK::ToolItemGroup;
use GTK::ToolItem;

our subset ToolPaletteAncestry is export
  where GtkToolPalette | GtkOrientable | ContainerAncestry;

class GTK::ToolPalette is GTK::Container {
  also does GTK::Roles::Orientable;

  has GtkToolPalette $!tp is implementor;

  method bless(*%attrinit) {
    my $o = self.CREATE.BUILDALL(Empty, %attrinit);
    $o.setType($o.^name);
    $o;
  }

  submethod BUILD(:$palette) {
    my $to-parent;
    given $palette {
      when ToolPaletteAncestry {
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

  multi method new (ToolPaletteAncestry $palette) {
    return unless $palette;

    my $o = self.bless(:$palette);
    $o.upref;
    $o;
  }
  multi method new {
    my $palette = gtk_tool_palette_new();

    $palette ?? self.bless(:$palette) !! Nil;
  }

  # ↓↓↓↓ SIGNALS ↓↓↓↓
  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓\
  method style is rw {
    Proxy.new(
      FETCH => -> $ {
        GtkToolbarStyleEnum( gtk_tool_palette_get_style($!tp) );
      },
      STORE => -> $, Int() $val {
        my guint $v = $val;

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
    my uint32 ($f, $t, $a) = ($flags, $targets, $actions);

    gtk_tool_palette_add_drag_dest($!tp, $widget, $f, $t, $a);
  }

  method get_drag_item (GtkSelectionData $selection)
    is also<get-drag-item>
  {
    gtk_tool_palette_get_drag_item($!tp, $selection);
  }

  method get_drop_group (Int() $x, Int() $y, :$raw = False)
    is also<get-drop-group>
  {
    my gint ($xx, $yy) = ($x, $y);

    my $tig = gtk_tool_palette_get_drop_group($!tp, $xx, $yy);

    $tig ??
      ( $raw ?? $tig !! GTK::ToolItemGroup.new($tig) )
      !!
      Nil;
  }

  method get_drop_item (Int() $x, Int() $y, :$raw = False)
    is also<get-drop-item>
  {  
    my gint ($xx, $yy) = ($x, $y);
    my $ti = gtk_tool_palette_get_drop_item($!tp, $xx, $yy);

    $ti ??
      ( $raw ?? $ti !! GTK::ToolItem.new($ti) )
      !!
      Nil;
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

  method get_hadjustment (:$raw = False)
    is also<
      get-hadjustment
      hadjustment
    >
  {
    my $a = gtk_tool_palette_get_hadjustment($!tp);

    $a ??
      ( $raw ?? $a !! GTK::Adjustment.new($a) )
      !!
      Nil;
  }

  method get_icon_size
    is also<
      get-icon-size
      icon_size
      icon-size
    >
  {
    GtkIconSizeEnum( gtk_tool_palette_get_icon_size($!tp) );
  }

  method get_type is also<get-type> {
    state ($n, $t);

    GTK::Widget.unstable_get_type( &gtk_tool_palette_get_type, $n, $t );
  }

  method get_vadjustment (:$raw = False)
    is also<
      get-vadjustment
      vadjustment
    >
  {
    my $a = gtk_tool_palette_get_vadjustment($!tp);

    $a ??
      ( $raw ?? $a !! GTK::Adjustment.new($a) )
      !!
      Nil;
  }

  multi method set_drag_source (
    Int() $targets           # GtkToolPaletteDragTargets $targets
  )
    is also<set-drag-source>
  {
    my GtkToolPaletteDragTargets $t = $targets;

    gtk_tool_palette_set_drag_source($!tp, $t);
  }

  method set_exclusive (GtkToolItemGroup() $group, Int() $exclusive)
    is also<set-exclusive>
  {
    my gboolean $e = $exclusive.so.Int;

    gtk_tool_palette_set_exclusive($!tp, $group, $e);
  }

  method set_expand (GtkToolItemGroup() $group, Int() $expand)
    is also<set-expand>
  {
    my gboolean $e = $expand.so.Int;

    gtk_tool_palette_set_expand($!tp, $group, $e);
  }

  method set_group_position (GtkToolItemGroup() $group, Int() $position)
    is also<set-group-position>
  {
    my gint $p = $position;

    gtk_tool_palette_set_group_position($!tp, $group, $p);
  }

  method unset_icon_size is also<unset-icon-size> {
    gtk_tool_palette_unset_icon_size($!tp);
  }

  method unset_style is also<unset-style> {
    gtk_tool_palette_unset_style($!tp);
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

  method child-set(*@propval) {
    my @notfound;
    @notfound = gather for @propval -> $p, $v {
      given $p {
        when 'expand'     |
             'exclusive'  { self.child-set-bool($p, $v)  }

        default           { take $p; take $v;            }
      }
    }
    nextwith(@notfound) if +@notfound;
  }
}
