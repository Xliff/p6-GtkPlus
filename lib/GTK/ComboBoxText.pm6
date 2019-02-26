use v6.c;

use Method::Also;
use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::ComboBoxText;
use GTK::Raw::Types;

use GTK::ComboBox;

our subset ComboBoxTextAncestry is export 
  where GtkComboBoxText | ComboBoxAncestry;

class GTK::ComboBoxText is GTK::ComboBox {
  has GtkComboBoxText $!cbt;

  method bless(*%attrinit) {
    my $o = self.CREATE.BUILDALL(Empty, %attrinit);
    $o.setType('GTK::ComboBoxText');
    $o;
  }

  submethod BUILD(:$combobox) {
    given $combobox {
      when ComboBoxTextAncestry {
        self.setComboBoxText($combobox);
      }
      when GTK::ComboBoxText {
      }
      default {
      }
    }
  }
  
  method setComboBoxText(ComboBoxTextAncestry $combobox) {
    my $to-parent;
    #self.IS-PROTECTED;
    $!cbt = do {
      when GtkComboBoxText {
        $to-parent = nativecast(GtkComboBox, $_);
        $_;
      }
      when ComboBoxAncestry {
        $to-parent = $_;
        nativecast(GtkComboBoxText, $_);
      }
    }
    self.setComboBox($to-parent);
  }

  multi method new(ComboBoxTextAncestry $combobox) {
    my $o = self.bless(:$combobox);
    $o.upref;
    $o;
  }
  multi method new(:$entry) {
    my $combobox = $entry ??
      gtk_combo_box_text_new_with_entry() !! gtk_combo_box_text_new();
    self.bless(:$combobox);
  }
  multi method new(@list, :$entry) {
    my $o = samewith(:$entry);
    $o.append_text(~$_) for @list;
    $o;
  }

  method new_with_entry is also<new-with-entry> {
    my $combobox = gtk_combo_box_text_new_with_entry();
    self.bless($combobox);
  }

  # ↓↓↓↓ SIGNALS ↓↓↓↓
  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  method append (Str() $id, Str() $text) {
    gtk_combo_box_text_append($!cbt, $id, $text);
  }

  method append_text (Str() $text) is also<append-text> {
    gtk_combo_box_text_append_text($!cbt, $text);
  }

  method get_active_text is also<get-active-text> {
    gtk_combo_box_text_get_active_text($!cbt);
  }

  method get_type is also<get-type> {
    state ($n, $t);
    GTK::Widget.unstable_get_type(  &gtk_combo_box_text_get_type, $n, $t );
  }

  method insert (Int() $position, Str() $id, Str() $text) {
    my gint $p = self.RESOLVE-INT($position);
    gtk_combo_box_text_insert($!cbt, $p, $id, $text);
  }

  method insert_text (Int() $position, Str() $text) is also<insert-text> {
    my gint $p = self.RESOLVE-INT($position);
    gtk_combo_box_text_insert_text($!cbt, $p, $text);
  }

  method prepend (Str() $id, Str() $text) {
    gtk_combo_box_text_prepend($!cbt, $id, $text);
  }

  method prepend_text (Str() $text) is also<prepend-text> {
    gtk_combo_box_text_prepend_text($!cbt, $text);
  }

  method remove (Int() $position) {
    my gint $p = self.RESOLVE-INT($position);
    gtk_combo_box_text_remove($!cbt, $p);
  }

  method remove_all is also<remove-all> {
    gtk_combo_box_text_remove_all($!cbt);
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
