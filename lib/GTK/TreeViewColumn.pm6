use v6.c;

use Method::Also;

use GTK::Raw::TreeViewColumn;
use GTK::Raw::Types;

use GLib::Value;
use GTK::CellArea;
use GTK::Widget;

use GTK::Roles::Buildable;
use GTK::Roles::CellLayout;
use GLib::Roles::Properties;
use GTK::Roles::Types;

class GTK::TreeViewColumn {
  also does GTK::Roles::Buildable;
  also does GTK::Roles::CellLayout;
  also does GLib::Roles::Properties;

  # Using GTK::Raw::Utils to prevent circular role dependency between
  # CellLayout and Types

  has GtkTreeViewColumn $!tvc is implementor;

  submethod BUILD(:$treeview) {
    self!setObject($!tvc = $treeview);

    $!b   = cast(GtkBuildable,  $!tvc);   # GTK::Roles::Buildable
    $!cl  = cast(GtkCellLayout, $!tvc);   # GTK::Roles::CellLayout
  }

  method GTK::Raw::Definitions::GtkTreeViewColumn
    is also<
      TreeViewColumn
      GtkTreeViewColumn
    >
  { $!tvc }

  multi method new (GtkTreeViewColumn $treeview) {
    $treeview ?? self.bless(:$treeview) !! Nil;
  }
  multi method new {
    my $treeview = gtk_tree_view_column_new();

    $treeview ?? self.bless(:$treeview) !! Nil;
  }

