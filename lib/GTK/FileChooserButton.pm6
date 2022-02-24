use v6.c;

use Method::Also;

use GTK::Raw::FileChooserButton;
use GTK::Raw::Types;

use GLib::Value;
use GTK::Box;

use GTK::Roles::FileChooser;

our subset GtkFileChooserButtonAncestry is export of Mu
  where GtkFileChooserButton | GtkFileChooser | GtkBoxAncestry;

class GTK::FileChooserButton is GTK::Box {
  also does GTK::Roles::FileChooser;

  has GtkFileChooserButton $!fcb is implementor;

  method bless(*%attrinit) {
    my $o = self.CREATE.BUILDALL(Empty, %attrinit);
    $o.setType($o.^name);
    $o;
  }

  submethod BUILD (:$chooser) {
    self.setGtkFileChooserButton($chooser) if $chooser;
  }

  method setGtkFileChooserButton (GtkFileChooserButtonAncestry $_) {
    my $to-parent;

    $!fcb = do {
      when GtkFileChooserButton {
        $to-parent = cast(GtkBin, $_);
        $_;
      }
      when GtkFileChooser {
        $!fc = $_;                            # GTK::Roles::FileChooser
        $to-parent = cast(GtkBin, $_);
        cast(GtkFileChooserButton, $_);
      }
      default {
        $to-parent = $_;
        cast(GtkFileChooserButton, $_);
      }
    }
    self.setGtkBox($to-parent);
    $!fc //= cast(GtkFileChooser, $!fcb);   # GTK::Roles::FileChooser
  }

  multi method new (GtkFileChooserButtonAncestry $chooser, :$ref = True) {
    return Nil unless $chooser;

    my $o = self.bless(:$chooser);
    $o.ref if $ref;
    $o;
  }
  multi method new (
    Str() $title,
    Int() $action                 # GtkFileChooserAction $action
  ) {
    my uint32 $a = $action;
    my $chooser = gtk_file_chooser_button_new($title, $a);

    $chooser ?? self.bless(:$chooser) !! Nil;
  }
  multi method new {
    die "Please use GTK::FileChooserButton.new(<title>, <action>)";
  }

  method new_with_dialog (GtkWidget() $dialog) is also<new-with-dialog> {
    my $chooser = gtk_file_chooser_button_new_with_dialog($dialog);

    $chooser ?? self.bless(:$chooser) !! Nil;
  }

  # ↓↓↓↓ SIGNALS ↓↓↓↓
  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  method title is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_file_chooser_button_get_title($!fcb);
      },
      STORE => sub ($, Str() $title is copy) {
        gtk_file_chooser_button_set_title($!fcb, $title);
      }
    );
  }

  method width_chars is rw is also<width-chars> {
    Proxy.new(
      FETCH => sub ($) {
        gtk_file_chooser_button_get_width_chars($!fcb);
      },
      STORE => sub ($, Int() $n_chars is copy) {
        my int32 $nc = $n_chars;

        gtk_file_chooser_button_set_width_chars($!fcb, $nc);
      }
    );
  }
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # Type: GtkFileChooser
  method dialog is rw {
    my GLib::Value $gv .= new( G_TYPE_OBJECT );
    Proxy.new(
      FETCH => sub ($) {
        warn 'GTK::FileChooserButton.dialog does not allow reading'
          if $DEBUG;
        Nil;
      },
      STORE => -> $, GtkFileChooser() $val is copy {
        $gv.object = $val;
        self.prop_set('dialog', $gv);
      }
    );
  }

  # ↓↓↓↓ METHODS ↓↓↓↓
  method get_type is also<get-type> {
    state ($n, $t);

    GTK::Widget.unstable_get_type( &gtk_file_chooser_button_get_type, $n, $t );
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
