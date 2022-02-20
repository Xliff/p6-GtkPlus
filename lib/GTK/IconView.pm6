use v6.c;

use Method::Also;
use NativeCall;

use GTK::Raw::IconView:ver<3.0.1146>;
use GTK::Raw::Types:ver<3.0.1146>;

use GLib::Value;
use GTK::CellArea:ver<3.0.1146>;
use GTK::CellRenderer:ver<3.0.1146>;
use GTK::Container:ver<3.0.1146>;
use GTK::TreePath:ver<3.0.1146>;
use GTK::TreeIter:ver<3.0.1146>;

use GTK::Roles::CellLayout:ver<3.0.1146>;
use GTK::Roles::Scrollable:ver<3.0.1146>;
use GTK::Roles::Signals::IconView:ver<3.0.1146>;
use GTK::Roles::TreeModel:ver<3.0.1146>;

our subset IconViewAncestry
  where GtkIconView | GtkCellLayout | GtkScrollable | ContainerAncestry;

class GTK::IconView:ver<3.0.1146> is GTK::Container {
  also does GTK::Roles::CellLayout;
  also does GTK::Roles::Scrollable;
  also does GTK::Roles::Signals::IconView;

  has GtkIconView $!iv is implementor;

  method bless(*%attrinit) {
    my $o = self.CREATE.BUILDALL(Empty, %attrinit);
    $o.setType($o.^name);
    $o;
  }

  submethod DESTROY {
    self.disconnect-all($_) for %!signals-iv;
  }

  submethod BUILD(:$iconview) {
    my $to-parent;
    given $iconview {
      when IconViewAncestry {
        $!iv = do {
          when GtkIconView  {
            $to-parent = nativecast(GtkContainer, $_);
            $_;
          }
          when GtkCellLayout {
            $!cl = $_;                          # GTK::Roles::CellLayout
            $to-parent = nativecast(GtkContainer, $_);
            nativecast(GtkIconView, $_);
          }
          when GtkScrollable {
            $!s = $_;                           # GTK::Roles::CellLayout
            $to-parent = nativecast(GtkContainer, $_);
            nativecast(GtkIconView, $_);
          }
          default {
            $to-parent = $_;
            nativecast(GtkIconView, $_);
          }
        }
        $!cl = nativecast(GtkCellLayout, $!iv); # GTK::Roles::CellLayout
        $!s = nativecast(GtkScrollable, $!iv);  # GTK::Roles::Scrollable
        self.setContainer($to-parent);
      }
      when GTK::IconView {
      }
      default {
      }
    }
  }

  multi method new (IconViewAncestry $iconview) {
    $iconview ?? self.bless(:$iconview) !! Nil;
  }
  multi method new {
    my $iconview = gtk_icon_view_new();

    $iconview ?? self.bless(:$iconview) !! Nil;
  }

  method new_with_area (GtkCellArea() $area) is also<new-with-area> {
    my $iconview = gtk_icon_view_new_with_area($area);

    $iconview ?? self.bless(:$iconview) !! Nil;
  }

  method new_with_model (GtkTreeModel() $model) is also<new-with-model> {
    my $iconview = gtk_icon_view_new_with_model($model);

    $iconview ?? self.bless(:$iconview) !! Nil;
  }

  # ↓↓↓↓ SIGNALS ↓↓↓↓

  # Is originally:
  # GtkIconView, gpointer --> gboolean
  method activate-cursor-item is also<activate_cursor_item> {
    self.connect-activate-cursor-item($!iv);
  }

  # Is originally:
  # GtkIconView, GtkTreePath, gpointer --> void
  method item-activated is also<item_activated> {
    self.connect-item-activated($!iv);
  }

  # Is originally:
  # GtkIconView, GtkMovementStep, gint, gpointer --> gboolean
  method move-cursor is also<move_cursor> {
    self.connect-move-cursor1($!iv);
  }

  # Is originally:
  # GtkIconView, gpointer --> void
  method select-all is also<select_all> {
    self.connect($!iv, 'select-all');
  }

  # Is originally:
  # GtkIconView, gpointer --> void
  method select-cursor-item is also<select_cursor_item> {
    self.connect($!iv, 'select-cursor-item');
  }

