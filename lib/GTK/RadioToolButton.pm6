use v6.c;

use Method::Also;
use NativeCall;

use GTK::Compat::GSList;
use GTK::Compat::Types;
use GTK::Raw::RadioToolButton;
use GTK::Raw::Types;

use GTK::ToggleToolButton;

our subset RadioToolButtonAncestry is export
  where GtkRadioToolButton | GtkActionable | ToggleToolButtonAncestry;
  
class GTK::RadioToolButton is GTK::ToggleToolButton {
  has GtkRadioToolButton $!rtb is implementor;

  method bless(*%attrinit) {
    my $o = self.CREATE.BUILDALL(Empty, %attrinit);
    $o.setType('GTK::RadioToolButton');
    $o;
  }

  submethod BUILD(:$radiotoolbutton) {
    given $radiotoolbutton {
      when RadioToolButtonAncestry {
        my $to-parent;
        $!rtb = do {
          when GtkRadioToolButton {
            $to-parent = nativecast(GtkToggleToolButton, $_);
            $_;
          }
          default {
            $to-parent = $_;
            nativecast(GtkRadioToolButton, $_);
          }
        }
        self.setToggleToolButton($to-parent);
      }
      when GTK::RadioToolButton {
      }
      default {
      }
    }
  }
  
  method GTK::Raw::Types::GtkRadioToolButton 
    is also<RadioToolButton> 
  { $!rtb }

  multi method new (RadioToolButtonAncestry $radiotoolbutton) {
    my $o = self.bless(:$radiotoolbutton);
    $o.upref;
    $o;
  }
  multi method new(GSList() $group) {
    my $radiotoolbutton = gtk_radio_tool_button_new($group);
    self.bless(:$radiotoolbutton);
  }

  method new_from_stock (GSList() $group, Str() $stock_id)
    is DEPRECATED( 'GTK::RadioToolButton.new()' )
  is also<new-from-stock> {
    my $radiotoolbutton = gtk_radio_tool_button_new_from_stock(
      $group, $stock_id
    );
    self.bless(:$radiotoolbutton);
  }

  method new_from_widget(GtkRadioToolButton() $group)
    is also<new-from-widget>
  {
    my $radiotoolbutton = gtk_radio_tool_button_new_from_widget($group);
    self.bless(:$radiotoolbutton);
  }

  method new_with_stock_from_widget (
    GtkRadioToolButton() $group,
    Str() $stock_id
  )
    is DEPRECATED( 'GTK::RadioToolButton.new_from_widget()' )
    is also<new-with-stock-from-widget>
  {
    my $radiotoolbutton = gtk_radio_tool_button_new_with_stock_from_widget(
      $group, $stock_id
    );
    self.bless(:$radiotoolbutton);
  }

  # ↓↓↓↓ SIGNALS ↓↓↓↓
  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  method group is rw {
    Proxy.new(
      FETCH => sub ($) {
        #GTK::Compat::GSList.new( gtk_radio_tool_button_get_group($!rtb) );
        gtk_radio_tool_button_get_group($!rtb);
      },
      STORE => sub ($, GSList() $group is copy) {
        gtk_radio_tool_button_set_group($!rtb, $group);
      }
    );
  }
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  method get_type is also<get-type> {
    state ($n, $t);
    GTK::Widget.unstable_get_type( &gtk_radio_tool_button_get_type, $n, $t );
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
