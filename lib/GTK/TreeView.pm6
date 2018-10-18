use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::TreeView;
use GTK::Raw::Types;

use GTK::Adjustment;
use GTK::Container;
use GTK::Entry;
use GTK::TreeIter;
use GTK::TreeSelection;
use GTK::TreeStore;
use GTK::TreeViewColumn;

use GTK::Roles::Scrollable;
use GTK::Roles::Signals::Generic;
use GTK::Roles::Signals::TreeView;

sub EXPORT {
  %(
    GTK::Compat::Types::EXPORT::DEFAULT::,
    GTK::Raw::Types::EXPORT::DEFAULT::,
    GTK::Adjustment::,
    GTK::Container::,
    GTK::Entry::,
    GTK::TreeIter::,
    GTK::TreeSelection::,
    GTK::TreeStore::,
    GTK::TreeViewColumn::,
  );
}

class GTK::TreeView is GTK::Container {
  also does GTK::Roles::Scrollable;
  also does GTK::Roles::Signals::Generic;
  also does GTK::Roles::Signals::TreeView;

  has GtkTreeView $!tv;

  method bless(*%attrinit) {
    my $o = self.CREATE.BUILDALL(Empty, %attrinit);
    $o.setType('GTK::TreeView');
    $o;
  }

  submethod BUILD(:$treeview) {
    my $to-parent;
    given $treeview {
      when GtkTreeView | GtkWidget {
        $!tv = do {
          when GtkWidget {
            $to-parent = $_;
            nativecast(GtkTreeView, $_);
          }
          when GtkTreeView {
            $to-parent = nativecast(GtkContainer, $_);
            $_;
          }
        }
        self.setContainer($to-parent);
      }
      when GTK::TreeView {
      }
      default {
      }
    }
    $!s = nativecast(GtkScrollable, $!tv);    # GTK::Roles::Scrollable
  }

  submethod DESTROY {
    self.disconnect-all($_) for %!signals-generic, %!signals-tv;
  }

  method new {
    my $treeview = gtk_tree_view_new();
    self.bless(:$treeview);
  }

  method new_with_model(GtkTreeModel() $model) {
    my $treeview = gtk_tree_view_new_with_model($model);
    self.bless(:$treeview);
  }

  # ↓↓↓↓ SIGNALS ↓↓↓↓

  # Is originally:
  # GtkTreeView, gpointer --> void
  method columns-changed {
    self.connect($!tv, 'columns-changed');
  }

  # Is originally:
  # GtkTreeView, gpointer --> void
  method cursor-changed {
    self.connect($!tv, 'cursor-changed');
  }

  # Is originally:
  # GtkTreeView, gboolean, gboolean, gboolean, gpointer --> gboolean
  method expand-collapse-cursor-row {
    self.connect-expand-collapse($!tv);
  }

  # Is originally:
  # GtkTreeView, GtkMovementStep, gint, gpointer --> gboolean
  method move-cursor {
    self.connect-move-cursor1($!tv, 'move-cursor');
  }

  # Is originally:
  # GtkTreeView, GtkTreePath, GtkTreeViewColumn, gpointer --> void
  method row-activated {
    self.connect($!tv, 'row-activated');
  }

  # Is originally:
  # GtkTreeView, GtkTreeIter, GtkTreePath, gpointer --> void
  method row-collapsed {
    self.connect-row($!tv, 'row-collapsed');
  }

  # Is originally:
  # GtkTreeView, GtkTreeIter, GtkTreePath, gpointer --> void
  method row-expanded {
    self.connect-row($!tv, 'row-expanded');
  }

  # Is originally:
  # GtkTreeView, gpointer --> gboolean
  method select-all {
    self.connect-rbool($!tv, 'select-all');
  }

  # Is originally:
  # GtkTreeView, gpointer --> gboolean
  method select-cursor-parent {
    self.connect-rbool($!tv, 'select-cursor-parent');
  }

