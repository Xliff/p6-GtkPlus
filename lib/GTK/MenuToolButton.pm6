use v6.c;

use Method::Also;

use GTK::Raw::MenuToolButton;
use GTK::Raw::Types;

use GTK::ToolButton;

our subset MenuToolButtonAncestry is export
  where GtkMenuToolButton | ToolButtonAncestry;

class GTK::MenuToolButton is GTK::ToolButton {
  has GtkMenuToolButton $!mtb is implementor;

  method bless(*%attrinit) {
    my $o = self.CREATE.BUILDALL(Empty, %attrinit);
    $o.setType($o.^name);
    $o;
  }

  submethod BUILD(:$menutoolbutton) {
    my $to-parent;
    given $menutoolbutton {
      when MenuToolButtonAncestry {
        $!mtb = do {
          when GtkMenuToolButton {
            $to-parent = cast(GtkToolButton, $_);
            $_;
          }
          default {
            $to-parent = $_;
            cast(GtkMenuToolButton, $_);
          }
        }
        self.setGtkToolButton($to-parent);
      }
      when GTK::MenuToolButton {
      }
      default {
      }
    }
  }

  multi method new (MenuToolButtonAncestry $menutoolbutton, :$ref = True) {
    return Nil unless $menutoolbutton;

    my $o = self.bless(:$menutoolbutton);
    $o.ref if $ref;
    $o;
  }
  multi method new (GtkWidget() $widget, Str() $label) {
    my $menutoolbutton = gtk_menu_tool_button_new($widget, $label);

    $menutoolbutton ?? self.bless(:$menutoolbutton) !! Nil;
  }

  # ↓↓↓↓ SIGNALS ↓↓↓↓

  # Is originally:
  # GtkMenuToolButton, gpointer --> void
  method show-menu is also<show_menu> {
    self.connect($!mtb, 'show-menu');
  }

  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  method menu (:$raw = False, :$widget = False) is rw {
    Proxy.new(
      FETCH => sub ($) {
        my $w = gtk_menu_tool_button_get_menu($!mtb);

        self.ReturnWidget($w, $raw, $widget);
      },
      STORE => sub ($, GtkWidget() $menu is copy) {
        gtk_menu_tool_button_set_menu($!mtb, $menu);
      }
    );
  }
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  method get_type is also<get-type> {
    state ($n, $t);

    GTK::Widget.unstable_get_type( &gtk_menu_tool_button_get_type, $n, $t );
  }

  method set_arrow_tooltip_markup (Str() $markup)
    is also<set-arrow-tooltip-markup>
  {
    gtk_menu_tool_button_set_arrow_tooltip_markup($!mtb, $markup);
  }

  method set_arrow_tooltip_text (Str() $text)
    is also<set-arrow-tooltip-text>
  {
    gtk_menu_tool_button_set_arrow_tooltip_text($!mtb, $text);
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
