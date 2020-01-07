use v6.c;

use Method::Also;
use NativeCall;


use GTK::Raw::FileChooserButton;
use GTK::Raw::Types;

use GTK::Raw::Utils;

use GLib::Value;
use GTK::Box;

use GTK::Roles::FileChooser;

our subset FileChooserButtonAncestry
  where GtkFileChooserButton | GtkFileChooser | BoxAncestry;

class GTK::FileChooserButton is GTK::Box {
  also does GTK::Roles::FileChooser;

  has GtkFileChooserButton $!fcb is implementor;

  method bless(*%attrinit) {
    my $o = self.CREATE.BUILDALL(Empty, %attrinit);
    $o.setType($o.^name);
    $o;
  }

  submethod BUILD(:$chooser) {
    my $to-parent;
    given $chooser {
      when FileChooserButtonAncestry {
        $!fcb = do {
          when GtkFileChooserButton {
            $to-parent = nativecast(GtkBin, $_);
            $_;
          }
          when GtkFileChooser {
            $!fc = $_;                            # GTK::Roles::FileChooser
            $to-parent = nativecast(GtkBin, $_);
            nativecast(GtkFileChooserButton, $_);
          }
          default {
            $to-parent = $_;
            nativecast(GtkFileChooserButton, $_);
          }
        }
        self.setBox($to-parent);
      }
      when GTK::FileChooserButton {
      }
      default {
      }
    }
    $!fc //= nativecast(GtkFileChooser, $!fcb);   # GTK::Roles::FileChooser
  }

  multi method new (FileChooserButtonAncestry $chooser) {
    my $o = self.bless(:$chooser);
    $o.upref;
    $o;
  }
  multi method new (
    Str() $title,
    Int() $action                 # GtkFileChooserAction $action
  ) {
    my uint32 $a = resolve-uint($action);
    my $chooser = gtk_file_chooser_button_new($title, $a);
    self.bless(:$chooser);
  }
  multi method new {
    die "Please use GTK::FileChooserButton.new(<title>, <action>)";
  }

  method new_with_dialog (GtkWidget() $dialog) is also<new-with-dialog> {
    my $chooser = gtk_file_chooser_button_new_with_dialog($dialog);
    self.bless(:$chooser);
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
        my int32 $nc = resolve-int($n_chars);
        gtk_file_chooser_button_set_width_chars($!fcb, $nc);
      }
    );
  }
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # Type: GtkFileChooser
  method dialog is rw {
    my GLib::Value $gv .= new( G_TYPE_OBJECT );
    Proxy.new(
      FETCH => -> $ {
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
