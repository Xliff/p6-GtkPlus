use v6.c;

use Method::Also;
use NativeCall;

use GTK::Raw::TreeView;
use GTK::Raw::Types;

use GTK::Adjustment;
use GTK::Container;
use GTK::Entry;
use GTK::TreeIter;
use GTK::TreePath;
use GTK::TreeSelection;
use GTK::TreeStore;
use GTK::TreeViewColumn;

use GTK::Roles::Scrollable;
use GTK::Roles::Signals::TreeView;

our subset TreeViewAncestry is export
  where GtkTreeView | GtkScrollable | ContainerAncestry;

# Are we still doing this, or not. I think it might be better to just do
# "use GTK".
sub EXPORT {
  %(
    GTK::Adjustment::,
    GTK::Container::,
    GTK::Entry::,
    GTK::TreeIter::,
    GTK::TreeSelection::,
    GTK::TreeStore::,
    GTK::TreeViewColumn::,
  );
}

# REFINEMENTS MUST BE COMPLETED. -- THIS MODULE NEEDS TO BE RE-REVIEWED!

class GTK::TreeView is GTK::Container {
  also does GTK::Roles::Scrollable;
  also does GTK::Roles::Signals::TreeView;

  has GtkTreeView $!tv is implementor;

  method bless(*%attrinit) {
    my $o = self.CREATE.BUILDALL(Empty, %attrinit);
    $o.setType($o.^name);
    $o;
  }

  submethod BUILD(:$treeview) {
    my $to-parent;
    given $treeview {
      when TreeViewAncestry {
        $!tv = do {
          when GtkTreeView {
            $to-parent = cast(GtkContainer, $_);
            $_;
          }
          when GtkScrollable {
            $!s = $_;                               # GTK::Roles::Scrollable
            $to-parent = cast(GtkContainer, $_);
            cast(GtkTreeView, $_);
          }
          default {
            $to-parent = $_;
            cast(GtkTreeView, $_);
          }
        }
        $!s //= cast(GtkScrollable, $!tv);    # GTK::Roles::Scrollable
        self.setContainer($to-parent);
      }
      when GTK::TreeView {
      }
      default {
      }
    }
  }

  submethod DESTROY {
    self.disconnect-all($_) for %!signals-tv;
  }

  method GTK::Raw::Definitions::GtkTreeView
    is also<
      GtkTreeView
      TreeView
    >
  { $!tv }

  multi method new (TreeViewAncestry $treeview, :$ref = True) {
    return Nil unless $treeview;

    my $o = self.bless(:$treeview);
    $o.ref if $ref;
    $o;
  }
  multi method new {
    my $treeview = gtk_tree_view_new();

    $treeview ?? self.bless(:$treeview) !! Nil;
  }

  method new_with_model(GtkTreeModel() $model) is also<new-with-model> {
    my $treeview = gtk_tree_view_new_with_model($model);

    $treeview ?? self.bless(:$treeview) !! Nil;
  }

  # ↓↓↓↓ SIGNALS ↓↓↓↓

  # Is originally:
  # GtkTreeView, gpointer --> void
  method columns-changed is also<columns_changed> {
    self.connect($!tv, 'columns-changed');
  }

  # Is originally:
  # GtkTreeView, gpointer --> void
  method cursor-changed is also<cursor_changed> {
    self.connect($!tv, 'cursor-changed');
  }

  # Is originally:
  # GtkTreeView, gboolean, gboolean, gboolean, gpointer --> gboolean
  method expand-collapse-cursor-row is also<expand_collapse_cursor_row> {
    self.connect-expand-collapse($!tv);
  }

  # Is originally:
  # GtkTreeView, GtkMovementStep, gint, gpointer --> gboolean
  method move-cursor is also<move_cursor> {
    self.connect-move-cursor1($!tv, 'move-cursor');
  }

  # Is originally:
  # GtkTreeView, GtkTreePath, GtkTreeViewColumn, gpointer --> void
  method row-activated is also<row_activated> {
    self.connect($!tv, 'row-activated');
  }

  # Is originally:
  # GtkTreeView, GtkTreeIter, GtkTreePath, gpointer --> void
  method row-collapsed is also<row_collapsed> {
    self.connect-row($!tv, 'row-collapsed');
  }

  # Is originally:
  # GtkTreeView, GtkTreeIter, GtkTreePath, gpointer --> void
  method row-expanded is also<row_expanded> {
    self.connect-row($!tv, 'row-expanded');
  }

  # Is originally:
  # GtkTreeView, gpointer --> gboolean
  method select-all is also<select_all> {
    self.connect-rbool($!tv, 'select-all');
  }

  # Is originally:
  # GtkTreeView, gpointer --> gboolean
  method select-cursor-parent is also<select_cursor_parent> {
    self.connect-rbool($!tv, 'select-cursor-parent');
  }

