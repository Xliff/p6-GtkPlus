use v6.c;

use NativeCall;

use GTK::Compat::GList;
use GTK::Compat::Types;
use GTK::Raw::FlowBox;
use GTK::Raw::Types;

use GTK::FlowBoxChild;
use GTK::Container;

class GTK::FlowBox is GTK::Container {
  has GtkFlowBox $!fb;

  method bless(*%attrinit) {
    my $o = self.CREATE.BUILDALL(Empty, %attrinit);
    $o.setType('GTK::FlowBox');
    $o;
  }

  submethod BUILD(:$flowbox) {
    my $to-parent;
    given $flowbox {
      when GtkFlowBox | GtkWidget {
        $!fb = do {
          when GtkWidget  {
            $to-parent = $_;
            nativecast(GtkFlowBox, $_);
          }
          when GtkFlowBox {
            $to-parent = nativecast(GtkContainer, $_);
            $_;
          }
        };
        self.setContainer($flowbox);
      }
      when GTK::FlowBox {
      }
      default {
      }
    }
  }

  multi method new {
    my $flowbox = gtk_flow_box_new();
    self.bless(:$flowbox);
  }
  multi method new (GtkWidget $flowbox) {
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
        so gtk_flow_box_get_activate_on_single_click($!fb);
      },
      STORE => sub ($, Int() $single is copy) {
        my gboolean $s = self.RESOLVE-BOOL($single);
        gtk_flow_box_set_activate_on_single_click($!fb, $s);
      }
    );
  }

  method column_spacing is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_flow_box_get_column_spacing($!fb);
      },
      STORE => sub ($, Int() $spacing is copy) {
        my gint $s = self.RESOLVE-INT($spacing);
        gtk_flow_box_set_column_spacing($!fb, $s);
      }
    );
  }

  method homogeneous is rw {
    Proxy.new(
      FETCH => sub ($) {
        so gtk_flow_box_get_homogeneous($!fb);
      },
      STORE => sub ($, Int() $homogeneous is copy) {
        my gboolean $h = self.RESOLVE-BOOL($homogeneous);
        gtk_flow_box_set_homogeneous($!fb, $h);
      }
    );
  }

  method max_children_per_line is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_flow_box_get_max_children_per_line($!fb);
      },
      STORE => sub ($, Int() $n_children is copy) {
        my gint $n = self.RESOLVE-INT($n_children);
        gtk_flow_box_set_max_children_per_line($!fb, $n);
      }
    );
  }

  method min_children_per_line is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_flow_box_get_min_children_per_line($!fb);
      },
      STORE => sub ($, $n_children is copy) {
        my gint $n = self.RESOLVE-INT($n_children);
        gtk_flow_box_set_min_children_per_line($!fb, $n);
      }
    );
  }

  method row_spacing is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_flow_box_get_row_spacing($!fb);
      },
      STORE => sub ($, $spacing is copy) {
        my gint $s = self.RESOLVE-INT($spacing);
        gtk_flow_box_set_row_spacing($!fb, $s);
      }
    );
  }

  method selection_mode is rw {
    Proxy.new(
      FETCH => sub ($) {
        GtkSelectionMode( gtk_flow_box_get_selection_mode($!fb) );
      },
      STORE => sub ($, Int() $mode is copy) {
        my uint32 $m = self.RESOLVE-UINT($mode);
        gtk_flow_box_set_selection_mode($!fb, $m);
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
    gtk_flow_box_bind_model(
      $!fb, $model, $create_widget_func, $user_data, $user_data_free_func
    );
  }

  method get_child_at_index (gint $idx) {
    GTK::FlowBoxChild.new(
      gtk_flow_box_get_child_at_index($!fb, $idx)
    );
  }

  method get_child_at_pos (gint $x, gint $y) {
    GTK::FlowBoxChild.new(
      gtk_flow_box_get_child_at_pos($!fb, $x, $y);
    );
  }

  method get_selected_children {
    GList.new( gtk_flow_box_get_selected_children($!fb) );
  }

  method get_type {
    gtk_flow_box_get_type();
  }

  method insert (GtkWidget() $widget, gint $position) {
    gtk_flow_box_insert($!fb, $widget, $position);
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

  method select_child (GtkFlowBoxChild() $child) {
    gtk_flow_box_select_child($!fb, $child);
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

  method set_hadjustment (GtkAdjustment() $adjustment) {
    gtk_flow_box_set_hadjustment($!fb, $adjustment);
  }

  multi method set_sort_func (
    GtkFlowBoxSortFunc $sort_func,
    gpointer $user_data,
    GDestroyNotify $destroy
  ) {
    gtk_flow_box_set_sort_func(
      $!fb, $sort_func, $user_data, $destroy
    );
  }

  method set_vadjustment (GtkAdjustment() $adjustment) {
    gtk_flow_box_set_vadjustment($!fb, $adjustment);
  }

  method unselect_all {
    gtk_flow_box_unselect_all($!fb);
  }

  method unselect_child (GtkFlowBoxChild() $child) {
    gtk_flow_box_unselect_child($!fb, $child);
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
