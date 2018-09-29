use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::Label;
use GTK::Raw::Types;

use GTK::Raw::InfoBar;
use GTK::Box;

class GTK::InfoBar is GTK::Box {
  has GtkInfoBar $!ib;

  method bless(*%attrinit) {
    use nqp;
    my $o = nqp::create(self).BUILDALL(Empty, %attrinit);
    $o.setType('GTK::InfoBar');
    $o;
  }

  submethod BUILD(:$infobar) {
    my $to-parent;
    given $infobar {
      when GtkInfoBar | GtkWidget {
        $!ib = do {
          when GtkWidget {
            $to-parent = $_;
            nativecast(GtkInfoBar, $_);
          }
          when GtkInfoBar {
            $to-parent = nativecast(GtkBox, $_);
            $_;
          }
        };
        self.setBox($to-parent);
      }
      when GTK::InfoBar {
      }
      default {
      }
    }
  }

  multi method new {
    my $infobar = gtk_info_bar_new();
    self.bless(:$infobar);
  }
  multi method new (GtkWidget $infobar) {
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
  # - Made multi so as to not conflict with the implementation for
  #   gtk_info_bar_response
  multi method response {
    self.connect($!ib, 'response');
  }
  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  method message_type is rw {
    Proxy.new(
      FETCH => sub ($) {
        GtkMessageType( gtk_info_bar_get_message_type($!ib) );
      },
      STORE => sub ($, $message_type is copy) {
        my uint32 $mt = self.RESOLVE-UINT($message_type);
        gtk_info_bar_set_message_type($!ib, $mt);
      }
    );
  }

  method revealed is rw {
    Proxy.new(
      FETCH => sub ($) {
        so gtk_info_bar_get_revealed($!ib);
      },
      STORE => sub ($, Int() $revealed is copy) {
        my gboolean $r = self.RESOLVE-BOOL($revealed);
        gtk_info_bar_set_revealed($!ib, $revealed);
      }
    );
  }

  method show_close_button is rw {
    Proxy.new(
      FETCH => sub ($) {
        so gtk_info_bar_get_show_close_button($!ib);
      },
      STORE => sub ($, $setting is copy) {
        my gboolean $s = self.RESOLVE-BOOL($setting);
        gtk_info_bar_set_show_close_button($!ib, $s);
      }
    );
  }
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  method add_action_widget (GtkWidget() $child, gint $response_id) {
    gtk_info_bar_add_action_widget($!ib, $child, $response_id);
  }

  method add_button (gchar $button_text, gint $response_id) {
    my gint $ri = self.RESOLVE-INT($response_id);
    gtk_info_bar_add_button($!ib, $button_text, $ri);
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

  multi method response (Int() $response_id) {
    my gint $ri = self.RESOLVE-INT($response_id);
    gtk_info_bar_response($!ib, $ri);
  }

  method set_default_response (Int() $response_id) {
    my gint $ri = self.RESOLVE-INT($response_id);
    gtk_info_bar_set_default_response($!ib, $ri);
  }

  method set_response_sensitive (gint $response_id, gboolean $setting) {
    my gint $ri = self.RESOLVE-INT($response_id);
    my gboolean $s = self.RESOLVE-BOOL($setting);
    gtk_info_bar_set_response_sensitive($!ib, $ri, $s);
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
