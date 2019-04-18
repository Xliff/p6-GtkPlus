use v6.c;

use Method::Also;
use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::Types;

use GTK::Raw::Utils;

use GTK::Dialog;

use GTK::Roles::RecentChooser;

our subset RecentChooserDialogAncestry is export
  where GtkRecentChooserDialog | GtkRecentChooser | DialogAncestry;

class GTK::Dialog::RecentChooser is GTK::Dialog {
  also does GTK::Roles::RecentChooser;

  has GtkRecentChooserDialog $!rcd;

  method bless(*%attrinit) {
    my $o = self.CREATE.BUILDALL(Empty, %attrinit);
    $o.setType(self.^name);
    $o;
  }

  submethod BUILD(:$recentdialog) {
    my $to-parent;
    given $recentdialog {
      when RecentChooserDialogAncestry {
        $!rcd = do {
          when GtkRecentChooserDialog  {
            $to-parent = nativecast(GtkDialog, $_);
            $_;
          }
          when GtkRecentChooser {
            $!rc = $_;                                # GTK::Roles::RecentChooser
            $to-parent = nativecast(GtkDialog, $_);
            nativecast(GtkRecentChooserDialog, $_);
          }
          default {
            $to-parent = $_;
            nativecast(GtkRecentChooserDialog, $_);
          }
        }
        self.setDialog($to-parent);
      }
      when GTK::Dialog::RecentChooser {
      }
      default {
      }
    }
    $!rc //= nativecast(GtkRecentChooser, $!rcd);     # GTK::Roles::RecentChooser
  }

  proto method new (|) { * }

  multi method new (RecentChooserDialogAncestry $recentdialog) {
    my $o = self.bless(:$recentdialog);
    $o.upref;
    $o;
  }
  multi method new (
    Str() $title,
    GtkWindow() $parent,
  ) {
    samewith($title, $parent, (
      '_OK'      => GTK_RESPONSE_OK,
      '_Cancel'  => GTK_RESPONSE_CANCEL
    ));
  }
  multi method new (
    Str() $title,
    GtkWindow() $parent,
    @buttons is copy,
  ) {
    die '@buttons cannot be empty' unless +@buttons;
    die '\@buttons is not an array of Pair objects!'
      unless @buttons.all ~~ Pair;
    my $f = @buttons.shift;
    my gint $r = resolve-int($f.value);
    my $recentdialog = gtk_recent_chooser_dialog_new(
      $title, $parent, $f.key, $r, Str
    );
    my $o = self.bless(:$recentdialog);
    $o.add_buttons(@buttons);
    $o;
  }

  proto method new_for_manager (|)
    is also<new-for-manager>
  { * }
  
  multi method new_for_manager (
    Str() $title,
    GtkWindow() $parent,
    GtkRecentManager() $manager,
  ) {
    samewith($title, $parent, $manager, (
      '_OK'      => GTK_RESPONSE_OK,
      '_Cancel'  => GTK_RESPONSE_CANCEL
    ));
  }
  multi method new_for_manager (
    Str() $title,
    GtkWindow() $parent,
    GtkRecentManager() $manager,
    @buttons is copy,
  ) {
    die '@buttons cannot be empty' unless +@buttons;
    die '\@buttons is not an array of Pair objects!'
      unless @buttons.all ~~ Pair;
    my $f = @buttons.shift;
    my gint $r = resolve-int($f.value);
    my $recentdialog = gtk_recent_chooser_dialog_new_for_manager(
      $title, $parent, $manager, $f.key, $r, Str
    );
    my $o = self.bless(:$recentdialog);
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
    unstable_get_type(
      self.^name,
      &gtk_recent_chooser_dialog_get_type,
      $n,
      $t
    );
  }

  # ↑↑↑↑ METHODS ↑↑↑↑
}


sub gtk_recent_chooser_dialog_new (
  Str $title,
  GtkWindow $parent,
  Str $first_button_text,
  gint $button_response_id,
  Str
)
  returns GtkRecentChooserDialog
  is native(gtk)
  { * }

sub gtk_recent_chooser_dialog_new_for_manager (
  Str $title,
  GtkWindow $parent,
  GtkRecentManager $manager,
  Str $first_button_text,
  gint $button_response_id,
  Str
)
  returns GtkRecentChooserDialog
  is native(gtk)
  { * }

sub gtk_recent_chooser_dialog_get_type ()
  returns GType
  is native(gtk)
  { * }
