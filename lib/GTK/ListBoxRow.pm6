use v6.c;

use Method::Also;
use NativeCall;


use GTK::Raw::ListBox;
use GTK::Raw::Types;

use GTK::Bin;

use GTK::Roles::Actionable;

our subset ListBoxRowAncestry
  where GtkListBoxRow | GtkActionable | BinAncestry;

class GTK::ListBoxRow is GTK::Bin {
  also does GTK::Roles::Actionable;

  has GtkListBoxRow $!lbr is implementor;

  method bless(*%attrinit) {
    my $o = self.CREATE.BUILDALL(Empty, %attrinit);
    $o.setType($o.^name);
    $o;
  }

  submethod BUILD(:$row) {
    my $to-parent;
    given $row {
      when ListBoxRowAncestry {
        $!lbr = do {
          when GtkListBoxRow {
            $to-parent = nativecast(GtkBin, $_);
            $_;
          }
          when GtkActionable {
            $!action = $_;                          # GTK::Roles::Actionable
            $to-parent = nativecast(GtkBin, $_);
            nativecast(GtkListBoxRow, $_);
          }
          default {
            $to-parent = $_;
            nativecast(GtkListBoxRow, $_);
          }

        }
        $!action //= nativecast(GtkActionable, $_); # GTK::Roles::Actionable
        self.setBin($to-parent);
      }
      when GTK::ListBoxRow {
      }
      default {
      }
    }
  }

  method GTK::Raw::Types::GtkListBoxRow is also<ListBoxRow> { $!lbr }

  multi method new (ListBoxRowAncestry $row) {
    my $o = self.bless(:$row);
    $o.upref;
    $o;
  }
  multi method new {
    my $row = gtk_list_box_row_new();
    self.bless(:$row);
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
        my gboolean $a = self.RESOLVE-BOOL($activatable);
        gtk_list_box_row_set_activatable($!lbr, $a);
      }
    );
  }

  method header is rw {
    Proxy.new(
      FETCH => sub ($) {
        GTK::Widget.new( gtk_list_box_row_get_header($!lbr) );
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
        my gboolean $s = self.RESOLVE-BOOL($selectable);
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
    gtk_list_box_row_is_selected($!lbr);
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
