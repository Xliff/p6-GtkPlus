use v6.c;

use Method::Also;

use GDK::RGBA;

use GTK::Raw::ColorButton:ver<3.0.1146>;
use GTK::Raw::ColorChooser:ver<3.0.1146>;
use GTK::Raw::Types:ver<3.0.1146>;

use GTK::Button:ver<3.0.1146>;

use GTK::Roles::ColorChooser:ver<3.0.1146>;

our subset ColorButtonAncestry is export
  where GtkColorButton | GtkColorChooser | ButtonAncestry;

class GTK::ColorButton:ver<3.0.1146> is GTK::Button {
  also does GTK::Roles::ColorChooser;

  has GtkColorButton $!cb is implementor;

  method bless(*%attrinit) {
    my $o = self.CREATE.BUILDALL(Empty, %attrinit);
    $o.setType($o.^name);
    $o;
  }

  method setGtkColorButton (ColorButtonAncestry $_) {
    my $to-parent;

    when ColorButtonAncestry {
      $!cb = do {
        when GtkColorButton {
          $to-parent = cast(GtkButton, $_);
          $_;
        }

        when GtkColorChooser {
          $!cc       = $_;
          $to-parent = cast(GtkButton, $_);
          cast(GtkColorButton, $_);
        }

        when ButtonAncestry {
          $to-parent = $_;
          cast(GtkColorButton, $_);
        }

      }
      self.setButton($to-parent);
      self.roleInit-GtkColorChooser;
    }
  }

  submethod BUILD( :$gtk-color-button ) {
    self.setGtkColorButton( $gtk-color-button ) if $gtk-color-button;
  }

  multi method new (ColorButtonAncestry $button, :$ref = True) {
    return Nil unless $button;

    my $o = self.bless(:$button);
    $o.ref if $ref;
    $o;
  }
  multi method new {
    my $gtk-color-button = gtk_color_button_new();

    $gtk-color-button ?? self.bless( :$gtk-color-button ) !! Nil;
  }
  multi method new-from-hex (Str() $h) {
    ( my $c = GDK::RGBA.new ).parse($h);

    self.new_with_rgba($c);
  }

  method new_with_color (GdkColor() $color)
    is DEPRECATED
    is also<new-with-color>
  {
    my $gtk-color-button = gtk_color_button_new_with_color($color);

    $gtk-color-button ?? self.bless( :$gtk-color-button ) !! Nil;
  }

  method new_with_rgba (GDK::RGBA $color) is also<new-with-rgba> {
    my $gtk-color-button = gtk_color_button_new_with_rgba($color);

    $gtk-color-button ?? self.bless( :$gtk-color-button ) !! Nil;
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
        my guint $a = $alpha;

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
        my gboolean $ua = $use_alpha.so.Int;

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
