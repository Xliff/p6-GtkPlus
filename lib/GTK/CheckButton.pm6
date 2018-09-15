use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::CheckButton;
use GTK::Raw::Types;

use GTK::ToggleButton;

class GTK::CheckButton is GTK::ToggleButton {
  has GtkCheckButton $!cb;

  submethod BUILD(:$checkbutton) {
    my $to-parent;
    given $button {
      when GtkCheckButton | GtkWidget {
        $!cb = do {
          when GtkWidget {
            $to-parent = $_;
            nativecast(GtkCheckButton, $checkbutton);
          }
          when GtkCheckButton {
            $to-parent = nativecast(GtkToggleButton, $_);
            $checkbutton;
          }
        };
        self.setToggleButton($to-parent);
      }
      when GTK::CheckButton {
      }
      default {
      }
    }
    self.setType('GTK::CheckButton');
  }

  method new () {
    my $checkbutton = gtk_check_button_new();
    self.bless(:$checkbutton);
  }

  method new_with_label (Str $label) {
    my $checkbutton = gtk_check_button_new_with_label($label);
    self.bless(:$checkbutton);
  }

  method new_with_mnemonic (Str $label) {
    my $checkbutton = gtk_check_button_new_with_mnemonic($label);
    self.bless(:$checkbutton);
  }

  # ↓↓↓↓ SIGNALS ↓↓↓↓
  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  method get_type {
    gtk_check_button_get_type();
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
