use v6.c;

use Method::Also;

use GTK::Raw::ToolButton:ver<3.0.1146>;
use GTK::Raw::Types:ver<3.0.1146>;

use GTK::Image:ver<3.0.1146>;
use GTK::ToolItem:ver<3.0.1146>;

use GTK::Roles::Actionable:ver<3.0.1146>;

our subset ToolButtonAncestry is export of Mu
  where GtkToolButton | GtkToolItemAncestry;

class GTK::ToolButton:ver<3.0.1146> is GTK::ToolItem {
  also does GTK::Roles::Actionable;

  has GtkToolButton $!tb is implementor;

  method bless(*%attrinit) {
    my $o = self.CREATE.BUILDALL(Empty, %attrinit);
    $o.setType($o.^name);
    $o;
  }

  submethod BUILD(:$toolbutton) {
    self.setGtkToolButton($toolbutton) if $toolbutton;
  }

  method GTK::Raw::Definitions::GtkToolButton
    is also<
      ToolButton
      GtkToolButton
    >
  { $!tb }

  method setGtkToolButton(ToolButtonAncestry $_) {
    my $to-parent;
    $!tb = do {
      when GtkToolButton {
        $to-parent = cast(GtkToolItem, $_);
        $_;
      }

      when GtkActionable {
        $!action = $_;
        $to-parent = cast(GtkToolItem, $_);
        cast(GtkToolButton, $_);
      }

      default {
        $to-parent = $_;
        cast(GtkToolButton, $_);
      }

    }
    $!action //= cast(GtkActionable, $!tb);   # GTK::Roles::Actionable
    self.setGtkToolItem($to-parent);
  }

  multi method new (ToolButtonAncestry $toolbutton, :$ref = True) {
    return unless $toolbutton;

    my $o = self.bless(:$toolbutton);
    $o.ref if $ref;
    $o;
  }
  multi method new {
    my $toolbutton = gtk_tool_button_new(GtkWidget, Str);

    $toolbutton ?? self.bless(:$toolbutton) !! Nil;
  }
  multi method new (Str() $label) {
    samewith(GtkWidget, $label);
  }
  multi method new (GtkWidget() $widget, Str() $label) {
    my $toolbutton = gtk_tool_button_new($widget, $label);

    $toolbutton ?? self.bless(:$toolbutton) !! Nil;
  }

  method new_from_stock (Str() $stock_id)
    is DEPRECATED('GTK::ToolButton.new( GTK::Image.new_from_icon_name() )')
    is also<new-from-stock>
  {
    my $toolbutton = gtk_tool_button_new_from_stock($stock_id);

    $toolbutton ?? self.bless(:$toolbutton) !! Nil;
  }

  # ↓↓↓↓ SIGNALS ↓↓↓↓

  # Is originally:
  # GtkToolButton, gpointer --> void
  method clicked {
    self.connect($!tb, 'clicked');
  }
  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  method icon_name is rw is also<icon-name> {
    Proxy.new(
      FETCH => sub ($) {
        gtk_tool_button_get_icon_name($!tb);
      },
      STORE => sub ($, Str() $icon_name is copy) {
        gtk_tool_button_set_icon_name($!tb, $icon_name);
      }
    );
  }

  method icon_widget (:$raw = False, :$widget = False)
    is rw is also<icon-widget>
  {
    Proxy.new(
      FETCH => sub ($) {
        my $w = gtk_tool_button_get_icon_widget($!tb);

        self.ReturnWidget($w, $raw, $widget);
      },
      STORE => sub ($, GtkWidget() $icon_widget is copy) {
        gtk_tool_button_set_icon_widget($!tb, $icon_widget);
      }
    );
  }

  method label is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_tool_button_get_label($!tb);
      },
      STORE => sub ($, Str() $label is copy) {
        gtk_tool_button_set_label($!tb, $label);
      }
    );
  }

  method label_widget (:$raw = False, :$widget = False) is rw
    is also<label-widget>
  {
    Proxy.new(
      FETCH => sub ($) {
        my $w = gtk_tool_button_get_label_widget($!tb);

        self.ReturnWidget($w, $raw, $widget);
      },
      STORE => sub ($, GtkWidget() $label_widget is copy) {
        gtk_tool_button_set_label_widget($!tb, $label_widget);
      }
    );
  }

  method stock_id is DEPRECATED is rw is also<stock-id> {
    Proxy.new(
      FETCH => sub ($) {
        gtk_tool_button_get_stock_id($!tb);
      },
      STORE => sub ($, Str() $stock_id is copy) {
        gtk_tool_button_set_stock_id($!tb, $stock_id);
      }
    );
  }

  method use_underline is rw is also<use-underline> {
    Proxy.new(
      FETCH => sub ($) {
        so gtk_tool_button_get_use_underline($!tb);
      },
      STORE => sub ($, Int() $use_underline is copy) {
        my $uu = $use_underline;
        gtk_tool_button_set_use_underline($!tb, $uu);
      }
    );
  }
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  method get_type is also<get-type> {
    state ($n, $t);

    GTK::Widget.unstable_get_type( &gtk_tool_button_get_type, $n, $t );
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
