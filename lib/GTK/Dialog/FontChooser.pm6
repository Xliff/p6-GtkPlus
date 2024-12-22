use v6.c;

use Method::Also;
use NativeCall;


use GTK::Dialog::Raw::FontChooser:ver<3.0.1146>;
use GTK::Raw::Types:ver<3.0.1146>;

use GTK::Dialog:ver<3.0.1146>;

use GTK::Roles::FontChooser:ver<3.0.1146>;

our subset GtkFontChooserDialogAncestry
  where GtkFontChooserDialog | GtkFontChooser | GtkDialogAncestry;

constant FontChooserDialogAncestry is export = GtkFontChooserDialogAncestry;

class GTK::Dialog::FontChooser:ver<3.0.1146> is GTK::Dialog {
  also does GTK::Roles::FontChooser;

  has GtkFontChooserDialog $!fcd is implementor;

  submethod BUILD ( :$gtk-font-dialog ) {
    self.setGtkFontChooserDialog($gtk-font-dialog) if $gtk-font-dialog;
  }

  method setGtkFontChooserDialog (GtkFontChooserDialogAncestry $_) {
    my $to-parent;
    $!fcd = do {
      when GtkFontChooserDialog {
        $to-parent = nativecast(GtkDialog, $_);
        $_;
      }
      when GtkFontChooser {
        $!fnt-c = $_;                          # For GTK::Roles::GtkFontChooser
        $to-parent = nativecast(GtkDialog, $_);
        nativecast(GtkFontChooserDialog, $_);
      }
      default {
        $to-parent = $_;
        nativecast(GtkFontChooserDialog, $_);
      }
    }
    self.setGtkDialog($to-parent);
    self.roleInit-GtkFontChooser;
  }

  # ↓↓↓↓ SIGNALS ↓↓↓↓
  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  multi method new (GtkFontChooserDialogAncestry $gtk-font-dialog) {
    my $o = self.bless( :$gtk-font-dialog );
    $o.upref;
    $o;
  }
  multi method new (Str() $title, GtkWindow() $parent, *%a) {
    my $gtk-font-dialog = gtk_font_chooser_dialog_new($title, $parent);

    # Do not allow attributes to override positional parameters.
    if %a<parent title>:delete {
      $*ERR.say: "PARENT and TITLE named parameters are ignored when {
                  '' } creating a new GtkFontChooserDialog!";
    }

    my $o = $gtk-font-dialog ?? self.bless( :$gtk-font-dialog ) !! Nil;
    $o.setAttributes(%a) if $o && +%a;
    $o;
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( &gtk_font_chooser_dialog_get_type, $n, $t );
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
