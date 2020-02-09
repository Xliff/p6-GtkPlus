use v6.c;

use Method::Also;

use GTK::Raw::ComboBox;
use GTK::Raw::Types;

use GLib::Value;
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
    $o.setType($o.^name);
    $o;
  }

  submethod BUILD(:$combobox) {
    given $combobox {
      when ComboBoxAncestry { self.setComboBox($combobox) }
      when GTK::ComboBox    { }
      default               { }
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
        $to-parent = cast(GtkBin, $_);
        $_;
      }

      when GtkCellEditable {
        $!ce = $_;                                # GTK::Roles::CellEditable
        $to-parent = cast(GtkBin, $_);
        cast(GtkComboBox, $_);
      }

      when GtkCellLayout {
        $!cl = $_;                                # GTK::Roles::CellLayout
        $to-parent = cast(GtkBin, $_);
        cast(GtkComboBox, $_);
      }
      default {
        $to-parent = $_;
        cast(GtkComboBox, $_);
      }
    }
    $!cl //= cast(GtkCellLayout, $!cb);     # GTK::Roles::CellLayout
    $!ce //= cast(GtkCellEditable, $!cb);   # GTK::Roles::CellEditable
    self.setBin($to-parent);
  }

  multi method new (ComboBoxAncestry $combobox, :$ref = True) {
    return Nil unless $combobox;

    my $o = self.bless(:$combobox);
    $o.ref if $ref;
    $o;
  }
  multi method new {
    my $combobox = gtk_combo_box_new();

    $combobox ?? self.bless(:$combobox) !! Nil;
  }

  method new_with_area(GtkCellArea() $area) is also<new-with-area> {
    my $combobox = gtk_combo_box_new_with_area($area);

    $combobox ?? self.bless(:$combobox) !! Nil;
  }

  method new_with_area_and_entry(GtkCellArea() $area)
    is also<new-with-area-and-entry>
  {
    my $combobox = gtk_combo_box_new_with_area_and_entry($area);

    $combobox ?? self.bless(:$combobox) !! Nil;
  }

  method new_with_entry is also<new-with-entry> {
    my $combobox = gtk_combo_box_new_with_entry();

    $combobox ?? self.bless(:$combobox) !! Nil;
  }

  method new_with_model (GtkTreeModel() $model) is also<new-with-model> {
    my $combobox = gtk_combo_box_new_with_model($model);

    $combobox ?? self.bless(:$combobox) !! Nil;
  }

  method new_with_model_and_entry(GtkTreeModel() $model)
    is also<new-with-model-and-entry>
  {
    my $combobox = gtk_combo_box_new_with_model_and_entry($model);

    $combobox ?? self.bless(:$combobox) !! Nil;
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
    my GLib::Value $gv .= new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => -> $ {
        $gv = GLib::Value.new(
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
     my GLib::Value $gv .= new( G_TYPE_BOOLEAN );
     Proxy.new(
       FETCH => -> $ {
         $gv = GLib::Value.new(
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
        my gint $i = $index;

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
        my gboolean $a = $add_tearoffs.so.Int;

        gtk_combo_box_set_add_tearoffs($!cb, $a);
      }
    );
  }

  method button_sensitivity is rw is also<button-sensitivity> {
    Proxy.new(
      FETCH => sub ($) {
        GtkSensitivityTypeEnum( gtk_combo_box_get_button_sensitivity($!cb) );
      },
      STORE => sub ($, Int() $sensitivity is copy) {
        my guint $s = $sensitivity;

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
        my gint $c = $column_span;

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
        my gint $t = $text_column;

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
        my gboolean $f = $focus_on_click.so.Int;

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
        my gint $i = $id_column;

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
        my gboolean $f = $fixed.so.Int;

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
        my gint $r = $row_span;

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
    my GLib::Value $gv .= new( G_TYPE_STRING );
    Proxy.new(
      FETCH => -> $ {
        $gv = GLib::Value.new(
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
        my gint $w = $width;
        gtk_combo_box_set_wrap_width($!cb, $w);
      }
    );
  }
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  proto method get_active_iter (|)
    is also<get-active-iter>
  { * }

  multi method get_active_iter (:$raw = False)
    is also<
      active_iter
      active-iter
    >
  {
    my $iter = GtkTreeIter.new;

    my @r = samewith($iter, :all, :$raw);

    @r[0] ?? @r[1] !! Nil;
  }
  multi method get_active_iter ($iter is rw, :$all = False, :$raw = False) {
    my $rv = so gtk_combo_box_get_active_iter($!cb, $iter);

    return Nil unless $rv;

    $iter = GTK::TreeIter.new($iter) unless $raw;

    $all.not ?? $rv !! ($rv, $iter);
  }

  method get_has_entry
    is also<
      get-has-entry
      has_entry
      has-entry
    >
  {
    so gtk_combo_box_get_has_entry($!cb);
  }

  method get_popup_accessible
    is also<
      get-popup-accessible
      popup_accessible
      popup-accessible
    >
  {
    so gtk_combo_box_get_popup_accessible($!cb);
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
