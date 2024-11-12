use v6.c;

use Method::Also;

use GLib::GList;

use GTK::Raw::Types:ver<3.0.1146>;

use GTK::Raw::FlowBox:ver<3.0.1146>;

use GTK::FlowBoxChild:ver<3.0.1146>;
use GTK::Container:ver<3.0.1146>;
use GTK::Widget:ver<3.0.1146>;

use GTK::Roles::Orientable:ver<3.0.1146>;
use GTK::Roles::Signals::FlowBox:ver<3.0.1146>;

our subset FlowBoxAncestry is export
  where GtkFlowBox | GtkOrientable | ContainerAncestry;

class GTK::FlowBox:ver<3.0.1146> is GTK::Container {
  also does GTK::Roles::Orientable;
  also does GTK::Roles::Signals::FlowBox;

  has GtkFlowBox $!fb is implementor;

  has %!child-manifest;

  method bless(*%attrinit) {
    my $o = self.CREATE.BUILDALL(Empty, %attrinit);
    $o.setType(self.^name);
    $o;
  }

  submethod BUILD (:$flowbox) {
    my $to-parent;
    given $flowbox {
      when FlowBoxAncestry {
        $!fb = do {
          when GtkFlowBox {
            $to-parent = cast(GtkContainer, $_);
            $_;
          }
          when GtkOrientable {
            $!or = $_;
            $to-parent = cast(GtkContainer, $_);
            cast(GtkFlowBox, $_);
          }
          default {
            $to-parent = $_;
            cast(GtkFlowBox, $_);
          }
        };
        $!or //= cast(GtkOrientable, $flowbox);
        self.setContainer($flowbox);
      }
      when GTK::FlowBox {
      }
      default {
      }
    }
  }

  method GTK::Raw::Definitions::GtkFlowBox
    is also<
      FlowBox
      GtkFlowBox
    >
  { $!fb }

  multi method new (FlowBoxAncestry $flowbox, :$ref = False) {
    return Nil unless $flowbox;

    my $o = self.bless(:$flowbox);
    $o.ref if $ref;
    $o;
  }
  multi method new {
    my $flowbox = gtk_flow_box_new();

    $flowbox ?? self.bless( :$flowbox ) !! Nil;
  }
  multi method new (Int() $orientation, Int() $spacing) {
    my $o = self.new;
    ( .orientation, .spacing ) = ($orientation, $spacing) given $o;
    $o;
  }

  multi method new-hbox (Int() $spacing = 0) {
    self.new(GTK_ORIENTATION_HORIZONTAL, $spacing);
  }

  multi method new-vbox (Int() $spacing = 0) {
    self.new(GTK_ORIENTATION_VERTICAL, $spacing);
  }

  method !resolve-selected-child ($child) {
    do given $child {
      when GTK::FlowBoxChild { $_.FlowBoxChild                }
      when GtkFlowBoxChild   { $_                             }
      when GTK::Widget       { %!child-manifest{ +.Widget.p } }
      when GtkWidget         { %!child-manifest{ +.p }        }
    }
  }

  # ↓↓↓↓ SIGNALS ↓↓↓↓
  method activate-cursor-child is also<activate_cursor_child> {
    self.connect($!fb, 'activate-cursor-child');
  }

  method child-activated is also<child_activated> {
    # Really wants:
      # (GtkFlowBox      *box,
      #  GtkFlowBoxChild *child,
      #  gpointer         user_data)
    self.connect-child-activated($!fb);
  }

  method move-cursor is also<move_cursor> {
    # Really wants:
     # (GtkFlowBox     *box,
     #  gint            count,
     #  GtkMovementStep step,
     #  gpointer        user_data)
    self.connect-move-cursor1($!fb, 'move-cursor');
  }

  method select-all is also<select_all> {
    self.connect($!fb, 'connect-all');
  }

  method toggle-cursor-child is also<toggle_cursor_child> {
    self.connect($!fb, 'toggle-cursor-child');
  }

