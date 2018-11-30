use v6.c;

use Method::Also;
use NativeCall;

use GTK::Compat::Types;
use GTK::Dialog::Raw::FontChooser;
use GTK::Raw::Types;

use GTK::Dialog;

use GTK::Roles::FontChooser;

my subset Ancestry
  where GtkFontChooserDialog | GtkFontChooser | GtkDialog  | GtkWindow |
        GtkBin               | GtkContainer   | GtkBuilder | GtkWidget;

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
      when Ancestry {
        $!fcd = do {
          when GtkFontChooserDialog {
            $to-parent = nativecast(GtkDialog, $_);
            $_;
          }
          when GtkFontChooser {
            $!fc = $_;                          # For GTK::Roles::GtkFontChooser
            $to-parent = nativecast(GtkDialog, $_);
            nativecast(GtkFontChooserDialog, $_);
          }
          default {
            $to-parent = $_;
            nativecast(GtkFontChooserDialog, $_);
          }
        }
        self.setDialog($to-parent);
      }
      when GTK::Dialog::FontChooser {
      }
      default {
      }
    }
    $!fc = nativecast(GtkFontChooser, $!fcd);   # For GTK::Roles::GtkFontChooser
  }

  # ↓↓↓↓ SIGNALS ↓↓↓↓
  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  method get_type is also<get-type> {
    gtk_font_chooser_dialog_get_type();
  }

  multi method new(Ancestry $dialog) {
    my $o = self.bless(:$dialog);
    $o.upref;
    $o;
  }
  multi method new (Str() $title, GtkWindow() $parent) {
    my $dialog = gtk_font_chooser_dialog_new($title, $parent);
    self.bless(:$dialog);
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
