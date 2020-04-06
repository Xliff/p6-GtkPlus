use v6.c;

use Method::Also;

use GTK::Raw::LinkButton;
use GTK::Raw::Types;

use GTK::Button;

our subset LinkButtonAncestry where GtkLinkButton | ButtonAncestry;

class GTK::LinkButton is GTK::Button {
  has GtkLinkButton $!lb is implementor;

  method bless(*%attrinit) {
    my $o = self.CREATE.BUILDALL(Empty, %attrinit);
    $o.setType($o.^name);
    $o;
  }

  submethod BUILD(:$button) {
    my $to-parent;
    given $button {
      when LinkButtonAncestry {
        $!lb = do {
          when GtkLinkButton {
            $to-parent = cast(GtkButton, $_);
            $_;
          }
          default {
            $to-parent = $_;
            cast(GtkLinkButton, $_);
          }
        };
        self.setButton($to-parent);
      }
      when GTK::LinkButton {
      }
      default {
      }
    }
  }

  method GTK::Raw::Definitions::GtkLinkButton
    is also<
      LinkButton
      GtkLinkButton
    >
  { $!lb }

  multi method new (LinkButtonAncestry $button, :$ref = True) {
    return Nil unless $button;

    my $o = self.bless(:$button);
    $o.ref if $ref;
    $o;
  }
  multi method new (Str() $uri) {
    my $button = gtk_link_button_new($uri);

    $button ?? self.bless(:$button) !! Nil;
  }

  method new_with_label (Str() $uri, Str() $label)
    is also<new-with-label>
  {
    my $button = gtk_link_button_new_with_label($uri, $label);

    $button ?? self.bless(:$button) !! Nil;
  }

  # ↓↓↓↓ SIGNALS ↓↓↓↓
  method activate-link is also<activate_link> {
    self.connect($!lb, 'activate-link');
  }
  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  method uri is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_link_button_get_uri($!lb);
      },
      STORE => sub ($, Str() $uri is copy) {
        gtk_link_button_set_uri($!lb, $uri);
      }
    );
  }

  method visited is rw {
    Proxy.new(
      FETCH => sub ($) {
        so gtk_link_button_get_visited($!lb);
      },
      STORE => sub ($, $visited is copy) {
        my gboolean $v = $visited.so.Int;

        gtk_link_button_set_visited($!lb, $v);
      }
    );
  }
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  method get_type is also<get-type> {
    state ($n, $t);
    
    GTK::Widget.unstable_get_type( &gtk_link_button_get_type, $n, $t );
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
