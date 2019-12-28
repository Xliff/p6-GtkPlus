use v6.c;

use Method::Also;
use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::CellArea;
use GTK::Raw::Types;

use GLib::Roles::Object;

use GTK::Roles::Buildable;
use GTK::Roles::CellLayout;
use GTK::Roles::Signals::CellArea;

our subset CellAreaAncestry is export
  where GtkCellArea | GtkOrientable | GtkCellLayout | GtkBuildable;

class GTK::CellArea {
  also does GLib::Roles::Object;
  
  also does GTK::Roles::Buildable;
  also does GTK::Roles::CellLayout;
  also does GTK::Roles::Signals::CellArea;

  has GtkCellArea $!ca is implementor;

  # Abstract classs GTK::CellArea

  method setCellArea(CellAreaAncestry $cellarea) {
    self!setObject(
      $!ca = do given $cellarea {
        when GtkCellLayout {
          $!cl = $_;                          # GTK::Roles::CellLayout
          nativecast(GtkCellArea, $_);
        }
        when GtkBuildable {
          $!b = $_;                           # GTK::Roles::Buildable
          nativecast(GtkCellArea, $_);
        }
        when GtkCellArea {
          $_
        }
        default {
          nativecast(GtkCellArea, $_);
        }
      } 
    );
    $!cl //= nativecast(GtkCellLayout, $!ca);        # GTK::Roles::CellLayout
    $!b  //= nativecast(GtkBuildable,   $!ca);       # GTK::Roles::Buildable
  }

  method GTK::Raw::Types::GtkCellArea is also<CellArea> { $!ca } 

  submethod DESTROY {
    # Almost certainly a mistake! This should be done at the pointer level!!
    #self.disconnect-all for %!signals-ca, $!signals;
  }

  # ↓↓↓↓ SIGNALS ↓↓↓↓

  # Is originally:
  # GtkCellArea, GtkCellRenderer, GtkCellEditable, GdkRectangle, gchar, gpointer --> void
  method add-editable is also<add_editable> {
    self.connect-add-editable($!ca);
  }

  # Is originally:
  # GtkCellArea, GtkTreeModel, GtkTreeIter, gboolean, gboolean, gpointer --> void
  method apply-attributes is also<apply_attributes> {
    self.connect-apply-attributes($!ca);
  }

  # Is originally:
  # GtkCellArea, GtkCellRenderer, gchar, gpointer --> void
  method focus-changed is also<focus_changed> {
    self.connect-focus-changed($!ca);
  }

  # Is originally:
  # GtkCellArea, GtkCellRenderer, GtkCellEditable, gpointer --> void
  method remove-editable is also<remove_editable> {
    self.connect-remove-editable($!ca);
  }

  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  method focus_cell is rw is also<focus-cell> {
    Proxy.new(
      FETCH => sub ($) {
        gtk_cell_area_get_focus_cell($!ca);
      },
      STORE => sub ($, GtkCellRenderer() $renderer is copy) {
        gtk_cell_area_set_focus_cell($!ca, $renderer);
      }
    );
  }
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  method activate (
    GtkCellAreaContext() $context,
    GtkWidget() $widget,
    GdkRectangle $cell_area,
    Int() $flags,               # GtkCellRendererState $flags,
    Int() $edit_only
  ) {
    my guint $f = self.RESOLVE-UINT($flags);
    my gboolean $e = self.RESOLVE-BOOL($edit_only);
    gtk_cell_area_activate($!ca, $context, $widget, $cell_area, $f, $e);
  }

  method activate_cell (
    GtkWidget() $widget,
    GtkCellRenderer() $r,
    GdkEvent $e,
    GdkRectangle $ca,
    Int() $flags                # GtkCellRendererState $flags
  ) 
    is also<activate-cell> 
  {
    my guint $f = self.RESOLVE-UINT($flags);
    gtk_cell_area_activate_cell($!ca, $widget, $r, $e, $ca, $f);
  }


