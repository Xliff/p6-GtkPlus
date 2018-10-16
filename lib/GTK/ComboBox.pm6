use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::ComboBox;
use GTK::Raw::Types;

use GTK::Bin;

use GTK::Roles::CellLayout;
use GTK::Roles::Signals::ComboBox;

subset Ancestry where GtkComboBox | GtkCellLayout | GtkWidget;

class GTK::ComboBox is GTK::Bin {
  also does GTK::Roles::CellLayout;
  also does GTK::Roles::Signals::ComboBox;

  has GtkComboBox $!cb;

  method bless(*%attrinit) {
    my $o = self.CREATE.BUILDALL(Empty, %attrinit);
    $o.setType('GTK::ComboBox');
    $o;
  }

  submethod BUILD(:$combobox) {
    given $combobox {
      when Ancestry {
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
      when GtkWidget {
        $to-parent = $_;
        nativecast(GtkComboBox, $_);
      }
      when GtkCellLayout {
        $!cl = $_;                               # GTK::Roles::CellLayout
        $to-parent = nativecast(GtkBin, $_);
        nativecast(GtkComboBox, $_);
      }
      when GtkComboBox  {
        $to-parent = nativecast(GtkBin, $_);
        $_;
      }
    }
    $!cl //= nativecast(GtkCellLayout, $!cb);   # GTK::Roles::CellLayout
    self.setBin($to-parent);
  }

  multi method new {
    my $combobox = gtk_combo_box_new();
    self.bless(:$combobox);
  }
  multi method new (Ancestry $combobox) {
    self.bless(:$combobox);
  }

  method new_with_area(GtkCellArea() $area) {
    my $combobox = gtk_combo_box_new_with_area($area);
    self.bless(:$combobox);
  }

  method new_with_area_and_entry(GtkCellArea() $area) {
    my $combobox = gtk_combo_box_new_with_area_and_entry($area);
    self.bless(:$combobox);
  }

  method new_with_entry {
    my $combobox = gtk_combo_box_new_with_entry();
    self.bless(:$combobox);
  }

  method new_with_model (GtkTreeModel() $model) {
    my $combobox = gtk_combo_box_new_with_model($model);
    self.bless(:$combobox);
  }

  method new_with_model_and_entry(GtkTreeModel() $model) {
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
  method format-entry-text {
    self.connect-format-entry-text($!cb);
  }

  # Is originally:
  # GtkComboBox, GtkScrollType, gpointer --> void
  method move-active {
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

  method active_id is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_combo_box_get_active_id($!cb);
      },
      STORE => sub ($, $active_id is copy) {
        gtk_combo_box_set_active_id($!cb, $active_id);
      }
    );
  }

  method add_tearoffs is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_combo_box_get_add_tearoffs($!cb);
      },
      STORE => sub ($, $add_tearoffs is copy) {
        gtk_combo_box_set_add_tearoffs($!cb, $add_tearoffs);
      }
    );
  }

  method button_sensitivity is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_combo_box_get_button_sensitivity($!cb);
      },
      STORE => sub ($, $sensitivity is copy) {
        gtk_combo_box_set_button_sensitivity($!cb, $sensitivity);
      }
    );
  }

  method column_span_column is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_combo_box_get_column_span_column($!cb);
      },
      STORE => sub ($, $column_span is copy) {
        gtk_combo_box_set_column_span_column($!cb, $column_span);
      }
    );
  }

  method entry_text_column is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_combo_box_get_entry_text_column($!cb);
      },
      STORE => sub ($, $text_column is copy) {
        gtk_combo_box_set_entry_text_column($!cb, $text_column);
      }
    );
  }

  method focus_on_click is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_combo_box_get_focus_on_click($!cb);
      },
      STORE => sub ($, $focus_on_click is copy) {
        gtk_combo_box_set_focus_on_click($!cb, $focus_on_click);
      }
    );
  }

  method id_column is rw {
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

  method popup_fixed_width is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_combo_box_get_popup_fixed_width($!cb);
      },
      STORE => sub ($, $fixed is copy) {
        gtk_combo_box_set_popup_fixed_width($!cb, $fixed);
      }
    );
  }

  method row_span_column is rw {
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

  method wrap_width is rw {
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
  method get_active_iter (GtkTreeIter() $iter) {
    gtk_combo_box_get_active_iter($!cb, $iter);
  }

  method get_has_entry {
    gtk_combo_box_get_has_entry($!cb);
  }

  method get_popup_accessible {
    gtk_combo_box_get_popup_accessible($!cb);
  }

  method get_row_separator_func {
    gtk_combo_box_get_row_separator_func($!cb);
  }

  method get_type {
    gtk_combo_box_get_type();
  }

  method emit-popdown {
    gtk_combo_box_popdown($!cb);
  }

  method emit-popup {
    gtk_combo_box_popup($!cb);
  }

  method popup_for_device (GdkDevice $device) {
    gtk_combo_box_popup_for_device($!cb, $device);
  }

  method set_active_iter (GtkTreeIter() $iter) {
    gtk_combo_box_set_active_iter($!cb, $iter);
  }

  method set_row_separator_func (
    GtkTreeViewRowSeparatorFunc $func,
    gpointer $data = gpointer,
    GDestroyNotify $destroy = GDestroyNotify
  ) {
    gtk_combo_box_set_row_separator_func($!cb, $func, $data, $destroy);
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
