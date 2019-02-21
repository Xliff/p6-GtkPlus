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

  has GtkComboBox $!cb;

  method bless(*%attrinit) {
    my $o = self.CREATE.BUILDALL(Empty, %attrinit);s
    $o.setType('GTK::ComboBox');
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
      when BinAncestry {
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
      STORE => sub ($, $index is copy) {
        gtk_combo_box_set_active($!cb, $index);
      }
    );
  }

  method active_id is rw is also<active-id> {
    Proxy.new(
      FETCH => sub ($) {
        gtk_combo_box_get_active_id($!cb);
      },
      STORE => sub ($, $active_id is copy) {
        gtk_combo_box_set_active_id($!cb, $active_id);
      }
    );
  }

  method add_tearoffs is rw is also<add-tearoffs> {
    Proxy.new(
      FETCH => sub ($) {
        gtk_combo_box_get_add_tearoffs($!cb);
      },
      STORE => sub ($, $add_tearoffs is copy) {
        gtk_combo_box_set_add_tearoffs($!cb, $add_tearoffs);
      }
    );
  }

  method button_sensitivity is rw is also<button-sensitivity> {
    Proxy.new(
      FETCH => sub ($) {
        gtk_combo_box_get_button_sensitivity($!cb);
      },
      STORE => sub ($, $sensitivity is copy) {
        gtk_combo_box_set_button_sensitivity($!cb, $sensitivity);
      }
    );
  }

  method column_span_column is rw is also<column-span-column> {
    Proxy.new(
      FETCH => sub ($) {
        gtk_combo_box_get_column_span_column($!cb);
      },
      STORE => sub ($, $column_span is copy) {
        gtk_combo_box_set_column_span_column($!cb, $column_span);
      }
    );
  }

  method entry_text_column is rw is also<entry-text-column> {
    Proxy.new(
      FETCH => sub ($) {
        gtk_combo_box_get_entry_text_column($!cb);
      },
      STORE => sub ($, $text_column is copy) {
        gtk_combo_box_set_entry_text_column($!cb, $text_column);
      }
    );
  }

  method focus_on_click is rw is also<focus-on-click> {
    Proxy.new(
      FETCH => sub ($) {
        gtk_combo_box_get_focus_on_click($!cb);
      },
      STORE => sub ($, $focus_on_click is copy) {
        gtk_combo_box_set_focus_on_click($!cb, $focus_on_click);
      }
    );
  }

  method id_column is rw is also<id-column> {
    Proxy.new(
      FETCH => sub ($) {
        gtk_combo_box_get_id_column($!cb);
      },
      STORE => sub ($, $id_column is copy) {
        gtk_combo_box_set_id_column($!cb, $id_column);
      }
    );
  }

  method model is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_combo_box_get_model($!cb);
      },
      STORE => sub ($, $model is copy) {
        gtk_combo_box_set_model($!cb, $model);
      }
    );
  }

  method popup_fixed_width is rw is also<popup-fixed-width> {
    Proxy.new(
      FETCH => sub ($) {
        gtk_combo_box_get_popup_fixed_width($!cb);
      },
      STORE => sub ($, $fixed is copy) {
        gtk_combo_box_set_popup_fixed_width($!cb, $fixed);
      }
    );
  }

  method row_span_column is rw is also<row-span-column> {
    Proxy.new(
      FETCH => sub ($) {
        gtk_combo_box_get_row_span_column($!cb);
      },
      STORE => sub ($, $row_span is copy) {
        gtk_combo_box_set_row_span_column($!cb, $row_span);
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
      STORE => sub ($, $width is copy) {
        gtk_combo_box_set_wrap_width($!cb, $width);
      }
    );
  }
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  proto method get_active_iter (|)
    is also<get-active-iter>
    { * }

  multi method get_active_iter is also<active_iter active-iter> {
    my GtkTreeIter $iter = GtkTreeIter.new;
    samewith($iter);
    GTK::TreeIter.new($iter);
  }

  multi method get_active_iter (GtkTreeIter() $iter) {
    gtk_combo_box_get_active_iter($!cb, $iter);
  }

  method get_has_entry is also<get-has-entry> {
    gtk_combo_box_get_has_entry($!cb);
  }

  method get_popup_accessible is also<get-popup-accessible> {
    gtk_combo_box_get_popup_accessible($!cb);
  }

  method get_row_separator_func is also<get-row-separator-func> {
    gtk_combo_box_get_row_separator_func($!cb);
  }

  method get_type is also<get-type> {
    gtk_combo_box_get_type();
  }

  method emit-popdown is also<emit_popdown> {
    gtk_combo_box_popdown($!cb);
  }

  method emit-popup is also<emit_popup> {
    gtk_combo_box_popup($!cb);
  }

  method popup_for_device (GdkDevice $device) is also<popup-for-device> {
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
