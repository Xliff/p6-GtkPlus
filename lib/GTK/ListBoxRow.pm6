use v6.c;

use Method::Also;

use GTK::Raw::ListBox;
use GTK::Raw::Types;

use GTK::Bin;

use GTK::Roles::Actionable;

our subset GtkListBoxRowAncestry is export of Mu
  where GtkListBoxRow | GtkActionable | BinAncestry;

class GTK::ListBoxRow is GTK::Bin {
  also does GTK::Roles::Actionable;

  has GtkListBoxRow $!lbr is implementor;

  method bless(*%attrinit) {
    my $o = self.CREATE.BUILDALL(Empty, %attrinit);
    $o.setType($o.^name);
    $o;
  }

  submethod BUILD( :$row ) {
    self.setGtkListBoxRow($row) if $row;
  }

  method setGtkListBoxRow (GtkListBoxRowAncestry $_) {
    my $to-parent;

    $!lbr = do {
      when GtkListBoxRow {
        $to-parent = cast(GtkBin, $_);
        $_;
      }
      when GtkActionable {
        $!action = $_;                          # GTK::Roles::Actionable
        $to-parent = cast(GtkBin, $_);
        cast(GtkListBoxRow, $_);
      }
      default {
        $to-parent = $_;
        cast(GtkListBoxRow, $_);
      }

    }
    $!action //= cast(GtkActionable, $_); # GTK::Roles::Actionable
    self.setBin($to-parent);
  }

  method GTK::Raw::Definitions::GtkListBoxRow
    is also<
      ListBoxRow
      GtkListBoxRow
    >
  { $!lbr }

  multi method new (GtkListBoxRowAncestry $row, :$ref = True) {
    return Nil unless $row;

    my $o = self.bless(:$row);
    $o.ref if $ref;
    $o;
  }
  multi method new {
    my $row = gtk_list_box_row_new();

    $row ?? self.bless(:$row) !! Nil;
  }

  # ↓↓↓↓ SIGNALS ↓↓↓↓

  # Is originally:
  # GtkListBoxRow, gpointer --> void
  method activate {
    self.connect($!lbr, 'activate');
  }
  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  method activatable is rw {
    Proxy.new(
      FETCH => sub ($) {
        so gtk_list_box_row_get_activatable($!lbr);
      },
      STORE => sub ($, Int() $activatable is copy) {
        my gboolean $a = $activatable.so.Int;

        gtk_list_box_row_set_activatable($!lbr, $a);
      }
    );
  }

  method header (:$raw = False, :$widget = False) is rw {
    Proxy.new(
      FETCH => sub ($) {
        my $w = gtk_list_box_row_get_header($!lbr);

        self.ReturnWidget($w, $raw, $widget);
      },
      STORE => sub ($, GtkWidget() $header is copy) {
        gtk_list_box_row_set_header($!lbr, $header);
      }
    );
  }

  method selectable is rw {
    Proxy.new(
      FETCH => sub ($) {
        so gtk_list_box_row_get_selectable($!lbr);
      },
      STORE => sub ($, Int() $selectable is copy) {
        my gboolean $s = $selectable.so.Int;

        gtk_list_box_row_set_selectable($!lbr, $s);
      }
    );
  }
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ PROPERTIES ↓↓↓↓
  # ↑↑↑↑ PROPERTIES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  method changed {
    gtk_list_box_row_changed($!lbr);
  }

  method get_index
    is also<
      get-index
      index
    >
  {
    gtk_list_box_row_get_index($!lbr);
  }

  method is_selected
    is also<
      is-selected
      selected
    >
  {
    so gtk_list_box_row_is_selected($!lbr);
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
