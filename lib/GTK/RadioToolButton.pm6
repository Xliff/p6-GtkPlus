use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::RadioToolButton;
use GTK::Raw::Types;

use GTK::ToggleToolButton;

class GTK::RadioToolButton is GTK::ToggleToolButton {
  has Gtk $!rtb;

  method bless(*%attrinit) {
    use nqp;
    my $o = nqp::create(self).BUILDALL(Empty, %attrinit);
    $o.setType('GTK::RadioToolButton');
    $o;
  }

  submethod BUILD(:$radiotoolbutton ) {
    given $radiotoolbutton {
      when GtkRadioToolButton | GtkToolItem | GtkWidget {
        my $to-parent;
        $!rtb = do {
          when GtkToolItem | GtkWidget {
            $to-parent = $radiotoolbutton
            nativecast(GtkRadioToolButton, $radiotoolbutton);
          }
          when GtkRadioToolButton {
            $to-parent = nativecast(GtkToggleToolButton, $radiotoolbutton);
            $radiotoolbutton;
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

  method new {
    my $radiotoolbutton = gtk_radio_tool_button_new();
    self.bless(:$radiotoolbutton);
  }

  method new_from_stock (gchar $stock_id)
    is DEPRECATED( ::?CLASS.name ~ '.new()' )
  {
    my $radiotoolbutton = gtk_radio_tool_button_new_from_stock(
      $!rtb, $stock_id
    );
    self.bless(:$radiotoolbutton);
  }

  method new_from_widget {
    my $radiotoolbutton = gtk_radio_tool_button_new_from_widget();
    self.bless(:$radiotoolbutton);
  }

  method new_with_stock_from_widget (gchar $stock_id)
    is DEPRECATED( ::?CLASS.name ~ '.new_from_widget()' )
  {
    my $radiotoolbutton = gtk_radio_tool_button_new_with_stock_from_widget(
      $!rtb, $stock_id
    );
    self.bless(:$radiotoolbutton);
  }

  # ↓↓↓↓ SIGNALS ↓↓↓↓
  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  method get_type {
    gtk_radio_tool_button_get_type();
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
