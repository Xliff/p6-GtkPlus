use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::FileChooserButton;
use GTK::Raw::Types;

use GTK::Bin;

use GTK::Roles::FileChooser;

my subset ParentChild where GtkFileChooserButton | GtkFileChooser | GtkWidget;

class GTK::FileChooserButton is GTK::Bin {
  also does GTK::Roles::FileChooser;

  has GtkFileChooserButton $!fcb;

  method bless(*%attrinit) {
    my $o = self.CREATE.BUILDALL(Empty, %attrinit);
    $o.setType('GTK::FileChooserButton');
    $o;
  }

  submethod BUILD(:$chooser) {
    my $to-parent;
    given $chooser {
      when ParentChild {
        $!fcb = do {
          when GtkWidget {
            $to-parent = $_;
            nativecast(GtkFileChooserButton, $_);
          }
          when GtkFileChooser {
            $!fc = $_;                          # GTK::Roles::FileChooser
            $to-parent = nativecast(GtkBin, $_);
            nativecast(GtkFileChooserButton, $_);
          }
          when GtkFileChooserButton {
            $to-parent = nativecast(GtkBin, $_);
            $_;
          }
        }
        self.setBin($to-parent);
      }
      when GTK::FileChooserButton {
      }
      default {
      }
    }
    $!fc //= nativecast(GtkFileChooser, $!fcb);   # GTK::Roles::FileChooser
  }

  multi method new (
    Str() $title,
    Int() $action                 # GtkFileChooserAction $action
  ) {
    my uint32 $a = self.RESOLVE-UINT($action);
    my $chooser = gtk_file_chooser_button_new($title, $a);
    self.bless(:$chooser);
  }
  multi method new (ParentChild $chooser) {
    self.bless(:$chooser);
  }

  method new_with_dialog (GtkWidget() $dialog) {
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
      STORE => sub ($, Str $title is copy) {
        gtk_file_chooser_button_set_title($!fcb, $title);
      }
    );
  }

  method width_chars is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_file_chooser_button_get_width_chars($!fcb);
      },
      STORE => sub ($, Int() $n_chars is copy) {
        my int32 $nc = self.RESOLVE-INT($n_chars);
        gtk_file_chooser_button_set_width_chars($!fcb, $nc);
      }
    );
  }
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # Type: GtkFileChooser
  method dialog is rw {
    my GTK::Compat::Value $gv .= new( G_TYPE_OBJECT );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new( warn "dialog does not allow reading" );
        nativecast(GtkFileChooser, $gv.object);
      },
      STORE => -> $, GtkFileChooser() $val is copy {
        $gv.objecet = $val;
        self.prop_set($!fcb, 'dialog', $gv);
      }
    );
  }

  # ↓↓↓↓ METHODS ↓↓↓↓
  method get_type {
    gtk_file_chooser_button_get_type();
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
