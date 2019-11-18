use v6.c;

use Method::Also;
use NativeCall;

use GTK::Compat::Types;
use GTK::Dialog::Raw::PageSetupUnix;
use GTK::Raw::Types;

use GTK::Dialog;
use GTK::PageSetup;
use GTK::PrintSettings;

my subset Ancestry
  where GtkPageSetupUnixDialog | GtkDialog    | GtkWindow | GtkBin |
        GtkContainer           | GtkBuildable | GtkWidget;

class GTK::Dialog::PageSetupUnix is GTK::Dialog {
  has GtkPageSetupUnixDialog $!psd is implementor;

  method bless(*%attrinit) {
    my $o = self.CREATE.BUILDALL(Empty, %attrinit);
    $o.setType('GTK::Dialog::PageSetupUnix');
    $o;
  }

  submethod BUILD(:$dialog) {
    my $to-parent;
    given $dialog {
      when Ancestry {
        $!psd = do {
          when GtkPageSetupUnixDialog {
            $to-parent = nativecast(GtkDialog, $_);
            $_;
          }
          default {
            $to-parent = $_;
            nativecast(GtkPageSetupUnixDialog, $_);
          }
        }
        self.setDialog($to-parent);
      }
      when GTK::Dialog::PageSetupUnix {
      }
      default {
      }
    }
  }

  multi method new (Ancestry $dialog) {
    my $o = self.bless(:$dialog);
    $o.upref;
    $o;
  }
  multi method new (Str() $title, GtkWindow() $parent) {
    my $dialog = gtk_page_setup_unix_dialog_new($title, $parent);
    self.bless(:$dialog);
  }

  # ↓↓↓↓ SIGNALS ↓↓↓↓
  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  method page_setup is rw is also<page-setup> {
    Proxy.new(
      FETCH => sub ($) {
        GTK::PageSetup.new(
          gtk_page_setup_unix_dialog_get_page_setup($!psd)
        );
      },
      STORE => sub ($, GtkPageSetup() $page_setup is copy) {
        gtk_page_setup_unix_dialog_set_page_setup($!psd, $page_setup);
      }
    );
  }

  method print_settings is rw is also<print-settings> {
    Proxy.new(
      FETCH => sub ($) {
        GTK::PrintSettings(
          gtk_page_setup_unix_dialog_get_print_settings($!psd)
        );
      },
      STORE => sub ($, GtkPrintSettings() $print_settings is copy) {
        gtk_page_setup_unix_dialog_set_print_settings(
          $!psd,
          $print_settings
        );
      }
    );
  }
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ PROPERTIES ↓↓↓↓
  # ↑↑↑↑ PROPERTIES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  method get_type is also<get-type> {
    gtk_page_setup_unix_dialog_get_type();
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
