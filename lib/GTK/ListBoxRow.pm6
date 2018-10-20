use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::ListBox;
use GTK::Raw::Types;

use GTK::Bin;

use GTK::Roles::Actionable;

my subset Ancestry
  where GtkListBoxRow | GtkBuildable | GtkActionable | GtkWidget;

class GTK::ListBoxRow is GTK::Bin {
  has GtkListBoxRow $!lbrr;

  method bless(*%attrinit) {
    my $o = self.CREATE.BUILDALL(Empty, %attrinit);
    $o.setType('GTK::ListBoxRow');
    $o;
  }

  submethod BUILD(:$row) {
    my $to-parent;
    given $row {
      when Ancestry {
        $!lbrr = do {
          when GtkWidget {
            $to-parent = $_;
            nativecast(GtkListBoxRow, $_);
          }
          when GtkActionable {
            $!action = nativecast(GtkActionable, $_);
            $to-parent = nativecast(GtkBin, $_);
            nativecast(GtkListBoxRow, $_);
          }
          when GtkBuildable {
            $!b = nativecast(GtkActionable, $_);
            $to-parent = nativecast(GtkBin, $_);
            nativecast(GtkListBoxRow, $_);
          }
          when GtkListBoxRow {
            $to-parent = nativecast(GtkBin, $_);
            $_;
          }
        }
        self.setParent($to-parent);
        $!b //= nativecast(GtkBuildable, $_);
        $!action //= native(GtkActionable, $_);
      }
      when GTK::ListBoxRow {
      }
      default {
      }
    }
  }

  multi method new {
    my $row = gtk_list_box_row_new();
    self.bless(:$row);
  }
  multi method new (Ancestry $row) {
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
        gtk_list_box_row_get_activatable($!lbr);
      },
      STORE => sub ($, $activatable is copy) {
        gtk_list_box_row_set_activatable($!lbr, $activatable);
      }
    );
  }

  method header is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_list_box_row_get_header($!lbr);
      },
      STORE => sub ($, $header is copy) {
        gtk_list_box_row_set_header($!lbr, $header);
      }
    );
  }

  method selectable is rw {
    Proxy.new(
      FETCH => sub ($) {
        so gtk_list_box_row_get_selectable($!lbr);
      },
      STORE => sub ($, $selectable is copy) {
        gtk_list_box_row_set_selectable($!lbr, $selectable);
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

  method get_index {
    gtk_list_box_row_get_index($!lbr);
  }

  method is_selected {
    gtk_list_box_row_is_selected($!lbr);
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
