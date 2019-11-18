use v6.c;

use Method::Also;
use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::ComboBox;
use GTK::Raw::Types;

use GTK::Bin;
use GTK::TreeIter;

use GTK::Roles::CellEditable;
use GTK::Roles::CellLayout;
use GTK::Roles::Signals::ComboBox;

our subset ComboBoxAncestry is export 
  where GtkComboBox  | GtkCellEditable | GtkCellLayout | BinAncestry;

class GTK::ComboBox is GTK::Bin {
  also does GTK::Roles::CellEditable;
  also does GTK::Roles::CellLayout;
  also does GTK::Roles::Signals::ComboBox;

  has GtkComboBox $!cb is implementor;

  method bless(*%attrinit) {
    my $o = self.CREATE.BUILDALL(Empty, %attrinit);
    $o.setType(self.^name);
    $o;
  }

  submethod BUILD(:$combobox) {
    given $combobox {
      when ComboBoxAncestry {
        self.setComboBox($combobox);
      }
      when GTK::ComboBox {
      }
      default {
      }
    }
  }

  submethod DESTROY {
    self.disconnect-all(%!signals-cb);
  }

  method setComboBox($combobox) {
    self.IS-PROTECTED; 
    
    my $to-parent;
    $!cb = do given $combobox {
      when GtkComboBox  {
        $to-parent = nativecast(GtkBin, $_);
        $_;
      }
      when GtkCellEditable {
        $!ce = $_;                                # GTK::Roles::CellEditable
        $to-parent = nativecast(GtkBin, $_);
        nativecast(GtkComboBox, $_);
      }
      when GtkCellLayout {
        $!cl = $_;                                # GTK::Roles::CellLayout
        $to-parent = nativecast(GtkBin, $_);
        nativecast(GtkComboBox, $_);
      }
      default {
        $to-parent = $_;
        nativecast(GtkComboBox, $_);
      }
    }
    $!cl //= nativecast(GtkCellLayout, $!cb);     # GTK::Roles::CellLayout
    $!ce //= nativecast(GtkCellEditable, $!cb);   # GTK::Roles::CellEditable
    self.setBin($to-parent);
  }

  multi method new (ComboBoxAncestry $combobox) {
    my $o = self.bless(:$combobox);
    $o.upref;
    $o;
  }
  multi method new {
    my $combobox = gtk_combo_box_new();
    self.bless(:$combobox);
  }

  method new_with_area(GtkCellArea() $area) is also<new-with-area> {
    my $combobox = gtk_combo_box_new_with_area($area);
    self.bless(:$combobox);
  }

  method new_with_area_and_entry(GtkCellArea() $area)
    is also<new-with-area-and-entry>
  {
    my $combobox = gtk_combo_box_new_with_area_and_entry($area);
    self.bless(:$combobox);
  }

  method new_with_entry is also<new-with-entry> {
    my $combobox = gtk_combo_box_new_with_entry();
    self.bless(:$combobox);
  }

  method new_with_model (GtkTreeModel() $model) is also<new-with-model> {
    my $combobox = gtk_combo_box_new_with_model($model);
    self.bless(:$combobox);
  }

  method new_with_model_and_entry(GtkTreeModel() $model)
    is also<new-with-model-and-entry>
  {
    my $combobox = gtk_combo_box_new_with_model_and_entry($model);
    self.bless(:$combobox);
  }

  # ↓↓↓↓ SIGNALS ↓↓↓↓

  # Is originally:
  # GtkComboBox, gpointer --> void
  method changed {
    self.connect($!cb, 'changed');
  }

  # Is originally:
  #
  method format-entry-text is also<format_entry_text> {
    self.connect-format-entry-text($!cb);
  }

  # Is originally:
  # GtkComboBox, GtkScrollType, gpointer --> void
  method move-active is also<move_active> {
    self.connect-move-active($!cb);
  }