  method unselect-all-children is also<unselect_all_children> {
    self.connect($!fb, 'unselect-all');
  }
  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # cw: QoL
  method spacing is rw {
    Proxy.new:
      FETCH => -> $     { (self.row_spacing, self.column_spacing).max   },
      STORE => -> $, \v { .row_spacing = .column-spacing = v with self; }
  }

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  method activate_on_single_click is rw is also<activate-on-single-click> {
    Proxy.new(
      FETCH => sub ($) {
        so gtk_flow_box_get_activate_on_single_click($!fb);
      },
      STORE => sub ($, Int() $single is copy) {
        my gboolean $s = $single.Int.so;

        gtk_flow_box_set_activate_on_single_click($!fb, $s);
      }
    );
  }

  method column_spacing is rw is also<column-spacing> {
    Proxy.new(
      FETCH => sub ($) {
        gtk_flow_box_get_column_spacing($!fb);
      },
      STORE => sub ($, Int() $spacing is copy) {
        my gint $s = $spacing;

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
        my gboolean $h = $homogeneous.Int.so;

        gtk_flow_box_set_homogeneous($!fb, $h);
      }
    );
  }

  method max_children_per_line is rw is also<max-children-per-line> {
    Proxy.new(
      FETCH => sub ($) {
        gtk_flow_box_get_max_children_per_line($!fb);
      },
      STORE => sub ($, Int() $n_children is copy) {
        my gint $n = $n_children;

        gtk_flow_box_set_max_children_per_line($!fb, $n);
      }
    );
  }

  method min_children_per_line is rw is also<min-children-per-line> {
    Proxy.new(
      FETCH => sub ($) {
        gtk_flow_box_get_min_children_per_line($!fb);
      },
      STORE => sub ($, Int() $n_children is copy) {
        my gint $n = $n_children;

        gtk_flow_box_set_min_children_per_line($!fb, $n);
      }
    );
  }

  method row_spacing is rw is also<row-spacing> {
    Proxy.new(
      FETCH => sub ($) {
        gtk_flow_box_get_row_spacing($!fb);
      },
      STORE => sub ($, Int() $spacing is copy) {
        my gint $s = $spacing;

        gtk_flow_box_set_row_spacing($!fb, $s);
      }
    );
  }

  method selection_mode is rw is also<selection-mode> {
    Proxy.new(
      FETCH => sub ($) {
        GtkSelectionModeEnum( gtk_flow_box_get_selection_mode($!fb) );
      },
      STORE => sub ($, Int() $mode is copy) {
        my uint32 $m = $mode;

        gtk_flow_box_set_selection_mode($!fb, $m);
      }
    );
  }
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  method get_children (:$wrap is copy, :$unwrap is copy)
    is also<get-children>
  {
    die
      "Both $wrap and $unwrap cannot be specified in the same call to {
      } GTK::FlowBox.get_children"
    with $wrap && $unwrap;

