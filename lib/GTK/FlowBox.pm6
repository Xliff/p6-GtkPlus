use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::FlowBox;
use GTK::Raw::Types;

use GTK::FlowBoxChild;
use GTK::Container;

class GTK::FlowBox is GTK::Container {
  has GtkFlowBox $!fb;

  submethod BUILD(:$flowbox) {
    given $flowbox {
      when GtkFlowBox | GtkWidget {
        $!fb = do {
          when GtkWidget  { nativecast(GtkFlowBox, $flowbox); }
          when GtkFlowBox { $flowbox; }
        };
        self.setContainer($flowbox);
      }
      when GTK::FlowBox {
      }
      default {
      }
    }
    self.setType('GTK::FlowBox');
  }


  method new {
    my $flowbox = gtk_flow_box_new();
    self.bless(:$flowbox);
  }

  # ↓↓↓↓ SIGNALS ↓↓↓↓
  method activate {
    self.connect($!fb, 'activate');
  }

  method activate-cursor-child {
    self.connect($!fb, 'activate-cursor-child');
  }

  method child-activated {
    # Really wants:
      # (GtkFlowBox      *box,
      #  GtkFlowBoxChild *child,
      #  gpointer         user_data)
    self.connect($!fb, 'child-activated');
  }

  method move-cursor {
    # Really wants:
     # (GtkFlowBox     *box,
     #  gint            count,
     #  GtkMovementStep step,
     #  gpointer        user_data)
    self.connect($!fb, 'move-cursor');
  }

  method select-all {
    self.connect($!fb, 'connect-all');
  }

  method toggle-cursor-child {
    self.connect($!fb, 'toggle-cursor-child');
  }

  method unselect-all {
    self.connect($!fb, 'unselect-all');
  }
  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  method activate_on_single_click is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_flow_box_get_activate_on_single_click($!fb);
      },
      STORE => sub ($, $single is copy) {
        gtk_flow_box_set_activate_on_single_click($!fb, $single);
      }
    );
  }

  method column_spacing is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_flow_box_get_column_spacing($!fb);
      },
      STORE => sub ($, $spacing is copy) {
        gtk_flow_box_set_column_spacing($!fb, $spacing);
      }
    );
  }

  method homogeneous is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_flow_box_get_homogeneous($!fb);
      },
      STORE => sub ($, $homogeneous is copy) {
        gtk_flow_box_set_homogeneous($!fb, $homogeneous);
      }
    );
  }

  method max_children_per_line is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_flow_box_get_max_children_per_line($!fb);
      },
      STORE => sub ($, $n_children is copy) {
        gtk_flow_box_set_max_children_per_line($!fb, $n_children);
      }
    );
  }

  method min_children_per_line is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_flow_box_get_min_children_per_line($!fb);
      },
      STORE => sub ($, $n_children is copy) {
        gtk_flow_box_set_min_children_per_line($!fb, $n_children);
      }
    );
  }

  method row_spacing is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_flow_box_get_row_spacing($!fb);
      },
      STORE => sub ($, $spacing is copy) {
        gtk_flow_box_set_row_spacing($!fb, $spacing);
      }
    );
  }

  method selection_mode is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_flow_box_get_selection_mode($!fb);
      },
      STORE => sub ($, $mode is copy) {
        gtk_flow_box_set_selection_mode($!fb, $mode);
      }
    );
  }
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  multi method bind_model (
    GListModel $model,
    GtkFlowBoxCreateWidgetFunc $create_widget_func,
    gpointer $user_data,
    GDestroyNotify $user_data_free_func
  ) {
    gtk_flow_box_bind_model($!fb, $model, $create_widget_func, $user_data, $user_data_free_func);
  }

  method child_changed {
    gtk_flow_box_child_changed($!fb);
  }

  method child_get_index {
    gtk_flow_box_child_get_index($!fb);
  }

  method child_is_selected {
    gtk_flow_box_child_is_selected($!fb);
  }

  method child_new () {
    GTK::FlowBoxChild.new;
  }

  method get_child_at_index (gint $idx) {
    gtk_flow_box_get_child_at_index($!fb, $idx);
  }

  method get_child_at_pos (gint $x, gint $y) {
    gtk_flow_box_get_child_at_pos($!fb, $x, $y);
  }

  method get_selected_children {
    gtk_flow_box_get_selected_children($!fb);
  }

  method get_type {
    gtk_flow_box_get_type($!fb);
  }

  multi method insert (GtkWidget $widget, gint $position) {
    gtk_flow_box_insert($!fb, $widget, $position);
  }
  multi method insert (GTK::Widget $widget, gint $position)  {
    samewith($widget.widget, $position);
  }

  method invalidate_filter {
    gtk_flow_box_invalidate_filter($!fb);
  }

  method invalidate_sort {
    gtk_flow_box_invalidate_sort($!fb);
  }

  method select_all {
    gtk_flow_box_select_all($!fb);
  }

  multi method _select_child (GtkFlowBoxChild $child) {
    gtk_flow_box_select_child($!fb, $child);
  }
  multi method select_child (GTK::FlowBoxChild $child)  {
    samewith($child.flowboxchild);
  }

  method selected_foreach (GtkFlowBoxForeachFunc $func, gpointer $data) {
    gtk_flow_box_selected_foreach($!fb, $func, $data);
  }

  method set_filter_func (
    GtkFlowBoxFilterFunc $filter_func,
    gpointer $user_data,
    GDestroyNotify $destroy
  ) {
    gtk_flow_box_set_filter_func($!fb, $filter_func, $user_data, $destroy);
  }


  method set_hadjustment (GtkAdjustment $adjustment) {
    gtk_flow_box_set_hadjustment($!fb, $adjustment);
  }

  multi method set_sort_func (
    GtkFlowBoxSortFunc $sort_func,
    gpointer $user_data,
    GDestroyNotify $destroy
  ) {
    gtk_flow_box_set_sort_func($!fb, $sort_func, $user_data, $destroy);
  }

  method set_vadjustment (GtkAdjustment $adjustment) {
    my uint32 $a = $adjustment.Int;
    gtk_flow_box_set_vadjustment($!fb, $a);
  }

  method unselect_all {
    gtk_flow_box_unselect_all($!fb);
  }

  multi method unselect_child (GtkFlowBoxChild $child) {
    gtk_flow_box_unselect_child($!fb, $child);
  }
  multi method unselect_child (GTK::FlowBoxChild $child)  {
    samewith($child.flowboxchild);
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
