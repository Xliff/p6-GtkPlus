use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::TreeViewColumn;
use GTK::Raw::Types;

use GTK::CellArea;

use GTK::Roles::Buildable;
use GTK::Roles::CellLayout;

class GTK::TreeViewColumn {
  also does GTK::Roles::Buildable;
  also does GTK::Roles::CellLayout;

  has GtkTreeViewColumn $!tvc;

  submethod BUILD(:$treeview) {
    $!tvc = $treeview;
    $!b   = nativecast(GtkBuildable, $!tvc);    # GTK::Roles::Buildable
    $!cl  = nativecast(GtkCellLayout, $!tvc);  # GTK::Roles::CellLayout
  }

  method GTK::Raw::Types::GtkTreeViewColumn {
    $!tvc;
  }

  method new {
    my $treeview = gtk_tree_view_column_new();
    self.bless(:$treeview);
  }

  method new_with_area(GtkCellArea $area) {
    my $treeview = gtk_tree_view_column_new_with_area($area);
    self.bless(:$treeview);
  }


  # ↓↓↓↓ SIGNALS ↓↓↓↓

  # Is originally:
  # GtkTreeViewColumn, gpointer --> void
  method clicked {
    self.connect($!tvc, 'clicked');
  }

  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  method alignment is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_tree_view_column_get_alignment($!tvc);
      },
      STORE => sub ($, Num() $xalign is copy) {
        my num32 $xa = $xalign;
        gtk_tree_view_column_set_alignment($!tvc, $xa);
      }
    );
  }

  method clickable is rw {
    Proxy.new(
      FETCH => sub ($) {
        so GTK::CellArea.new( gtk_tree_view_column_get_clickable($!tvc) );
      },
      STORE => sub ($, GtkCellArea() $clickable is copy) {
        my gboolean $c = self.RESOLVE-BOOL($clickable);
        gtk_tree_view_column_set_clickable($!tvc, $c);
      }
    );
  }

  method expand is rw {
    Proxy.new(
      FETCH => sub ($) {
        so gtk_tree_view_column_get_expand($!tvc);
      },
      STORE => sub ($, Int() $expand is copy) {
        my gboolean $e = self.RESOLVE-BOOL($expand);
        gtk_tree_view_column_set_expand($!tvc, $e);
      }
    );
  }

  method fixed_width is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_tree_view_column_get_fixed_width($!tvc);
      },
      STORE => sub ($, Int() $fixed_width is copy) {
        my gint $fw = self.RESOLVE-INT($fixed_width);
        gtk_tree_view_column_set_fixed_width($!tvc, $fw);
      }
    );
  }

  method max_width is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_tree_view_column_get_max_width($!tvc);
      },
      STORE => sub ($, Int() $max_width is copy) {
        my gint $mw = self.RESOLVE-BOOL($max_width);
        gtk_tree_view_column_set_max_width($!tvc, $mw);
      }
    );
  }

  method min_width is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_tree_view_column_get_min_width($!tvc);
      },
      STORE => sub ($, Int() $min_width is copy) {
        my gint $mw = self.RESOLVE-BOOL($min_width);
        gtk_tree_view_column_set_min_width($!tvc, $mw);
      }
    );
  }

  method reorderable is rw {
    Proxy.new(
      FETCH => sub ($) {
        so gtk_tree_view_column_get_reorderable($!tvc);
      },
      STORE => sub ($, Int() $reorderable is copy) {
        my gboolean $r = self.RESOLVE-BOOL($reorderable);
        gtk_tree_view_column_set_reorderable($!tvc, $r);
      }
    );
  }

  method resizable is rw {
    Proxy.new(
      FETCH => sub ($) {
        so gtk_tree_view_column_get_resizable($!tvc);
      },
      STORE => sub ($, Int() $resizable is copy) {
        my gboolean $r = self.RESOLVE-BOOL($resizable);
        gtk_tree_view_column_set_resizable($!tvc, $r);
      }
    );
  }

  method sizing is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_tree_view_column_get_sizing($!tvc);
      },
      STORE => sub ($, Int() $type is copy) {
        my uint32 $t = self.RESOLVE-UINT($type);
        gtk_tree_view_column_set_sizing($!tvc, $t);
      }
    );
  }

  method sort_column_id is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_tree_view_column_get_sort_column_id($!tvc);
      },
      STORE => sub ($, Int() $sort_column_id is copy) {
        my gint $s = self.RESOLVE-INT($sort_column_id);
        gtk_tree_view_column_set_sort_column_id($!tvc, $s);
      }
    );
  }

  method sort_indicator is rw {
    Proxy.new(
      FETCH => sub ($) {
        so gtk_tree_view_column_get_sort_indicator($!tvc);
      },
      STORE => sub ($, Int() $setting is copy) {
        my gboolean $s = self.RESOLVE-BOOL($setting);
        gtk_tree_view_column_set_sort_indicator($!tvc, $s);
      }
    );
  }

  method sort_order is rw {
    Proxy.new(
      FETCH => sub ($) {
        GtkSortType( gtk_tree_view_column_get_sort_order($!tvc) );
      },
      STORE => sub ($, Int() $order is copy) {
        my uint32 $o = self.RESOLVE-UINT($order);
        gtk_tree_view_column_set_sort_order($!tvc, $o);
      }
    );
  }

  method spacing is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_tree_view_column_get_spacing($!tvc);
      },
      STORE => sub ($, Int() $spacing is copy) {
        my gint $s = self.RESOLVE-INT($spacing);
        gtk_tree_view_column_set_spacing($!tvc, $s);
      }
    );
  }

  method title is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_tree_view_column_get_title($!tvc);
      },
      STORE => sub ($, Str() $title is copy) {
        gtk_tree_view_column_set_title($!tvc, $title);
      }
    );
  }

  method visible is rw {
    Proxy.new(
      FETCH => sub ($) {
        so gtk_tree_view_column_get_visible($!tvc);
      },
      STORE => sub ($, $visible is copy) {
        my gboolean $v = self.RESOLVE-BOOL($visible);
        gtk_tree_view_column_set_visible($!tvc, $v);
      }
    );
  }

  # Must be resolved by caller.
  method widget is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_tree_view_column_get_widget($!tvc);
      },
      STORE => sub ($, GtkWidget() $widget is copy) {
        gtk_tree_view_column_set_widget($!tvc, $widget);
      }
    );
  }
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ PROPERTIES ↓↓↓↓

  # Type: GtkCellArea
  method cell-area is rw {
    my GTK::Compat::Value $gv .= new( G_TYPE_OBJECT );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new( self.prop_get($!tvc, 'cell-area', $gv); );
        GTK::CellArea.new( nativecast(GtkCellArea, $gv.object) );
      },
      STORE => -> $, GtkCellArea() $val is copy {
        $gv.object = $val;
        self.prop_set($!tvc, 'cell-area', $gv);
      }
    );
  }

  # Type: gint
  method width is rw {
    my GTK::Compat::Value $gv .= new( G_TYPE_INT );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new( self.prop_get($!tvc, 'width', $gv); );
        $gv.int;
      },
      STORE => -> $, Int() $val is copy {
        warn "width does not allow writing"
      }
    );
  }

  # Type: gint
  method x-offset is rw {
    my GTK::Compat::Value $gv .= new( G_TYPE_INT );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new( self.prop_get($!tvc, 'x-offset', $gv); );
        $gv.int;
      },
      STORE => -> $, $val is copy {
        warn "x-offset does not allow writing"
      }
    );
  }

  # ↑↑↑↑ PROPERTIES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  method add_attribute (
    GtkCellRenderer() $cell_renderer,
    Str() $attribute,
    Int() $column
  ) {
    my gint $c = self.RESOLVE-INT($column);
    gtk_tree_view_column_add_attribute($!tvc, $cell_renderer, $attribute, $c);
  }

  method cell_get_position (
    GtkCellRenderer() $cell_renderer,
    Int() $x_offset,
    Int() $width
  ) {
    my @i = ($x_offset, $width);
    my gint ($xo, $w) = self.RESOLVE-INT(@i);
    gtk_tree_view_column_cell_get_position($!tvc, $cell_renderer, $xo, $w);
  }

  method cell_get_size (
    GdkRectangle() $cell_area,
    Int() $x_offset,
    Int() $y_offset,
    Int() $width,
    Int() $height
  ) {
    my @i = ($x_offset, $y_offset, $width, $height);
    my gint ($xo, $yo, $w, $h) = self.RESOLVE-INT(@i);
    gtk_tree_view_column_cell_get_size($!tvc, $cell_area, $xo, $yo, $w, $h);
  }

  method cell_is_visible {
    gtk_tree_view_column_cell_is_visible($!tvc);
  }

  method cell_set_cell_data (
    GtkTreeModel() $tree_model,
    GtkTreeIter() $iter,
    Int() $is_expander,
    Int() $is_expanded
  ) {
    my @b = ($is_expander, $is_expanded);
    my ($er, $ed) = self.RESOLVE-BOOL(@b);
    gtk_tree_view_column_cell_set_cell_data(
      $!tvc,
      $tree_model,
      $iter,
      $er,
      $ed
    );
  }

  method clear {
    gtk_tree_view_column_clear($!tvc);
  }

  method clear_attributes (GtkCellRenderer() $cell_renderer) {
    gtk_tree_view_column_clear_attributes($!tvc, $cell_renderer);
  }

  method emit-clicked {
    gtk_tree_view_column_clicked($!tvc);
  }

  method focus_cell (GtkCellRenderer() $cell) {
    gtk_tree_view_column_focus_cell($!tvc, $cell);
  }

  method get_button {
    gtk_tree_view_column_get_button($!tvc);
  }

  method get_tree_view {
    gtk_tree_view_column_get_tree_view($!tvc);
  }

  method get_type {
    gtk_tree_view_column_get_type();
  }

  method get_width {
    gtk_tree_view_column_get_width($!tvc);
  }

  method get_x_offset {
    gtk_tree_view_column_get_x_offset($!tvc);
  }

  method pack_end (GtkCellRenderer() $cell, Int() $expand) {
    my gboolean $e = self.RESOLVE-BOOL($expand);
    gtk_tree_view_column_pack_end($!tvc, $cell, $e);
  }

  method pack_start (GtkCellRenderer() $cell, Int() $expand) {
    my gboolean $e = self.RESOLVE-BOOL($expand);
    gtk_tree_view_column_pack_start($!tvc, $cell, $e);
  }

  method queue_resize {
    gtk_tree_view_column_queue_resize($!tvc);
  }

  method set_cell_data_func (
    GtkCellRenderer() $cell_renderer,
    GtkTreeCellDataFunc $func,
    gpointer $func_data = gpointer,
    GDestroyNotify $destroy = GDestroyNotify
  ) {
    gtk_tree_view_column_set_cell_data_func(
      $!tvc,
      $cell_renderer,
      $func,
      $func_data,
      $destroy
    );
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
