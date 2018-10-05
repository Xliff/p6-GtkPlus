use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Dialog::Raw::Message;
use GTK::Raw::Types;

use GTK::Box;
use GTK::Dialog;
use GTK::Image;

class GTK::Dialog::Message is GTK::Dialog {
  has GtkMessageDialog $!md;

  method bless(*%attrinit) {
    my $o = self.CREATE.BUILDALL(Empty, %attrinit);
    $o.setType('GTK::Dialog::Message');
    $o;
  }

  submethod BUILD(:$dialog) {
    my $to-parent;
    given $dialog {
      when GtkMessageDialog | GtkWidget {
        $!md = do {
          when GtkWidget {
            $to-parent = $_;
            nativecast(GtkMessageDialog, $_);
          }
          when GtkMessageDialog {
            $to-parent = nativecast(GtkDialog, $_);
            $_;
          }
        }
        self.setDialog($to-parent);
      }
      when GTK::Dialog::Message {
      }
      default {
      }
    }
  }

  method new (
    GtkWindow() $parent,
    Int()       $flags,             # GtkDialogFlags flags
    Int()       $type,              # GtkMessageType type
    Int()       $buttons,           # GtkButtonsType buttons
    Str         $message_format
  ) {
    #my @u = ($flags, $type, $buttons);
    # Can't use type resolution since it's the constructor.
    #my guint ($f, $t, $b) = @u >>+&<< (0xffff xx @u.elems);
    my $dialog = gtk_message_dialog_new(
      $parent,
      $flags,
      $type,
      $buttons,
      $message_format
    );
    self.bless(:$dialog);
  }

  method new_with_markup (
    GtkWindow() $parent,
    Int()       $flags,             # GtkDialogFlags flags
    Int()       $type,              # GtkMessageType type
    Int()       $buttons,           # GtkButtonsType buttons
    Str         $message_format
  ) {
    #my @u = ($flags, $type, $buttons);
    #my guint ($f, $t, $b) = self.RESOLVE-UINT(@u);
    my $dialog = gtk_message_dialog_new(
      $parent,
      $flags,
      $type,
      $buttons,
      $message_format
    );
    self.bless(:$dialog);
  }


  # ↓↓↓↓ SIGNALS ↓↓↓↓
  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  method image is rw is DEPRECATED {
    Proxy.new(
      FETCH => sub ($) {
        GTK::Image.new( gtk_message_dialog_get_image($!md) );
      },
      STORE => sub ($, GtkImage() $image is copy) {
        gtk_message_dialog_set_image($!md, $image);
      }
    );
  }
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  method get_message_area {
    GTK::Box( gtk_message_dialog_get_message_area($!md) );
  }

  method format_secondary_markup (Str() $message_format) {
    gtk_message_dialog_format_secondary_markup($!md, $message_format);
  }

  method format_secondary_text (Str() $message_format) {
    gtk_message_dialog_format_secondary_text($!md, $message_format);
  }

  method get_type {
    gtk_message_dialog_get_type();
  }

  method set_markup (Str() $str) {
    gtk_message_dialog_set_markup($!md, $str);
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
