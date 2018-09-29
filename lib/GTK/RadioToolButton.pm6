use v6.c;

use NativeCall;

use GTK::Compat::GSList;
use GTK::Compat::Types;
use GTK::Raw::RadioToolButton;
use GTK::Raw::Types;

use GTK::ToggleToolButton;

class GTK::RadioToolButton is GTK::ToggleToolButton {
  has GtkRadioToolButton $!rtb;

  method bless(*%attrinit) {
    use nqp;
    my $o = nqp::create(self).BUILDALL(Empty, %attrinit);
    $o.setType('GTK::RadioToolButton');
    $o;
  }

  submethod BUILD(:$radiotoolbutton) {
    given $radiotoolbutton {
      when GtkRadioToolButton | GtkToolItem | GtkWidget {
        my $to-parent;
        $!rtb = do {
          when GtkToolItem | GtkWidget {
            $to-parent = $_;
            nativecast(GtkRadioToolButton, $_);
          }
          when GtkRadioToolButton {
            $to-parent = nativecast(GtkToggleToolButton, $_);
            $_;
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

  multi method new (GtkWidget $radiotoolbutton) {
    self.bless(:$radiotoolbutton);
  }
  multi method new(GSList() $group) {
    my $radiotoolbutton = gtk_radio_tool_button_new($group);
    self.bless(:$radiotoolbutton);
  }

  method new_from_stock (GSList() $group, gchar $stock_id)
    is DEPRECATED( 'GTK::RadioToolButton.new()' )
  {
    my $radiotoolbutton = gtk_radio_tool_button_new_from_stock(
      $group, $stock_id
    );
    self.bless(:$radiotoolbutton);
  }

  method new_from_widget(GtkRadioToolButton() $group) {
    my $radiotoolbutton = gtk_radio_tool_button_new_from_widget($group);
    self.bless(:$radiotoolbutton);
  }

  method new_with_stock_from_widget (
    GtkRadioToolButton() $group,
    gchar $stock_id
  )
    is DEPRECATED( 'GTK::RadioToolButton.new_from_widget()' )
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
        GTK::Compat::GSList.new( gtk_radio_tool_button_get_group($!rtb) );
      },
      STORE => sub ($, GSList() $group is copy) {
        gtk_radio_tool_button_set_group($!rtb, $group);
      }
    );
  }
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  method get_type {
    gtk_radio_tool_button_get_type();
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