  # Is originally:
  # GtkTreeView, gboolean, gpointer --> gboolean
  method select-cursor-row is also<select_cursor_row> {
    self.connect-uint-ruint($!tv, 'select-cursor-row');
  }

  # Is originally:
  # GtkTreeView, gpointer --> gboolean
  method start-interactive-search is also<start_interactive_search> {
    self.connect-rbool($!tv, 'start-interactive-search');
  }

  # Is originally:
  # GtkTreeView, GtkTreeIter, GtkTreePath, gpointer --> gboolean
  method test-collapse-row is also<test_collapse_row> {
    self.connect-test-row($!tv, 'test-collapse-row');
  }

  # Is originally:
  # GtkTreeView, GtkTreeIter, GtkTreePath, gpointer --> gboolean
  method test-expand-row is also<test_expand_row> {
    self.connect-test-row($!tv, 'test-expand-row');
  }

  # Is originally:
  # GtkTreeView, gpointer --> gboolean
  method toggle-cursor-row is also<toggle_cursor_row> {
    self.connect-rbool($!tv, 'toggle-cursor-row');
  }

  # Is originally:
  # GtkTreeView, gpointer --> gboolean
  method unselect-all is also<unselect_all> {
    self.connect-rbool($!tv, 'unselect-all');
  }

  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓

  method activate_on_single_click is rw is also<activate-on-single-click> {
    Proxy.new(
      FETCH => sub ($) {
        so gtk_tree_view_get_activate_on_single_click($!tv);
      },
      STORE => sub ($, Int() $single is copy) {
        my gboolean $s = $single.so.Int;

        gtk_tree_view_set_activate_on_single_click($!tv, $s);
      }
    );
  }

  method enable_search is rw is also<enable-search> {
    Proxy.new(
      FETCH => sub ($) {
        so gtk_tree_view_get_enable_search($!tv);
      },
      STORE => sub ($, Int() $enable_search is copy) {
        my gboolean $es = $enable_search.so.Int;

        gtk_tree_view_set_enable_search($!tv, $es);
      }
    );
  }

  method enable_tree_lines is rw is also<enable-tree-lines> {
    Proxy.new(
      FETCH => sub ($) {
        so gtk_tree_view_get_enable_tree_lines($!tv);
      },
      STORE => sub ($, Int() $enabled is copy) {
        my gboolean $e = $enabled.so.Int;

        gtk_tree_view_set_enable_tree_lines($!tv, $e);
      }
    );
  }

  method expander_column (:$raw = False) is rw is also<expander-column> {
    Proxy.new(
      FETCH => sub ($) {
        my $tvc = gtk_tree_view_get_expander_column($!tv);

        $tvc ??
          ( $raw ?? $tvc !! GTK::TreeViewColumn.new($tvc) )
          !!
          Nil;
      },
      STORE => sub ($, GtkTreeViewColumn() $column is copy) {
        gtk_tree_view_set_expander_column($!tv, $column);
      }
    );
  }

  method fixed_height_mode is rw is also<fixed-height-mode> {
    Proxy.new(
      FETCH => sub ($) {
        so gtk_tree_view_get_fixed_height_mode($!tv);
      },
      STORE => sub ($, Int() $enable is copy) {
        my gboolean $e = $enable.so.Int;

        gtk_tree_view_set_fixed_height_mode($!tv, $e);
      }
    );
  }

  # Alias also to enable-grid-lines
  method grid_lines is rw is also<grid-lines> {
    Proxy.new(
      FETCH => sub ($) {
        GtkTreeViewGridLinesEnum( gtk_tree_view_get_grid_lines($!tv) );
      },
      STORE => sub ($, Int() $grid_lines is copy) {
        my guint $gl = $grid_lines;

        gtk_tree_view_set_grid_lines($!tv, $gl);
      }
    );
  }

  method hadjustment (:$raw = False) is rw {
    Proxy.new(
      FETCH => sub ($) {
        my $a = gtk_tree_view_get_hadjustment($!tv);

        $a ??
          ( $raw ?? $a !! GTK::Adjustment.new($a) )
          !!
          Nil;
      },
      STORE => sub ($, GtkAdjustment() $adjustment is copy) {
        gtk_tree_view_set_hadjustment($!tv, $adjustment);
      }
    );
  }

  method headers_clickable is rw is also<headers-clickable> {
    Proxy.new(
      FETCH => sub ($) {
        so gtk_tree_view_get_headers_clickable($!tv);
      },
      STORE => sub ($, Int() $setting is copy) {
        my gboolean $s = $setting.so.Int;

        gtk_tree_view_set_headers_clickable($!tv, $s);
      }
    );
  }