  # Is originally:
  # GtkTreeView, gboolean, gpointer --> gboolean
  method select-cursor-row {
    self.connect-uint-rbool($!tv, 'select-cursor-row');
  }

  # Is originally:
  # GtkTreeView, gpointer --> gboolean
  method start-interactive-search {
    self.connect-rbool($!tv, 'start-interactive-search');
  }

  # Is originally:
  # GtkTreeView, GtkTreeIter, GtkTreePath, gpointer --> gboolean
  method test-collapse-row {
    self.connect-test-row($!tv, 'test-collapse-row');
  }

  # Is originally:
  # GtkTreeView, GtkTreeIter, GtkTreePath, gpointer --> gboolean
  method test-expand-row {
    self.connect-test-row($!tv, 'test-expand-row');
  }

  # Is originally:
  # GtkTreeView, gpointer --> gboolean
  method toggle-cursor-row {
    self.connect-rbool($!tv, 'toggle-cursor-row');
  }

  # Is originally:
  # GtkTreeView, gpointer --> gboolean
  method unselect-all {
    self.connect-rbool($!tv, 'unselect-all');
  }

  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓

  method activate_on_single_click is rw {
    Proxy.new(
      FETCH => sub ($) {
        so gtk_tree_view_get_activate_on_single_click($!tv);
      },
      STORE => sub ($, Int() $single is copy) {
        my guint $s = self.RESOLVE-BOOL($single);
        gtk_tree_view_set_activate_on_single_click($!tv, $s);
      }
    );
  }

  method enable_search is rw {
    Proxy.new(
      FETCH => sub ($) {
        so gtk_tree_view_get_enable_search($!tv);
      },
      STORE => sub ($, Int() $enable_search is copy) {
        my guint $es = self.RESOLVE-BOOL($enable_search);
        gtk_tree_view_set_enable_search($!tv, $es);
      }
    );
  }

  method enable_tree_lines is rw {
    Proxy.new(
      FETCH => sub ($) {
        so gtk_tree_view_get_enable_tree_lines($!tv);
      },
      STORE => sub ($, Int() $enabled is copy) {
        my guint $e = self.RESOLVE-BOOL($enabled);
        gtk_tree_view_set_enable_tree_lines($!tv, $e);
      }
    );
  }

  method expander_column is rw {
    Proxy.new(
      FETCH => sub ($) {
        GTK::TreeViewColumn.new( gtk_tree_view_get_expander_column($!tv) );
      },
      STORE => sub ($, GtkTreeViewColumn() $column is copy) {
        gtk_tree_view_set_expander_column($!tv, $column);
      }
    );
  }

  method fixed_height_mode is rw {
    Proxy.new(
      FETCH => sub ($) {
        so gtk_tree_view_get_fixed_height_mode($!tv);
      },
      STORE => sub ($, Int() $enable is copy) {
        my guint $e = self.RESOLVE-BOOL($enable);
        gtk_tree_view_set_fixed_height_mode($!tv, $e);
      }
    );
  }

  # Alias also to enable-grid-lines
  method grid_lines is rw {
    Proxy.new(
      FETCH => sub ($) {
        GtkTreeViewGridLines( gtk_tree_view_get_grid_lines($!tv) );
      },
      STORE => sub ($, Int() $grid_lines is copy) {
        my guint $gl = self.RESOLVE-UINT($grid_lines);
        gtk_tree_view_set_grid_lines($!tv, $gl);
      }
    );
  }

  method hadjustment is rw {
    Proxy.new(
      FETCH => sub ($) {
        GTK::Adjustment.new( gtk_tree_view_get_hadjustment($!tv) );
      },
      STORE => sub ($, GtkAdjustment() $adjustment is copy) {
        gtk_tree_view_set_hadjustment($!tv, $adjustment);
      }
    );
  }

