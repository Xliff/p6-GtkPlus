use v6.c;

use Method::Also;

use GTK::Raw::ListBox;
use GTK::Raw::Types;

use GLib::GList;
use GTK::Container;
use GTK::ListBoxRow;

use GLib::Roles::ListData;
use GTK::Roles::Actionable;
use GTK::Roles::Signals::ListBox;

our subset ListBoxAncestry is export
  where GtkListBox | GtkActionable | ContainerAncestry;

class GTK::ListBox is GTK::Container {
  also does GTK::Roles::Actionable;
  also does GTK::Roles::Signals::ListBox;

  has GtkListBox $!lb is implementor;

  method bless(*%attrinit) {
    my $o = self.CREATE.BUILDALL(Empty, %attrinit);
    $o.setType($o.^name);
    $o;
  }

  submethod BUILD(:$listbox) {
    my $to-parent;
    given $listbox {
      when ListBoxAncestry {
        $!lb = do {
          when GtkListBox {
            $to-parent = cast(GtkContainer, $_);
            $_;
          }
          when GtkActionable {
            $!action = $_;
            $to-parent = cast(GtkContainer, $_);
            cast(GtkListBox, $_);
          }
          default {
            $to-parent = $_;
            cast(GtkListBox, $_);
          }
        }
        $!action //= cast(GtkActionable, $listbox);
        self.setContainer($to-parent);
      }
      when GTK::ListBox {
      }
      default {
      }
    }
  }

  submethod DESTROY {
    self.disconnect-all($_) for %!signals-lb;
  }

  method GTK::Raw::Definitions::GtkListBox
    is also<
      ListBox
      GtkListBox
    >
  { $!lb }

  multi method new (ListBoxAncestry $listbox, :$ref = True) {
    return Nil unless $listbox;

    my $o = self.bless(:$listbox);
    $o.ref if $ref;
    $o;
  }
  multi method new {
    my $listbox = gtk_list_box_new();

    $listbox ?? self.bless(:$listbox) !! Nil
  }


  # ↓↓↓↓ SIGNALS ↓↓↓↓

  # Is originally:
  # GtkListBox, gpointer --> void
  method activate-cursor-row is also<activate_cursor_row> {
    self.connect($!lb, 'activate-cursor-row');
  }

  # Is originally:
  # GtkListBox, GtkMovementStep, gint, gpointer --> void
  method move-cursor is also<move_cursor> {
    self.connect-move-cursor1($!lb, 'move-cursor');
  }

  # Is originally:
  # GtkListBox, GtkListBoxRow, gpointer --> void
  method row-activated is also<row_activated> {
    self.connect-listboxrow($!lb, 'row-activated');
  }

  # Is originally:
  # GtkListBox, GtkListBoxRow, gpointer --> void
  method row-selected is also<row_selected> {
    self.connect-listboxrow($!lb, 'row-selected');
  }

  # Is originally:
  # GtkListBox, gpointer --> void
  method select-all is also<select_all> {
    self.connect($!lb, 'select-all');
  }

  # Is originally:
  # GtkListBox, gpointer --> void
  method selected-rows-changed is also<selected_rows_changed> {
    self.connect($!lb, 'selected-rows-changed');
  }

  # Is originally:
  # GtkListBox, gpointer --> void
  method toggle-cursor-row is also<toggle_cursor_row> {
    self.connect($!lb, 'toggle-cursor-row');
  }

  # Is originally:
  # GtkListBox, gpointer --> void
  method unselect-all is also<unselect_all> {
    self.connect($!lb, 'unselect-all');
  }


  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  method activate_on_single_click is rw is also<activate-on-single-click> {
    Proxy.new(
      FETCH => sub ($) {
        so gtk_list_box_get_activate_on_single_click($!lb);
      },
      STORE => sub ($, Int() $single is copy) {
        my gboolean $s = $single.so.Int;

        gtk_list_box_set_activate_on_single_click($!lb, $s);
      }
    );
  }

  method adjustment (:$raw = False) is rw {
    Proxy.new(
      FETCH => sub ($) {
        my $adj = gtk_list_box_get_adjustment($!lb);

        $adj ??
          ( $raw ?? $adj !! GTK::Adjustment.new($adj) )
          !!
          Nil;
      },
      STORE => sub ($, GtkAdjustment() $adjustment is copy) {
        gtk_list_box_set_adjustment($!lb, $adjustment);
      }
    );
  }

