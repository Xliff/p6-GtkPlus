use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::Label;
use GTK::Raw::Types;

use GTK::Raw::

use GTK::;

class GTK:: is GTK:: {
  has GtkRadioButton $!rb;

  submethod BUILD(:$radiobutton) {
    given $radiobutton {
      when GtkRadioButton | GtkWidget {
        $!rb = nativecast(GtkRadioButton, $radiobutton);
        self.setCheckButton($radiobutton);
      }
      when GTK::RadioButton {
      }
      default {
      }
    }
  }

  method new {
    my $radiobutton = gtk_radio_button_new();
    self.bless(:$radiobutton);
  }

  multi method new_from_widget (GtkRadioButton $rgm) {
    my $radiobutton = gtk_radio_button_new_from_widget($rgm.radiobutton);
    self.bless(:$radiobutton);
  }
  multi method new_from_widget (GTK::RadioButton $rgm) {
    samewith($rgm);
  }

  method new_with_label (gchar $label) {
    my $radiobutton = gtk_radio_button_new_with_label($label);
    self.bless(:$radiobutton);
  }

  method new_with_label_from_widget (gchar $label) {
    my $radiobutton = gtk_radio_button_new_with_label_from_widget($label);
    self.bless(:$radiobutton);
  }

  method new_with_mnemonic (gchar $label) {
    my $radiobutton = gtk_radio_button_new_with_mnemonic($label);
    self.bless(:$radiobutton);
  }

  method new_with_mnemonic_from_widget (gchar $label) {
    my $radiobutton = gtk_radio_button_new_with_mnemonic_from_widget($label);
    self.bless(:$radiobutton);
  }

  method radiobutton {
    $!rb;
  }

  # ↓↓↓↓ SIGNALS ↓↓↓↓
  method group-changed {
    self.connect($!rb, 'group-changed');
  }
  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  method group is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_radio_button_get_group($!rb);
      },
      STORE => sub ($, $group is copy) {
        gtk_radio_button_set_group($!rb, $group);
      }
    );
  }
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  method get_type {
    gtk_radio_button_get_type();
  }

  multi method join_group (GtkRadioButton $group_source) {
    gtk_radio_button_join_group($!rb, $group_source);
  }
  multi method join_group (Gtk::RadioButton $group_source)  {
    samewith($group_source.radiobutton);
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
