use v6.c;

use Method::Also;
use NativeCall;


use GTK::Dialog::Raw::FontChooser:ver<3.0.1146>;
use GTK::Raw::Types:ver<3.0.1146>;

use GTK::Dialog:ver<3.0.1146>;

use GTK::Roles::FontChooser:ver<3.0.1146>;

our subset FontChooserDialogAncestry
  where GtkFontChooserDialog | GtkFontChooser | DialogAncestry;

class GTK::Dialog::FontChooser:ver<3.0.1146> is GTK::Dialog {
  also does GTK::Roles::FontChooser;

  has GtkFontChooserDialog $!fcd is implementor;

  method bless(*%attrinit) {
    my $o = self.CREATE.BUILDALL(Empty, %attrinit);
    $o.setType(self.^name);
    $o;
  }

  submethod BUILD(:$dialog) {
    my $to-parent;
    given $dialog {
      when FontChooserDialogAncestry {
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
    state ($n, $t);
    GTK::Widget.unstable_get_type( &gtk_font_chooser_dialog_get_type, $n, $t );
  }

  multi method new(FontChooserDialogAncestry $dialog) {
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