  method selection_mode is rw is also<selection-mode> {
    Proxy.new(
      FETCH => sub ($) {
        GtkSelectionModeEnum( gtk_list_box_get_selection_mode($!lb) );
      },
      STORE => sub ($, Int() $mode is copy) {
        my guint $m = $mode;

        gtk_list_box_set_selection_mode($!lb, $m);
      }
    );
  }

  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ PROPERTIES ↓↓↓↓
  # ↑↑↑↑ PROPERTIES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  method bind_model (
    GListModel() $model,
    &create_widget_func,
    gpointer $user_data                 = gpointer,
    GDestroyNotify $user_data_free_func = GDestroyNotify
  )
    is also<bind-model>
  {
    gtk_list_box_bind_model(
      $!lb,
      $model,
      &create_widget_func,
      $user_data,
      $user_data_free_func
    );
  }

  method drag_highlight_row (GtkListBoxRow() $row)
    is also<drag-highlight-row>
  {
    gtk_list_box_drag_highlight_row($!lb, $row);
  }

  method drag_unhighlight_row is also<drag-unhighlight-row> {
    gtk_list_box_drag_unhighlight_row($!lb);
  }

  method get_row_at_index (Int() $index, :$raw = False)
    is also<get-row-at-index>
  {
    my gint $i = $index;
    my $lbr = gtk_list_box_get_row_at_index($!lb, $i);

    $lbr ??
      ( $raw ?? $lbr !! GTK::ListBoxRow.new($lbr) )
      !!
      Nil;
  }

  method get_row_at_y (Int() $y, :$raw = False) is also<get-row-at-y> {
    my gint $yy = $y;
    my $lbr = gtk_list_box_get_row_at_y($!lb, $yy);

    $lbr ??
      ( $raw ?? $lbr !! GTK::ListBoxRow.new($lbr) )
      !!
      Nil;
  }

  method get_selected_row (:$raw = False)
    is also<
      get-selected-row
      selected_row
      selected-row
    >
  {
    my $lbr = gtk_list_box_get_selected_row($!lb);

    $lbr ??
      ( $raw ?? $lbr !! GTK::ListBoxRow.new($lbr) )
      !!
      Nil;
  }

  method get_selected_rows (:$glist = False, :$raw = False)
    is also<
      get-selected-rows
      selected_rows
      selected-rows
    >
  {
    my $srl = gtk_list_box_get_selected_rows($!lb);

    return Nil unless $srl;
    return $srl if $glist;

    $srl = GLib::GList.new($srl) but GLib::Roles::ListData[GtkListBoxRow];

    $raw ?? $srl.Array !! $srl.Array.map({ GTK::ListBoxRow.new($_) });
  }

  method get_type is also<get-type> {
    state ($n, $t);

    GTK::Widget.unstable_get_type( &gtk_list_box_get_type, $n, $t );
  }

  method insert (GtkWidget() $child, Int() $position) {
    my gint $p = $position;

    gtk_list_box_insert($!lb, $child, $p);
  }

  method invalidate_filter is also<invalidate-filter> {
    gtk_list_box_invalidate_filter($!lb);
  }

  method invalidate_headers is also<invalidate-headers> {
    gtk_list_box_invalidate_headers($!lb);
  }

  method invalidate_sort is also<invalidate-sort> {
    gtk_list_box_invalidate_sort($!lb);
  }

  method prepend (GtkWidget() $child) {
    gtk_list_box_prepend($!lb, $child);
  }

  multi method select (GtkListBoxRow() $r, :$row is required) {
    self.select_row($r);
  }
  multi method select (:$all is required) {
    gtk_list_box_select_all($!lb);
  }

  method select_row (GtkListBoxRow() $row) is also<select-row> {
    gtk_list_box_select_row($!lb, $row);
  }

  method selected_foreach (&func, gpointer $data)
    is also<selected-foreach>
  {
    gtk_list_box_selected_foreach($!lb, &func, $data);
  }

  method set_filter_func (
    &filter_func,
    gpointer $user_data     = gpointer,
    GDestroyNotify $destroy = GDestroyNotify
  )
    is also<set-filter-func>
  {
    gtk_list_box_set_filter_func($!lb, &filter_func, $user_data, $destroy);
  }

  method set_header_func (
    &update_header,
    gpointer $user_data     = gpointer,
    GDestroyNotify $destroy = GDestroyNotify
  )
    is also<set-header-func>
  {
    gtk_list_box_set_header_func($!lb, &update_header, $user_data, $destroy);
  }

  method set_placeholder (GtkWidget() $placeholder)
    is also<set-placeholder>
  {
    gtk_list_box_set_placeholder($!lb, $placeholder);
  }

  method set_sort_func (
    #&sort_func:(GtkListBoxRow, GtkListBoxRow, gpointer --> gint),
    &sort_func,
    gpointer $user_data = gpointer,
    GDestroyNotify $destroy = GDestroyNotify
  )
    is also<set-sort-func>
  {
    # my $sf := &sort_func;
    # if $sf ~~ Sub {
    #   $sf = -> $a, $b --> gint {
    #     &sort_func($a, $b);
    #   }
    # }

    gtk_list_box_set_sort_func($!lb, &sort_func, $user_data, $destroy);
  }

  multi method unselect (GtkListBoxRow() $r, :$row is required) {
    self.unselect_row($r);
  }
  multi method unselect (:$all is required) {
    gtk_list_box_unselect_all($!lb);
  }

  method unselect_row (GtkListBoxRow() $row) is also<unselect-row> {
    gtk_list_box_unselect_row($!lb, $row);
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
