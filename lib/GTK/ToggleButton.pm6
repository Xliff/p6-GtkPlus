use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::ToggleButton;
use GTK::Raw::Types;

use GTK::Button;

class GTK::ToggleButton is GTK::Button {
  has GtkToggleButton $!tb;

  method bless(*%attrinit) {
    use nqp;
    my $o = nqp::create(self).BUILDALL(Empty, %attrinit);
    $o.setType('GTK::ToggleButton');
    $o;
  }

  submethod BUILD(:$togglebutton) {
    my $to-parent;
    given $togglebutton {
      when GtkToggleButton | GtkWidget {
        $!tb = do {
          when GtkWidget {
            $to-parent = $_;
            nativecast(GtkToggleButton, $_);
          }
          when GtkToggleButton {
            $to-parent = nativecast(GtkButton, $_);
            $_;
          }
        };
        self.setButton($togglebutton);
      }
      when GTK::ToggleButton {
      }
      default {
      }
    }
  }

  multi method new {
    my $togglebutton = gtk_toggle_button_new();
    self.bless(:$togglebutton);
  }
  multi method new (GtkToggleButton $togglebutton) {
    self.bless(:$togglebutton);
  }
  multi method new (GtkWidget $togglebutton) {
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
        so gtk_toggle_button_get_active($!tb);
      },
      STORE => sub ($, Int() $is_active is copy) {
        my gboolean $ia = self.RESOLVE-BOOL($is_active);
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
        my gboolean $s = self.RESOLVE-BOOL($setting);
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
        my gboolean $di = self.RESOLVE-BOOL($draw_indicator);
        gtk_toggle_button_set_mode($!tb, $di);
      }
    );
  }
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  method get_type {
    gtk_toggle_button_get_type();
  }

  method emit-toggled {
    gtk_toggle_button_toggled($!tb);
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