  method headers_clickable is rw {
    Proxy.new(
      FETCH => sub ($) {
        so gtk_tree_view_get_headers_clickable($!tv);
      },
      STORE => sub ($, Int() $setting is copy) {
        my guint $s = self.RESOLVE-BOOL($setting);
        gtk_tree_view_set_headers_clickable($!tv, $s);
      }
    );
  }

  method headers_visible is rw {
    Proxy.new(
      FETCH => sub ($) {
        so gtk_tree_view_get_headers_visible($!tv);
      },
      STORE => sub ($, Int() $headers_visible is copy) {
        my guint $hv = self.RESOLVE-BOOL($headers_visible);
        gtk_tree_view_set_headers_visible($!tv, $hv);
      }
    );
  }

  method hover_expand is rw {
    Proxy.new(
      FETCH => sub ($) {
        so gtk_tree_view_get_hover_expand($!tv);
      },
      STORE => sub ($, Int() $expand is copy) {
        my guint $e = self.RESOLVE-BOOL($expand);
        gtk_tree_view_set_hover_expand($!tv, $e);
      }
    );
  }

  method hover_selection is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_tree_view_get_hover_selection($!tv);
      },
      STORE => sub ($, Int() $hover is copy) {
        my guint $h = self.RESOLVE-BOOL($hover);
        gtk_tree_view_set_hover_selection($!tv, $h);
      }
    );
  }

  method level_indentation is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_tree_view_get_level_indentation($!tv);
      },
      STORE => sub ($, Int() $indentation is copy) {
        my gint $i = self.RESOLVE-INT($indentation);
        gtk_tree_view_set_level_indentation($!tv, $i);
      }
    );
  }

  method model is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_tree_view_get_model($!tv);
      },
      STORE => sub ($, GtkTreeModel() $model is copy) {
        gtk_tree_view_set_model($!tv, $model);
      }
    );
  }

  method reorderable is rw {
    Proxy.new(
      FETCH => sub ($) {
        so gtk_tree_view_get_reorderable($!tv);
      },
      STORE => sub ($, Int() $reorderable is copy) {
        my guint $r = self.RESOLVE-BOOL($reorderable);
        gtk_tree_view_set_reorderable($!tv, $r);
      }
    );
  }

  method rubber_banding is rw {
    Proxy.new(
      FETCH => sub ($) {
        so gtk_tree_view_get_rubber_banding($!tv);
      },
      STORE => sub ($, Int() $enable is copy) {
        my guint $e = self.RESOLVE-BOOL($enable);
        gtk_tree_view_set_rubber_banding($!tv, $e);
      }
    );
  }

  method rules_hint is rw {
    Proxy.new(
      FETCH => sub ($) {
        so gtk_tree_view_get_rules_hint($!tv);
      },
      STORE => sub ($, Int() $setting is copy) {
        my guint $s = self.RESOLVE-BOOL($setting);
        gtk_tree_view_set_rules_hint($!tv, $s);
      }
    );
  }

  method search_column is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_tree_view_get_search_column($!tv);
      },
      STORE => sub ($, Int() $column is copy) {
        my gint $c = self.RESOLVE-INT($column);
        gtk_tree_view_set_search_column($!tv, $c);
      }
    );
  }

  method search_entry is rw {
    Proxy.new(
      FETCH => sub ($) {
        GTK::Entry.new( gtk_tree_view_get_search_entry($!tv) );
      },
      STORE => sub ($, GtkEntry() $entry is copy) {
        gtk_tree_view_set_search_entry($!tv, $entry);
      }
    );
  }

  method show_expanders is rw {
    Proxy.new(
      FETCH => sub ($) {
        so gtk_tree_view_get_show_expanders($!tv);
      },
      STORE => sub ($, Int() $enabled is copy) {
        my guint $e = self.RESOLVE-BOOL($enabled);
        gtk_tree_view_set_show_expanders($!tv, $e);
      }
    );
  }

  method tooltip_column is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_tree_view_get_tooltip_column($!tv);
      },
      STORE => sub ($, Int() $column is copy) {
        my gint $c = self.RESOLVE-INT($column);
        gtk_tree_view_set_tooltip_column($!tv, $c);
      }
    );
  }

  method vadjustment is rw {
    Proxy.new(
      FETCH => sub ($) {
        GTK::Adjustment.new( gtk_tree_view_get_vadjustment($!tv) );
      },
      STORE => sub ($, GtkAdjustment() $adjustment is copy) {
        gtk_tree_view_set_vadjustment($!tv, $adjustment);
      }
    );
  }

  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ PROPERTIES ↓↓↓↓
  # ↑↑↑↑ PROPERTIES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  method append_column (GtkTreeViewColumn() $column) {
    gtk_tree_view_append_column($!tv, $column);
  }

  method collapse_all {
    gtk_tree_view_collapse_all($!tv);
  }

  method collapse_row (GtkTreePath() $path) {
    gtk_tree_view_collapse_row($!tv, $path);
  }

  method columns_autosize {
    gtk_tree_view_columns_autosize($!tv);
  }

  multi method convert_bin_window_to_tree_coords (Int() $bx, Int() $by) {
    my gint ($bxx, $byy, $txx, $tyy) = ($bx, $by);
    samewith($bxx, $byy, $txx, $tyy);
    ($txx, $tyy);
  }
  multi method convert_bin_window_to_tree_coords (
    Int() $bx,
    Int() $by,
    Int $tx is rw,
    Int $ty is rw
  ) {
    my @i = ($bx, $by);
    my gint ($bxx, $byy) = self.RESOLVE-INT(@i);
    gtk_tree_view_convert_bin_window_to_tree_coords(
      $!tv,
      $bxx,
      $byy,
      $tx,
      $ty
    );
  }

  multi method convert_bin_window_to_widget_coords (Int() $bx, Int() $by) {
    my gint ($bxx, $byy, $wxx, $wyy) = ($bx, $by);
    samewith($bxx, $byy, $wxx, $wyy);
    ($wxx, $wyy);
  }
  multi method convert_bin_window_to_widget_coords (
    Int() $bx,
    Int() $by,
    Int $wx is rw,
    Int $wy is rw
  ) {
    my @i = ($bx, $by);
    my gint ($bxx, $byy) = self.RESOLVE-INT(@i);
    gtk_tree_view_convert_bin_window_to_widget_coords(
      $!tv,
      $bxx,
      $byy,
      $wx,
      $wy
    );
  }

  multi method convert_tree_to_bin_window_coords (Int() $tx, Int() $ty) {
    my @i = ($tx, $ty);
    my gint ($txx, $tyy, $bxx, $byy) = self.RESOLVE-INT(@i);
    samewith($txx, $tyy, $bxx, $byy);
    ($bxx, $byy);
  }
  multi method convert_tree_to_bin_window_coords (
    Int() $tx,
    Int() $ty,
    Int $bx is rw,
    Int $by is rw
  ) {
    my @i = ($tx, $ty);
    my gint ($txx, $tyy) =  self.RESOLVE-INT(@i);
    gtk_tree_view_convert_tree_to_bin_window_coords($!tv, $tx, $ty, $bx, $by);
  }

  multi method convert_widget_to_bin_window_coords ( Int() $wx, Int() $wy ) {
    my gint ($wxx, $wyy, $bxx, $byy) = ($wx, $wy);
    samewith($wxx, $wyy, $bxx, $byy);
    ($bxx, $byy);
  }
  multi method convert_widget_to_bin_window_coords (
    Int() $wx,
    Int() $wy,
    Int $bx is rw,
    Int $by is rw
  ) {
    my @i = ($wx, $wy);
    my gint ($wxx, $wyy) =  self.RESOLVE-INT(@i);
    gtk_tree_view_convert_widget_to_bin_window_coords(
      $!tv,
      $wxx,
      $wyy,
      $bx,
      $by
    );
  }

  multi method convert_widget_to_tree_coords (
    Int() $wx,
    Int() $wy
  ) {
    my gint ($wxx, $wyy, $txx, $tyy) = ($wx, $wy);
    samewith($wxx, $wyy, $txx, $tyy);
    ($txx, $tyy);
  }
  multi method convert_widget_to_tree_coords (
    Int() $wx,
    Int() $wy,
    Int $tx is rw,
    Int $ty is rw
  ) {
    my @i = ($wx, $wy);
    my ($wxx, $wyy) = self.RESOLVE-INT(@i);
    gtk_tree_view_convert_widget_to_tree_coords($!tv, $wxx, $wyy, $tx, $ty);
  }

  method create_row_drag_icon (GtkTreePath() $path) {
    gtk_tree_view_create_row_drag_icon($!tv, $path);
  }

  method enable_model_drag_dest (
    GtkTargetEntry() $targets,
    Int() $n_targets,
    uint32 $actions             # GdkDragAction $actions
  ) {
    my gint $nt = self.RESOLVE-INT($n_targets);
    my guint $a = self.RESOLVE-UINT($actions);
    gtk_tree_view_enable_model_drag_dest($!tv, $targets, $nt, $a);
  }

  method enable_model_drag_source (
    uint64 $start_button_mask,  # GdkModifierType $start_button_mask,
    GtkTargetEntry() $targets,
    gint $n_targets,
    uint32 $actions             # GdkDragAction $actions
  ) {
    my uint64 $sbm = self.RESOLVE-ULONG($start_button_mask);
    my gint $nt = self.RESOLVE-INT($n_targets);
    my guint $a = self.RESOLVE-UINT($actions);
    gtk_tree_view_enable_model_drag_source($!tv, $sbm, $targets, $nt, $a);
  }

  method expand_all {
    gtk_tree_view_expand_all($!tv);
  }

  method expand_row (GtkTreePath() $path, Int() $open_all) {
    my gboolean $o = self.RESOLVE-BOOL($open_all);
    gtk_tree_view_expand_row($!tv, $path, $o);
  }

  method expand_to_path (GtkTreePath() $path) {
    gtk_tree_view_expand_to_path($!tv, $path);
  }

  method get_background_area (
    GtkTreePath() $path,
    GtkTreeViewColumn() $column,
    GdkRectangle() $rect
  ) {
    gtk_tree_view_get_background_area($!tv, $path, $column, $rect);
  }

  method get_bin_window {
    gtk_tree_view_get_bin_window($!tv);
  }

  method get_cell_area (
    GtkTreePath() $path,
    GtkTreeViewColumn() $column,
    GdkRectangle() $rect
  ) {
    gtk_tree_view_get_cell_area($!tv, $path, $column, $rect);
  }

  method get_column (Int() $n) {
    my gint $nn = self.RESOLVE-INT($n);
    gtk_tree_view_get_column($!tv, $nn);
  }

  method get_columns {
    gtk_tree_view_get_columns($!tv);
  }

  method get_cursor (
    GtkTreePath() $path,
    GtkTreeViewColumn() $focus_column
  ) {
    gtk_tree_view_get_cursor($!tv, $path, $focus_column);
  }

  method get_dest_row_at_pos (
    Int() $drag_x,
    Int() $drag_y,
    GtkTreePath() $path,
    uint32 $pos                 # GtkTreeViewDropPosition $pos
  ) {
    my @i = ($drag_x, $drag_y);
    my gint ($dx, $dy) = self.RESOLVE-INT(@i);
    my guint $p = self.RESOLVE-UINT($pos);
    gtk_tree_view_get_dest_row_at_pos($!tv, $dx, $dy, $path, $p);
  }

  method get_drag_dest_row (
    GtkTreePath() $path,
    uint32 $pos                 # GtkTreeViewDropPosition $pos
  ) {
    my guint $p = self.RESOLVE-UINT($pos);
    gtk_tree_view_get_drag_dest_row($!tv, $path, $p);
  }

  method get_n_columns {
    gtk_tree_view_get_n_columns($!tv);
  }

  method get_path_at_pos (
    Int() $x,
    Int() $y,
    GtkTreePath() $path,
    GtkTreeViewColumn() $column,
    Int() $cell_x,
    Int() $cell_y
  ) {
    my @i = ($x, $y, $cell_x, $cell_y);
    my gint ($xx, $yy, $cx, $cy) = self.RESOLVE-INT(@i);
    gtk_tree_view_get_path_at_pos($!tv, $xx, $yy, $path, $column, $cx, $cy);
  }

  method get_row_separator_func {
    gtk_tree_view_get_row_separator_func($!tv);
  }

  method get_search_equal_func {
    gtk_tree_view_get_search_equal_func($!tv);
  }

  method get_search_position_func {
    gtk_tree_view_get_search_position_func($!tv);
  }

  method get_selection {
    GTK::TreeSelection.new( gtk_tree_view_get_selection($!tv) );
  }

  method get_tooltip_context (
    Int() $x,
    Int() $y,
    Int() $keyboard_tip,
    GtkTreeModel() $model,
    GtkTreePath() $path,
    GtkTreeIter() $iter
  ) {
    my @i = ($x, $y);
    my gint ($xx, $yy) = self.RESOLVE-INT(@i);
    my gboolean $kt = self.RESOLVE-BOOL($keyboard_tip);
    gtk_tree_view_get_tooltip_context(
      $!tv,
      $xx,
      $yy,
      $kt,
      $model,
      $path,
      $iter
    );
  }

  method get_type {
    gtk_tree_view_get_type();
  }

  method get_visible_range (
    GtkTreePath() $start_path,
    GtkTreePath() $end_path
  ) {
    gtk_tree_view_get_visible_range($!tv, $start_path, $end_path);
  }

  method get_visible_rect (GdkRectangle() $visible_rect) {
    gtk_tree_view_get_visible_rect($!tv, $visible_rect);
  }

  method insert_column (GtkTreeViewColumn() $column, Int() $position) {
    my guint $p = self.RESOLVE-UINT($position);
    gtk_tree_view_insert_column($!tv, $column, $p);
  }

  method insert_column_with_data_func (
    Int() $position,
    Str() $title,
    GtkCellRenderer() $cell,
    GtkTreeCellDataFunc $func,
    gpointer $data = gpointer,
    GDestroyNotify $dnotify = GDestroyNotify
  ) {
    my guint $p = self.RESOLVE-UINT($position);
    gtk_tree_view_insert_column_with_data_func(
      $!tv,
      $p,
      $title,
      $cell,
      $func,
      $data,
      $dnotify
    );
  }

  method is_blank_at_pos (
    Int() $x,
    Int() $y,
    GtkTreePath() $path,
    GtkTreeViewColumn() $column,
    Int() $cell_x,
    Int() $cell_y
  ) {
    my @i = ($x, $y, $cell_x, $cell_y);
    my gint ($xx, $yy, $cx, $cy) = self.RESOLVE-INT(@i);
    gtk_tree_view_is_blank_at_pos($!tv, $xx, $yy, $path, $column, $cx, $cy);
  }

  method is_rubber_banding_active {
    gtk_tree_view_is_rubber_banding_active($!tv);
  }

  method map_expanded_rows (GtkTreeViewMappingFunc $func, gpointer $data) {
    gtk_tree_view_map_expanded_rows($!tv, $func, $data);
  }

  method move_column_after (
    GtkTreeViewColumn() $column,
    GtkTreeViewColumn() $base_column
  ) {
    gtk_tree_view_move_column_after($!tv, $column, $base_column);
  }

  method remove_column (GtkTreeViewColumn() $column) {
    gtk_tree_view_remove_column($!tv, $column);
  }

  method row_activated (GtkTreePath() $path, GtkTreeViewColumn() $column) {
    gtk_tree_view_row_activated($!tv, $path, $column);
  }

  method row_expanded (GtkTreePath() $path) {
    gtk_tree_view_row_expanded($!tv, $path);
  }

  method scroll_to_cell (
    GtkTreePath() $path,
    GtkTreeViewColumn() $column,
    Int() $use_align,
    Num() $row_align,
    Num() $col_align
  ) {
    my gboolean $ua = self.RESOLVE-BOOL($use_align);
    my gfloat ($ra, $ca) = ($row_align, $col_align);
    gtk_tree_view_scroll_to_cell($!tv, $path, $column, $ua, $ra, $ca);
  }

  method scroll_to_point (gint $tree_x, gint $tree_y) {
    my @i = ($tree_x, $tree_y);
    my gint ($tx, $ty) = self.RESOLVE-INT(@i);
    gtk_tree_view_scroll_to_point($!tv, $tx, $ty);
  }

  method set_column_drag_function (
    GtkTreeViewColumnDropFunc $func,
    gpointer $user_data,
    GDestroyNotify $destroy
  ) {
    gtk_tree_view_set_column_drag_function($!tv, $func, $user_data, $destroy);
  }

  method set_cursor (
    GtkTreePath() $path,
    GtkTreeViewColumn() $focus_column,
    Int() $start_editing
  ) {
    my gboolean $se = self.RESOLVE-BOOL($start_editing);
    gtk_tree_view_set_cursor($!tv, $path, $focus_column, $se);
  }

  method set_cursor_on_cell (
    GtkTreePath $path,
    GtkTreeViewColumn $focus_column,
    GtkCellRenderer $focus_cell,
    gboolean $start_editing
  ) {
    my gboolean $se = self.RESOLVE-BOOL($start_editing);
    gtk_tree_view_set_cursor_on_cell(
      $!tv,
      $path,
      $focus_column,
      $focus_cell,
      $se
    );
  }

  method set_destroy_count_func (
    GtkTreeDestroyCountFunc $func,
    gpointer $data,
    GDestroyNotify $destroy
  ) {
    gtk_tree_view_set_destroy_count_func($!tv, $func, $data, $destroy);
  }

  method set_drag_dest_row (
    GtkTreePath $path,
    uint32 $pos                 # GtkTreeViewDropPosition $pos
  ) {
    my guint $p = self.RESOLVE-UINT($pos);
    gtk_tree_view_set_drag_dest_row($!tv, $path, $p);
  }

  method set_row_separator_func (
    GtkTreeViewRowSeparatorFunc $func,
    gpointer $data,
    GDestroyNotify $destroy
  ) {
    gtk_tree_view_set_row_separator_func($!tv, $func, $data, $destroy);
  }

  method set_search_equal_func (
    GtkTreeViewSearchEqualFunc $search_equal_func,
    gpointer $search_user_data,
    GDestroyNotify $search_destroy
  ) {
    gtk_tree_view_set_search_equal_func(
      $!tv,
      $search_equal_func,
      $search_user_data,
      $search_destroy
    );
  }

  method set_search_position_func (
    GtkTreeViewSearchPositionFunc $func,
    gpointer $data,
    GDestroyNotify $destroy
  ) {
    gtk_tree_view_set_search_position_func($!tv, $func, $data, $destroy);
  }

  method set_tooltip_cell (
    GtkTooltip() $tooltip,
    GtkTreePath() $path,
    GtkTreeViewColumn() $column,
    GtkCellRenderer() $cell
  ) {
    gtk_tree_view_set_tooltip_cell($!tv, $tooltip, $path, $column, $cell);
  }

  method set_tooltip_row (GtkTooltip() $tooltip, GtkTreePath() $path) {
    gtk_tree_view_set_tooltip_row($!tv, $tooltip, $path);
  }

  method unset_rows_drag_dest {
    gtk_tree_view_unset_rows_drag_dest($!tv);
  }

  method unset_rows_drag_source {
    gtk_tree_view_unset_rows_drag_source($!tv);
  }

  # ↑↑↑↑ METHODS ↑↑↑↑

}
