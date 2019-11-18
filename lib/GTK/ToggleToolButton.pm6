use v6.c;

use Method::Also;
use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::ToggleToolButton;
use GTK::Raw::Types;

use GTK::ToolButton;

our subset ToggleToolButtonAncestry
  where GtkToggleToolButton | ToolButtonAncestry;

class GTK::ToggleToolButton is GTK::ToolButton {
  has GtkToggleToolButton $!ttb is implementor;

  method bless(*%attrinit) {
    my $o = self.CREATE.BUILDALL(Empty, %attrinit);
    $o.setType($o.^name);
    $o;
  }

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
    self.IS-PROTECTED;

    my $to-parent;
    $!ttb = do given $toggletoolbutton {
      when GtkToggleToolButton {
        $to-parent = nativecast(GtkToolButton, $_);
        $_;
      }
      default {
        $to-parent = $_;
        nativecast(GtkToggleToolButton, $_);
      }
    }
    self.setToolButton($to-parent);
  }

  multi method new (ToggleToolButtonAncestry $toggletoolbutton) {
    my $o = self.bless(:$toggletoolbutton);
    $o.upref;
    $o;
  }
  multi method new {
    my $toggletoolbutton = gtk_toggle_tool_button_new();
    self.bless(:$toggletoolbutton);
  }

  method GTK::Raw::Types::GtkToggleToolButton 
    is also<ToggleToolButton> 
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
        my gboolean $ia = $is_active == 0 ?? 0 !! 1;
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
