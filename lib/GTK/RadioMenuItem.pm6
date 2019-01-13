use v6.c;

use Method::Also;
use NativeCall;

use GTK::Compat::GSList;
use GTK::Compat::Types;
use GTK::Raw::RadioMenuItem;
use GTK::Raw::Types;

use GTK::MenuItem;

my subset Ancestry
  where GtkRadioMenuItem | GtkCheckMenuItem | GtkMenuItem | GtkActionable |
        GtkBin           | GtkContainer     | GtkBuilder  | GtkWidget;

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
      when Ancestry {
        $!rmi = do {
          when GtkRadioMenuItem {
            $to-parent = nativecast(GtkMenuItem, $_);
            $_;
          }
          default {
            $to-parent = $_;
            nativecast(GtkRadioMenuItem, $_);
          }
        }
        self.setMenuItem($to-parent);
      }
      when GTK::RadioMenuItem {
      }
      default {
      }
    }
  }

  my sub postconf($o, %opts) {
    $o.toggled.tap({ %opts<clicked>() }) with %opts<clicked>;
    $o.toggled.tap({ %opts<toggled>() }) with %opts<toggled>;

    $o.group-changed.tap({ %opts<changed>() })
      with %opts<changed>;

    $o;
  }

  # So that GtkRadioMenuItem() works in signatures.
  method GTK::Raw::Types::GtkRadioMenuItem {
    $!rmi;
  }
  # Aliasing FTW -- next code review!
  method radiomenuitem {
    $!rmi;
  }

  multi method new (Ancestry $radiomenu) {
    my $o = self.bless(:$radiomenu);
    $o.upref;
    $o;
  }
  multi method new(Str() $label, :$mnemonic = False, :$group, *%opts) {
    with $group {
      die "Invalid group type { $group.^name }"
        unless $group ~~ (GSList, GtkRadioMenuItem, GTK::RadioMenuItem).any;
    }
    samewith($group // GtkRadioMenuItem, $label, :$mnemonic, |%opts);
  }
  # May have to merge these next two with complex type checking logic for
  # the $group parameter.
  multi method new(GSList $group, Str() $label, :$mnemonic = False, *%opts) {
    my $radiomenu;
    with $label {
      $radiomenu = $mnemonic ??
        gtk_radio_menu_item_new_with_mnemonic($group, $label)
        !!
        gtk_radio_menu_item_new_with_label($group, $label);
    } else {
      $radiomenu = gtk_radio_menu_item_new($group);
    }
    postconf( self.bless(:$radiomenu), %opts );
  }
  multi method new(
    GtkRadioMenuItem() $group,
    Str() $label,
    :$mnemonic = False,
    *%opts
  ) {
    my $radiomenu;
    with $label {
      $radiomenu = $mnemonic ??
        gtk_radio_menu_item_new_with_mnemonic_from_widget($group, $label)
        !!
        gtk_radio_menu_item_new_with_label_from_widget($group, $label);
    } else {
      $radiomenu = gtk_radio_menu_item_new($group);
    }
    postconf( self.bless(:$radiomenu), %opts );
  }

  method new_from_widget (GtkRadioMenuItem() $group)
    is also<new-from-widget>
  {
    my $radiomenu = gtk_radio_menu_item_new_from_widget($group);
    self.bless(:$radiomenu);
  }

  method new_with_label (GSList() $group, Str() $label)
    is also<new-with-label>
  {
    my $radiomenu = gtk_radio_menu_item_new_with_label($group, $label);
    self.bless(:$radiomenu);
  }

  method new_with_label_from_widget (
    GtkRadioMenuItem() $group,
    Str() $label
  )
    is also<new-with-label-from-widget>
  {
    my $radiomenu = gtk_radio_menu_item_new_with_label_from_widget(
      $group,
      $label
    );
    self.bless(:$radiomenu);
  }

  method new_with_mnemonic (GSList() $group, Str() $label)
    is also<new-with-mnemonic>
  {
    my $radiomenu = gtk_radio_menu_item_new_with_mnemonic($group, $label);
    self.bless(:$radiomenu);
  }

  method new_with_mnemonic_from_widget (
    GtkRadioMenuItem() $group,
    Str() $label
  )
    is also<new-with-mnemonic-from-widget>
  {
    my $radiomenu = gtk_radio_menu_item_new_with_mnemonic_from_widget(
      $group,
      $label
    );
    self.bless(:$radiomenu);
  }

  # ↓↓↓↓ SIGNALS ↓↓↓↓

  # Is originally:
  # GtkRadioMenuItem, gpointer --> void
  method group-changed is also<group_changed> {
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
  method join_group (GtkRadioMenuItem() $group_source) is also<join-group> {
    gtk_radio_menu_item_join_group($!rmi, $group_source);
  }

  method get_type is also<get-type> {
    gtk_radio_menu_item_get_type();
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