  method headers_visible is rw is also<headers-visible> {
    Proxy.new(
      FETCH => sub ($) {
        so gtk_tree_view_get_headers_visible($!tv);
      },
      STORE => sub ($, Int() $headers_visible is copy) {
        my gboolean $hv = $headers_visible.so.Int;

        gtk_tree_view_set_headers_visible($!tv, $hv);
      }
    );
  }

  method hover_expand is rw is also<hover-expand> {
    Proxy.new(
      FETCH => sub ($) {
        so gtk_tree_view_get_hover_expand($!tv);
      },
      STORE => sub ($, Int() $expand is copy) {
        my gboolean $e = $expand.so.Int;

        gtk_tree_view_set_hover_expand($!tv, $e);
      }
    );
  }

  method hover_selection is rw is also<hover-selection> {
    Proxy.new(
      FETCH => sub ($) {
        so gtk_tree_view_get_hover_selection($!tv);
      },
      STORE => sub ($, Int() $hover is copy) {
        my gboolean $h = $hover.so.Int;

        gtk_tree_view_set_hover_selection($!tv, $h);
      }
    );
  }

  method level_indentation is rw is also<level-indentation> {
    Proxy.new(
      FETCH => sub ($) {
        gtk_tree_view_get_level_indentation($!tv);
      },
      STORE => sub ($, Int() $indentation is copy) {
        my gint $i = $indentation;

        gtk_tree_view_set_level_indentation($!tv, $i);
      }
    );
  }

  method model (:$raw = False) is rw {
    Proxy.new(
      FETCH => sub ($) {
        my $tm = gtk_tree_view_get_model($!tv);

        $tm ??
          ( $raw ?? $tm !! GTK::Roles::TreeModel.new-treemodel-obj($tm) )
          !!
          Nil;
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
        my gboolean $r = $reorderable.so.Int;

        gtk_tree_view_set_reorderable($!tv, $r);
      }
    );
  }

  method rubber_banding is rw is also<rubber-banding> {
    Proxy.new(
      FETCH => sub ($) {
        so gtk_tree_view_get_rubber_banding($!tv);
      },
      STORE => sub ($, Int() $enable is copy) {
        my gboolean $e = $enable.so.Int;

        gtk_tree_view_set_rubber_banding($!tv, $e);
      }
    );
  }

  method search_column is rw is also<search-column> {
    Proxy.new(
      FETCH => sub ($) {
        gtk_tree_view_get_search_column($!tv);
      },
      STORE => sub ($, Int() $column is copy) {
        my gint $c = $column;

        gtk_tree_view_set_search_column($!tv, $c);
      }
    );
  }

  method search_entry (:$raw = False) is rw is also<search-entry> {
    Proxy.new(
      FETCH => sub ($) {
        my $e = gtk_tree_view_get_search_entry($!tv);

        $e ??
          ( $raw ?? $e !! GTK::Entry.new($e) )
          !!
          Nil;
      },
      STORE => sub ($, GtkEntry() $entry is copy) {
        gtk_tree_view_set_search_entry($!tv, $entry);
      }
    );
  }

  method show_expanders is rw is also<show-expanders> {
    Proxy.new(
      FETCH => sub ($) {
        so gtk_tree_view_get_show_expanders($!tv);
      },
      STORE => sub ($, Int() $enabled is copy) {
        my gboolean $e = $enabled.so.Int;

        gtk_tree_view_set_show_expanders($!tv, $e);
      }
    );
  }

  method tooltip_column is rw is also<tooltip-column> {
    Proxy.new(
      FETCH => sub ($) {
        gtk_tree_view_get_tooltip_column($!tv);
      },
      STORE => sub ($, Int() $column is copy) {
        my gint $c = $column;

        gtk_tree_view_set_tooltip_column($!tv, $c);
      }
    );
  }