  # Is originally:
  # GtkComboBox, gpointer --> gboolean
  method popdown {
    self.connect($!cb, 'popdown');
  }

  # Is originally:
  # GtkComboBox, gpointer --> void
  method popup {
    self.connect($!cb, 'popup');
  }

  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # Type: gboolean
  method has-frame is rw  {
    my GTK::Compat::Value $gv .= new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get('has-frame', $gv)
        );
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('has-frame', $gv);
      }
    );
  }

  # Type: gboolean
   method popup-shown is rw  {
     my GTK::Compat::Value $gv .= new( G_TYPE_BOOLEAN );
     Proxy.new(
       FETCH => -> $ {
         $gv = GTK::Compat::Value.new(
           self.prop_get('popup-shown', $gv)
         );
         $gv.boolean;
       },
       STORE => -> $, Int() $val is copy {
         warn "popup-shown does not allow writing"
       }
     );
   }

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓

  # cw - ATTRIBUTES NEED REFINEMENT!

  method active is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_combo_box_get_active($!cb);
      },
      STORE => sub ($, Int() $index is copy) {
        my gint $i = self.RESOLVE-INT($index);
        gtk_combo_box_set_active($!cb, $i);
      }
    );
  }

  method active_id is rw is also<active-id> {
    Proxy.new(
      FETCH => sub ($) {
        gtk_combo_box_get_active_id($!cb);
      },
      STORE => sub ($, Str() $active_id is copy) {
        gtk_combo_box_set_active_id($!cb, $active_id);
      }
    );
  }

  method add_tearoffs is rw is also<add-tearoffs> {
    Proxy.new(
      FETCH => sub ($) {
        so gtk_combo_box_get_add_tearoffs($!cb);
      },
      STORE => sub ($, Int() $add_tearoffs is copy) {
        my gboolean $a = self.RESOLVE-BOOL($add_tearoffs);
        gtk_combo_box_set_add_tearoffs($!cb, $a);
      }
    );
  }

  method button_sensitivity is rw is also<button-sensitivity> {
    Proxy.new(
      FETCH => sub ($) {
        GtkSensitivityType( gtk_combo_box_get_button_sensitivity($!cb) );
      },
      STORE => sub ($, Int() $sensitivity is copy) {
        my guint $s = self.RESOLVE-UINT($sensitivity);
        gtk_combo_box_set_button_sensitivity($!cb, $s);
      }
    );
  }

  method column_span_column is rw is also<column-span-column> {
    Proxy.new(
      FETCH => sub ($) {
        gtk_combo_box_get_column_span_column($!cb);
      },
      STORE => sub ($, Int() $column_span is copy) {
        my gint $c = self.RESOLVE-INT($column_span);
        gtk_combo_box_set_column_span_column($!cb, $c);
      }
    );
  }

  method entry_text_column is rw is also<entry-text-column> {
    Proxy.new(
      FETCH => sub ($) {
        gtk_combo_box_get_entry_text_column($!cb);
      },
      STORE => sub ($, Int() $text_column is copy) {
        my gint $t = self.RESOLVE-INT($text_column);
        gtk_combo_box_set_entry_text_column($!cb, $t);
      }
    );
  }

  method focus_on_click is rw is also<focus-on-click> {
    Proxy.new(
      FETCH => sub ($) {
        so gtk_combo_box_get_focus_on_click($!cb);
      },
      STORE => sub ($, Int() $focus_on_click is copy) {
        my gboolean $f = self.RESOLVE-BOOL($focus_on_click);
        gtk_combo_box_set_focus_on_click($!cb, $f);
      }
    );
  }

  method id_column is rw is also<id-column> {
    Proxy.new(
      FETCH => sub ($) {
        gtk_combo_box_get_id_column($!cb);
      },
      STORE => sub ($, Int() $id_column is copy) {
        my gint $i = self.RESOLVE-INT($id_column);
        gtk_combo_box_set_id_column($!cb, $i);
      }
    );
  }

  method model is rw {
    Proxy.new(
      FETCH => sub ($) {
        # This needs a placeholder object so that pointers can be properly
        # set. Until that has been designed, leave it as a pointer.
        gtk_combo_box_get_model($!cb);
      },
      STORE => sub ($, GtkTreeModel() $model is copy) {
        gtk_combo_box_set_model($!cb, $model);
      }
    );
  }

  method popup_fixed_width is rw is also<popup-fixed-width> {
    Proxy.new(
      FETCH => sub ($) {
        so gtk_combo_box_get_popup_fixed_width($!cb);
      },
      STORE => sub ($, Int() $fixed is copy) {
        my gboolean $f = self.RESOLVE-BOOL($fixed);
        gtk_combo_box_set_popup_fixed_width($!cb, $f);
      }
    );
  }

  method row_span_column is rw is also<row-span-column> {
    Proxy.new(
      FETCH => sub ($) {
        gtk_combo_box_get_row_span_column($!cb);
      },
      STORE => sub ($, Int() $row_span is copy) {
        my gint $r = self.RESOLVE-INT($row_span);
        gtk_combo_box_set_row_span_column($!cb, $r);
      }
    );
  }

  method title is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_combo_box_get_title($!cb);
      },
      STORE => sub ($, Str() $title is copy) {
        gtk_combo_box_set_title($!cb, $title);
      }
    );
  }

  # Type: gchar
  method tearoff-title is rw  is DEPRECATED {
    my GTK::Compat::Value $gv .= new( G_TYPE_STRING );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get('tearoff-title', $gv)
        );
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('tearoff-title', $gv);
      }
    );
  }

  method wrap_width is rw is also<wrap-width> {
    Proxy.new(
      FETCH => sub ($) {
        gtk_combo_box_get_wrap_width($!cb);
      },
      STORE => sub ($, Int() $width is copy) {
        my gint $w = self.RESOLVE-INT($width);
        gtk_combo_box_set_wrap_width($!cb, $w);
      }
    );
  }
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  proto method get_active_iter (|)
    is also<get-active-iter>
    { * }

  multi method get_active_iter 
    is also<
      active_iter 
      active-iter
    > 
  {
    my GtkTreeIter $iter = GtkTreeIter.new;
    samewith($iter);
    GTK::TreeIter.new($iter);
  }
  multi method get_active_iter (GtkTreeIter() $iter) {
    gtk_combo_box_get_active_iter($!cb, $iter);
  }

  method get_has_entry 
    is also<
      get-has-entry
      has_entry
      has-entry
    > 
  {
    gtk_combo_box_get_has_entry($!cb);
  }

  method get_popup_accessible 
    is also<
      get-popup-accessible
      popup_accessible
      popup-accessible
    > 
  {
    gtk_combo_box_get_popup_accessible($!cb);
  }

  method get_row_separator_func 
    is also<
      get-row-separator-func
      row_separator_func
      row-separator-func
    > 
  {
    gtk_combo_box_get_row_separator_func($!cb);
  }

  method get_type is also<get-type> {
    state ($n, $t);
    GTK::Widget.unstable_get_type( &gtk_combo_box_get_type, $n, $t );
  }

  method emit-popdown is also<emit_popdown> {
    gtk_combo_box_popdown($!cb);
  }

  method emit-popup is also<emit_popup> {
    gtk_combo_box_popup($!cb);
  }

  method popup_for_device (GdkDevice() $device) is also<popup-for-device> {
    gtk_combo_box_popup_for_device($!cb, $device);
  }

  method set_active_iter (GtkTreeIter() $iter) is also<set-active-iter> {
    gtk_combo_box_set_active_iter($!cb, $iter);
  }

  method set_row_separator_func (
    &func,
    gpointer $data = gpointer,
    &destroy = &g_destroy_none
  )
    is also<set-row-separator-func>
  {
    gtk_combo_box_set_row_separator_func($!cb, &func, $data, &destroy);
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
