use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::LinkButton;
use GTK::Raw::Types;

use GTK::Button;

class GTK::LinkButton is GTK::Button {
  has Gtk $!lb;

  submethod BUILD(:$button) {
    given $button {
      when GtkLinkButton | GtkWidget {
        $!lb = nativecast(GtkLinkButton, $button);
        self.setButton($button);
      }
      when GTK::Button {
      }
      default {
      }
    }
  }

  method new () {
    my $button = gtk_link_button_new();
    self.bless(:$button);
  }

  method new_with_label (gchar $label) {
    my $button = gtk_link_button_new_with_label($label);
    self.bless(:$button);
  }

  # ↓↓↓↓ SIGNALS ↓↓↓↓
  method activate-link {
    self.connect($!lb, 'activate-link');
  }
  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  method uri is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_link_button_get_uri($!fb);
      },
      STORE => sub ($, $uri is copy) {
        gtk_link_button_set_uri($!fb, $uri);
      }
    );
  }

  method visited is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_link_button_get_visited($!fb);
      },
      STORE => sub ($, $visited is copy) {
        gtk_link_button_set_visited($!fb, $visited);
      }
    );
  }
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  method get_type {
    gtk_link_button_get_type($!fb);
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
