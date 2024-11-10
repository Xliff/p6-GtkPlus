use v6.c;

use Method::Also;

use GLib::GList;

use GTK::Raw::RadioMenuItem:ver<3.0.1146>;
use GTK::Raw::Types:ver<3.0.1146>;

use GLib::GSList;
use GTK::CheckMenuItem:ver<3.0.1146>;

use GLib::Roles::ListData;

our subset GtkRadioMenuItemAncestry is export
  where GtkRadioMenuItem | GtkCheckMenuItemAncestry;

class GTK::RadioMenuItem:ver<3.0.1146> is GTK::CheckMenuItem {
  has GtkRadioMenuItem $!rmi is implementor;

  submethod BUILD( :$radiomenu, :%opts ) {
    self.setGtkRadioMenuItem($radiomenu) if $radiomenu;
  }

  method GTK::Raw::Definitions::GtkRadioMenuItem
    is also<GtkRadioMenuItem>
  { $!rmi }

  submethod TWEAK ( :$radiomenu, :%opts ) {
    self.toggled.tap:       SUB { %opts<clicked>() } with %opts<clicked>;
    self.toggled.tap:       SUB { %opts<toggled>() } with %opts<toggled>;
    self.group-changed.tap: SUB { %opts<changed>() } with %opts<changed>;
  }

  method setGtkRadioMenuItem ( $_) {
    say "Radio Menu Item is { .^name }";

    my $to-parent;

    $!rmi = do {
      when GtkRadioMenuItem {
        $to-parent = cast(GtkCheckMenuItem, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GtkRadioMenuItem, $_);
      }
    }

    self.setGtkCheckMenuItem($to-parent);
  }

  multi method new (GtkRadioMenuItemAncestry $radiomenu, :$ref = True) {
    return Nil unless $radiomenu;

    my $o = self.bless(:$radiomenu);
    $o.ref if $ref;
    $o;
  }
  multi method new(
    Str()  $label,
          :$group    is copy,
          :$mnemonic          = False,
          *%opts
  ) {
    with $group {
      die "Invalid group type { $group.^name }"
        unless $group ~~ (
          Positional,
          GSList,
          GLib::GSList,
          GtkRadioMenuItem,
          GTK::RadioMenuItem
        ).any;
    }

    $group = GLib::GSList.new($group, typed => GtkRadioMenuItem)
      if $group ~~ Positional;

    $group .= GSList           if $group ~~ GLib::GSList;
    $group .= GtkRadioMenuItem if $group ~~ GTK::RadioMenuItem;

    samewith($group // GtkRadioMenuItem, $label, :$mnemonic, |%opts);
  }
  # May have to merge these next two with complex type checking logic for
  # the $group parameter.
  multi method new(
    GSList  $group,
    Str()   $label,
           :$mnemonic = False,
           *%opts
  ) {
    my $radiomenu;

    with $label {
      $radiomenu = $mnemonic
        ?? gtk_radio_menu_item_new_with_mnemonic($group, $label)
        !! gtk_radio_menu_item_new_with_label($group, $label);
    } else {
      $radiomenu = gtk_radio_menu_item_new($group);
    }
    $radiomenu ?? self.bless( :$radiomenu ) !! Nil;
  }
  multi method new(
    GtkRadioMenuItem  $group,
    Str()             $label,
                     :$mnemonic = False,
                     *%opts
  ) {
    $mnemonic
      ?? self.new_with_mnemonic_from_widget($group, $label)
      !! self.new_with_label_from_widget($group, $label);
  }

  method new_from_widget (GtkRadioMenuItem() $group)
    is also<new-from-widget>
  {
    my $radiomenu = gtk_radio_menu_item_new_from_widget($group);

    $radiomenu ?? self.bless(:$radiomenu) !! Nil;
  }

  method new_with_label (GSList() $group, Str() $label)
    is also<new-with-label>
  {
    my $radiomenu = gtk_radio_menu_item_new_with_label($group, $label);

    $radiomenu ?? self.bless( :$radiomenu ) !! Nil;
  }

  method new_with_label_from_widget (
    GtkRadioMenuItem() $group,
    Str()              $label
  )
    is also<new-with-label-from-widget>
  {
    my $radiomenu = gtk_radio_menu_item_new_with_label_from_widget(
      $group,
      $label
    );

    $radiomenu ?? self.bless( :$radiomenu ) !! Nil;
  }

  method new_with_mnemonic (GSList() $group, Str() $label)
    is also<new-with-mnemonic>
  {
    my $radiomenu = gtk_radio_menu_item_new_with_mnemonic($group, $label);

    $radiomenu ?? self.bless( :$radiomenu ) !! Nil;
  }

  method new_with_mnemonic_from_widget (
    GtkRadioMenuItem() $group,
    Str()              $label
  )
    is also<new-with-mnemonic-from-widget>
  {
    my $radiomenu = gtk_radio_menu_item_new_with_mnemonic_from_widget(
      $group,
      $label
    );

    $radiomenu ?? self.bless( :$radiomenu ) !! Nil;
  }

  # ↓↓↓↓ SIGNALS ↓↓↓↓

  # Is originally:
  # GtkRadioMenuItem, gpointer --> void
  method group-changed is also<group_changed> {
    self.connect($!rmi, 'group-changed');
  }

  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓\
  method group ( :glist(:$gslist) = False, :$raw = False ) is rw {
    Proxy.new(
      FETCH => sub ($) {
        returnGSList(
          gtk_radio_menu_item_get_group($!rmi),
          $raw,
          $gslist,
          |GTK::RadioMenuItem.getTypePair
        );
      },
      STORE => sub ($, GSList() $group is copy) {
        gtk_radio_menu_item_set_group($!rmi, $group);
      }
    );
  }
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  method join_group (GtkRadioMenuItem() $group_source) is also<join-group> {
    gtk_radio_menu_item_join_group($!rmi, $group_source);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    GTK::Widget.unstable_get_type( &gtk_radio_menu_item_get_type, $n, $t );
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
