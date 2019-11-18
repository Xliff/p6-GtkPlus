use v6.c;

use Method::Also;
use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::CheckButton;
use GTK::Raw::Types;

use GTK::ToggleButton;

our subset CheckButtonAncestry is export 
  where GtkCheckButton | ToggleButtonAncestry;

class GTK::CheckButton is GTK::ToggleButton {
  has GtkCheckButton $!cb is implementor;

  method bless(*%attrinit) {
    my $o = self.CREATE.BUILDALL(Empty, %attrinit);
    $o.setType($o.^name);
    $o;
  }

  submethod BUILD(:$checkbutton) {
    given $checkbutton {
      when CheckButtonAncestry {
        self.setCheckButton($checkbutton);
      }
      when GTK::CheckButton {
      }
      default {
      }
    }
  }
  
  method GTK::Raw::Types::GtkCheckButton is also<CheckButton> { $!cb }

  method setCheckButton(CheckButtonAncestry $checkbutton) {
    self.IS-PROTECTED;
    
    my $to-parent;
    $!cb = do given $checkbutton {
      when GtkCheckButton {
        $to-parent = nativecast(GtkToggleButton, $_);
        $_;
      }
      default {
        $to-parent = $_;
        nativecast(GtkCheckButton, $checkbutton);
      }
    };
    self.setToggleButton($to-parent);
  }

  multi method new (CheckButtonAncestry $checkbutton) {
    my $o = self.bless(:$checkbutton);
    $o.upref;
    $o;
  }
  multi method new {
    my $checkbutton = gtk_check_button_new();
    self.bless(:$checkbutton);
  }

  method new_with_label (Str() $label) is also<new-with-label> {
    my $checkbutton = gtk_check_button_new_with_label($label);
    self.bless(:$checkbutton);
  }

  method new_with_mnemonic (Str() $label) is also<new-with-mnemonic> {
    my $checkbutton = gtk_check_button_new_with_mnemonic($label);
    self.bless(:$checkbutton);
  }

  # ↓↓↓↓ SIGNALS ↓↓↓↓
  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  method get_type is also<get-type> {
    state ($n, $t);
    GTK::Widget.unstable_get_type( &gtk_check_button_get_type, $n, $t );
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