  multi method add (GtkCellRenderer $renderer) {
    gtk_cell_area_add($!ca, $renderer);
  }

  method add_focus_sibling (
    GtkCellRenderer() $renderer,
    GtkCellRenderer() $sibling
  )
    is also<add-focus-sibling>
  {
    gtk_cell_area_add_focus_sibling($!ca, $renderer, $sibling);
  }

  sub add_with_properties (
    GtkCellArea() $area,
    GtkCellRenderer() $renderer,
    Str() $name,
    GValue() $value
  ) {
    gtk_cell_area_add_with_properties($area, $renderer, $name, $value, Str);
  }

  method apply_connected_attributes (
    GtkTreeModel() $tree_model,
    GtkTreeIter() $iter,
    Int() $is_expander,
    Int() $is_expanded
  )
    is also<apply-connected-attributes>
  {
    my @b = ($is_expander, $is_expanded);
    my gboolean ($ie1, $ie2) = self.RESOLVE-BOOL(@b);
    gtk_cell_area_apply_attributes($!ca, $tree_model, $iter, $ie1, $ie2);
  }

   method attribute_connect (
    GtkCellRenderer() $renderer,
    Str() $attribute,
    Int() $column
  )
    is also<attribute-connect>
  {
    my gint $c = self.RESOLVE-INT($column);
    gtk_cell_area_attribute_connect($!ca, $renderer, $attribute, $c);
  }

  method attribute_disconnect (
    GtkCellRenderer() $renderer,
    Str() $attribute
  )
    is also<attribute-disconnect>
  {
    gtk_cell_area_attribute_disconnect($!ca, $renderer, $attribute);
  }

  method attribute_get_column (
    GtkCellRenderer() $renderer,
    Str() $attribute
  )
    is also<attribute-get-column>
  {
    gtk_cell_area_attribute_get_column($!ca, $renderer, $attribute);
  }

  method cell_get (
    GtkCellArea() $area,
    GtkCellRenderer() $renderer,
    Str() $name,
    GValue() $value
  )
    is also<cell-get>
  {
    gtk_cell_area_cell_get($area, $renderer, $name, $value, Str);
  }

  method cell_set (
    GtkCellArea() $area,
    GtkCellRenderer() $renderer,
    Str() $name,
    GValue() $value
  )
    is also<cell-set>
  {
    gtk_cell_area_cell_set($area, $renderer, $name, $value, Str);
  }

  method cell_get_property (
    GtkCellRenderer() $renderer,
    Str() $property_name,
    GValue() $value
  )
    is also<cell-get-property>
  {
    gtk_cell_area_cell_get_property($!ca, $renderer, $property_name, $value);
  }

  # method cell_get_valist (GtkCellRenderer $renderer, gchar $first_property_name, va_list $var_args) {
  #   gtk_cell_area_cell_get_valist($!ca, $renderer, $first_property_name, $var_args);
  # }

  method cell_set_property (
    GtkCellRenderer() $renderer,
    Str() $property_name,
    GValue() $value
  )
    is also<cell-set-property>
  {
    gtk_cell_area_cell_set_property($!ca, $renderer, $property_name, $value);
  }

  # multi method cell_set_valist (GtkCellRenderer $renderer, gchar $first_property_name, va_list $var_args)  {
  #   samewith($renderer, $first_property_name, $var_args);
  # }

  # method class_find_cell_property (gchar $property_name) {
  #   gtk_cell_area_class_find_cell_property($!ca, $property_name);
  # }
  #
  # method class_install_cell_property (guint $property_id, GParamSpec $pspec) {
  #   gtk_cell_area_class_install_cell_property($!ca, $property_id, $pspec);
  # }
  #
  # method class_list_cell_properties (guint $n_properties) {
  #   gtk_cell_area_class_list_cell_properties($!ca, $n_properties);
  # }

  method copy_context (GtkCellAreaContext() $context)
    is also<copy-context>
  {
    gtk_cell_area_copy_context($!ca, $context);
  }

