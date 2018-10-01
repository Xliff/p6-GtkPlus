use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::CheckButton;
use GTK::Raw::Types;

use GTK::ToggleButton;

class GTK::CheckButton is GTK::ToggleButton {
  has GtkCheckButton $!cb;

  method bless(*%attrinit) {
    use nqp;
    my $o = nqp::create(self).BUILDALL(Empty, %attrinit);
    $o.setType('GTK::CheckButton`');
    $o;
  }

  submethod BUILD(:$checkbutton) {
    given $checkbutton {
      when GtkCheckButton | GtkWidget {
        self.setCheckButton($checkbutton);
      }
      when GTK::CheckButton {
      }
      default {
      }
    }
  }

  method setCheckButton($checkbutton) {
    my $to-parent;
    $!cb = do given $checkbutton {
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

  multi method new {
    my $checkbutton = gtk_check_button_new();
    self.bless(:$checkbutton);
  }
  multi method new (GtkWidget $checkbutton) {
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