  method new_with_area(GtkCellArea() $area) is also<new-with-area> {
    my $treeview = gtk_tree_view_column_new_with_area($area);

    $treeview ?? self.bless(:$treeview) !! Nil;
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
      STORE => sub ($, Int() $clickable is copy) {
        my gboolean $c = $clickable;

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
        my gboolean $e = $expand;

        gtk_tree_view_column_set_expand($!tvc, $e);
      }
    );
  }

  method fixed_width is rw is also<fixed-width> {
    Proxy.new(
      FETCH => sub ($) {
        gtk_tree_view_column_get_fixed_width($!tvc);
      },
      STORE => sub ($, Int() $fixed_width is copy) {
        my gint $fw = $fixed_width;

        gtk_tree_view_column_set_fixed_width($!tvc, $fw);
      }
    );
  }

  method max_width is rw is also<max-width> {
    Proxy.new(
      FETCH => sub ($) {
        gtk_tree_view_column_get_max_width($!tvc);
      },
      STORE => sub ($, Int() $max_width is copy) {
        my gint $mw = $max_width;

        gtk_tree_view_column_set_max_width($!tvc, $mw);
      }
    );
  }

  method min_width is rw is also<min-width> {
    Proxy.new(
      FETCH => sub ($) {
        gtk_tree_view_column_get_min_width($!tvc);
      },
      STORE => sub ($, Int() $min_width is copy) {
        my gint $mw = $min_width;

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
        my gboolean $r = $reorderable;

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
        my gboolean $r = $resizable;

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
        my uint32 $t = $type;

        gtk_tree_view_column_set_sizing($!tvc, $t);
      }
    );
  }

  method sort_column_id is rw is also<sort-column-id> {
    Proxy.new(
      FETCH => sub ($) {
        gtk_tree_view_column_get_sort_column_id($!tvc);
      },
      STORE => sub ($, Int() $sort_column_id is copy) {
        my gint $s = $sort_column_id;

        gtk_tree_view_column_set_sort_column_id($!tvc, $s);
      }
    );
  }

  method sort_indicator is rw is also<sort-indicator> {
    Proxy.new(
      FETCH => sub ($) {
        so gtk_tree_view_column_get_sort_indicator($!tvc);
      },
      STORE => sub ($, Int() $setting is copy) {
        my gboolean $s = $setting;

        gtk_tree_view_column_set_sort_indicator($!tvc, $s);
      }
    );
  }

  method sort_order is rw is also<sort-order> {
    Proxy.new(
      FETCH => sub ($) {
        GtkSortTypeEnum( gtk_tree_view_column_get_sort_order($!tvc) );
      },
      STORE => sub ($, Int() $order is copy) {
        my uint32 $o = $order;

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
        my gint $s = $spacing;

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
        my gboolean $v = $visible;

        gtk_tree_view_column_set_visible($!tvc, $v);
      }
    );
  }

  # Not to be confused with GTK::Widget.Widget, hence the case difference.
  method widget (:$raw = False, :$widget = False) is rw {
    Proxy.new(
      FETCH => sub ($) {
        my $w = gtk_tree_view_column_get_widget($!tvc);

        ReturnWidget($w, $raw, $widget);
      },
      STORE => sub ($, GtkWidget() $widget is copy) {
        gtk_tree_view_column_set_widget($!tvc, $widget);
      }
    );
  }
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ PROPERTIES ↓↓↓↓

  # Type: GtkCellArea
  method cell-area (:$raw = False) is rw is also<cell_area> {
    my GLib::Value $gv .= new( G_TYPE_OBJECT );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new( self.prop_get('cell-area', $gv) );

        return Nil unless $gv.object;

        my $ca = cast(GtkCellArea, $gv.object);
        $raw ?? $ca !! GTK::CellArea.new($ca);
      },
      STORE => -> $, GtkCellArea() $val is copy {
        $gv.object = $val;
        self.prop_set('cell-area', $gv)
      }
    );
  }

  # Type: gint
  method width is rw {
    my GLib::Value $gv .= new( G_TYPE_INT );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new( self.prop_get('width', $gv) );
        $gv.int;
      },
      STORE => -> $, Int() $val is copy {
        warn 'width does not allow writing';
      }
    );
  }

  # Type: gint
  method x-offset is rw is also<x_offset> {
    my GLib::Value $gv .= new( G_TYPE_INT );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new( self.prop_get('x-offset', $gv) );
        $gv.int;
      },
      STORE => -> $, $val is copy {
        warn 'x-offset does not allow writing'
      }
    );
  }

  # ↑↑↑↑ PROPERTIES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  method add_attribute (
    GtkCellRenderer() $cell_renderer,
    Str() $attribute,
    Int() $column
  )
    is also<add-attribute>
  {
    my gint $c = $column;

    gtk_tree_view_column_add_attribute($!tvc, $cell_renderer, $attribute, $c);
  }

  method cell_get_position (
    GtkCellRenderer() $cell_renderer,
    Int() $x_offset,
    Int() $width
  )
    is also<cell-get-position>
  {
    my gint ($xo, $w) = ($x_offset, $width);

    gtk_tree_view_column_cell_get_position($!tvc, $cell_renderer, $xo, $w);
  }

  method cell_get_size (
    GdkRectangle() $cell_area,
    Int() $x_offset,
    Int() $y_offset,
    Int() $width,
    Int() $height
  )
    is also<cell-get-size>
  {
    my gint ($xo, $yo, $w, $h) = ($x_offset, $y_offset, $width, $height);

    gtk_tree_view_column_cell_get_size($!tvc, $cell_area, $xo, $yo, $w, $h);
  }

  method cell_is_visible is also<cell-is-visible> {
    so gtk_tree_view_column_cell_is_visible($!tvc);
  }

  method cell_set_cell_data (
    GtkTreeModel() $tree_model,
    GtkTreeIter() $iter,
    Int() $is_expander = 0,
    Int() $is_expanded = 0
  )
    is also<cell-set-cell-data>
  {
    my ($er, $ed) = ($is_expander, $is_expanded);

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

  method clear_attributes (GtkCellRenderer() $cell_renderer)
    is also<clear-attributes>
  {
    gtk_tree_view_column_clear_attributes($!tvc, $cell_renderer);
  }

  method emit-clicked is also<emit_clicked> {
    gtk_tree_view_column_clicked($!tvc);
  }

  method focus_cell (GtkCellRenderer() $cell) is also<focus-cell> {
    gtk_tree_view_column_focus_cell($!tvc, $cell);
  }

  method get_button (:$raw = False, :$widget = False) is also<get-button> {
    my $w = gtk_tree_view_column_get_button($!tvc);

    ReturnWidget($w, $raw, $widget);
  }

  method get_tree_view (:$raw = False) is also<get-tree-view> {
    my $tv = gtk_tree_view_column_get_tree_view($!tvc);

    $tv ??
      ( $raw ?? $tv !! ::('GTK::TreeView').new($tv) )
      !!
      Nil;
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gtk_tree_view_column_get_type, $n, $t );
  }

  method get_width is also<get-width> {
    gtk_tree_view_column_get_width($!tvc);
  }

  method get_x_offset is also<get-x-offset> {
    gtk_tree_view_column_get_x_offset($!tvc);
  }

  method pack_end (GtkCellRenderer() $cell, Int() $expand = 0)
    is also<pack-end>
  {
    my gboolean $e = $expand.so.Int;

    gtk_tree_view_column_pack_end($!tvc, $cell, $e);
  }

  method pack_start (GtkCellRenderer() $cell, Int() $expand = 0)
    is also<pack-start>
  {
    my gboolean $e = $expand.so.Int;

    gtk_tree_view_column_pack_start($!tvc, $cell, $e);
  }

  method queue_resize is also<queue-resize> {
    gtk_tree_view_column_queue_resize($!tvc);
  }

  method set_cell_data_func (
    GtkCellRenderer() $cell_renderer,
    &func,
    gpointer $func_data     = gpointer,
    GDestroyNotify $destroy = GDestroyNotify
  )
    is also<set-cell-data-func>
  {
    gtk_tree_view_column_set_cell_data_func(
      $!tvc,
      $cell_renderer,
      &func,
      $func_data,
      $destroy
    );
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
