use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::RadioButton;
use GTK::Raw::Types;

use GTK::CheckButton;

class GTK::RadioButton is GTK::CheckButton {
  has GtkRadioButton $!rb;

  method bless(*%attrinit) {
    use nqp;
    my $o = nqp::create(self).BUILDALL(Empty, %attrinit);
    $o.setType('GTK::RadioButton');
    $o;
  }

  submethod BUILD(:$radiobutton) {
    my $to-parent;
    given $radiobutton {
      when GtkRadioButton | GtkWidget {
        $!rb = do {
          when GtkWidget {
            $to-parent = $_;
            nativecast(GtkRadioButton, $_);
          }
          when GtkRadioButton {
            $to-parent = nativecast(GtkCheckButton, $_);
            $_;
          }
        };
        self.setCheckButton($radiobutton);
      }
      when GTK::RadioButton {
      }
      default {
      }
    }
  }

  multi method new {
    my $radiobutton = gtk_radio_button_new();
    self.bless(:$radiobutton);
  }
  multi method new (GtkWidget $radiobutton) {
    self.bless(:$radiobutton);
  }

  method GTK::Raw::Types::GtkRadioButton {
    $!rb;
  }

  method new_from_widget (GtkRadioButton() $rgm) {
    my $radiobutton = gtk_radio_button_new_from_widget($rgm);
    self.bless(:$radiobutton);
  }

  method new_with_label (Str() $label) {
    my $radiobutton = gtk_radio_button_new_with_label($label);
    self.bless(:$radiobutton);
  }

  method new_with_label_from_widget (Str() $label) {
    my $radiobutton = gtk_radio_button_new_with_label_from_widget($label);
    self.bless(:$radiobutton);
  }

  method new_with_mnemonic (Str() $label) {
    my $radiobutton = gtk_radio_button_new_with_mnemonic($label);
    self.bless(:$radiobutton);
  }

  method new_with_mnemonic_from_widget (Str() $label) {
    my $radiobutton = gtk_radio_button_new_with_mnemonic_from_widget($label);
    self.bless(:$radiobutton);
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
        GSList.new( gtk_radio_button_get_group($!rb) );
      },
      STORE => sub ($, GSList() $group is copy) {
        gtk_radio_button_set_group($!rb, $group);
      }
    );
  }
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  method get_type {
    gtk_radio_button_get_type();
  }

  method join_group (GtkRadioButton() $group_source) {
    gtk_radio_button_join_group($!rb, $group_source);
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
