use v6.c;

use Method::Also;
use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::Types;

use GTK::Raw::Utils;

use GTK::Dialog;

use GTK::Roles::FileChooser;

our subset FileChooserDialogAncestry is export
  where GtkFileChooserDialog | GtkFileChooser | DialogAncestry;

class GTK::Dialog::FileChooser is GTK::Dialog {
  also does GTK::Roles::FileChooser;

  has GtkFileChooserDialog $!fcd is implementor;

  method bless(*%attrinit) {
    my $o = self.CREATE.BUILDALL(Empty, %attrinit);
    $o.setType(self.^name);
    $o;
  }

  submethod BUILD(:$dialog) {
    my $to-parent;
    given $dialog {
      when FileChooserDialogAncestry {
        $!fcd = do {
          when GtkFileChooserDialog  {
            $to-parent = nativecast(GtkDialog, $_);
            $_;
          }
          when GtkFileChooser {
            $!fc = $_;                            # GTK::Roles::FileChooser
            $to-parent = nativecast(GtkDialog, $_);
            nativecast(GtkFileChooserDialog, $_);
          }
          default {
            $to-parent = $_;
            nativecast(GtkFileChooserDialog, $_);
          }
        }
        self.setDialog($to-parent);
      }
      when GTK::Dialog::FileChooser {
      }
      default {
      }
    }
    $!fc //= nativecast(GtkFileChooser, $!fcd);   # GTK::Roles::FileChooser
  }

  proto method new (|) { * }

  multi method new (FileChooserDialogAncestry $dialog) {
    my $o = self.bless(:$dialog);
    $o.upref;
    $o;
  }
  multi method new (
    Str() $title,
    GtkWindow() $parent,
    Int() $action,              # GtkFileChooserAction  $action,
    Str() $text,
    Int() $response
  ) {
    my uint32 $a = resolve-uint($action);
    my gint $r = resolve-int($response);
    my $dialog = gtk_file_chooser_dialog_new(
      $title, $parent, $a, $text, $r, Str
    );
    self.bless(:$dialog);
  }
  multi method new (
    Str() $title,
    GtkWindow() $parent,
    Int() $action               # GtkFileChooserAction  $action,
  ) {
    samewith($title, $parent, $action, (
      '_OK'      => GTK_RESPONSE_OK,
      '_Cancel'  => GTK_RESPONSE_CANCEL
    ));
  }
  multi method new (
    Str() $title,
    GtkWindow() $parent,
    Int() $action,              # GtkFileChooserAction  $action,
    @buttons is copy,
  ) {
    die '@buttons cannot be empty' unless +@buttons;
    die '\@buttons is not an array of Pair objects!'
      unless @buttons.all ~~ Pair;
    my $f = @buttons.shift;
    my uint32 $a = resolve-uint($action);
    my gint $r = resolve-int($f.value);
    my $dialog = gtk_file_chooser_dialog_new(
      $title, $parent, $a, $f.key, $r, Str
    );
    my $o = self.bless(:$dialog);
    $o.add_buttons(@buttons);
    $o;
  }

  # Causes error:
  #      Circularity detected in multi sub types for &new
  # So replaced with proto method, above to prevent fallback to Mu.
  #
  # multi method new(|c) {
  #   die "No matching constructor for: ({ c.map( *.^name ).join(', ') })";
  # }


  # ↓↓↓↓ SIGNALS ↓↓↓↓
  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ PROPERTIES ↓↓↓↓
  # ↑↑↑↑ PROPERTIES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓

  method get_type is also<get-type> {
    state ($n, $t);
    unstable_get_type( self.^name, &gtk_file_chooser_dialog_get_type, $n, $t );
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
returns GtkFileChooserDialog
  is native(gtk)
  { * }

sub gtk_file_chooser_dialog_get_type ()
  returns GType
  is native(gtk)
  { * }
