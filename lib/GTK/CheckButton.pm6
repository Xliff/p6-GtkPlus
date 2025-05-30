use v6.c;

use Method::Also;

use GTK::Raw::CheckButton:ver<3.0.1146>;
use GTK::Raw::Types:ver<3.0.1146>;

use GTK::ToggleButton:ver<3.0.1146>;

our subset CheckButtonAncestry is export
  where GtkCheckButton | ToggleButtonAncestry;

class GTK::CheckButton:ver<3.0.1146> is GTK::ToggleButton {
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

  method GTK::Raw::Definitions::GtkCheckButton
    is also<
      CheckButton
      GtkCheckButton
    >
  { $!cb }

  method setCheckButton(CheckButtonAncestry $checkbutton) {
    my $to-parent;
    $!cb = do given $checkbutton {
      when GtkCheckButton {
        $to-parent = cast(GtkToggleButton, $_);
        $_;
      }
      default {
        $to-parent = $_;
        cast(GtkCheckButton, $checkbutton);
      }
    };
    self.setToggleButton($to-parent);
  }

  multi method new (CheckButtonAncestry $checkbutton, :$ref = True) {
    my $o = self.bless(:$checkbutton);
    $o.ref if $ref;
    $o;
  }
  multi method new {
    my $checkbutton = gtk_check_button_new();

    $checkbutton ?? self.bless(:$checkbutton) !! Nil;
  }

  method new_with_label (Str() $label) is also<new-with-label> {
    my $checkbutton = gtk_check_button_new_with_label($label);

    $checkbutton ?? self.bless(:$checkbutton) !! Nil;
  }

  method new_with_mnemonic (Str() $label) is also<new-with-mnemonic> {
    my $checkbutton = gtk_check_button_new_with_mnemonic($label);

    $checkbutton ?? self.bless(:$checkbutton) !! Nil;
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
