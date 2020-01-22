use v6.c;

use Method::Also;
use NativeCall;

use GTK::Dialog::Raw::PrintUnix;
use GTK::Raw::Types;

use GTK::Dialog;
use GTK::PageSetup;
use GTK::Printer;
use GTK::PrintSettings;

my subset PrintUnixDialogAncestry is export
  where GtkPrintUnixDialog | DialogAncestry;

class GTK::Dialog::PrintUnix is GTK::Dialog {
  has GtkPrintUnixDialog $!pud is implementor;

  method bless(*%attrinit) {
    my $o = self.CREATE.BUILDALL(Empty, %attrinit);
    $o.setType($o.^name);
    $o;
  }

  submethod BUILD(:$print-dialog) {
    my $to-parent;
    given $print-dialog {
      when PrintUnixDialogAncestry {
        $!pud = do {
          when GtkPrintUnixDialog {
            $to-parent = nativecast(GtkDialog, $_);
            $_;
          }
          default {
            $to-parent = $_;
            nativecast(GtkPrintUnixDialog, $_);
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

  multi method new (PrintUnixDialogAncestry $print-dialog, :$ref = True) {
    return Nil unless $print-dialog;

    my $o = self.bless(:$print-dialog);
    $o.ref if $ref;
    $o;
  }
  multi method new (Str() $title, GtkWindow() $parent) {
    my $print-dialog = gtk_print_unix_dialog_new($title, $parent);

    $print-dialog ?? self.bless(:$print-dialog) !! Nil;
  }

  # ↓↓↓↓ SIGNALS ↓↓↓↓
  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  method current_page is rw is also<current-page> {
    Proxy.new(
      FETCH => sub ($) {
        gtk_print_unix_dialog_get_current_page($!pud);
      },
      STORE => sub ($, Int() $current_page is copy) {
        my gint $cp = $current_page;

        gtk_print_unix_dialog_set_current_page($!pud, $cp);
      }
    );
  }

  method embed_page_setup is rw is also<embed-page-setup> {
    Proxy.new(
      FETCH => sub ($) {
        so gtk_print_unix_dialog_get_embed_page_setup($!pud);
      },
      STORE => sub ($, Int() $embed is copy) {
        my gboolean $e = $embed;

        gtk_print_unix_dialog_set_embed_page_setup($!pud, $e);
      }
    );
  }

  method has_selection is rw is also<has-selection> {
    Proxy.new(
      FETCH => sub ($) {
        so gtk_print_unix_dialog_get_has_selection($!pud);
      },
      STORE => sub ($, Int() $has_selection is copy) {
        my gboolean $hs = $has_selection;

        gtk_print_unix_dialog_set_has_selection($!pud, $hs);
      }
    );
  }

  method manual_capabilities is rw is also<manual-capabilities> {
    Proxy.new(
      FETCH => sub ($) {
        GtkPrintCapabilitiesEnum(
          gtk_print_unix_dialog_get_manual_capabilities($!pud)
        );
      },
      STORE => sub ($, Int() $capabilities is copy) {
        my guint $c = $capabilities;

        gtk_print_unix_dialog_set_manual_capabilities($!pud, $c);
      }
    );
  }

  method page_setup (:$raw = False) is rw is also<page-setup> {
    Proxy.new(
      FETCH => sub ($) {
        my $ps = gtk_print_unix_dialog_get_page_setup($!pud);

        $ps ??
          ( $raw ?? $ps !! GTK::PageSetup.new($ps) )
          !!
          Nil;
      },
      STORE => sub ($, GtkPageSetup() $page_setup is copy) {
        gtk_print_unix_dialog_set_page_setup($!pud, $page_setup);
      }
    );
  }

  method settings (:$raw = False) is rw {
    Proxy.new(
      FETCH => sub ($) {
        my $ps = gtk_print_unix_dialog_get_settings($!pud);

        $ps ??
          ( $raw ?? $ps !! GTK::PrintSettings.new($ps) )
          !!
          Nil;
      },
      STORE => sub ($, GtkPrintSettings() $settings is copy) {
        gtk_print_unix_dialog_set_settings($!pud, $settings);
      }
    );
  }

  method support_selection is rw is also<support-selection> {
    Proxy.new(
      FETCH => sub ($) {
        so gtk_print_unix_dialog_get_support_selection($!pud);
      },
      STORE => sub ($, Int() $support_selection is copy) {
        my gboolean $ss = $support_selection;

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
  )
    is also<add-custom-tab>
  {
    gtk_print_unix_dialog_add_custom_tab($!pud, $child, $tab_label);
  }

  method get_page_setup_set is also<get-page-setup-set> {
    so gtk_print_unix_dialog_get_page_setup_set($!pud);
  }

  method get_selected_printer (:$raw = False) is also<get-selected-printer> {
    my $p = gtk_print_unix_dialog_get_selected_printer($!pud);

    $p ??
      ( $raw ?? $p !! GTK::Printer.new($p) )
      !!
      Nil;
  }

  method get_type is also<get-type> {
    state ($n, $t) ;

    unstable_get_type( self.^name, &gtk_print_unix_dialog_get_type, $n, $t );
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
