use v6.c;

use Method::Also;

use GTK::Raw::ToggleToolButton:ver<3.0.1146>;
use GTK::Raw::Types:ver<3.0.1146>;

use GTK::ToolButton:ver<3.0.1146>;

our subset ToggleToolButtonAncestry
  where GtkToggleToolButton | ToolButtonAncestry;

class GTK::ToggleToolButton:ver<3.0.1146> is GTK::ToolButton {
  has GtkToggleToolButton $!ttb is implementor;

  submethod BUILD(:$toggletoolbutton) {
    given $toggletoolbutton {
      when ToggleToolButtonAncestry {
        self.setToggleToolButton($toggletoolbutton);
      }
      when GTK::ToggleToolButton {
      }
      default {
      }
    }
  }

  method setToggleToolButton(ToggleToolButtonAncestry $toggletoolbutton) {

    my $to-parent;
    $!ttb = do given $toggletoolbutton {
      when GtkToggleToolButton {
        $to-parent = cast(GtkToolButton, $_);
        $_;
      }
      default {
        $to-parent = $_;
        cast(GtkToggleToolButton, $_);
      }
    }
    self.setGtkToolButton($to-parent);
  }

  multi method new (ToggleToolButtonAncestry $toggletoolbutton, :$ref = True) {
    return Nil unless $toggletoolbutton;

    my $o = self.bless(:$toggletoolbutton);
    $o.ref if $ref;
    $o;
  }
  multi method new {
    my $toggletoolbutton = gtk_toggle_tool_button_new();

    $toggletoolbutton ?? self.bless(:$toggletoolbutton) !! Nil;
  }

  method GTK::Raw::Definitions::GtkToggleToolButton
    is also<
      ToggleToolButton
      GtkToggleToolButton
    >
  { $!ttb }

  # ↓↓↓↓ SIGNALS ↓↓↓↓
  # Is originally:
  # GtkToggleToolButton, gpointer --> void
  method toggled {
    self.connect($!ttb, 'toggled');
  }
  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  method active is rw {
    Proxy.new(
      FETCH => sub ($) {
        so gtk_toggle_tool_button_get_active($!ttb);
      },
      STORE => sub ($, Int() $is_active is copy) {
        my gboolean $ia = $is_active;

        gtk_toggle_tool_button_set_active($!ttb, $ia);
      }
    );
  }
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  method get_type is also<get-type> {
    state ($n, $t);

    GTK::Widget.unstable_get_type( &gtk_toggle_tool_button_get_type, $n, $t );
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
