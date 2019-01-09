use v6.c;

use Method::Also;
use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::Types;

use GTK::Dialog;

use GTK::Roles::FileChooser;

my subset Ancestry
  where GtkFileChooserDialog | GtkFileChooser | GtkDialog | GtkWindow    |
        GtkContainer         | GtkWindow      | GtkBin    | GtkContainer |
        GtkWidget;

class GTK::Dialog::FileChooser is GTK::Dialog {
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

  multi method new (Ancestry $dialog) {
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
    my uint32 $a = self.RESOLVE-UINT($action);
    my gint $r = self.RESOLVE-INT($response);
    my $dialog = gtk_file_chooser_dialog_new(
      $title, $parent, $a, $text, $r, Str
    );
    self.bless(:$dialog);
  }
  multi method new (
    Str() $title,
    GtkWindow() $parent,
    Int() $action,              # GtkFileChooserAction  $action,
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
    my uint32 $a = self.RESOLVE-UINT($action);
    my gint $r = self.RESOLVE-INT($f.value);
    my $dialog = gtk_file_chooser_dialog_new(
      $title, $parent, $a, $f.key, $r, Str
    );
    my $o = self.bless(:$dialog);
    $o.add_buttons(@buttons);
    $o;
  }
  multi method new(|c) {
    die "No matching constructor for: ({ c.map( *.^name ).join(', ') })";
  }


  # ↓↓↓↓ SIGNALS ↓↓↓↓
  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ PROPERTIES ↓↓↓↓
  # ↑↑↑↑ PROPERTIES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓

  method get_type is also<get-type> {
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