  method create_context
    is also<create-context>
  {
    gtk_cell_area_create_context($!ca);
  }

  multi method event (
    GtkCellAreaContext() $context,
    GtkWidget() $widget,
    GdkEvent $event,
    GdkRectangle $cell_area,
    Int() $flags                # GtkCellRendererState $flags
  ) {
    my guint $f = self.RESOLVE-UINT($flags);
    gtk_cell_area_event($!ca, $context, $widget, $event, $cell_area, $f);
  }

  multi method focus (
    Int() $direction            # GtkDirectionType $direction)
  ) {
    my guint $d = self.RESOLVE-UINT($direction);
    gtk_cell_area_focus($!ca, $d);
  }

  method foreach (GtkCellCallback $callback, gpointer $callback_data) {
    gtk_cell_area_foreach($!ca, $callback, $callback_data);
  }

  method foreach_alloc (
    GtkCellAreaContext() $context,
    GtkWidget() $widget,
    GdkRectangle $cell_area,
    GdkRectangle $background_area,
    GtkCellAllocCallback $callback,
    gpointer $callback_data
  )
    is also<foreach-alloc>
  {
    gtk_cell_area_foreach_alloc(
      $!ca,
      $context,
      $widget,
      $cell_area,
      $background_area,
      $callback,
      $callback_data
    );
  }

  method get_cell_allocation (
    GtkCellAreaContext() $context,
    GtkWidget() $widget,
    GtkCellRenderer() $renderer,
    GdkRectangle $cell_area,
    GdkRectangle $allocation
  )
    is also<get-cell-allocation>
  {
    gtk_cell_area_get_cell_allocation(
      $!ca,
      $context,
      $widget,
      $renderer,
      $cell_area,
      $allocation
    );
  }

  method get_cell_at_position (
    GtkCellAreaContext() $context,
    GtkWidget() $widget,
    GdkRectangle $cell_area,
    Int() $x,
    Int() $y,
    GdkRectangle $alloc_area
  )
    is also<get-cell-at-position>
  {
    my @i = ($x, $y);
    my gint ($xx, $yy) = self.RESOLVE-UINT(@i);
    gtk_cell_area_get_cell_at_position(
      $!ca,
      $context,
      $widget,
      $cell_area,
      $xx,
      $yy,
      $alloc_area
    );
  }

  method get_current_path_string is also<get-current-path-string> {
    gtk_cell_area_get_current_path_string($!ca);
  }

  method get_edit_widget is also<get-edit-widget> {
    gtk_cell_area_get_edit_widget($!ca);
  }

  method get_edited_cell is also<get-edited-cell> {
    gtk_cell_area_get_edited_cell($!ca);
  }

  method get_focus_from_sibling (GtkCellRenderer() $renderer)
    is also<get-focus-from-sibling>
  {
    gtk_cell_area_get_focus_from_sibling($!ca, $renderer);
  }

  method get_focus_siblings (GtkCellRenderer() $renderer)
    is also<get-focus-siblings>
  {
    gtk_cell_area_get_focus_siblings($!ca, $renderer);
  }

  method get_preferred_height (
    GtkCellAreaContext() $context,
    GtkWidget() $widget,
    Int() $minimum_height,
    Int() $natural_height
  )
    is also<get-preferred-height>
  {
    my @i = ($minimum_height, $natural_height);
    my ($mh, $nh) = self.RESOLVE-INT(@i);
    gtk_cell_area_get_preferred_height($!ca, $context, $widget, $mh, $nh);
  }

  method get_preferred_height_for_width (
    GtkCellAreaContext() $context,
    GtkWidget() $widget,
    Int() $width,
    Int() $minimum_height,
    Int() $natural_height
  )
    is also<get-preferred-height-for-width>
  {
    my @i = ($width, $minimum_height, $natural_height);
    my ($w, $mh, $nh) = self.RESOLVE-INT(@i);
    gtk_cell_area_get_preferred_height_for_width(
      $!ca,
      $context,
      $widget,
      $w,
      $mh,
      $nh
    );
  }