    $wrap //= ($unwrap // False).not;
    my @end = self.end;
    @end.map( *.get_child ) unless $wrap;
    @end;
  }

  # Override.
  method add ($widget) {
    say 'Flowbox add';
    my $adding = do given $widget {
      when GTK::FlowBoxChild { $_ }

      when GTK::Widget | GtkWidget {
        my $fbc = GTK::FlowBoxChild.new;
        $fbc.add($_);
        $fbc
      }

      default {
        die
          "GTK::FlowBox.add does not know how to handle object type {
          .^name }";
      }
    };
    %!child-manifest{ +.get-child.Widget.p } = $_ given $adding;
    nextwith($adding);
  }

  # Override
  method remove($widget) {
    my $removing = do given $widget {
      when GTK::FlowBoxChild {
        %!child-manifest{ +.get-child.Widget.p }:delete;
        $_
      }

      when GtkFlowBoxChild   {
        %!child-manifest{ +.p }:delete;
        $_
      }

      when GTK::Widget       {
        %!child-manifest{ +.Widget.p }:delete;
      }

      when GtkWidget         {
        %!child-manifest{ +.p }; #:delete;
      }
    }
    nextwith($removing);
  }

  # ↓↓↓↓ METHODS ↓↓↓↓
  multi method bind_model (
    GListModel() $model,
    GtkFlowBoxCreateWidgetFunc $create_widget_func,
    gpointer $user_data                 = gpointer,
    GDestroyNotify $user_data_free_func = gpointer
  )
    is also<bind-model>
  {
    gtk_flow_box_bind_model(
      $!fb, $model, $create_widget_func, $user_data, $user_data_free_func
    );
  }

  method get_child_at_index (Int() $idx, :$raw = False)
    is also<get-child-at-index>
  {
    my gint $i = $idx;

    my $fbc = self.end[$idx];

    return Nil unless $fbc;
    do given $fbc {
      when GTK::FlowBoxChild {
        $raw ?? .GtkFlowBoxChild !! $_;
      }

      default {
        $raw ?? $fbc !! GTK::FlowBoxChild.new($fbc)
      }
    }
  }

  method get_child_at_pos (Int() $x, Int() $y, :$raw = False)
    is also<get-child-at-pos>
  {
    my gint ($xx, $yy) = $x, $y;
    my $fbc = gtk_flow_box_get_child_at_pos($!fb, $xx, $yy);

    $fbc ??
      ( $raw ?? $fbc !! GTK::FlowBoxChild.new($fbc) )
      !!
      Nil;
  }

  method get_selected_children is also<get-selected-children> {
    %!child-manifest.values.grep( *.is-selected );
    #GList.new( GtkFlowBoxChild, gtk_flow_box_get_selected_children($!fb) );
  }

  method get_type is also<get-type> {
    state ($n, $t);

    GTK::Widget.unstable_get_type( &gtk_flow_box_get_type, $n, $t );
  }

  method insert ($widget, Int() $position) {
    my gint $p = $position;
    my $inserting = do given $widget {
      when GTK::FlowBoxChild { $_ }

      when GTK::Widget | GtkWidget {
        my $fbc = GTK::FlowBoxChild.new;
        $fbc.add($_);
        $fbc
      }

      default {
        die
          "GTK::FlowBox.insert does not know how to handle object type {
          .^name }";
      }
    };

    %!child-manifest{ +.get-child.Widget.p } = $_ given $inserting;
    self.insert-end-at($inserting, $position);
    gtk_flow_box_insert($!fb, $inserting, $p);
  }

  method invalidate_filter is also<invalidate-filter> {
    gtk_flow_box_invalidate_filter($!fb);
  }

  method invalidate_sort is also<invalidate-sort> {
    gtk_flow_box_invalidate_sort($!fb);
  }

  method select_all_children is also<select-all-children> {
    gtk_flow_box_select_all($!fb);
  }

  method select_child ($child) is also<select-child> {
    my $to-be-selected = self!resolve-selected-child($child);

    gtk_flow_box_select_child($!fb, $to-be-selected);
  }

  method selected_foreach (GtkFlowBoxForeachFunc $func, gpointer $data)
    is also<selected-foreach>
  {
    gtk_flow_box_selected_foreach($!fb, $func, $data);
  }

  method set_filter_func (
    &filter_func,
    gpointer $user_data     = gpointer,
    GDestroyNotify $destroy = GDestroyNotify
  )
    is also<set-filter-func>
  {
    gtk_flow_box_set_filter_func($!fb, &filter_func, $user_data, $destroy);
  }

  method set_hadjustment (GtkAdjustment() $adjustment)
    is also<set-hadjustment>
  {
    gtk_flow_box_set_hadjustment($!fb, $adjustment);
  }

  multi method set_sort_func (
    &sort_func,
    gpointer $user_data     = gpointer,
    GDestroyNotify $destroy = GDestroyNotify
  )
    is also<set-sort-func>
  {
    gtk_flow_box_set_sort_func(
      $!fb, &sort_func, $user_data, $destroy
    );
  }

  method set_vadjustment (GtkAdjustment() $adjustment)
    is also<set-vadjustment>
  {
    gtk_flow_box_set_vadjustment($!fb, $adjustment);
  }

  method remove_all(:$keep) is also<remove-all> {
    for %!child-manifest.values {
      .ref if $keep;
      self.remove($_);
    }
  }

  method unselect_all is also<unselect-all> {
    gtk_flow_box_unselect_all($!fb);
  }

  method unselect_child (GtkFlowBoxChild() $child)
    is also<unselect-child>
  {
    my $to-be-unselected = self!resolve-selected-child($child);

    gtk_flow_box_unselect_child($!fb, $to-be-unselected);
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
