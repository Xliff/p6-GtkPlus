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
    use nqp;
    my $o = nqp::create(self).BUILDALL(Empty, %attrinit);
    $o.setType('GTK::RadioMenuItem');
    $o;
  }

  submethod BUILD(:$radiomenu) {
    my $to-parent;
    given $radiomenu {
      when GtkRadioMenuItem | GtkWidget {
        $!rmi = do {
          when GtkWidget {
            $to-parent = $_
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

  multi method new {
    $radiomenu = gtk_radio_menu_item_new();
    self.bless(:$radiomenu);
  }
  multi method new (GtkWidget $radiomenu) {
    self.bless(:$radiomenu);
  }
  multi method new(:$widget, Str() :$label, Str() :$mnemonic) {
    without $widget {
      die "Must specify ONE of \$label or \$mnemonic when using { ::?CLASS }.new"
        unless $label.defined ^^ $mnemonic.defined;

      $radiomenu = do {
        when $label.defined {
          gtk_radio_menu_item_new_with_label($label);
        }
        when $mnemonic.defined {
          gtk_radio_menu_item_new_with_mnemonic($mnemonic);
        }
      };
      return self.bless(:$radiomenu);
    }

    die "\$widget must be a GtkRadioMenuItem or GTK::RadioMenuItem";
      unless $widget ~~ (GtkWidget, GtkRadioMenuItem, GTK::RadioMenuItem).any;
    die "\$widget must be GTK::RadioMenuItem"
      unless $widget.getType eq ('GTK::RadioMenuItem', '').any;
    die "Must specify ONE of \$label or \$mnemonic when using { ::?CLASS }.new"
      if $label.defined && $mnemonic.defined;

    my $w = do given $widget {
      when GtkWidget          { nativecast(GtkRadioMenuItem, $widget); }
      when GtkRadioMenuItem   { $widget; }
      when GTK::RadioMenuItem { $widget.radiomenuitem; }
    }
    $radiomenu = do {
      with $label {
        gtk_radio_menu_item_new_with_label_from_widget($w, $label);
      } orwith $mnemnic {
        gtk_radio_menu_item_new_with_mnemonic_from_widget($w, $label);
      } else {
        gtk_radio_menu_item_new_from_widget($w);
      }
    }
    self.bless(:$radiomenu);
  }

  method new_from_widget (GtkRadioMenuItem() $group) {
    $radiomenu = gtk_radio_menu_item_new_from_widget($group);
    self.bless(:$radiomenu);
  }

  method new_with_label (gchar $label) {
    $radiomenu = gtk_radio_menu_item_new_with_label($label);
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

  method new_with_mnemonic (gchar $label) {
    my $radiomenu = gtk_radio_menu_item_new_with_mnemonic($label);
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
        GSList.new( gtk_radio_menu_item_get_group($!rmi) );
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