  multi method get_preferred_width (
    GtkCellAreaContext() $context,
    GtkWidget() $widget,
    Int() $minimum_width,
    Int() $natural_width
  )
    is also<get-preferred-width>
  {
    my @i = ($minimum_width, $natural_width);
    my ($mw, $nw) = self.RESOLVE-INT(@i);
    gtk_cell_area_get_preferred_width($!ca, $context, $widget, $mw, $nw);
  }

  multi method get_preferred_width_for_height (
    GtkCellAreaContext() $context,
    GtkWidget() $widget,
    Int() $height,
    Int() $minimum_width,
    Int() $natural_width
  )
    is also<get-preferred-width-for-height>
  {
    my @i = ($height, $minimum_width, $natural_width);
    my ($h, $mw, $nw) = self.RESOLVE-INT(@i);
    gtk_cell_area_get_preferred_width_for_height(
      $!ca,
      $context,
      $widget,
      $h,
      $mw,
      $nw
    );
  }

  method get_request_mode is also<get-request-mode> {
    gtk_cell_area_get_request_mode($!ca);
  }

  method get_type is also<get-type> {
    gtk_cell_area_get_type();
  }

  method has_renderer (GtkCellRenderer() $renderer)
    is also<has-renderer>
  {
    gtk_cell_area_has_renderer($!ca, $renderer);
  }

  method inner_cell_area (
    GtkWidget() $widget,
    GdkRectangle $cell_area,
    GdkRectangle $inner_area
  )
    is also<inner-cell-area>
  {
    gtk_cell_area_inner_cell_area($!ca, $widget, $cell_area, $inner_area);
  }

  method is_activatable is also<is-activatable> {
    gtk_cell_area_is_activatable($!ca);
  }

  method is_focus_sibling (
    GtkCellRenderer() $renderer,
    GtkCellRenderer() $sibling
  )
    is also<is-focus-sibling>
  {
    gtk_cell_area_is_focus_sibling($!ca, $renderer, $sibling);
  }

  method remove (GtkCellRenderer() $renderer) {
    gtk_cell_area_remove($!ca, $renderer);
  }

  method remove_focus_sibling (
    GtkCellRenderer() $renderer,
    GtkCellRenderer() $sibling
  )
    is also<remove-focus-sibling>
  {
    gtk_cell_area_remove_focus_sibling($!ca, $renderer, $sibling);
  }

  method render (
    GtkCellAreaContext() $context,
    GtkWidget() $widget,
    cairo_t $cr,
    GdkRectangle $background_area,
    GdkRectangle $cell_area,
    Int() $flags,              # GtkCellRendererState $flags,
    Int() $paint_focus
  ) {
    my gboolean $pf = self.RESOLVE-BOOL($paint_focus);
    my guint $f = self.RESOLVE-UINT($flags);
    gtk_cell_area_render(
      $!ca,
      $context,
      $widget,
      $cr,
      $background_area,
      $cell_area,
      $f,
      $pf
    );
  }

  method request_renderer (
    GtkCellRenderer() $renderer,
    Int() $orientation,         # GtkOrientation $orientation,
    GtkWidget() $widget,
    Int() $for_size,
    Int() $minimum_size,
    Int() $natural_size
  )
    is also<request-renderer>
  {
    my guint $o = self.RESOLVE-UINT($orientation);
    my @i = ($for_size, $minimum_size, $natural_size);
    my gint ($fs, $ms, $ns) = self.RESOLVE-INT(@i);
    gtk_cell_area_request_renderer(
      $!ca,
      $renderer,
      $o,
      $widget,
      $fs,
      $ms,
      $ns
    );
  }

  method stop_editing (Int() $canceled) is also<stop-editing> {
    my gboolean $c = self.RESOLVE-BOOL($canceled);
    gtk_cell_area_stop_editing($!ca, $c);
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
