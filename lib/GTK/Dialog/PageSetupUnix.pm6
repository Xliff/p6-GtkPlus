use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Dialog::Raw::PageSetupUnix;
use GTK::Raw::Types;

use GTK::Dialog;
use GTK::PageSetup;
use GTK::PrintSettings;

my subset Ancestry
  where GtkPageSetupUnixDialog | GtkDialog | GtkBuildable | GtkWidget;

class GTK::Dialog::PageSetupUnix is GTK::Dialog {
  has GtkPageSetupUnixDialog $!psd;

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
          when GtkWidget | GtkDialog {
            $to-parent = $_;
            nativecast(GtkPageSetupUnixDialog, $_);
          }
          when GtkPageSetupUnixDialog {
            $to-parent = nativecast(GtkDialog, $_);
            $_;
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

  multi method new (Str() $title, GtkWindow() $parent) {
    gtk_page_setup_unix_dialog_new($title, $parent);
  }
  multi method new (Ancestry $dialog) {
    self.bless(:$dialog);
  }

  # ↓↓↓↓ SIGNALS ↓↓↓↓
  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  method page_setup is rw {
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

  method print_settings is rw {
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
  method get_type {
    gtk_page_setup_unix_dialog_get_type();
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
