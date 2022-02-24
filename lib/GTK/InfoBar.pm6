use v6.c;

use Method::Also;

use GTK::Raw::InfoBar;
use GTK::Raw::Types;

use GTK::Box;

our subset GtkInfoBarAncestry is export of Mu
  where GtkInfoBar | GtkBoxAncestry;

class GTK::InfoBar is GTK::Box {
  has GtkInfoBar $!ib is implementor;

  method bless(*%attrinit) {
    my $o = self.CREATE.BUILDALL(Empty, %attrinit);
    $o.setType($o.^name);
    $o;
  }

  submethod BUILD(:$infobar) {
    self.setGtkInfoBar($infobar);
  }

  method setGtkInfoBar (GtkInfoBarAncestry $_) {
    my $to-parent;

    $!ib = do {
      when GtkInfoBar {
        $to-parent = cast(GtkBox, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GtkInfoBar, $_);
      }
    };
    self.setGtkBox($to-parent);
  }

  method GTK::Raw::Definitions::GtkInfoBar
    is also<
      GtkInfoBar
      InfoBar
    >
  { $!ib }

  multi method new (GtkInfoBarAncestry $infobar, :$ref = True) {
    my $o = self.bless(:$infobar);
    $o.ref if $ref;
    $o;
  }
  multi method new {
    my $infobar = gtk_info_bar_new();

    $infobar ?? self.bless(:$infobar) !! Nil;
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
        GtkMessageTypeEnum( gtk_info_bar_get_message_type($!ib) );
      },
      STORE => sub ($, Int() $message_type is copy) {
        my uint32 $mt = $message_type;

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
        my gboolean $r = $revealed.so.Int;

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
        my gboolean $s = $setting.so.Int;

        gtk_info_bar_set_show_close_button($!ib, $s);
      }
    );
  }
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  method add_action_widget (GtkWidget() $child, Int() $response_id)
    is also<add-action-widget>
  {
    my gint $r = $response_id;

    gtk_info_bar_add_action_widget($!ib, $child, $r);
  }

  method add_button (Str() $button_text, Int() $response_id)
    is also<add-button>
  {
    my gint $ri = $response_id;

    gtk_info_bar_add_button($!ib, $button_text, $ri);
  }

  # Renamed from get_action_area
  method action_area (:$raw = False) is also<action-area> {
    my $b = gtk_info_bar_get_action_area($!ib);

    $b ??
      ( $raw ?? $b !!  GTK::Box.new($b) )
      !!
      Nil;
  }

  # Renamed from get_content_area
  method content_area (:$raw = False) is also<content-area> {
    my $b = gtk_info_bar_get_content_area($!ib);

    $b ??
      ( $raw ?? $b !!  GTK::Box.new($b) )
      !!
      Nil;
  }

  method get_type is also<get-type> {
    state ($n, $t);

    GTK::Widget.unstable_get_type( &gtk_info_bar_get_type, $n, $t );
  }

  multi method response (Int() $response_id) {
    my gint $ri = $response_id;

    gtk_info_bar_response($!ib, $ri);
  }

  method set_default_response (Int() $response_id)
    is also<set-default-response>
  {
    my gint $ri = $response_id;

    gtk_info_bar_set_default_response($!ib, $ri);
  }

  method set_response_sensitive (Int() $response_id, Int() $setting)
    is also<set-response-sensitive>
  {
    my gint $ri = $response_id;
    my gboolean $s = $setting.so.Int;

    gtk_info_bar_set_response_sensitive($!ib, $ri, $s);
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
