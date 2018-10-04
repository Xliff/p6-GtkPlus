use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::InfoBar;
use GTK::Raw::Types;

use GTK::Box;

use GTK::Roles::Signals::InfoBar;

class GTK::InfoBar is GTK::Box {
  also does GTK::Roles::Signals::InfoBar;

  has GtkInfoBar $!ib;

  method bless(*%attrinit) {
    my $o = self.CREATE.BUILDALL(Empty, %attrinit);
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
  multi method response(:$supply = True) {
    with %!signals<response> {
      if $_[0] ~~ Supply {
        die "Cannot mix <response> signal types" unless $supply;
      } else {
        die "Cannot mix <response> signal types" if $supply;
      }
    }

    $supply ??
      self.connect($!ib, 'response')
      !!
      self.connect-response($!ib);
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
  method add_action_widget (GtkWidget() $child, Int() $response_id) {
    my gint $r = self.RESOLVE-INT($response_id);
    gtk_info_bar_add_action_widget($!ib, $child, $r);
  }

  method add_button (Str() $button_text, Int() $response_id) {
    my gint $ri = self.RESOLVE-INT($response_id);
    gtk_info_bar_add_button($!ib, $button_text, $ri);
  }

  # Renamed from get_action_area
  method action_area {
    GTK::Box.new( gtk_info_bar_get_action_area($!ib) );
  }

  # Renamed from get_content_area
  method content_area {
    GTK::Box.new( gtk_info_bar_get_content_area($!ib) );
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

  method set_response_sensitive (Int() $response_id, Int() $setting) {
    my gint $ri = self.RESOLVE-INT($response_id);
    my gboolean $s = self.RESOLVE-BOOL($setting);
    gtk_info_bar_set_response_sensitive($!ib, $ri, $s);
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
