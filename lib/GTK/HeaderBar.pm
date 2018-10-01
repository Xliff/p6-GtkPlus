use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::HeaderBar;
use GTK::Raw::Types;

use GTK::Container;

class GTK::HeaderBar is GTK::Container {
  has GtkHeaderBar $!hb;

  method bless(*%attrinit) {
    my $o = self.CREATE.BUILDALL(Empty, %attrinit);
    $o.setType('GTK::HeaderBar');
    $o;
  }

  submethod BUILD(:$headerbar) {
    my $to-parent;
    given $headerbar {
      when GtkHeaderBar | GtkWidget {
        $!hb = do {
          when GtkWidget {
            $to-parent = $_;
            nativecast(GtkHeaderBar, $_);
          }
          when GtkHeaderBar {
            $to-partent = nativecast(GtkContainer, $_);
            $_;
          }
        };
        self.setContainer($to-parent);
      }
      when GTK::HeaderBar {
      }
      default {
      }
    }
  }

  multi method new {
    my $headerbar = gtk_header_bar_new();
    self.bless(:$headerbar);
  }
  multi method new (GtkWidget $headerbar) {
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
      STORE => sub ($, GtkWidget() $title_widget is copy) {
        gtk_header_bar_set_custom_title($!hb, $title_widget);
      }
    );
  }

  method decoration_layout is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_header_bar_get_decoration_layout($!hb);
      },
      STORE => sub ($, Str() $layout is copy) {
        gtk_header_bar_set_decoration_layout($!hb, $layout);
      }
    );
  }

  method has_subtitle is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_header_bar_get_has_subtitle($!hb);
      },
      STORE => sub ($, Int() $setting is copy) {
        my gboolean $s = self.RESOLVE-BOOL($setting);
        gtk_header_bar_set_has_subtitle($!hb, $s);
      }
    );
  }

  method show_close_button is rw {
    Proxy.new(
      FETCH => sub ($) {
        Bool( gtk_header_bar_get_show_close_button($!hb) );
      },
      STORE => sub ($, Int() $setting is copy) {
        my gboolean $s = self.RESOLVE-BOOL($setting);
        gtk_header_bar_set_show_close_button($!hb, $s);
      }
    );
  }

  method subtitle is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_header_bar_get_subtitle($!hb);
      },
      STORE => sub ($, Str() $subtitle is copy) {
        gtk_header_bar_set_subtitle($!hb, $subtitle);
      }
    );
  }

  method title is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_header_bar_get_title($!hb);
      },
      STORE => sub ($, Str() $title is copy) {
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
    self.unshift-end($child) unless self.IS-LATCHED;
    self.UNSET-LATCH;
    gtk_header_bar_pack_end($!hb, $child);
  }
  multi method pack_end (GTK::Widget $child)  {
    self.unshift-end($child);
    self.SET-LATCH;
    samewith($child.widget);
  }

  multi method pack_start (GtkWidget $child) {
    self.push-start($child) unless self.IS-LATCHED;
    self.UNSET-LATCH;
    gtk_header_bar_pack_start($!hb, $child);
  }
  multi method pack_start (GTK::Widget $child)  {
    self.push-start($child);
    self.SET-LATCH;
    samewith($child.widget);
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