  # Is originally:
  # GtkIconView, gpointer --> void
  method selection-changed is also<selection_changed> {
    self.connect($!iv, 'selection-changed');
  }

  # Is originally:
  # GtkIconView, gpointer --> void
  method toggle-cursor-item is also<toggle_cursor_item> {
    self.connect($!iv, 'toggle-cursor-item');
  }

  # Is originally:
  # GtkIconView, gpointer --> void
  method unselect-all is also<unselect_all> {
    self.connect($!iv, 'unselect-all');
  }

  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  method activate_on_single_click is rw is also<activate-on-single-click> {
    Proxy.new(
      FETCH => sub ($) {
        so gtk_icon_view_get_activate_on_single_click($!iv);
      },
      STORE => sub ($, Int() $single is copy) {
        my gboolean $s = $single.so.Int;

        gtk_icon_view_set_activate_on_single_click($!iv, $s);
      }
    );
  }

  # Type: GtkCellArea
  method cell-area (:$raw = False) is rw  {
    my GLib::Value $gv .= new( G_TYPE_OBJECT );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('cell-area', $gv)
        );

        return Nil unless $gv.object;

        my $a = nativecast(GtkCellArea, $gv.object);

        $raw ?? $a !! GTK::CellArea.new($a);
      },
      STORE => -> $, GtkCellArea() $val is copy {
        $gv.object = $val;
        self.prop_set('cell-area', $gv);
      }
    );
  }

  method column_spacing is rw is also<column-spacing> {
    Proxy.new(
      FETCH => sub ($) {
        gtk_icon_view_get_column_spacing($!iv);
      },
      STORE => sub ($, Int() $column_spacing is copy) {
        my gint $c = $column_spacing;

        gtk_icon_view_set_column_spacing($!iv, $c);
      }
    );
  }

  method columns is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_icon_view_get_columns($!iv);
      },
      STORE => sub ($, Int() $columns is copy) {
        my gint $c = $columns;

        gtk_icon_view_set_columns($!iv, $c);
      }
    );
  }

  method item_orientation is rw is also<item-orientation> {
    Proxy.new(
      FETCH => sub ($) {
        GtkOrientationEnum( gtk_icon_view_get_item_orientation($!iv) );
      },
      STORE => sub ($, Int() $orientation is copy) {
        my guint $o = $orientation;

        gtk_icon_view_set_item_orientation($!iv, $o);
      }
    );
  }

  method item_padding is rw is also<item-padding> {
    Proxy.new(
      FETCH => sub ($) {
        gtk_icon_view_get_item_padding($!iv);
      },
      STORE => sub ($, Int() $item_padding is copy) {
        my gint $i = $item_padding;

        gtk_icon_view_set_item_padding($!iv, $i);
      }
    );
  }

  method item_width is rw is also<item-width> {
    Proxy.new(
      FETCH => sub ($) {
        gtk_icon_view_get_item_width($!iv);
      },
      STORE => sub ($, Int() $item_width is copy) {
        my gint $i = $item_width;

        gtk_icon_view_set_item_width($!iv, $i);
      }
    );
  }

  method margin is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_icon_view_get_margin($!iv);
      },
      STORE => sub ($, Int() $margin is copy) {
        my gint $m = $margin;

        gtk_icon_view_set_margin($!iv, $m);
      }
    );
  }

  method markup_column is rw is also<markup-column> {
    Proxy.new(
      FETCH => sub ($) {
        gtk_icon_view_get_markup_column($!iv);
      },
      STORE => sub ($, Int() $column is copy) {
        my gint $c = $column;

        gtk_icon_view_set_markup_column($!iv, $c);
      }
    );
  }

  method model (:$raw = False) is rw {
    Proxy.new(
      FETCH => sub ($) {
        my $tm = gtk_icon_view_get_model($!iv);

        $tm ??
          ( $raw ?? $tm !! GTK::Roles::TreeModel.new-treemodel-obj($tm) )
          !!
          Nil;
      },
      STORE => sub ($, GtkTreeModel() $model is copy) {
        gtk_icon_view_set_model($!iv, $model);
      }
    );
  }

  method pixbuf_column is rw is also<pixbuf-column> {
    Proxy.new(
      FETCH => sub ($) {
        gtk_icon_view_get_pixbuf_column($!iv);
      },
      STORE => sub ($, Int() $column is copy) {
        my gint $c = $column;

        gtk_icon_view_set_pixbuf_column($!iv, $c);
      }
    );
  }

  method reorderable is rw {
    Proxy.new(
      FETCH => sub ($) {
        so gtk_icon_view_get_reorderable($!iv);
      },
      STORE => sub ($, Int() $reorderable is copy) {
        my gint $r = $reorderable;

        gtk_icon_view_set_reorderable($!iv, $r);
      }
    );
  }

  method row_spacing is rw is also<row-spacing> {
    Proxy.new(
      FETCH => sub ($) {
        gtk_icon_view_get_row_spacing($!iv);
      },
      STORE => sub ($, Int() $row_spacing is copy) {
        my gint $r = $row_spacing;

        gtk_icon_view_set_row_spacing($!iv, $r);
      }
    );
  }

  method selection_mode is rw is also<selection-mode> {
    Proxy.new(
      FETCH => sub ($) {
        GtkSelectionModeEnum( gtk_icon_view_get_selection_mode($!iv) );
      },
      STORE => sub ($, Int() $mode is copy) {
        my gint $m = $mode;

        gtk_icon_view_set_selection_mode($!iv, $m);
      }
    );
  }

  method spacing is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_icon_view_get_spacing($!iv);
      },
      STORE => sub ($, Int() $spacing is copy) {
        my gboolean $s = $spacing.so.Int;

        gtk_icon_view_set_spacing($!iv, $spacing);
      }
    );
  }

  method text_column is rw is also<text-column> {
    Proxy.new(
      FETCH => sub ($) {
        gtk_icon_view_get_text_column($!iv);
      },
      STORE => sub ($, Int() $column is copy) {
        my gint $c = $column;

        gtk_icon_view_set_text_column($!iv, $c);
      }
    );
  }

  method tooltip_column is rw is also<tooltip-column> {
    Proxy.new(
      FETCH => sub ($) {
        gtk_icon_view_get_tooltip_column($!iv);
      },
      STORE => sub ($, Int() $column is copy) {
        my gint $c = $column;

        gtk_icon_view_set_tooltip_column($!iv, $c);
      }
    );
  }

  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ PROPERTIES ↓↓↓↓
  # ↑↑↑↑ PROPERTIES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓

  method convert_widget_to_bin_window_coords (
    Int() $wx,
    Int() $wy,
    Int() $bx,
    Int() $by
  )
    is also<convert-widget-to-bin-window-coords>
  {
    my ($wxx, $wyy, $bxx, $byy) = ($wx, $wy, $bx, $by);

    gtk_icon_view_convert_widget_to_bin_window_coords(
      $!iv,
      $wxx,
      $wyy,
      $bxx,
      $byy
    );
  }

  method create_drag_icon (GtkTreePath() $path) is also<create-drag-icon> {
    gtk_icon_view_create_drag_icon($!iv, $path);
  }

  proto method enable_model_drag_dest (|)
    is also<enable-model-drag-dest>
  { * }


  multi method enable_model_drag_dest (
    @targets,
    Int() $actions             # GdkDragAction $actions
  ) {
    samewith(
      GLib::Roles::TypedBuffer[GtkTargetEntry].new(@targets).p,
      @targets.elems;
      $actions
    );
  }
  multi method enable_model_drag_dest (
    gpointer $targets,
    Int() $n_targets,
    Int() $actions             # GdkDragAction $actions
  ) {
    my gint $nt = $n_targets;
    my uint32 $a = $actions;

    gtk_icon_view_enable_model_drag_dest($!iv, $targets, $nt, $a);
  }

  proto method enable_model_drag_source (|)
    is also<enable-model-drag-source>
  { * }

  multi method enable_model_drag_source (
    Int() $start_button_mask,  # GdkModifierType $start_button_mask,
    @targets,
    Int() $actions             # GdkDragAction $actions
  ) {
    samewith(
      $start_button_mask,
      GLib::Roles::TypedBuffer[GtkTargetEntry].new(@targets);
      @targets.elems
    );
  }
  multi method enable_model_drag_source (
    Int() $start_button_mask,  # GdkModifierType $start_button_mask,
    gpointer $targets,
    Int() $n_targets,
    Int() $actions             # GdkDragAction $actions
  ) {
    my guint ($s, $a) = ($start_button_mask, $actions);
    my gint $nt = $n_targets;

    gtk_icon_view_enable_model_drag_source($!iv, $s, $targets, $nt, $a);
  }

  method get_cell_rect (
    GtkTreePath() $path,
    GtkCellRenderer() $cell,
    GdkRectangle() $rect
  )
    is also<get-cell-rect>
  {
    gtk_icon_view_get_cell_rect($!iv, $path, $cell, $rect);
  }

  # Needs better interface that considers object reuse (or at least recycling)
  proto method get_cursor (|)
    is also<get-cursor>
  { * }

  multi method get_cursor (:$raw = False) {
    my @r = callwith($, $, :all, :$raw);

    @r[0] ?? @r[1..*] !! Nil;
  }
  multi method get_cursor (
    $path is rw,
    $cell is rw,
    :$all = False,
    :$raw = False
  ) {
    my $cpath = CArray[Pointer[GtkTreePath]].new;
    my $ccell = CArray[Pointer[GtkCellRenderer]].new;
    $cpath[0] = Pointer[GtkTreePath];
    $ccell[0] = Pointer[GtkCellRenderer];
    my $rv = gtk_icon_view_get_cursor($!iv, $cpath, $ccell);

    if $rv {
      $path = do {
        my $ret = $cpath[0] ?? $cpath[0] !! Nil;
        $ret = GTK::TreePath.new($ret) unless !$ret || $raw;
        $ret;
      }

      $cell = do {
        my $ret = $ccell[0] ?? $ccell[0] !! Nil;
        $ret = GTK::CellRenderer.new($ret) unless !$ret || $raw;
        $ret;
      }
    } else {
      ($path, $cell) = Nil xx 2;
    }

    $all.not ?? $rv !! ($rv, $path, $cell);
  }

  proto method get_dest_item_at_pos (|)
    is also<get-dest-item-at-pos>
  { * }

  multi method get_dest_item_at_pos (
    Int() $drag_x,
    Int() $drag_y,
    :$raw = False
  ) {
    my @r = callwith($drag_x, $drag_y, $, $, :all, :$raw);

    @r[0] ?? @r[1..*] !! Nil;
  }
  multi method get_dest_item_at_pos (
    Int() $drag_x,
    Int() $drag_y,
    $path is rw,
    $pos  is rw,                # GtkIconViewDropPosition $pos
    :$all = False,
    :$raw = False
  ) {
    my gint ($dx, $dy) = ($drag_x, $drag_y);
    my uint32 $p = 0;
    my $pp = CArray[Pointer[GtkTreePath]];

    $pp[0] = Pointer[GtkTreePath];
    my $rv = gtk_icon_view_get_dest_item_at_pos($!iv, $dx, $dy, $pp, $p);
    $path = $p;

    $path = do {
      my $ret = $pp[0] ?? $pp[0] !! Nil;
      $ret = GTK::TreePath.new($ret) unless $ret || $raw;
      $ret;
    }

    $all.not ?? $rv !! ($rv, $path, $pos);
  }

  proto method get_drag_dest_item (|)
    is also<get-drag-dest-item>
  { * }

  multi method get_drag_dest_item (
    Int() $pos                 # GtkIconViewDropPosition $pos
    :$raw = False
  ) {
    samewith($, $pos, :$raw);
  }
  multi method get_drag_dest_item (
    $path is rw,
    Int() $pos,                # GtkIconViewDropPosition $pos
    :$raw = False
  ) {
    my uint32 $p = $pos;
    my $pp = CArray[Pointer[GtkTreePath]].new;

    $pp[0] = Pointer[GtkTreePath];
    gtk_icon_view_get_drag_dest_item($!iv, $pp, $p);

    $path = $pp[0] ??
      ( $raw ?? $pp[0] !! GTK::TreePath.new($pp[0]) )
      !!
      Nil;
  }

  proto method get_item_at_pos (|)
    is also<get-item-at-pos>
  { * }

  multi method get_item_at_pos (
    Int() $x,
    Int() $y,
    :$raw = False
  ) {
    my @r = callwith($x, $y, $, $, :all, :$raw);

    @r[0] ?? @r[1..*] !! Nil;
  }
  multi method get_item_at_pos (
    Int() $x,
    Int() $y,
    $path is rw,
    $cell is rw,
    :$all = False,
    :$raw = False
  ) {
    my @i = ($x, $y);
    my gint ($xx, $yy) = @i;
    my $cpath = CArray[Pointer[GtkTreePath]].new;
    my $ccell = CArray[Pointer[GtkCellRenderer]].new;
    $cpath[0] = Pointer[GtkTreePath];
    $ccell[0] = Pointer[GtkCellRenderer];
    my $rv = gtk_icon_view_get_item_at_pos($!iv, $xx, $yy, $cpath, $ccell);

    if $rv {
      $path = do {
        my $ret = $cpath[0] ?? $cpath[0] !! Nil;
        $ret = GTK::TreePath.new($ret) unless !$ret || $raw;
        $ret;
      }

      $cell = do {
        my $ret = $ccell[0] ?? $ccell[0] !! Nil;
        $ret = GTK::CellRenderer.new($ret) unless !$ret || $raw;
        $ret;
      }
    } else {
      ($path, $cell) = Nil xx 2;
    }

    $all.not ?? $rv !! ($rv, $cell, $path);
  }

  method get_item_column (GtkTreePath() $path)
    is also<get-item-column>
  {
    gtk_icon_view_get_item_column($!iv, $path);
  }

  method get_item_row (GtkTreePath() $path)
    is also<get-item-row>
  {
    gtk_icon_view_get_item_row($!iv, $path);
  }

  method get_path_at_pos (Int() $x, Int() $y, :$raw = False)
    is also<get-path-at-pos>
  {
    my gint ($xx, $yy) = ($x, $y);
    my $p = gtk_icon_view_get_path_at_pos($!iv, $xx, $yy);

    $p ??
      ( $raw ?? $p !! GTK::TreePath.new($p) )
      !!
      Nil;
  }

  method get_selected_items (:$glist = False, :$raw = False)
    is also<get-selected-items>
  {
    my $il = gtk_icon_view_get_selected_items($!iv);

    return Nil unless $il;
    return $il if $glist;

    $il = GLib::GList.new($il) but GLib::Roles::ListData[GtkTreePath];
    $raw ?? $il.Array !! $il.Array.map({ GTK::TreePath.new($_) });
  }

  proto method get_tooltip_context (|)
    is also<get-tooltip-context>
  { * }

  multi method get_tooltip_context (
    Int() $x,
    Int() $y,
    Int() $keyboard_tip,
    :$raw = False
  ) {
    my @r = callwith($x, $y, $keyboard_tip, $, $, $, :all, :$raw);

    @r[0] ?? @r[1..*] !! Nil;
  }
  multi method get_tooltip_context (
    Int() $x,
    Int() $y,
    Int() $keyboard_tip,
    $model is rw,
    $path  is rw,
    $iter  is rw,
    :$all = False,
    :$raw = False
  ) {
    my gint ($xx, $yy) = ($x, $y);
    my gboolean $kt = $keyboard_tip.so.Int;
    my $cmodel = CArray[Pointer[GtkTreeModel]].new;
    my $cpath = CArray[Pointer[GtkTreePath]].new;
    my $citer = CArray[Pointer[GtkTreeIter]].new;

    $cmodel[0] = Pointer[GtkTreeModel];
    $cpath[0]  = Pointer[GtkTreePath];
    $citer[0]  = Pointer[GtkTreeIter];
    my $rv = gtk_icon_view_get_tooltip_context(
      $!iv,
      $x,
      $y,
      $keyboard_tip,
      $cmodel,
      $cpath,
      $citer
    );

    if $rv {
      $model = do {
        my $ret = $cmodel[0] ?? $cmodel[0] !! Nil;
        $ret = GTK::Roles::TreeModel.new-treemodel-obj($ret)
          unless !$ret || $raw;
        $ret
      };

      $path  = do {
        my $ret = $cpath[0] ?? $cpath[0] !! Nil;
        $ret = GTK::TreePath.new($ret) unless !$ret || $raw;
        $ret;
      }

      $iter = do {
        my $ret = $citer[0] ?? $citer[0] !! Nil;
        $ret = GTK::TreeIter.new($ret) unless !$ret || $raw;
        $ret
      }
    } else {
      ($model, $path, $iter) = Nil xx 3;
    }

    $all.not ?? $rv !! ($rv, $model, $path, $iter);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    GTK::Widget.unstable_get_type( &gtk_icon_view_get_type, $n, $t );
  }

  proto method get_visible_range (|)
    is also<get-visible-range>
  { * }

  multi method get_visible_range (:$raw = False) {
    my @r = callwith($, $, :all, :$raw);

    @r[0] ?? @r[1..*] !! Nil;
  }
  multi method get_visible_range (
    $start_path is rw,
    $end_path   is rw,
    :$all = False,
    :$raw = False
  ) {
    my $cstart = CArray[Pointer[GtkTreePath]].new;
    my $cend   = CArray[Pointer[GtkTreePath]].new;
    $cstart[0] = Pointer[GtkTreePath];
    $cend[0]   = Pointer[GtkTreePath];
    my $rv = gtk_icon_view_get_visible_range($!iv, $cstart, $cend);

    if $rv {
      $start_path = do {
        my $ret = $cstart[0] ?? $cstart[0] !! Nil;
        $ret = GTK::TreePath.new($ret) unless !$ret || $raw;
        $ret;
      }

      $end_path = do {
        my $ret = $cend[0] ?? $cend[0] !! Nil;
        $ret = GTK::TreePath.new($ret) unless !$ret || $raw;
        $ret;
      }
    } else {
      ($start_path, $end_path) = Nil xx 2;
    }

    $all.not ?? $rv !! ($rv, $start_path, $end_path);
  }

  method emit_item_activated (GtkTreePath() $path)
    is also<emit-item-activated>
  {
    gtk_icon_view_item_activated($!iv, $path);
  }

  method path_is_selected (GtkTreePath() $path) is also<path-is-selected> {
    gtk_icon_view_path_is_selected($!iv, $path);
  }

  method scroll_to_path (
    GtkTreePath() $path,
    Int() $use_align,
    Num() $row_align,
    Num() $col_align
  )
    is also<scroll-to-path>
  {
    my guint $ua = $use_align;
    my num32 ($ra, $ca) = ($row_align, $col_align);

    gtk_icon_view_scroll_to_path($!iv, $path, $ua, $ra, $ca);
  }

  method select_all_icons is also<select-all-icons> {
    gtk_icon_view_select_all($!iv);
  }

  method select_path (GtkTreePath() $path) is also<select-path> {
    gtk_icon_view_select_path($!iv, $path);
  }

  method selected_foreach (&func, gpointer $data = gpointer)
    is also<selected-foreach>
  {
    gtk_icon_view_selected_foreach($!iv, &func, $data);
  }

  method set_cursor (
    GtkTreePath() $path,
    GtkCellRenderer() $cell,
    Int() $start_editing
  )
    is also<set-cursor>
  {
    my gboolean $se = $start_editing.so.Int;

    gtk_icon_view_set_cursor($!iv, $path, $cell, $se);
  }

  method set_drag_dest_item (
    GtkTreePath() $path,
    Int() $pos                 # GtkIconViewDropPosition $pos
  )
    is also<set-drag-dest-item>
  {
    my uint32 $p = $pos;

    gtk_icon_view_set_drag_dest_item($!iv, $path, $p);
  }

  method set_tooltip_cell (
    GtkTooltip() $tooltip,
    GtkTreePath() $path,
    GtkCellRenderer() $cell
  )
    is also<set-tooltip-cell>
  {
    gtk_icon_view_set_tooltip_cell($!iv, $tooltip, $path, $cell);
  }

  method set_tooltip_item (GtkTooltip() $tooltip, GtkTreePath() $path)
    is also<set-tooltip-item>
  {
    gtk_icon_view_set_tooltip_item($!iv, $tooltip, $path);
  }

  method unselect_all_icons is also<unselect-all-icons> {
    gtk_icon_view_unselect_all($!iv);
  }

  method unselect_path (GtkTreePath() $path) is also<unselect-path> {
    gtk_icon_view_unselect_path($!iv, $path);
  }

  method unset_model_drag_dest is also<unset-model-drag-dest> {
    gtk_icon_view_unset_model_drag_dest($!iv);
  }

  method unset_model_drag_source is also<unset-model-drag-source> {
    gtk_icon_view_unset_model_drag_source($!iv);
  }

  # ↑↑↑↑ METHODS ↑↑↑↑

}
