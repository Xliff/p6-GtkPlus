use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Dialog::Raw::FontChooser;
use GTK::Raw::Types;

use GTK::Dialog;

use GTK::Roles::FontChooser;

class GTK::Dialog::FontChooser is GTK::Dialog {
  also does GTK::Roles::FontChooser;

  has GtkFontChooserDialog $!fcd;

  method bless(*%attrinit) {
    my $o = self.CREATE.BUILDALL(Empty, %attrinit);
    $o.setType('GTK::Dialog::FontChoser');
    $o;
  }

  submethod BUILD(:$dialog) {
    my $to-parent;
    given $dialog {
      when GtkFontChooserDialog | GtkWidget {
        $!fcd = do {
          when GtkWidget {
            $to-parent = $_;
            nativecast(GtkFontChooserDialog, $_);
          }
          when GtkFontChooserDialog {
            $to-parent = nativecast(GtkDialog, $_);
            $_;
          }
        }
        self.setDialog($to-parent);
      }
      when GTK::Dialog::FontChooser {
      }
      default {
      }
    }
    # For GTK::Roles::GtkFontChooser
    $!fc = nativecast(GtkFontChooser, $!fcd);
  }

  # ↓↓↓↓ SIGNALS ↓↓↓↓
  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  method get_type {
    gtk_font_chooser_dialog_get_type();
  }

  multi method new (Str() $title, GtkWindow() $parent) {
    my $dialog = gtk_font_chooser_dialog_new($title, $parent);
    self.bless(:$dialog);
  }
  multi method new(GtkWidget $dialog) {
    self.bless(:$dialog);
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
