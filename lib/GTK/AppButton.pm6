use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::AppButton;
use GTK::Raw::Types;

use GTK::ComboBox;

use GTK::Roles::AppChooser;
use GTK::Roles::Signals::Generic;

my subset Ancestry where GtkAppChooserButton | GtkAppChooser | GtkWidget;

class GTK::AppButton is GTK::ComboBox {
  also does GTK::Roles::AppChooser;
  also does GTK::Roles::Signals::Generic;

  has GtkAppChooserButton $!acb;

  method bless(*%attrinit) {
    my $o = self.CREATE.BUILDALL(Empty, %attrinit);
    $o.setType('GTK::AppButton');
    $o;
  }

  submethod BUILD(:$appbutton) {
    my $to-parent;
    given $appbutton {
      when Ancestry {
        $!acb = {
          when GtkAppChooserButton {
            $to-parent = nativecast(GtkComboBox, $_);
            $_;
          }
          when GtkAppChooser {
            $!ac = $_;
            $to-parent = nativecast(GtkComboBox, $_);
            nativecast(GtkAppChooserButton, $_);
          }
          when GtkWidget {
            $to-parent = $_;
            nativecast(GtkAppChooserButton, $_);
          }
        }
        self.setComboBox($to-parent);
      }
      when GTK::AppButton {
      }
      default {
      }
    }
    # For GTK::Roles::AppChooser
    $!ac //= nativecast(GtkAppChooser, $!acb);
  }

  submethod DESTROY {
    self.disconnect-all(%!signals-generic);
  }

  multi method new(Str $content-type) {
    my $appbutton = gtk_app_chooser_button_new($content-type);
    self.bless(:$appbutton);
  }
  multi method new (Ancestry $appbutton) {
    self.bless(:$appbutton);
  }

  # ↓↓↓↓ SIGNALS ↓↓↓↓

  # Is originally:
  # GtkAppChooserButton, gchar, gpointer --> void
  method custom-item-activated {
    self.connect-string($!acb, 'custom-item-activated');
  }

  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  method heading is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_app_chooser_button_get_heading($!acb);
      },
      STORE => sub ($, Str() $heading is copy) {
        gtk_app_chooser_button_set_heading($!acb, $heading);
      }
    );
  }

  method show_default_item is rw {
    Proxy.new(
      FETCH => sub ($) {
        so gtk_app_chooser_button_get_show_default_item($!acb);
      },
      STORE => sub ($, Int() $setting is copy) {
        my gboolean $s = self.RESOLVE-BOOL($setting);
        gtk_app_chooser_button_set_show_default_item($!acb, $s);
      }
    );
  }

  method show_dialog_item is rw {
    Proxy.new(
      FETCH => sub ($) {
        so gtk_app_chooser_button_get_show_dialog_item($!acb);
      },
      STORE => sub ($, Int() $setting is copy) {
        my gboolean $s = self.RESOLVE-BOOL($setting);
        gtk_app_chooser_button_set_show_dialog_item($!acb, $s);
      }
    );
  }
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  method append_custom_item (Str() $name, Str() $label, GIcon $icon) {
    gtk_app_chooser_button_append_custom_item(
      $!acb, $name, $label, $icon
    );
  }

  method append_separator {
    gtk_app_chooser_button_append_separator($!acb);
  }

  method get_type {
    gtk_app_chooser_button_get_type();
  }

  method set_active_custom_item (Str() $name) {
    gtk_app_chooser_button_set_active_custom_item($!acb, $name);
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
