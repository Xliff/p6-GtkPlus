use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::Label;
use GTK::Raw::Types;

use GTK::Raw::InfoBar;

use GTK::Box;

class GTK::InfoBar is GTK::Box {
  has Gtk $!ib;

  submethod BUILD(:$infobar) {
    given $infobar {
      when GtkInfoBar | GtkWidget {
        nativecast(GtkInfoBar, $infobar);
        self.setBox($infobar);
      }
      when GTK::InfoBar {
      }
      default {
      }
    }
  }

  method new {
    my $infobar = gtk_info_bar_new();
    self.bless(:$infobar);
  }

  # ↓↓↓↓ SIGNALS ↓↓↓↓
  method close {
    self.connect($!ib, 'close');
  }


  # Should be:
  # (GtkInfoBar *info_bar,
  #  gint        response_id,
  #  gpointer    user_data)
  method response {
    self.connect($!ib, 'response');
  }
  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  method message_type is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_info_bar_get_message_type($!ib);
      },
      STORE => sub ($, $message_type is copy) {
        gtk_info_bar_set_message_type($!ib, $message_type);
      }
    );
  }

  method revealed is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_info_bar_get_revealed($!ib);
      },
      STORE => sub ($, $revealed is copy) {
        gtk_info_bar_set_revealed($!ib, $revealed);
      }
    );
  }

  method show_close_button is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_info_bar_get_show_close_button($!ib);
      },
      STORE => sub ($, $setting is copy) {
        gtk_info_bar_set_show_close_button($!ib, $setting);
      }
    );
  }

  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  multi method add_action_widget (GtkWidget $child, gint $response_id) {
    gtk_info_bar_add_action_widget($!ib, $child, $response_id);
  }
  multi method add_action_widget (GTK::Widget $child, gint $response_id)  {
    samewith($child.widget, $response_id);
  }

  method add_button (gchar $button_text, gint $response_id) {
    gtk_info_bar_add_button($!ib, $button_text, $response_id);
  }

  method get_action_area {
    gtk_info_bar_get_action_area($!ib);
  }

  method get_content_area {
    gtk_info_bar_get_content_area($!ib);
  }

  method get_type {
    gtk_info_bar_get_type();
  }

  method response (gint $response_id) {
    gtk_info_bar_response($!ib, $response_id);
  }

  method set_default_response (gint $response_id) {
    gtk_info_bar_set_default_response($!ib, $response_id);
  }

  method set_response_sensitive (gint $response_id, gboolean $setting) {
    gtk_info_bar_set_response_sensitive($!ib, $response_id, $setting);
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
