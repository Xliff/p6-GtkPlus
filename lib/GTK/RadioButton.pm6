use v6.c;

use Method::Also;
use NativeCall;

use GTK::Compat::GSList;
use GTK::Compat::Types;
use GTK::Raw::RadioButton;
use GTK::Raw::Types;

use GTK::CheckButton;

our subset RadioButtonAncestry is export 
  where GtkRadioButton | CheckButtonAncestry;

class GTK::RadioButton is GTK::CheckButton {
  has GtkRadioButton $!rb;

  method bless(*%attrinit) {
    my $o = self.CREATE.BUILDALL(Empty, %attrinit);
    $o.setType('GTK::RadioButton');
    $o;
  }

  submethod BUILD(:$radiobutton) {
    given $radiobutton {
      when RadioButtonAncestry {
        self.setRadioButton($radiobutton);
      }
      when GTK::RadioButton {
      }
      default {
      }
    }
  }
  
  method GTK::Raw::Types::GtkRadioButton is also<RadioButton> { $!rb }
  
  method setRadioButton(RadioButtonAncestry $radiobutton) {
    self.IS-PROTECTED; 
    
    my $to-parent;
    $!rb = do given $radiobutton {
      when GtkRadioButton {
        $to-parent = nativecast(GtkCheckButton, $_);
        $_;
      }
      default {
        $to-parent = $_;
        nativecast(GtkRadioButton, $_);
      }
    }
    self.setCheckButton($to-parent);
  }

  multi method new (RadioButtonAncestry $radiobutton) {
    my $o = self.bless(:$radiobutton);
    $o.upref;
    $o;
  }
  multi method new(GSList() $group) {
    my $radiobutton = gtk_radio_button_new($group);
    self.bless(:$radiobutton);
  }
  method new-group (*@members) is also<new_group> {
    my @m = @members.clone;
    my @radiobuttons = (
      GTK::RadioButton.new_with_label(GSList, @m.shift)
    );
    for @m {
      @radiobuttons.push(
        GTK::RadioButton.new_with_label_from_widget(
          @radiobuttons[0].RadioButton,
          $_
        )
      );
    }
    @radiobuttons;
  }
  
  method new_from_widget (GtkRadioButton() $member)
    is also<new-from-widget>
  {
    my $radiobutton = gtk_radio_button_new_from_widget($member);
    self.bless(:$radiobutton);
  }

  method new_with_label (GSList() $group, Str() $label)
    is also<new-with-label>
  {
    my $radiobutton = gtk_radio_button_new_with_label($group, $label);
    self.bless(:$radiobutton);
  }

  method new_with_label_from_widget (GtkRadioButton() $member, Str() $label)
    is also<new-with-label-from-widget>
  {
    my $radiobutton = gtk_radio_button_new_with_label_from_widget(
      $member,
      $label
    );
    self.bless(:$radiobutton);
  }

  method new_with_mnemonic (GSList() $group, Str() $label)
    is also<new-with-mnemonic>
  {
    my $radiobutton = gtk_radio_button_new_with_mnemonic($group, $label);
    self.bless(:$radiobutton);
  }

  method new_with_mnemonic_from_widget (
    GtkRadioButton() $member,
    Str() $label
  )
    is also<new-with-mnemonic-from-widget>
  {
    my $radiobutton = gtk_radio_button_new_with_mnemonic_from_widget(
      $member,
      $label
    );
    self.bless(:$radiobutton);
  }

  # ↓↓↓↓ SIGNALS ↓↓↓↓

  # Default handler
  method group-changed is also<group_changed> {
    self.connect($!rb, 'group-changed');
  }

  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  method group is rw {
    Proxy.new(
      FETCH => sub ($) {
        GTK::Compat::GSList.new( gtk_radio_button_get_group($!rb) );
      },
      STORE => sub ($, GSList() $group is copy) {
        gtk_radio_button_set_group($!rb, $group);
      }
    );
  }
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  method get_type is also<get-type> {
    gtk_radio_button_get_type();
  }

  method join_group (GtkRadioButton() $group_source) is also<join-group> {
    gtk_radio_button_join_group($!rb, $group_source);
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
