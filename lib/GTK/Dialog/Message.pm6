use v6.c;

use Method::Also;
use NativeCall;

use GTK::Compat::Types;
use GTK::Dialog::Raw::Message;
use GTK::Raw::Types;

use GTK::Box;
use GTK::Dialog;
use GTK::Image;

my subset Ancestry
  where GtkMessageDialog | GtkDialog | GtkWindow | GtkBin | GtkContainer |
        GtkBuilder       | GtkWidget;

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
      when Ancestry {
        $!md = do {
          when GtkMessageDialog {
            $to-parent = nativecast(GtkDialog, $_);
            $_;
          }
          default {
            $to-parent = $_;
            nativecast(GtkMessageDialog, $_);
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

  multi method new (Ancestry $dialog) {
    my $o = self.bless(:$dialog);
    $o.upref;
    $o;
  }
  multi method new (
    GtkWindow() $parent,
    Str $message_format,
    Int() $flags = GTK_DIALOG_DESTROY_WITH_PARENT,
    Int() $type = GTK_MESSAGE_ERROR,
    Int() $buttons = GTK_BUTTONS_CLOSE
  ) {
    samewith($parent, $flags, $type, $buttons, $message_format);
  }
  multi method new (
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
  ) is also<new-with-markup> {
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
  method get_message_area is also<get-message-area> {
    GTK::Box( gtk_message_dialog_get_message_area($!md) );
  }

  method format_secondary_markup (Str() $message_format) is also<format-secondary-markup> {
    gtk_message_dialog_format_secondary_markup($!md, $message_format);
  }

  method format_secondary_text (Str() $message_format) is also<format-secondary-text> {
    gtk_message_dialog_format_secondary_text($!md, $message_format);
  }

  method get_type is also<get-type> {
    gtk_message_dialog_get_type();
  }

  method set_markup (Str() $str) is also<set-markup> {
    gtk_message_dialog_set_markup($!md, $str);
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
