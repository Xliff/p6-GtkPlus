use v6.c;

use Method::Also;
use NativeCall;

use GDK::RGBA;

use GTK::Raw::ColorButton;
use GTK::Raw::ColorChooser;
use GTK::Raw::Types;

use GTK::Button;

use GTK::Roles::ColorChooser;

our subset ColorButtonAncestry is export 
  where GtkColorButton | GtkColorChooser | ButtonAncestry;

class GTK::ColorButton is GTK::Button {
  also does GTK::Roles::ColorChooser;

  has GtkColorButton $!cb is implementor;

  method bless(*%attrinit) {
    my $o = self.CREATE.BUILDALL(Empty, %attrinit);
    $o.setType('GTK::ColorButton');
    $o;
  }

  submethod BUILD(:$button) {
    my $to-parent;
    given $button {
      when ColorButtonAncestry {
        $!cb = do {
          when GtkColorButton {
            $to-parent = nativecast(GtkButton, $_);
            $_;
          }
          when GtkColorChooser {
            $!cc = $_;
            $to-parent = nativecast(GtkButton, $_);
            nativecast(GtkColorButton, $_);
          }
          when ButtonAncestry {
            $to-parent = $_;
            nativecast(GtkColorButton, $_);
          }
        };
        self.setButton($to-parent);
      }
      when GTK::Button {
      }
      default {
      }
    }
    $!cc //= nativecast(GtkColorChooser, $!cb);
  }

  multi method new (ColorButtonAncestry $button) {
    my $o = self.bless(:$button);
    $o.upref;
    $o;
  }
  multi method new {
    my $button = gtk_color_button_new();
    self.bless(:$button);
  }

  method new_with_color (GdkColor $color)
    is DEPRECATED
    is also<new-with-color>
  {
    my $button = gtk_color_button_new_with_color($color);
    self.bless(:$button);
  }

  method new_with_rgba (GDK::RGBA $color) is also<new-with-rgba> {
    my $button = gtk_color_button_new_with_rgba($color);
    self.bless(:$button);
  }

  # ↓↓↓↓ SIGNALS ↓↓↓↓
  method color-set is also<color_set> {
    self.connect($!cb, 'color-set');
  }
  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  method alpha is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_color_button_get_alpha($!cb);
      },
      STORE => sub ($, Int() $alpha is copy) {
        my guint $a = self.RESOLVE-UINT($alpha);
        gtk_color_button_set_alpha($!cb, $a);
      }
    );
  }

  method title is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_color_button_get_title($!cb);
      },
      STORE => sub ($, Str() $title is copy) {
        gtk_color_button_set_title($!cb, $title);
      }
    );
  }

  method use_alpha is rw is also<use-alpha> {
    Proxy.new(
      FETCH => sub ($) {
        so gtk_color_button_get_use_alpha($!cb);
      },
      STORE => sub ($, Int() $use_alpha is copy) {
        my gboolean $ua = self.RESOLVE-BOOL($use_alpha);
        gtk_color_button_set_use_alpha($!cb, $ua);
      }
    );
  }
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  method get_color (GdkColor $color) is DEPRECATED is also<get-color> {
    gtk_color_button_get_color($!cb, $color);
  }

  method get_type is also<get-type> {
    state ($n, $t);
    GTK::Widget.unstable_get_type( &gtk_color_button_get_type, $n, $t );
  }

  method set_color (GdkColor $color) is DEPRECATED is also<set-color> {
    gtk_color_button_set_color($!cb, $color);
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
