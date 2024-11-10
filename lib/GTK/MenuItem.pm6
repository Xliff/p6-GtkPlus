use v6.c;

use Method::Also;

use GTK::Raw::MenuItem:ver<3.0.1146>;
use GTK::Raw::Types:ver<3.0.1146>;

use GTK::Roles::Actionable:ver<3.0.1146>;

use GTK::Bin:ver<3.0.1146>;

our subset GtkMenuItemAncestry is export
  where GtkMenuItem | GtkActionable | GtkBinAncestry;

class GTK::MenuItem:ver<3.0.1146> is GTK::Bin {
  also does GTK::Roles::Actionable;

  has GtkMenuItem $!mi is implementor;

  submethod BUILD ( :$menuitem ) {
    self.setGtkMenuItem($menuitem) if $menuitem;
  }

  submethod TWEAK (
    :$submenu,
    :$clicked,
    :$activate,
    :$right
  ) {
    if $submenu {
      self.submenu = $submenu if $submenu ~~ ( GtkMenu, ::('GTK::Menu') ).any;
    }

    # $clicked and $activate do the same thing.
    # DON'T GO OVERBOARD.
    self.activate.tap: SUB { $clicked()  } with $clicked;
    self.activate.tap: SUB { $activate() } with $activate && $clicked.not;
    self.right_justified = True if $right;
    self.show;
  }

  method setGtkMenuItem (GtkMenuItemAncestry $_) is also<setMenuItem> {
    say "Menu Item is a { .^name }";

    my $to-parent;

    $!mi = do {
      when GtkMenuItem {
        $to-parent = cast(GtkBin, $_);
        $_;
      }

      when GtkActionable {
        $!action   = $_;                            # GTK::Roles::Actionable
        $to-parent = cast(GtkBin, $_);
        cast(GtkMenuItem, $_);
      }

      default {
        $to-parent = $_;
        cast(GtkMenuItem, $_);
      }

    }
    self.roleInit-GtkActionable;
    self.setGtkBin($to-parent);
  }

  method GTK::Raw::Definitions::GtkMenuItem
    is also<GtkMenuItem>
  { $!mi }

  multi method new (GtkMenuItemAncestry $menuitem, :$ref = True) {
    return Nil unless $menuitem;

    my $o = self.bless(:$menuitem);
    $o.ref if $ref;
    $o;
  }
  multi method new {
    my $menuitem = gtk_menu_item_new();

    $menuitem ?? self.bless(:$menuitem) !! Nil;
  }

  multi method new(
    Str() $label,
    :$clicked,
    :$activate,
    :$right,
    :$mnemonic,
    :$submenu
  ) {
    my $menuitem = $mnemonic.so ??
      gtk_menu_item_new_with_mnemonic($label)
      !!
      gtk_menu_item_new_with_label($label);

    return Nil unless $menuitem;

    self.bless(
      :$menuitem,
      :$submenu,
      :$activate,
      :$clicked,
      :$right
    );
  }
  # multi method new(
  #   Str() :$label,
  #   Str() :$mnemonic
  # ) {
  #   die "Use ONE of \$label or \$mnemonic when using { ::?CLASS.^name }.new()"
  #     unless $label.defined ^^ $mnemonic.defined;
  #
  #   my $menuitem = do {
  #     with $label    { gtk_menu_item_new_with_label($_);    }
  #     with $mnemonic { gtk_menu_item_new_with_mnemonic($_); }
  #   };
  #   self.bless(:$menuitem);
  # }

  method new_with_label (Str() $label) is also<new-with-label> {
    my $menuitem = gtk_menu_item_new_with_label($label);

    $menuitem ?? self.bless(:$menuitem) !! Nil;
  }

  method new_with_mnemonic (Str() $label) is also<new-with-mnemonic> {
    my $menuitem = gtk_menu_item_new_with_mnemonic($label);

    $menuitem ?? self.bless(:$menuitem) !! Nil;
  }

  # ↓↓↓↓ SIGNALS ↓↓↓↓

