use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::HeaderBar;
use GTK::Raw::Types;

use GTK::Container;

class GTK::HeaderBar is GTK::Container {
  has Gtk $!hb;

  submethod BUILD(:$headerbar) {
    given $headerbar {
      when GtkHeaderBar | GtkWidget {
        $!hb = do {
          when GtkHeaderBar { $headerbar }
          when GtkWidget    { nativecast(GtkHeaderBar, $headerbar) }
        };
        self.setContainer($headerbar);
      }
      when GTK::HeaderBar {
      }
      default {
      }
    }
  }

  method new {
    my $headerbar = gtk_header_bar_new();
    self.bless(:$headerbar);
  }

  # ↓↓↓↓ SIGNALS ↓↓↓↓
  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  method custom_title is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_header_bar_get_custom_title($!hb);
      },
      STORE => sub ($, $title_widget is copy) {
        gtk_header_bar_set_custom_title($!hb, $title_widget);
      }
    );
  }

  method decoration_layout is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_header_bar_get_decoration_layout($!hb);
      },
      STORE => sub ($, $layout is copy) {
        gtk_header_bar_set_decoration_layout($!hb, $layout);
      }
    );
  }

  method has_subtitle is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_header_bar_get_has_subtitle($!hb);
      },
      STORE => sub ($, $setting is copy) {
        gtk_header_bar_set_has_subtitle($!hb, $setting);
      }
    );
  }

  method show_close_button is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_header_bar_get_show_close_button($!hb);
      },
      STORE => sub ($, $setting is copy) {
        gtk_header_bar_set_show_close_button($!hb, $setting);
      }
    );
  }

  method subtitle is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_header_bar_get_subtitle($!hb);
      },
      STORE => sub ($, $subtitle is copy) {
        gtk_header_bar_set_subtitle($!hb, $subtitle);
      }
    );
  }

  method title is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_header_bar_get_title($!hb);
      },
      STORE => sub ($, $title is copy) {
        gtk_header_bar_set_title($!hb, $title);
      }
    );
  }
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  method get_type {
    gtk_header_bar_get_type();
  }

  multi method pack_end (GtkWidget $child) {
    self.unshift-end($child) unless $!add-latch;
    $!add-latch = False;
    gtk_header_bar_pack_end($!hb, $child);
  }
  multi method pack_end (GTK::Widget $child)  {
    self.unshift-end($child);
    $!add-latch = True;
    samewith($child.widget);
  }

  multi method pack_start (GtkWidget $child) {
    self.push-start($child) unless $!add-latch;
    $!add-latch = False;
    gtk_header_bar_pack_start($!hb, $child);
  }
  multi method pack_start (GTK::Widget $child)  {
    self.push-start($child);
    $!add-latch = True;
    samewith($child.widget);
  }

  # ↑↑↑↑ METHODS ↑↑↑↑

}
