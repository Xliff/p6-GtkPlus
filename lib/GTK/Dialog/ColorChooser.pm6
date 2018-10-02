use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Dialog::Raw::ColorChooser;
use GTK::Raw::Types;

use GTK::Dialog;

use GTK::Roles::ColorChooser;

class GTK::Dialog::ColorChooser is GTK::Dialog {
  also does GTK::Roles::ColorChooser;

  has GtkColorChooserDialog $!ccd;

  method bless(*%attrinit) {
    my $o = self.CREATE.BUILDALL(Empty, %attrinit);
    $o.setType('GTK::Dialog::ColorChooser');
    $o;
  }

  submethod BUILD(:$dialog) {
    my $to-parent;
    given $dialog {
      when GtkColorChooserDialog | GtkWidget {
        $!ccd = do {
          when GtkWidget {
            $to-parent = $_;
            nativecast(GtkColorChooserDialog, $_);
          }
          when GtkColorChooserDialog  {
            $to-parent = nativecast(GtkDialog, $_);
            $_;
          }
        }
        self.setDialog($to-parent);
      }
      when GTK::Dialog::ColorChooser {
      }
      default {
      }
    }
    # For GTK::Role::ColorChooser
    $!cc = nativecast(GtkColorChooser, $!ccd);
  }

  multi method new (Str() $title, GtkWindow() $parent) {
    my $dialog = gtk_color_chooser_dialog_new($title, $parent);
    self.bless(:$dialog);
  }
  multi method new (GtkWidget $dialog)  {
    self.bless(:$dialog);
  }

  # ↓↓↓↓ SIGNALS ↓↓↓↓
  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  method get_type {
    gtk_color_chooser_dialog_get_type();
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
