use v6.c;

use Method::Also;
use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::HeaderBar;
use GTK::Raw::Types;

use GTK::Container;

my subset Ancestry
  where GtkHeaderBar | GtkContainer | GtkBuildable | GtkWidget;

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
      when Ancestry {
        $!hb = do {
          when GtkHeaderBar {
            $to-parent = nativecast(GtkContainer, $_);
            $_;
          }
          default {
            $to-parent = $_;
            nativecast(GtkHeaderBar, $_);
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

  multi method new (Ancestry $headerbar) {
    self.bless(:$headerbar);
  }
  multi method new {
    my $headerbar = gtk_header_bar_new();
    self.bless(:$headerbar);
  }

  # ↓↓↓↓ SIGNALS ↓↓↓↓
  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  method custom_title is rw is also<custom-title> {
    Proxy.new(
      FETCH => sub ($) {
        gtk_header_bar_get_custom_title($!hb);
      },
      STORE => sub ($, GtkWidget() $title_widget is copy) {
        gtk_header_bar_set_custom_title($!hb, $title_widget);
      }
    );
  }

  method decoration_layout is rw is also<decoration-layout> {
    Proxy.new(
      FETCH => sub ($) {
        gtk_header_bar_get_decoration_layout($!hb);
      },
      STORE => sub ($, Str() $layout is copy) {
        gtk_header_bar_set_decoration_layout($!hb, $layout);
      }
    );
  }

  method has_subtitle is rw is also<has-subtitle> {
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

  method show_close_button is rw is also<show-close-button> {
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
  method get_type is also<get-type> {
    gtk_header_bar_get_type();
  }

  multi method pack-end (GtkWidget $child) {
    self.pack_end($child);
  }
  multi method pack_end (GtkWidget $child) {
    self.unshift-end($child) unless self.IS-LATCHED;
    self.UNSET-LATCH;
    gtk_header_bar_pack_end($!hb, $child);
  }
  multi method pack-end (GTK::Widget $child) {
    self.pack_end($child);
  }
  multi method pack_end (GTK::Widget $child) {
    self.unshift-end($child);
    self.SET-LATCH;
    samewith($child.widget);
  }

  multi method pack_start (GtkWidget $child) {
    self.pack_start($child);
  }
  multi method pack_start (GtkWidget $child) {
    self.push-start($child) unless self.IS-LATCHED;
    self.UNSET-LATCH;
    gtk_header_bar_pack_start($!hb, $child);
  }
  multi method pack-start (GTK::Widget $child) {
    self.pack_start($child);
  }
  multi method pack_start (GTK::Widget $child) {
    self.push-start($child);
    self.SET-LATCH;
    samewith($child.widget);
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

  method child-set(*@propval) {
    my @notfound;
    @notfound = gather for @propval -> $p, $v {
      given $p {
        when 'pack-type' { self.child-set-uint($p, $v) }
        when 'position'  { self.child-set-int($p, $v)  }

        default          { take $p; take $v;           }
      }
    }
    nextwith(@notfound) if +@notfound;
  }

}
