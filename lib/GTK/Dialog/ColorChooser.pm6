use v6.c;

use Method::Also;
use NativeCall;

use GTK::Compat::Types;
use GTK::Dialog::Raw::ColorChooser;
use GTK::Raw::Types;

use GTK::Dialog;

use GTK::Roles::ColorChooser;

my subset Ancestry
  where GtkColorChooserDialog | GtkColorChooser | GtkDialog | GtkWindow |
        GtkBin                | GtkContainer    | GtkWidget;

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
      when Ancestry {
        $!ccd = do {
          when GtkColorChooserDialog {
            $to-parent = nativecast(GtkDialog, $_);
            $_;
          }
          when GtkColorChooser {
            $!cc = $_;                              # GTK::Role::ColorChooser
            $to-parent = nativecast(GtkDialog, $_);
            nativecast(GtkColorChooserDialog, $_);
          }
          default {
            $to-parent = $_;
            nativecast(GtkColorChooserDialog, $_);
          }
        }
        self.setDialog($to-parent);
      }
      when GTK::Dialog::ColorChooser {
      }
      default {
      }
    }
    $!cc //= nativecast(GtkColorChooser, $!ccd);    # GTK::Role::ColorChooser
  }

  multi method new (Ancestry $dialog)  {
    my $o = self.bless(:$dialog);
    $o.upref;
    $o;
  }
  multi method new (Str() $title, GtkWindow() $parent) {
    my $dialog = gtk_color_chooser_dialog_new($title, $parent);
    self.bless(:$dialog);
  }

  # ↓↓↓↓ SIGNALS ↓↓↓↓
  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  method get_type is also<get-type> {
    gtk_color_chooser_dialog_get_type();
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
