use v6.c;

use Method::Also;
use NativeCall;

use GTK::Raw::Types:ver<3.0.1146>;

use GTK::Dialog:ver<3.0.1146>;

use GTK::Roles::FileChooser:ver<3.0.1146>;

our subset GtkFileChooserDialogAncestry is export
  where GtkFileChooserDialog | GtkFileChooser | GtkDialogAncestry;

class GTK::Dialog::FileChooser:ver<3.0.1146> is GTK::Dialog {
  also does GTK::Roles::FileChooser;

  has GtkFileChooserDialog $!fcd is implementor;

  submethod BUILD ( :$gtk-file-dialog ) {
    self.setGtkFileChooserDialog($gtk-file-dialog) if $gtk-file-dialog
  }

  method setGtkFileChooserDialog (GtkFileChooserDialog $_) {
    my $to-parent;

    say "File Chooser Dialog is a { .^name }";

    $!fcd = do {
      when GtkFileChooserDialog  {
        $to-parent = nativecast(GtkDialog, $_);
        $_;
      }

      when GtkFileChooser {
        $!fc       = $_;                            # GTK::Roles::FileChooser
        $to-parent = nativecast(GtkDialog, $_);
        nativecast(GtkFileChooserDialog, $_);
      }

      default {
        $to-parent = $_;
        nativecast(GtkFileChooserDialog, $_);
      }
    }
    self.roleInit-GtkFileChooser;
    self.setGtkDialog($to-parent);
  }

  proto method new (|)
  { * }

  multi method new (GtkFileChooserDialogAncestry $gtk-file-dialog) {
    return Nil unless $gtk-file-dialog;

    my $o = self.bless( :$gtk-file-dialog );
    $o.upref;
    $o;
  }
  multi method new (
    Str()       $title,
    GtkWindow() $parent,
    Int()       $action,              # GtkFileChooserAction  $action,
    Str()       $text,
    Int()       $response
  ) {
    my uint32 $a = $action;
    my gint   $r = $response;

    my $gtk-file-dialog = gtk_file_chooser_dialog_new(
      $title,
      $parent,
      $a,
      $text,
      $r,
      Str
    );

    $gtk-file-dialog ?? self.bless( :$gtk-file-dialog ) !! Nil;
  }
  multi method new (
    Str()       $title,
    GtkWindow() $parent,
    Int()       $action               # GtkFileChooserAction  $action,
  ) {
    samewith(
      $title,
      $parent,
      $action,
      (
        '_OK'      => GTK_RESPONSE_OK,
        '_Cancel'  => GTK_RESPONSE_CANCEL
      )
    );
  }
  multi method new (
    Str()       $title,
    GtkWindow() $parent,
    Int()       $action,              # GtkFileChooserAction  $action,
                @buttons is copy
  ) {
    die '@buttons cannot be empty' unless +@buttons;

    die '\@buttons is not an array of Pair objects!'
      unless @buttons.all ~~ Pair;

    my        $f = @buttons.shift;
    my uint32 $a = $action;
    my gint   $r = $f.value;

    my $gtk-file-dialog = gtk_file_chooser_dialog_new(
      $title,
      $parent,
      $a,
      $f.key,
      $r,
      Str
    );

    my $o = $gtk-file-dialog ?? self.bless( :$gtk-file-dialog ) !! Nil;
    $o.add_buttons(@buttons) if $o;
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
  Str       $title,
  GtkWindow $parent,
  uint32    $action,               # GtkFileChooserAction  $action,
  Str       $first_button_text,
  gint      $button_response_id,
  Str
)
  returns GtkFileChooserDialog
  is      native(gtk)
{ * }

sub gtk_file_chooser_dialog_get_type ()
  returns GType
  is      native(gtk)
{ * }