  method vadjustment (:$raw = False) is rw {
    Proxy.new(
      FETCH => sub ($) {
        my $a = gtk_tree_view_get_vadjustment($!tv);

        $a ??
          ( $raw ?? $a !! GTK::Adjustment.new($a) )
          !!
          Nil;
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
  method append_column (GtkTreeViewColumn() $column)
    is also<append-column>
  {
    gtk_tree_view_append_column($!tv, $column);
  }

  method collapse_all is also<collapse-all> {
    gtk_tree_view_collapse_all($!tv);
  }

  method collapse_row (GtkTreePath() $path) is also<collapse-row> {
    gtk_tree_view_collapse_row($!tv, $path);
  }

  method columns_autosize is also<columns-autosize> {
    gtk_tree_view_columns_autosize($!tv);
  }

  proto method convert_bin_window_to_tree_coords (|)
    is also<convert-bin-window-to-tree-coords>
  { * }

  multi method convert_bin_window_to_tree_coords (Int() $bx, Int() $by) {
    samewith($bx, $by, $, $);
  }
  multi method convert_bin_window_to_tree_coords (
    Int() $bx,
    Int() $by,
    $tx is rw,
    $ty is rw
  ) {
    my gint ($bxx, $byy, $txx, $tyy) = ($bx, $by, 0, 0);
    gtk_tree_view_convert_bin_window_to_tree_coords(
      $!tv,
      $bxx,
      $byy,
      $txx,
      $tyy
    );
    ($tx, $ty) = ($txx, $tyy);
  }

  proto method convert_bin_window_to_widget_coords (|)
    is also<convert-bin-window-to-widget-coords>
  { * }

  multi method convert_bin_window_to_widget_coords (Int() $bx, Int() $by) {
    samewith($bx, $by, $, $);
  }
  multi method convert_bin_window_to_widget_coords (
    Int() $bx,
    Int() $by,
    $wx is rw,
    $wy is rw
  ) {
    my @i =
    my gint ($bxx, $byy, $wxx, $wyy) = ($bx, $by, 0, 0);
    gtk_tree_view_convert_bin_window_to_widget_coords(
      $!tv,
      $bxx,
      $byy,
      $wxx,
      $wyy
    );
    ($wx, $wy) = ($wxx, $wyy);
  }

  proto method convert_tree_to_bin_window_coords (|)
    is also<convert-tree-to-bin-window-coords>
  { * }
  multi method convert_tree_to_bin_window_coords (Int() $tx, Int() $ty) {
    samewith($tx, $ty, $, $);
  }
  multi method convert_tree_to_bin_window_coords (
    Int() $tx,
    Int() $ty,
    $bx is rw,
    $by is rw
  ) {
    my gint ($txx, $tyy, $bxx, $byy) =  ($tx, $ty, $bx, $by);
    gtk_tree_view_convert_tree_to_bin_window_coords(
      $!tv,
      $txx,
      $tyy,
      $bxx,
      $byy
    );
    ($bx, $by) = ($bxx, $byy);
  }

  proto method convert_widget_to_bin_window_coords (|)
    is also<convert-widget-to-bin-window-coords>
  { * }

  multi method convert_widget_to_bin_window_coords (
    Int() $wx,
    Int() $wy
  ) {
    samewith($wx, $wy, $, $);
  }
  multi method convert_widget_to_bin_window_coords (
    Int() $wx,
    Int() $wy,
    $bx is rw,
    $by is rw
  ) {
    my @i = ($wx, $wy);
    my gint ($wxx, $wyy) =  @i;
    gtk_tree_view_convert_widget_to_bin_window_coords(
      $!tv,
      $wxx,
      $wyy,
      $bx,
      $by
    );
  }

  proto method convert_widget_to_tree_coords (|)
    is also<convert-widget-to-tree-coords>
  { * }

  multi method convert_widget_to_tree_coords (
    Int() $wx,
    Int() $wy
  ) {
    samewith($wx, $wy, $, $);
  }
  multi method convert_widget_to_tree_coords (
    Int() $wx,
    Int() $wy,
    $ty is rw,
    $tx is rw
  ) {
    my ($wxx, $wyy, $txx, $tyy) = ($wx, $wy, 0, 0);
    gtk_tree_view_convert_widget_to_tree_coords(
      $!tv,
      $wxx,
      $wyy,
      $txx,
      $tyy
    );
    ($tx, $ty) = ($txx, $tyy);
  }

  method create_row_drag_icon (GtkTreePath() $path)
    is also<create-row-drag-icon>
  {
    gtk_tree_view_create_row_drag_icon($!tv, $path);
  }

  proto method enable_model_drag_dest (|)
    is also<enable-model-drag-dest>
  { * }

  multi method enable_model_drag_dest (
    @targets,
    Int() $actions             # GdkDragAction $actions
  ) {
    samewith(
      GLib::Roles::TypedBuffer[GdkDragAction].new(@targets).p,
      @targets.elems,
      $actions
    );
  }
  multi method enable_model_drag_dest (
    Pointer $targets,
    Int() $n_targets,
    Int $actions             # GdkDragAction $actions
  ) {
    my gint $nt = $n_targets;
    my guint $a = $actions;

    gtk_tree_view_enable_model_drag_dest($!tv, $targets, $nt, $a);
  }

  method enable_model_drag_source (
    uint64 $start_button_mask,  # GdkModifierType $start_button_mask,
    GtkTargetEntry() $targets,
    Int() $n_targets,
    Int() $actions             # GdkDragAction $actions
  )
    is also<enable-model-drag-source>
  {
    my uint64 $sbm = $start_button_mask;
    my gint $nt = $n_targets;
    my guint $a = $actions;

    gtk_tree_view_enable_model_drag_source($!tv, $sbm, $targets, $nt, $a);
  }

  method expand_all is also<expand-all> {
    gtk_tree_view_expand_all($!tv);
  }

  method expand_row (GtkTreePath() $path, Int() $open_all)
    is also<expand-row>
  {
    my gboolean $o = $open_all.so.Int;

    gtk_tree_view_expand_row($!tv, $path, $o);
  }

  method expand_to_path (GtkTreePath() $path) is also<expand-to-path> {
    gtk_tree_view_expand_to_path($!tv, $path);
  }

  method get_background_area (
    GtkTreePath() $path,
    GtkTreeViewColumn() $column,
    GdkRectangle() $rect
  )
    is also<get-background-area>
  {
    gtk_tree_view_get_background_area($!tv, $path, $column, $rect);
  }

  method get_bin_window is also<get-bin-window> {
    gtk_tree_view_get_bin_window($!tv);
  }

  method get_cell_area (
    GtkTreePath() $path,
    GtkTreeViewColumn() $column,
    GdkRectangle $rect
  )
    is also<get-cell-area>
  {
    gtk_tree_view_get_cell_area($!tv, $path, $column, $rect);
  }

  method get_column (Int() $n) is also<get-column> {
    my gint $nn = $n;

    gtk_tree_view_get_column($!tv, $nn);
  }

  method get_columns
    is also<
      get-columns
      columns
    >
  {
    gtk_tree_view_get_columns($!tv);
  }

  proto method get_cursor (|) is also<get-cursor> { * }

  multi method get_cursor {
    my $p = GtkTreePath;
    my $fc = GtkTreeViewColumn;
    my ($p1, $p2) = samewith($p, $fc);
    $p1 = GTK::TreePath.new($_) with $p1;
    $p2 = GTK::TreeViewColumn.new($_) with $p2;
    ($p1, $p2);
  }
  multi method get_cursor (
    $path         is rw,
    $focus_column is rw
  ) {
    # Better to use subsets?
    die '$path must be a GTK::TreePath or GtkTreePath'
      unless $path ~~ (GTK::TreePath, GtkTreePath).any;
    die '$focus_column must be GTK::TreeViewColumn or GtkTreeViewColumn'
      unless $focus_column ~~ (GTK::TreeViewColumn, GtkTreeViewColumn).any;

    $path         .= TreePath       if $path         ~~ GTK::TreePath;
    $focus_column .= TreeViewColumn if $focus_column ~~ GTK::TreeViewColumn;

    my $pc = CArray[Pointer[GtkTreePath]].new;
    my $fc = CArray[Pointer[GtkTreeViewColumn]].new;
    $pc[0] = $$path.defined ??
      cast(Pointer[GtkTreePath], $path) !!
      Pointer[GtkTreePath];
    $fc[0] = $focus_column.defined ??
      cast(Pointer[GtkTreeViewColumn], $focus_column) !!
      Pointer[GtkTreeViewColumn];
    my $rc = gtk_tree_view_get_cursor($!tv, $pc, $fc);

    my $rv;
    if $rc {
      # Returned list. Will always return objects.
      $rv = (
        $path = $pc[0].defined ??
          GTK::TreePath.new( cast(GtkTreePath, $pc[0]) )
          !!
          GtkTreePath,
        $focus_column = $fc[0].defined ??
          GTK::TreeViewColumn.new( cast(GtkTreeViewColumn, $fc[0]) )
          !!
          GtkTreeViewColumn
      );
    } else {
      ($path, $focus_column) = (GtkTreePath, GtkTreeViewColumn);
    }

    $rv;
  }

  method get_dest_row_at_pos (
    Int() $drag_x,
    Int() $drag_y,
    GtkTreePath() $path,
    Int() $pos                 # GtkTreeViewDropPosition $pos
  )
    is also<get-dest-row-at-pos>
  {
    my @i = ($drag_x, $drag_y);
    my gint ($dx, $dy) = @i;
    my guint $p = $pos;
    gtk_tree_view_get_dest_row_at_pos($!tv, $dx, $dy, $path, $p);
  }

  method get_drag_dest_row (
    $path is rw,
    Int() $pos                 # GtkTreeViewDropPosition $pos
  )
    is also<get-drag-dest-row>
  {
    die '$path must be a GTK::TreePath or GtkTreePath'
      unless $path ~~ (GTK::TreePath, GtkTreePath).any;
    $path .= TreePath if $path ~~ GTK::TreePath;

    my guint $p = $pos;
    my $cpath = CArray[Pointer[GtkTreePath]].new;
    $cpath[0] = cast(Pointer[GtkTreePath], $path);

    my ($rc, $rv) = ( gtk_tree_view_get_drag_dest_row($!tv, $cpath, $p) );
    if $rc {
      $rv = $path = $cpath[0].defined ??
        cast(GtkTreePath, $cpath[0]) !! GtkTreePath;
    } else {
      $path = GtkTreePath;
    }

    $rv;
  }

  method get_n_columns
    is also<
      get-n-columns
      n_columns
      n-columns
      elems
    >
  {
    gtk_tree_view_get_n_columns($!tv);
  }

  method get_path_at_pos (
    Int() $x,
    Int() $y,
    $path   is rw,
    $column is rw,
    Int() $cell_x,
    Int() $cell_y
  )
    is also<get-path-at-pos>
  {
    die '$path must be GTK::TreePath or GtkTreePath'
      unless $path ~~ (GTK::TreePath, GtkTreePath).any;
    die '$column must be GTK::TreeViewColumn or GtkTreeViewColumn'
      unless $column ~~ (GTK::TreeViewColumn, GtkTreeViewColumn);
    $path   .= TreePath       if $path   ~~ GTK::TreePath;
    $column .= TreeViewColumn if $column ~~ GTK::TreeViewColumn;

    my @i = ($x, $y, $cell_x, $cell_y);
    my gint ($xx, $yy, $cx, $cy) = @i;

    my $rv;
    my $cpath = CArray[Pointer[GtkTreePath]].new;
    my $ccol  = CArray[Pointer[GtkTreeViewColumn]].new;
    my $rc = gtk_tree_view_get_path_at_pos(
      $!tv,
      $xx,
      $yy,
      $cpath,
      $ccol,
      $cx,
      $cy
    );

    if $rc {
      $rv = (
        $path = $cpath[0].defined ??
          GTK::TreePath.new( cast(GtkTreePath, $cpath[0]) )
          !!
          GtkTreePath,
        $column = $ccol[0].defined ??
          GTK::TreeViewColumn.new( cast(GtkTreeViewColumn, $ccol[0]) )
          !!
          GtkTreeViewColumn
      );
    } else {
      ($path, $column) = (GtkTreePath, GtkTreeViewColumn);
    }

    $rv;
  }

  method get_row_separator_func is also<get-row-separator-func> {
    gtk_tree_view_get_row_separator_func($!tv);
  }

  method get_search_equal_func is also<get-search-equal-func> {
    gtk_tree_view_get_search_equal_func($!tv);
  }

  method get_search_position_func is also<get-search-position-func> {
    gtk_tree_view_get_search_position_func($!tv);
  }

  method get_selection (:$raw = False)
    is also<
      get-selection
      selection
    >
  {
    my $ts = gtk_tree_view_get_selection($!tv);

    $ts ??
      ( $raw ?? $ts !! GTK::TreeSelection.new($ts) )
      !!
      Nil;
  }

  method get_tooltip_context (
    Int $x is rw,
    Int $y is rw,
    Int() $keyboard_tip,
    $model is rw,
    $path  is rw,
    GtkTreeIter() $iter
  )
    is also<get-tooltip-context>
  {
    die '$model must be GTK::TreeModel or GtkTreeModel'
      unless $model ~~ (GTK::TreeModel, GtkTreeModel).any;
    die '$path must be GTK::TreePath or GtkTreePath'
      unless $path ~~ (GTK::TreePath, GtkTreePath).any;

    $model .= TreeModel if $model ~~ GTK::TreeModel;
    $path  .= TreePath  if $path  ~~ GTK::TreePath;

    my $rv;
    my $cmodel = CArray[Pointer[GtkTreeModel]].new;
    my $cpath  = CArray[Pointer[GtkTreePath]].new;
    my gint ($xx, $yy) = $x, $y;
    my gboolean $kt = $keyboard_tip.so.Int;

    my $rc = gtk_tree_view_get_tooltip_context(
      $!tv,
      $xx,
      $yy,
      $kt,
      $cmodel,
      $cpath,
      $iter
    );

    ($x, $y) = ($xx, $yy);
    if $rc {
      $rv = (
        $model = $cmodel[0].defined ??
          nativecast(GtkTreeModel, $cmodel[0]) !! GtkTreeModel,
        $path = $cpath[0].defined ??
          GTK::TreePath.new( nativecast(GtkTreePath, $cpath[0]) )
          !!
          GtkTreePath
      );
    } else {
      ($model, $path) = (GtkTreeModel, GtkTreePath);
    }

    $rv;
  }

  method get_type is also<get-type> {
    state ($n, $t);

    GTK::Widget.unstable_get_type( &gtk_tree_view_get_type, $n, $t );
  }

  method get_visible_range (
    GtkTreePath() $start_path,
    GtkTreePath() $end_path
  )
    is also<get-visible-range>
  {
    my $cstart = CArray[Pointer[GtkTreePath]].new;
    my $cend   = CArray[Pointer[GtkTreePath]].new;
    $cstart[0] = cast(Pointer[GtkTreePath], $start_path);
    $cend[0]   = cast(Pointer[GtkTreePath], $end_path);
    my $rc = gtk_tree_view_get_visible_range($!tv, $cstart, $cend);

    my $rv;
    if $rc {
      $rv = (
        $start_path = $cstart[0].defined ??
          cast(GtkTreePath, $cstart[0])
          !!
          GtkTreePath,
        $end_path = $cend[0].defined ??
          cast(GtkTreePath, $cend[0])
          !!
          GtkTreePath
      );
    }

    $rv;
  }

  method get_visible_rect (GdkRectangle $visible_rect)
    is also<get-visible-rect>
  {
    gtk_tree_view_get_visible_rect($!tv, $visible_rect);
  }

  method insert_column (GtkTreeViewColumn() $column, Int() $position)
    is also<insert-column>
  {
    my guint $p = $position;
    gtk_tree_view_insert_column($!tv, $column, $p);
  }

  method insert_column_with_attributes(
    Int()             $position,
    Str()             $title,
    GtkCellRenderer() $cell,
    Str()             $attr,
    Int()             $value
  ) {
    my gint  $p = $position;
    my guint $v = $value;

    gtk_tree_view_insert_column_with_attributes(
      $!tv,
      $p,
      $title,
      $cell,
      $attr,
      $v,
      Str
    );
  }

  method append_column_with_data_func (
    Str() $title,
    GtkCellRenderer() $cell,
    &func,
    gpointer $data          = gpointer,
    GDestroyNotify $dnotify = GDestroyNotify
  ) {
    self.insert_column_with_data_func(
      -1,
      $title,
      $cell,
      &func,
      $data,
      $dnotify
    );
  }

  method insert_column_with_data_func (
    Int() $position,
    Str() $title,
    GtkCellRenderer() $cell,
    &func,
    gpointer $data          = gpointer,
    GDestroyNotify $dnotify = GDestroyNotify
  )
    is also<insert-column-with-data-func>
  {
    my guint $p = $position;

    gtk_tree_view_insert_column_with_data_func(
      $!tv,
      $p,
      $title,
      $cell,
      &func,
      $data,
      $dnotify
    );
  }

  proto method is_blank_at_pos (|)
    is also<is-blank-at-pos>
  { * }

  multi method is_blank_at_pos (
    Int() $x,
    Int() $y
  ) {
    my @r = callwith($x, $y, $, $, $, $, :all);

    @r[0] ?? @r[1..*] !! Nil;
  }
  multi method is_blank_at_pos (
    Int() $x,
    Int() $y,
    $path   is rw,
    $column is rw,
    $cell_x is rw,
    $cell_y is rw,
    :$all = False
  ) {
    die '$path must be GTK::TreePath or GtkTreePath'
      unless $path ~~ (GTK::TreePath, GtkTreePath).any;
    die '$column must be GTK::TreeViewColumn or GtkTreeViewColumn'
      unless $column ~~ (GTK::TreeViewColumn, GtkTreeViewColumn);
    $path   .= TreePath       if $path   ~~ GTK::TreePath;
    $column .= TreeViewColumn if $column ~~ GTK::TreeViewColumn;

    my $rv;
    my @i = ($x, $y, $cell_x, $cell_y);
    my gint ($xx, $yy, $cx, $cy) = @i;
    my $cpath = CArray[Pointer[GtkTreePath]].new;
    my $ccol  = CArray[Pointer[GtkTreeViewColumn]].new;
    my $rc = gtk_tree_view_is_blank_at_pos(
      $!tv,
      $xx,
      $yy,
      $cpath,
      $ccol,
      $cx,
      $cy
    );

    ($cell_x, $cell_y) = ($cx, $cy);
    if $rc {
      $rv = (
        $path = $cpath[0].defined ??
          GTK::TreePath.new( cast(GtkTreePath, $cpath[0]) )
          !!
          GtkTreePath,
        $column = $ccol[0].defined ??
          GTK::TreeViewColumn.new( cast(GtkTreeViewColumn, $ccol[0]) )
          !!
          GtkTreeViewColumn
      );
    } else {
      ($path, $column) = (GtkTreePath, GtkTreeViewColumn);
    }

    $all.not ?? $rv !! ($rv, $path, $column, $cell_x, $cell_y);
  }

  method is_rubber_banding_active is also<is-rubber-banding-active> {
    gtk_tree_view_is_rubber_banding_active($!tv);
  }

  method map_expanded_rows (
    GtkTreeViewMappingFunc $func,
    gpointer $data = gpointer
  )
    is also<map-expanded-rows>
  {
    gtk_tree_view_map_expanded_rows($!tv, $func, $data);
  }

  method move_column_after (
    GtkTreeViewColumn() $column,
    GtkTreeViewColumn() $base_column
  )
    is also<move-column-after>
  {
    gtk_tree_view_move_column_after($!tv, $column, $base_column);
  }

  method remove_column (GtkTreeViewColumn() $column)
    is also<remove-column>
  {
    gtk_tree_view_remove_column($!tv, $column);
  }

  method emit_row_activated (
    GtkTreePath() $path,
    GtkTreeViewColumn() $column
  )
    is also<emit-row-activated>
  {
    gtk_tree_view_row_activated($!tv, $path, $column);
  }

  method is_row_expanded (GtkTreePath() $path) is also<is-row-expanded> {
    gtk_tree_view_row_expanded($!tv, $path);
  }

  method scroll_to_cell (
    GtkTreePath() $path,
    GtkTreeViewColumn() $column,
    Int() $use_align,
    Num() $row_align,
    Num() $col_align
  )
    is also<scroll-to-cell>
  {
    my gboolean $ua = $use_align.so.Int;
    my gfloat ($ra, $ca) = ($row_align, $col_align);

    gtk_tree_view_scroll_to_cell($!tv, $path, $column, $ua, $ra, $ca);
  }

  method scroll_to_point (Int() $tree_x, Int() $tree_y)
    is also<scroll-to-point>
  {
    my gint ($tx, $ty) = ($tree_x, $tree_y);

    gtk_tree_view_scroll_to_point($!tv, $tx, $ty);
  }

  method set_column_drag_function (
    GtkTreeViewColumnDropFunc $func,
    gpointer $user_data     = gpointer,
    GDestroyNotify $destroy = GDestroyNotify
  )
    is also<set-column-drag-function>
  {
    gtk_tree_view_set_column_drag_function($!tv, $func, $user_data, $destroy);
  }

  method set_cursor (
    GtkTreePath() $path,
    GtkTreeViewColumn() $focus_column,
    Int() $start_editing
  )
    is also<set-cursor>
  {
    my gboolean $se = $start_editing.so.Int;

    gtk_tree_view_set_cursor($!tv, $path, $focus_column, $se);
  }

  method set_cursor_on_cell (
    GtkTreePath() $path,
    GtkTreeViewColumn() $focus_column,
    GtkCellRenderer() $focus_cell,
    Int() $start_editing
  )
    is also<set-cursor-on-cell>
  {
    my gboolean $se = $start_editing.so.Int;

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
    gpointer $data          = gpointer,
    GDestroyNotify $destroy = GDestroyNotify
  )
    is also<set-destroy-count-func>
  {
    gtk_tree_view_set_destroy_count_func($!tv, $func, $data, $destroy);
  }

  method set_drag_dest_row (
    GtkTreePath() $path,
    Int() $pos                 # GtkTreeViewDropPosition $pos
  )
    is also<set-drag-dest-row>
  {
    my guint $p = $pos;

    gtk_tree_view_set_drag_dest_row($!tv, $path, $p);
  }

  method set_row_separator_func (
    &func,
    gpointer $data = gpointer,
    GDestroyNotify $destroy = GDestroyNotify
  )
    is also<set-row-separator-func>
  {
    gtk_tree_view_set_row_separator_func($!tv, &func, $data, $destroy);
  }

  method set_search_equal_func (
    GtkTreeViewSearchEqualFunc $search_equal_func,
    gpointer $search_user_data     = gpointer,
    GDestroyNotify $search_destroy = GDestroyNotify
  )
    is also<set-search-equal-func>
  {
    gtk_tree_view_set_search_equal_func(
      $!tv,
      $search_equal_func,
      $search_user_data,
      $search_destroy
    );
  }

  method set_search_position_func (
    GtkTreeViewSearchPositionFunc $func,
    gpointer $data          = gpointer,
    GDestroyNotify $destroy = GDestroyNotify
  )
    is also<set-search-position-func>
  {
    gtk_tree_view_set_search_position_func($!tv, $func, $data, $destroy);
  }

  method set_tooltip_cell (
    GtkTooltip() $tooltip,
    GtkTreePath() $path,
    GtkTreeViewColumn() $column,
    GtkCellRenderer() $cell
  )
    is also<set-tooltip-cell>
  {
    gtk_tree_view_set_tooltip_cell($!tv, $tooltip, $path, $column, $cell);
  }

  method set_tooltip_row (GtkTooltip() $tooltip, GtkTreePath() $path)
    is also<set-tooltip-row>
  {
    gtk_tree_view_set_tooltip_row($!tv, $tooltip, $path);
  }

  method unset_rows_drag_dest is also<unset-rows-drag-dest> {
    gtk_tree_view_unset_rows_drag_dest($!tv);
  }

  method unset_rows_drag_source is also<unset-rows-drag-source> {
    gtk_tree_view_unset_rows_drag_source($!tv);
  }

  # ↑↑↑↑ METHODS ↑↑↑↑

}
