use v6.c;

use Method::Also;

use GLib::GList;

use GTK::Raw::RadioMenuItem:ver<3.0.1146>;
use GTK::Raw::Types:ver<3.0.1146>;

use GTK::CheckMenuItem:ver<3.0.1146>;

use GLib::Roles::ListData;

our subset RadioMenuItemAncestry
  where GtkRadioMenuItem | CheckMenuItemAncestry;

class GTK::RadioMenuItem:ver<3.0.1146> is GTK::CheckMenuItem {
  has GtkRadioMenuItem $!rmi is implementor;

  method bless(*%attrinit) {
    my $o = self.CREATE.BUILDALL(Empty, %attrinit);
    $o.setType($o.^name);
    $o;
  }

  submethod BUILD(:$radiomenu) {
    my $to-parent;
    given $radiomenu {
      when RadioMenuItemAncestry {
        $!rmi = do {
          when GtkRadioMenuItem {
            $to-parent = cast(GtkMenuItem, $_);
            $_;
          }
          default {
            $to-parent = $_;
            cast(GtkRadioMenuItem, $_);
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

  method !postconf($radiomenu, %opts) {
    return Nil unless $radiomenu;

    my $o = self.bless( :$radiomenu );

    $o.toggled.tap({ %opts<clicked>() }) with %opts<clicked>;
    $o.toggled.tap({ %opts<toggled>() }) with %opts<toggled>;

    $o.group-changed.tap({ %opts<changed>() })
      with %opts<changed>;

    $o;
  }

  multi method new (RadioMenuItemAncestry $radiomenu, :$ref = True) {
    return Nil unless $radiomenu;

    my $o = self.bless(:$radiomenu);
    $o.ref if $ref;
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
  multi method new(
    GSList() $group,
    Str() $label,
    :$mnemonic = False,
    *%opts
  ) {
    my $radiomenu;
    with $label {
      $radiomenu = $mnemonic ??
        gtk_radio_menu_item_new_with_mnemonic($group, $label)
        !!
        gtk_radio_menu_item_new_with_label($group, $label);
    } else {
      $radiomenu = gtk_radio_menu_item_new($group);
    }

    self!postconf( $radiomenu, %opts );
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

    self!postconf( $radiomenu, %opts );
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

    $radiomenu ?? self.bless(:$radiomenu) !! Nil;
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

    $radiomenu ?? self.bless(:$radiomenu) !! Nil;
  }

  method new_with_mnemonic (GSList() $group, Str() $label)
    is also<new-with-mnemonic>
  {
    my $radiomenu = gtk_radio_menu_item_new_with_mnemonic($group, $label);

    $radiomenu ?? self.bless(:$radiomenu) !! Nil;
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

    $radiomenu ?? self.bless(:$radiomenu) !! Nil;
  }

  # ↓↓↓↓ SIGNALS ↓↓↓↓

  # Is originally:
  # GtkRadioMenuItem, gpointer --> void
  method group-changed is also<group_changed> {
    self.connect($!rmi, 'group-changed');
  }

  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓\
  method group (:$glist = False, :$raw = False) is rw {
  Proxy.new(
      FETCH => sub ($) {
        my $gl = gtk_radio_menu_item_get_group($!rmi);

        return Nil unless $gl;
        return $gl if     $glist;

        $gl = GLib::GList.new($gl) but GLib::Roles::ListData;

        $raw ?? $gl.Array !! $gl.Array.map({ GTK::RadioMenuItem.new($_) });
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
