use v6.c;

use Method::Also;
use NativeCall;

use GLib::GList;

use GTK::Raw::RadioToolButton;
use GTK::Raw::Types;

use GTK::RadioButton;
use GTK::ToggleToolButton;

use GLib::Roles::ListData;

our subset RadioToolButtonAncestry is export
  where GtkRadioToolButton | GtkActionable | ToggleToolButtonAncestry;

class GTK::RadioToolButton is GTK::ToggleToolButton {
  has GtkRadioToolButton $!rtb is implementor;

  method bless(*%attrinit) {
    my $o = self.CREATE.BUILDALL(Empty, %attrinit);
    $o.setType($o.^name);
    $o;
  }

  submethod BUILD(:$radiotoolbutton) {
    given $radiotoolbutton {
      when RadioToolButtonAncestry {
        my $to-parent;
        $!rtb = do {
          when GtkRadioToolButton {
            $to-parent = cast(GtkToggleToolButton, $_);
            $_;
          }

          default {
            $to-parent = $_;
            cast(GtkRadioToolButton, $_);
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

  method GTK::Raw::Definitions::GtkRadioToolButton
    is also<
      RadioToolButton
      GtkRadioToolButton
    >
  { $!rtb }

  multi method new (RadioToolButtonAncestry $radiotoolbutton, :$ref = True) {
    return unless $radiotoolbutton;

    my $o = self.bless(:$radiotoolbutton);
    $o.ref if $ref;
    $o;
  }
  # Needs a multi to properly handle Positional!
  # In this case, it needs to convert Positional to GSList!
  multi method new ($group) {
    die "\$group is a { $group.^name }, not a GSList" unless $group ~~ GSList;

    my $radiotoolbutton = gtk_radio_tool_button_new($group);

    $radiotoolbutton ?? self.bless(:$radiotoolbutton) !! Nil;
  }

  method new_from_stock (GSList() $group, Str() $stock_id)
    is DEPRECATED( 'GTK::RadioToolButton.new()' )
    is also<new-from-stock>
  {
    my $radiotoolbutton = gtk_radio_tool_button_new_from_stock(
      $group, $stock_id
    );

    $radiotoolbutton ?? self.bless(:$radiotoolbutton) !! $radiotoolbutton;
  }

  method new_from_widget(GtkRadioToolButton() $group)
    is also<new-from-widget>
  {
    my $radiotoolbutton = gtk_radio_tool_button_new_from_widget($group);

    $radiotoolbutton ?? self.bless(:$radiotoolbutton) !! $radiotoolbutton;
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

    $radiotoolbutton ?? self.bless(:$radiotoolbutton) !! Nil;
  }

  # ↓↓↓↓ SIGNALS ↓↓↓↓
  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  method group (:$glist = False, :$raw = False) is rw {
    Proxy.new(
      FETCH => sub ($) {
        my $gl = gtk_radio_tool_button_get_group($!rtb);

        return Nil unless $gl;
        return $gl if     $glist;

        $gl = GLib::GList.new($gl)
          but GLib::Roles::ListData[GtkRadioButton];

        $raw ?? $gl.Array !! $gl.Array.map({ GTK::RadioButton.new($_) });
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
