use v6.c;

use NativeCall;

use GTK::Compat::GSList;
use GTK::Compat::Types;
use GTK::Raw::RadioMenuItem;
use GTK::Raw::Types;

use GTK::MenuItem;

class GTK::RadioMenuItem is GTK::MenuItem {
  has GtkRadioMenuItem $!rmi;

  method bless(*%attrinit) {
    my $o = self.CREATE.BUILDALL(Empty, %attrinit);
    $o.setType('GTK::RadioMenuItem');
    $o;
  }

  submethod BUILD(:$radiomenu) {
    my $to-parent;
    given $radiomenu {
      when GtkRadioMenuItem | GtkWidget {
        $!rmi = do {
          when GtkWidget {
            $to-parent = $_;
            nativecast(GtkRadioMenuItem, $_);
          }
          when GtkRadioMenuItem {
            $to-parent = nativecast(GtkMenuItem, $_);
            $_;
          }
        }
        self.setParent($to-parent);
      }
      when GTK::RadioMenuItem {
      }
      default {
      }
    }
  }

  # So that GtkRadioMenuItem() works in signatures.
  method GTK::Raw::Types::GtkRadioMenuItem {
    $!rmi;
  }
  # Aliasing FTW -- next code review!
  method radiomenuitem {
    $!rmi;
  }

  multi method new (GtkWidget $radiomenu) {
    self.bless(:$radiomenu);
  }
  multi method new(GSList() $group, Str() :$label, :$mnemonic = False) {
    my $radiomenu;
    with $label {
      $radiomenu = $mnemonic ??
        gtk_radio_menu_item_new_with_mnemonic($group, $label)
        !!
        gtk_radio_menu_item_new_with_label($group, $label);
    } else {
      $radiomenu = gtk_radio_menu_item_new($group);
    }
    self.bless(:$radiomenu);
  }

  method new_from_widget (GtkRadioMenuItem() $group) {
    my $radiomenu = gtk_radio_menu_item_new_from_widget($group);
    self.bless(:$radiomenu);
  }

  method new_with_label (GSList() $group, gchar $label) {
    my $radiomenu = gtk_radio_menu_item_new_with_label($group, $label);
    self.bless(:$radiomenu);
  }

  method new_with_label_from_widget (
    GtkRadioMenuItem() $group,
    gchar $label
  ) {
    my $radiomenu = gtk_radio_menu_item_new_with_label_from_widget(
      $group,
      $label
    );
    self.bless(:$radiomenu);
  }

  method new_with_mnemonic (GSList() $group, gchar $label) {
    my $radiomenu = gtk_radio_menu_item_new_with_mnemonic($group, $label);
    self.bless(:$radiomenu);
  }

  method new_with_mnemonic_from_widget (
    GtkRadioMenuItem() $group,
    gchar $label
  ) {
    my $radiomenu = gtk_radio_menu_item_new_with_mnemonic_from_widget(
      $group,
      $label
    );
    self.bless(:$radiomenu);
  }

  # ↓↓↓↓ SIGNALS ↓↓↓↓

  # Is originally:
  # GtkRadioMenuItem, gpointer --> void
  method group-changed {
    self.connect($!rmi, 'group-changed');
  }
  
  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓\
  method group is rw {
  Proxy.new(
      FETCH => sub ($) {
        GTK::Compat::GSList.new( gtk_radio_menu_item_get_group($!rmi) );
      },
      STORE => sub ($, GSList() $group is copy) {
        gtk_radio_menu_item_set_group($!rmi, $group);
      }
    );
  }
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  method join_group (GtkRadioMenuItem() $group_source) {
    gtk_radio_menu_item_join_group($!rmi, $group_source);
  }

  method get_type {
    gtk_radio_menu_item_get_type();
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
