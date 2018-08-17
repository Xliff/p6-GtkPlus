use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::ToggleButton;
use GTK::Raw::Types;

use GTK::Button;

class GTK:: is GTK::Button {
  has Gtk $!tb;

  submethod BUILD(:$button) {
    given $button {
      when GtkToggleButton | GtkWidget {
        $!tb = nativecast(GtkToggleButton, $button);
        self.setButton($button);
      }
      when GTK::Button {
      }
      default {
      }
    }
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
  method get_type () {
    gtk_toggle_button_get_type($!tb);
  }

  method new () {
    gtk_toggle_button_new($!tb);
  }

  method new_with_label () {
    gtk_toggle_button_new_with_label($!tb);
  }

  method new_with_mnemonic () {
    gtk_toggle_button_new_with_mnemonic($!tb);
  }

  method toggled () {
    gtk_toggle_button_toggled($!tb);
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
