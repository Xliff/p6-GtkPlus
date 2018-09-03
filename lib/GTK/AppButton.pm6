use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::AppButton;
use GTK::Raw::Types;

use GTK::ComboBox;

class GTK::AppButton is GTK::ComboBox {
  has GtkAppChooserButton $!acb;

  submethod BUILD(:$appbutton) {
    given $appbutton {
      when GtkAppChooserButton | GtkWidget {
        $!acb = {
          when GtkAppChooserButton { $appbutton; }
          when GtkWidget           { nativecast(GtkAppChooserButton, $appbutton); }
        }
        self.setComboBox($appbutton);
      }
      when GTK::AppButton {
      }
      default {
      }
    }
  }

  method new {
    my $appbutton = gtk_app_chooser_button_new();
    self.bless(:$appbutton);
  }


  # ↓↓↓↓ SIGNALS ↓↓↓↓

  # Is originally:
  # GtkAppChooserButton, gchar, gpointer --> void
  method custom-item-activated {
    self.connect($!acb, 'custom-item-activated');
  }

  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  method heading is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_app_chooser_button_get_heading($!acb);
      },
      STORE => sub ($, $heading is copy) {
        gtk_app_chooser_button_set_heading($!acb, $heading);
      }
    );
  }

  method show_default_item is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_app_chooser_button_get_show_default_item($!acb);
      },
      STORE => sub ($, $setting is copy) {
        gtk_app_chooser_button_set_show_default_item($!acb, $setting);
      }
    );
  }

  method show_dialog_item is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_app_chooser_button_get_show_dialog_item($!acb);
      },
      STORE => sub ($, $setting is copy) {
        gtk_app_chooser_button_set_show_dialog_item($!acb, $setting);
      }
    );
  }
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  method append_custom_item (gchar $name, gchar $label, GIcon $icon) {
    gtk_app_chooser_button_append_custom_item($!acb, $name, $label, $icon);
  }

  method append_separator {
    gtk_app_chooser_button_append_separator($!acb);
  }

  method get_type {
    gtk_app_chooser_button_get_type();
  }

  method set_active_custom_item (gchar $name) {
    gtk_app_chooser_button_set_active_custom_item($!acb, $name);
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
