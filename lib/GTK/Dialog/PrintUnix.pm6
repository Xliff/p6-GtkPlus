use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Dialog::Raw::PrintUnix;
use GTK::Raw::Types;

use GTK::Dialog;

my subset Ancestry
  where GtkPrintUnixDialog | GtkDialog | GtkBuildable | GtkWidget;

class GTK::Dialog::PrintUnix is GTK::Dialog {
  has GtkPrintUnixDialog $!pud;

  method bless(*%attrinit) {
    my $o = self.CREATE.BUILDALL(Empty, %attrinit);
    $o.setType('GTK::Dialog::PrintUnix');
    $o;
  }

  submethod BUILD(:$dialog) {
    my $to-parent;
    given $dialog {
      when Ancestry {
        $!pud = do {
          when GtkWidget | GtkDialog {
            $to-parent = $_;
            nativecast(GtkPrintUnixDialog, $_);
          }
          when GtkPrintUnixDialog {
            $to-parent = nativecast(GtkDialog, $_);
            $_;
          }
        }
        self.setDialog($to-parent);
      }
      when GTK::Dialog::PrintUnix {
      }
      default {
      }
    }
  }

  multi method new (Ancestry $dialog) {
    self.bless(:$dialog);
  }
  multi method new (Str $title, GtkWindow $parent) {
    my $dialog = gtk_print_unix_dialog_new($title, $parent);
    self.bless(:$dialog);
  }

  # ↓↓↓↓ SIGNALS ↓↓↓↓
  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  method current_page is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_print_unix_dialog_get_current_page($!pud);
      },
      STORE => sub ($, Int() $current_page is copy) {
        my gint $cp = self.RESOLVE-INT($current_page);
        gtk_print_unix_dialog_set_current_page($!pud, $cp);
      }
    );
  }

  method embed_page_setup is rw {
    Proxy.new(
      FETCH => sub ($) {
        so gtk_print_unix_dialog_get_embed_page_setup($!pud);
      },
      STORE => sub ($, $embed is copy) {
        my gboolean $e = self.RESOLVE-BOOL($embed);
        gtk_print_unix_dialog_set_embed_page_setup($!pud, $e);
      }
    );
  }

  method has_selection is rw {
    Proxy.new(
      FETCH => sub ($) {
        so gtk_print_unix_dialog_get_has_selection($!pud);
      },
      STORE => sub ($, $has_selection is copy) {
        my gboolean $hs = self.RESOLVE-BOOLEAN($has_selection);
        gtk_print_unix_dialog_set_has_selection($!pud, $hs);
      }
    );
  }

  method manual_capabilities is rw {
    Proxy.new(
      FETCH => sub ($) {
        GtkPrintCapabilities(
          gtk_print_unix_dialog_get_manual_capabilities($!pud)
        );
      },
      STORE => sub ($, Int() $capabilities is copy) {
        my guint $c = self.RESOLVE-UINT($capabilities);
        gtk_print_unix_dialog_set_manual_capabilities($!pud, $c);
      }
    );
  }

  method page_setup is rw {
    Proxy.new(
      FETCH => sub ($) {
        GTK::PageSetup.new( gtk_print_unix_dialog_get_page_setup($!pud) );
      },
      STORE => sub ($, GtkPageSetup() $page_setup is copy) {
        gtk_print_unix_dialog_set_page_setup($!pud, $page_setup);
      }
    );
  }

  method settings is rw {
    Proxy.new(
      FETCH => sub ($) {
        GTK::PrintSettings.new(
          gtk_print_unix_dialog_get_settings($!pud)
        );
      },
      STORE => sub ($, GtkPrintSettings() $settings is copy) {
        gtk_print_unix_dialog_set_settings($!pud, $settings);
      }
    );
  }

  method support_selection is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_print_unix_dialog_get_support_selection($!pud);
      },
      STORE => sub ($, $support_selection is copy) {
        my gboolean $ss = self.RESOLVE-BOOL($support_selection);
        gtk_print_unix_dialog_set_support_selection($!pud, $ss);
      }
    );
  }

  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ PROPERTIES ↓↓↓↓
  # ↑↑↑↑ PROPERTIES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  method add_custom_tab (
    GtkWidget() $child,
    GtkWidget() $tab_label
  ) {
    gtk_print_unix_dialog_add_custom_tab($!pud, $child, $tab_label);
  }

  method get_page_setup_set {
    gtk_print_unix_dialog_get_page_setup_set($!pud);
  }

  method get_selected_printer {
    gtk_print_unix_dialog_get_selected_printer($!pud);
  }

  method get_type {
    gtk_print_unix_dialog_get_type();
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
