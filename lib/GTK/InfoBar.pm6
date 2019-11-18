use v6.c;

use Method::Also;
use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::InfoBar;
use GTK::Raw::Types;

use GTK::Raw::Utils;

use GTK::Box;

our subset InfoBarAncestry is export of Mu
  where GtkInfoBar | BoxAncestry;

class GTK::InfoBar is GTK::Box {
  has GtkInfoBar $!ib is implementor;

  method bless(*%attrinit) {
    my $o = self.CREATE.BUILDALL(Empty, %attrinit);
    $o.setType($o.^name);
    $o;
  }

  submethod BUILD(:$infobar) {
    given $infobar {
      when InfoBarAncestry {
        self.setInfoBar($infobar);
      }
      when GTK::InfoBar {
      }
      default {
      }
    }
  }

  method setInfoBar (InfoBarAncestry $_) {
    my $to-parent;
    $!ib = do {
      when GtkInfoBar {
        $to-parent = nativecast(GtkBox, $_);
        $_;
      }
      default {
        $to-parent = $_;
        nativecast(GtkInfoBar, $_);
      }
    };
    self.setBox($to-parent);
  }

  method GTK::Raw::Types::GtkInfoBar
    is also<
      GtkInfoBar
      InfoBar
    >
  { $!ib }

  multi method new (InfoBarAncestry $infobar) {
    my $o = self.bless(:$infobar);
    $o.upref;
    $o;
  }
  multi method new {
    self.bless( infobar => gtk_info_bar_new() );
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
    self.connect-int($!ib, 'response');
  }
  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  method message_type is rw is also<message-type> {
    Proxy.new(
      FETCH => sub ($) {
        GtkMessageType( gtk_info_bar_get_message_type($!ib) );
      },
      STORE => sub ($, Int() $message_type is copy) {
        my uint32 $mt = resolve-uint($message_type);

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
        my gboolean $r = resolve-bool($revealed);

        gtk_info_bar_set_revealed($!ib, $revealed);
      }
    );
  }

  method show_close_button is rw is also<show-close-button> {
    Proxy.new(
      FETCH => sub ($) {
        so gtk_info_bar_get_show_close_button($!ib);
      },
      STORE => sub ($, Int() $setting is copy) {
        my gboolean $s = resolve-bool($setting);

        gtk_info_bar_set_show_close_button($!ib, $s);
      }
    );
  }
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  method add_action_widget (GtkWidget() $child, Int() $response_id)
    is also<add-action-widget>
  {
    my gint $r = resolve-int($response_id);

    gtk_info_bar_add_action_widget($!ib, $child, $r);
  }

  method add_button (Str() $button_text, Int() $response_id)
    is also<add-button>
  {
    my gint $ri = resolve-int($response_id);

    gtk_info_bar_add_button($!ib, $button_text, $ri);
  }

  # Renamed from get_action_area
  method action_area is also<action-area> {
    GTK::Box.new( gtk_info_bar_get_action_area($!ib) );
  }

  # Renamed from get_content_area
  method content_area is also<content-area> {
    GTK::Box.new( gtk_info_bar_get_content_area($!ib) );
  }

  method get_type is also<get-type> {
    state ($n, $t);

    GTK::Widget.unstable_get_type( &gtk_info_bar_get_type, $n, $t );
  }

  multi method response (Int() $response_id) {
    my gint $ri = resolve-int($response_id);

    gtk_info_bar_response($!ib, $ri);
  }

  method set_default_response (Int() $response_id)
    is also<set-default-response>
  {
    my gint $ri = resolve-int($response_id);

    gtk_info_bar_set_default_response($!ib, $ri);
  }

  method set_response_sensitive (Int() $response_id, Int() $setting)
    is also<set-response-sensitive>
  {
    my gint $ri = resolve-int($response_id);
    my gboolean $s = resolve-bool($setting);

    gtk_info_bar_set_response_sensitive($!ib, $ri, $s);
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
