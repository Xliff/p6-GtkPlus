use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::ToggleButton;
use GTK::Raw::Types;

use GTK::Button;

class GTK::ToggleButton is GTK::Button {
  has Gtk $!tb;

  submethod BUILD(:$togglebutton) {
    given $button {
      when GtkToggleButton | GtkWidget {
        $!tb = do {
          when GtkWidget       { nativecast(GtkToggleButton, $togglebutton); }
          when GtkToggleButton { $togglebutton; }
        };
        self.setButton($togglebutton);
      }
      when GTK::ToggleButton {
      }
      default {
      }
    }
    self.setType('GTK::ToggleButton');
  }

  method new {
    my $togglebutton = gtk_toggle_button_new($!tb);
    self.bless(:$togglebutton);
  }

  method new_with_label (Str $label) {
    my $togglebutton = gtk_toggle_button_new_with_label($label);
    self.bless(:$togglebutton);
  }

  method new_with_mnemonic (Str $label) {
    my $togglebutton = gtk_toggle_button_new_with_mnemonic($label);
    self.bless(:$togglebutton);
  }

  method setToggleButton($togglebutton) {
    $!tb = nativecast(GtkToggleButton, $togglebutton);
    self.setButton($togglebutton);
  }

  # ↓↓↓↓ SIGNALS ↓↓↓↓
  method toggled {
    self.connect($!tb, 'toggled');
  }
  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  method active is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_toggle_button_get_active($!tb);
      },
      STORE => sub ($, $is_active is copy) {
        gtk_toggle_button_set_active($!tb, $is_active);
      }
    );
  }

  method inconsistent is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_toggle_button_get_inconsistent($!tb);
      },
      STORE => sub ($, $setting is copy) {
        gtk_toggle_button_set_inconsistent($!tb, $setting);
      }
    );
  }

  method mode is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_toggle_button_get_mode($!tb);
      },
      STORE => sub ($, $draw_indicator is copy) {
        gtk_toggle_button_set_mode($!tb, $draw_indicator);
      }
    );
  }
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  method get_type {
    gtk_toggle_button_get_type($!tb);
  }

  method toggled {
    gtk_toggle_button_toggled($!tb);
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
