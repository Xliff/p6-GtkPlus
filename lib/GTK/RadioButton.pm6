use v6.c;

use Method::Also;

use GLib::GList;

use GTK::Raw::RadioButton:ver<3.0.1146>;
use GTK::Raw::Types:ver<3.0.1146>;

use GLib::GList;

use GTK::CheckButton:ver<3.0.1146>;
use GLib::Roles::ListData;

our subset GtkRadioButtonAncestry is export
  where GtkRadioButton | CheckButtonAncestry;

constant RadioButtonAncestry is export = GtkRadioButtonAncestry;

class GTK::RadioButton:ver<3.0.1146> is GTK::CheckButton {
  has GtkRadioButton $!rb is implementor;

  submethod BUILD(:$radiobutton) {
    self.setRadioButton($radiobutton) if $radiobutton;
  }

  method GTK::Raw::Definitions::GtkRadioButton
    is also<
      RadioButton
      GtkRadioButton
    >
  { $!rb }

  method setRadioButton (GtkRadioButtonAncestry $radiobutton) {
    my $to-parent;

    $!rb = do given $radiobutton {
      when GtkRadioButton {
        $to-parent = cast(GtkCheckButton, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GtkRadioButton, $_);
      }
    }
    self.setCheckButton($to-parent);
  }

  multi method new (GtkRadioButtonAncestry $radiobutton, :$ref = True) {
    return unless $radiobutton;

    my $o = self.bless(:$radiobutton);
    $o.ref if $ref;
    $o;
  }
  multi method new (GSList() $group) {
    my $radiobutton = gtk_radio_button_new($group);

    $radiobutton ?? self.bless( :$radiobutton ) !! Nil;
  }

  method new-group (*@members) is also<new_group> {
    my @m = @members.clone;
    my @radiobuttons = (
      GTK::RadioButton.new_with_label(GSList, @m.shift)
    );

    for @m {
      @radiobuttons.push(
        GTK::RadioButton.new_with_label_from_widget(
          @radiobuttons[0].GtkRadioButton,
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

    $radiobutton ?? self.bless( :$radiobutton ) !! Nil;
  }

  proto method new_with_label (|)
    is also<new-with-label>
  { * }

  multi method new_with_label (Str() $label) {
    samewith(GSList, $label);
  }
  multi method new_with_label (GSList() $group, Str() $label) {
    my $radiobutton = gtk_radio_button_new_with_label($group, $label);

    $radiobutton ?? self.bless(:$radiobutton) !! Nil;
  }

  method new_with_label_from_widget (GtkRadioButton() $member, Str() $label)
    is also<new-with-label-from-widget>
  {
    my $radiobutton = gtk_radio_button_new_with_label_from_widget(
      $member,
      $label
    );

    $radiobutton ?? self.bless( :$radiobutton ) !! Nil;
  }

  proto method new_with_mnemonic (|)
  { * }

  multi method new_with_mnemonic (Str() $label) {
    samewith(GSList, $label);
  }
  multi method new_with_mnemonic (GSList() $group, Str() $label)
    is also<new-with-mnemonic>
  {
    my $radiobutton = gtk_radio_button_new_with_mnemonic($group, $label);

    $radiobutton ?? self.bless( :$radiobutton ) !! Nil;
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

    $radiobutton ?? self.bless( :$radiobutton ) !! Nil;
  }

  # ↓↓↓↓ SIGNALS ↓↓↓↓

  # Default handler
  method group-changed is also<group_changed> {
    self.connect($!rb, 'group-changed');
  }

  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  method group (:$glist = False, :$raw = False) is rw {
    Proxy.new(
      FETCH => sub ($) {
        my $rl = gtk_radio_button_get_group($!rb);

        return Nil unless $rl;
        return $rl if     $glist;

        $rl = GLib::GList.new($rl) but GLib::Roless::ListData[GtkRadioButton];

        $raw ?? $rl.Array !! $rl.Array.map({ GTK::RadioButton.new($rl) });
      },
      STORE => sub ($, GSList() $group is copy) {
        gtk_radio_button_set_group($!rb, $group);
      }
    );
  }
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  method get_type is also<get-type> {
    state ($n, $t);

    GTK::Widget.unstable_get_type( &gtk_radio_button_get_type, $n, $t );
  }

  method join_group (GtkRadioButton() $group_source) is also<join-group> {
    gtk_radio_button_join_group($!rb, $group_source);
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
