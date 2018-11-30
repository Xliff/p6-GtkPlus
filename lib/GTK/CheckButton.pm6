use v6.c;

use Method::Also;
use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::CheckButton;
use GTK::Raw::Types;

use GTK::ToggleButton;

my subset Ancestry
  where GtkCheckButton | GtkToggleButton | GtkButton  | GtkActionable |
        GtkBin         | GtkContainer    | GtkBuilder | GtkWidget;

class GTK::CheckButton is GTK::ToggleButton {
  has GtkCheckButton $!cb;

  method bless(*%attrinit) {
    my $o = self.CREATE.BUILDALL(Empty, %attrinit);
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
      when Ancestry {
        when GtkCheckButton {
          $to-parent = nativecast(GtkToggleButton, $_);
          $_;
        }
        default {
          $to-parent = $_;
          nativecast(GtkCheckButton, $checkbutton);
        }
      }
    };
    self.setToggleButton($to-parent);
  }

  multi method new (Ancestry $checkbutton) {
    my $o = self.bless(:$checkbutton);
    $o.upref;
    $o;
  }
  multi method new {
    my $checkbutton = gtk_check_button_new();
    self.bless(:$checkbutton);
  }

  method new_with_label (Str $label) is also<new-with-label> {
    my $checkbutton = gtk_check_button_new_with_label($label);
    self.bless(:$checkbutton);
  }

  method new_with_mnemonic (Str $label) is also<new-with-mnemonic> {
    my $checkbutton = gtk_check_button_new_with_mnemonic($label);
    self.bless(:$checkbutton);
  }

  # ↓↓↓↓ SIGNALS ↓↓↓↓
  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  method get_type is also<get-type> {
    gtk_check_button_get_type();
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