  # Is originally:
  # GtkMenuItem, gpointer --> void
  method activate {
    self.connect($!mi, 'activate');
  }

  # Is originally:
  # GtkMenuItem, gpointer --> void
  method activate-item is also<activate_item> {
    self.connect($!mi, 'activate-item');
  }

  # Is originally:
  # GtkMenuItem, gpointer --> void
  method deselect {
    self.connect($!mi, 'deselect');
  }

  # Is originally:
  # GtkMenuItem, gpointer --> void
  method select {
    self.connect($!mi, 'select');
  }

  # Is originally:
  # GtkMenuItem, gint, gpointer --> void
  method toggle-size-allocate is also<toggle_size_allocate> {
    self.connect-int($!mi, 'toggle-size-allocate');
  }

  # Is originally:
  # GtkMenuItem, gpointer, gpointer --> void
  method toggle-size-request is also<toggle_size_request> {
    self.connect-pointer($!mi, 'toggle-size-request');
  }
  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  method accel_path is rw is also<accel-path> {
    Proxy.new(
      FETCH => sub ($) {
        gtk_menu_item_get_accel_path($!mi);
      },
      STORE => sub ($, Str() $accel_path is copy) {
        gtk_menu_item_set_accel_path($!mi, $accel_path);
      }
    );
  }

  method label is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_menu_item_get_label($!mi);
      },
      STORE => sub ($, Str() $label is copy) {
        gtk_menu_item_set_label($!mi, $label);
      }
    );
  }

  method reserve_indicator is rw is also<reserve-indicator> {
    Proxy.new(
      FETCH => sub ($) {
        so gtk_menu_item_get_reserve_indicator($!mi);
      },
      STORE => sub ($, Int() $reserve is copy) {
        my gboolean $r = $reserve.so.Int;

        gtk_menu_item_set_reserve_indicator($!mi, $r);
      }
    );
  }

  method submenu (:$raw = False, :$widget = False) is rw {
    # We can't bring in MenuShellAncestry without causing all kinds of bad,
    # so we reproduce it here. In a set of bad options, it's the one that's
    # the least bad.
    my subset WidgetOrObject of Mu
      where GTK::Widget | GtkWidget;

    Proxy.new(
      FETCH => sub ($) {
        my $w = gtk_menu_item_get_submenu($!mi);

        self.ReturnWidget($w, $raw, $widget);
      },
      STORE => sub ($, WidgetOrObject $submenu is copy) {
        self.set_end($submenu);
        $submenu .= Widget if $submenu ~~ GTK::Widget;
        gtk_menu_item_set_submenu($!mi, $submenu);
      }
    );
  }

  method use_underline is rw is also<use-underline> {
    Proxy.new(
      FETCH => sub ($) {
        so gtk_menu_item_get_use_underline($!mi);
      },
      STORE => sub ($, Int() $setting is copy) {
        my gboolean $s = $setting.so.Int;

        gtk_menu_item_set_use_underline($!mi, $s);
      }
    );
  }
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  method right-justified is also<right_justified> {
    ($.hexpand, $.halign) = (True, GTK_ALIGN_END);
  }

  # ↓↓↓↓ METHODS ↓↓↓↓
  method emit-activate is also<emit_activate> {
    gtk_menu_item_activate($!mi);
  }

  method emit-deselect is also<emit_deselect> {
    gtk_menu_item_deselect($!mi);
  }

  method emit-select is also<emit_select> {
    gtk_menu_item_select($!mi);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    GTK::Widget.unstable_get_type( &gtk_menu_item_get_type, $n, $t );
  }

  method emit_toggle_size_allocate (Int() $allocation)
    is also<emit-toggle-size-allocate>
  {
    my gint $a = $allocation;

    gtk_menu_item_toggle_size_allocate($!mi, $a);
  }

  method emit_toggle_size_request (Int() $requisition)
    is also<emit-toggle-size-request>
  {
    my gint $r = $requisition;

    gtk_menu_item_toggle_size_request($!mi, $r);
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
