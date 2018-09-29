use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::FileChooserButton;
use GTK::Raw::Types;

use GTK::Bin;

class GTK::FileChooserButton is GTK::Bin {
  has GtkFileChooserButton $!fc;

  method bless(*%attrinit) {
    use nqp;
    my $o = nqp::create(self).BUILDALL(Empty, %attrinit);
    $o.setType('GTK::FileChooserButton');
    $o;
  }

  submethod BUILD(:$chooser) {
    my $to-parent;
    given $chooser {
      when GtkFileChooserButton | GtkWidget {
        $!fc = do {
          when GtkWidget {
            $to-parent = $_;
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
  }

  multi method new (
    Str() $title,
    Int() $action                 # GtkFileChooserAction $action
  ) {
    my uint32 $a = self.RESOLVE-UINT($action);
    my $chooser = gtk_file_chooser_button_new($title, $a);
    self.bless(:$chooser);
  }
  multi method new (GtkWidget $chooser) {
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
        gtk_file_chooser_button_get_title($!fc);
      },
      STORE => sub ($, Str $title is copy) {
        gtk_file_chooser_button_set_title($!fc, $title);
      }
    );
  }

  method width_chars is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_file_chooser_button_get_width_chars($!fc);
      },
      STORE => sub ($, Int() $n_chars is copy) {
        my uint32 $nc = $n_chars;
        gtk_file_chooser_button_set_width_chars($!fc, $nc);
      }
    );
  }
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  method get_type {
    gtk_file_chooser_button_get_type();
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
