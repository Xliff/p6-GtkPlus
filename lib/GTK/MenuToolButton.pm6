use v6.c;

use Method::Also;
use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::MenuToolButton;
use GTK::Raw::Types;

use GTK::ToolButton;

my subset Ancestry
  where GtkMenuToolButton | GtkToolButton | GtkActionable | GtkToolItem |
        GtkBin            | GtkContainer  | GtkBuilder    | GtkWidget;

class GTK::MenuToolButton is GTK::ToolButton {
  has GtkMenuToolButton $!mtb;

  method bless(*%attrinit) {
    my $o = self.CREATE.BUILDALL(Empty, %attrinit);
    $o.setType('GTK::MenuToolButton');
    $o;
  }

  submethod BUILD(:$menutoolbutton) {
    my $to-parent;
    given $menutoolbutton {
      when Ancestry {
        $!mtb = do {
          when GtkMenuToolButton {
            $to-parent = nativecast(GtkToolButton, $_);
            $_;
          }
          default {
            $to-parent = $_;
            nativecast(GtkMenuToolButton, $_);
          }
        }
        self.setToolButton($to-parent);
      }
      when GTK::MenuToolButton {
      }
      default {
      }
    }
  }

  multi method new (Ancestry $menutoolbutton) {
    my $o = self.bless(:$menutoolbutton);
    $o.upref;
    $o;
  }
  multi method new (GtkWidget() $widget, Str() $label) {
    my $menutoolbutton = gtk_menu_tool_button_new($widget, $label);
    self.bless(:$menutoolbutton);
  }

  # ↓↓↓↓ SIGNALS ↓↓↓↓

  # Is originally:
  # GtkMenuToolButton, gpointer --> void
  method show-menu is also<show_menu> {
    self.connect($!mtb, 'show-menu');
  }

  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  method menu is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_menu_tool_button_get_menu($!mtb);
      },
      STORE => sub ($, GtkWidget() $menu is copy) {
        gtk_menu_tool_button_set_menu($!mtb, $menu);
      }
    );
  }
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  method get_type is also<get-type> {
    gtk_menu_tool_button_get_type();
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
