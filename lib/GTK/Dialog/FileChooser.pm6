use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::Types;

use GTK::Dialog;

use GTK::Roles::FileChooser;

my subset Ancestry
  where GtkFileChooserDialog | GtkDialog | GtkFileChooser | GtkWidget;

class GTK::FileChooserDialog is GTK::Dialog {
  also does GTK::Roles::FileChooser;

  has GtkFileChooserDialog $!fcd;

  method bless(*%attrinit) {
    my $o = self.CREATE.BUILDALL(Empty, %attrinit);
    $o.setType('GTK::Dialog::FileChooser');
    $o;
  }

  submethod BUILD(:$dialog) {
    my $to-parent;
    given $dialog {
      when Ancestry {
        $!fcd = do {
          when GtkWidget | GtkDialog {
            $to-parent = $_;
            nativecast(GtkFileChooserDialog, $_);
          }
          when GtkFileChooser {
            $!fc = $_;                            # GTK::Roles::FileChooser
            $to-parent = nativecast(GtkDialog, $_);
            nativecast(GtkFileChooserDialog, $_);
          }
          when GtkFileChooserDialog  {
            $to-parent = nativecast(GtkDialog, $_);
            $_;
          }
        }
        self.setDialog($to-parent);
      }
      when GTK::FileChooserDialog {
      }
      default {
      }
    }
    $!fc //= nativecast(GtkFileChooser, $!fcd);   # GTK::Roles::FileChooser
  }

  multi method new (
    Str() $title,
    GtkWindow() $parent,
    Int() $action,              # GtkFileChooserAction  $action,
    Str() $text,
    Int() $response
  ) {
    my uint32 $a = self.RESOLVE-UINT($action);
    my gint $r = self.RESOLVE-INT($response);
    my $dialog = gtk_file_chooser_dialog_new($title, $parent, $a, $text, $r);
    self.bless(:$dialog);
  }
  multi method new (
    Str() $title,
    GtkWindow() $parent,
    Int() $action,              # GtkFileChooserAction  $action,
    *%buttons
  ) {
    samewith($title, $parent, $action, %buttons.pairs.Array);
  }
  multi method new (
    Str() $title,
    GtkWindow() $parent,
    Int() $action,              # GtkFileChooserAction  $action,
    @buttons
  ) {
    die '@buttons cannot be empty' unless +@buttons;
    die '\@buttons is not an array of Pair objects!'
      unless @buttons.all ~~ Pair;
    my $f = @buttons.unshift;
    my $o = samewith($title, $parent, $action, $f.key, $f.value);
    $o.add_buttons(@buttons);
    $o;
  }


  # ↓↓↓↓ SIGNALS ↓↓↓↓
  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ PROPERTIES ↓↓↓↓
  # ↑↑↑↑ PROPERTIES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓

  method get_type {
    gtk_file_chooser_dialog_get_type();
  }

  # ↑↑↑↑ METHODS ↑↑↑↑
}


sub gtk_file_chooser_dialog_new (
  Str $title,
  GtkWindow $parent,
  uint32 $action,               # GtkFileChooserAction  $action,
  Str $first_button_text,
  gint $button_response_id,
  Str
)
returns GtkWidget
  is native(gtk)
  { * }

sub gtk_file_chooser_dialog_get_type ()
  returns GType
  is native(gtk)
  { * }