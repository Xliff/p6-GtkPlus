use v6.c;

use Method::Also;

use GTK::Raw::ToggleButton:ver<3.0.1146>;
use GTK::Raw::Types:ver<3.0.1146>;

use GTK::Button:ver<3.0.1146>;

our subset ToggleButtonAncestry is export
  where GtkToggleButton | ButtonAncestry;

class GTK::ToggleButton:ver<3.0.1146> is GTK::Button {
  has GtkToggleButton $!tb is implementor;

  submethod BUILD(:$togglebutton) {
    do given $togglebutton {
      when ToggleButtonAncestry { self.setToggleButton($togglebutton) }
      when GTK::ToggleButton    { }
      default                   { }
    }
  }

  method GTK::Raw::Definitions::GtkToggleButton
    is also<
      ToggleButton
      GtkToggleButton
    >
  { $!tb }

  method setToggleButton(ToggleButtonAncestry $togglebutton) {
    my $to-parent;
    $!tb = do given $togglebutton {
      when GtkToggleButton {
        $to-parent = cast(GtkButton, $_);
        $_;
      }
      when ButtonAncestry {
        $to-parent = $_;
        cast(GtkToggleButton, $_);
      }
    }
    self.setButton($to-parent);
  }

  multi method new (ToggleButtonAncestry $togglebutton, :$ref = True) {
    return unless $togglebutton;

    my $o = self.bless(:$togglebutton);
    $o.ref if $ref;
    $o;
  }
  multi method new {
    my $togglebutton = gtk_toggle_button_new();

    $togglebutton ?? self.bless(:$togglebutton) !! Nil;
  }

  method new_with_label (Str() $label) is also<new-with-label> {
    my $togglebutton = gtk_toggle_button_new_with_label($label);

    $togglebutton ?? self.bless(:$togglebutton) !! Nil;
  }

  method new_with_mnemonic (Str() $label) is also<new-with-mnemonic> {
    my $togglebutton = gtk_toggle_button_new_with_mnemonic($label);

    $togglebutton ?? self.bless(:$togglebutton) !! Nil;
  }

  # ↓↓↓↓ SIGNALS ↓↓↓↓
  # Is originally:
  # GtkToggleButton, gpointer --> void
  method toggled {
    self.connect($!tb, 'toggled');
  }
  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  method active is rw {
    Proxy.new(
      FETCH => sub ($) {
        so gtk_toggle_button_get_active($!tb);
      },
      STORE => sub ($, Int() $is_active is copy) {
        my gboolean $ia = $is_active.so.Int;

        gtk_toggle_button_set_active($!tb, $ia);
      }
    );
  }

  method inconsistent is rw {
    Proxy.new(
      FETCH => sub ($) {
        so gtk_toggle_button_get_inconsistent($!tb);
      },
      STORE => sub ($, Int() $setting is copy) {
        my gboolean $s = $setting;

        gtk_toggle_button_set_inconsistent($!tb, $s);
      }
    );
  }

  method mode is rw {
    Proxy.new(
      FETCH => sub ($) {
        so gtk_toggle_button_get_mode($!tb);
      },
      STORE => sub ($, $draw_indicator is copy) {
        my gboolean $di = $draw_indicator.so.Int;

        gtk_toggle_button_set_mode($!tb, $di);
      }
    );
  }
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  method get_type is also<get-type> {
    state ($n, $t);

    GTK::Widget.unstable_get_type( &gtk_toggle_button_get_type, $n, $t );
  }

  method emit-toggled is also<emit_toggled> {
    gtk_toggle_button_toggled($!tb);
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
