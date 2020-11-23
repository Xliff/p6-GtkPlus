use v6.c;

use Method::Also;
use NativeCall;


use GTK::Dialog::Raw::Message;
use GTK::Raw::Types;

use GTK::Box;
use GTK::Dialog;
use GTK::Image;

my subset GtkMessageDialogAncestry
  where GtkMessageDialog | GtkDialog | GtkWindow | GtkBin | GtkContainer |
        GtkBuilder       | GtkWidget;

class GTK::Dialog::Message is GTK::Dialog {
  has GtkMessageDialog $!md is implementor;

  method bless(*%attrinit) {
    my $o = self.CREATE.BUILDALL(Empty, %attrinit);
    $o.setType($o.^name);
    $o;
  }

  submethod BUILD(:$message-dialog) {
    self.setGtkMessageDialog($message-dialog) if $message-dialog;
  }

  method setGtkMessageDialog (GtkMessageDialogAncestry $_) {
    my $to-parent;
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

  multi method new (GtkMessageDialogAncestry $dialog, :$ref = True) {
    return Nil unless $dialog;

    my $o = self.bless(:$dialog);
    $o.ref if $ref;
    $o;
  }
  multi method new (
    GtkWindow() $parent,
    Str         $message,
    Int()       :$flags    = GTK_DIALOG_DESTROY_WITH_PARENT,
    Int()       :$type     = GTK_MESSAGE_INFO,
    Int()       :$buttons  = GTK_BUTTONS_CLOSE
  ) {
    samewith($parent, $flags, $type, $buttons, $message);
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
    my $message-dialog = gtk_message_dialog_new(
      $parent,
      $flags,
      $type,
      $buttons,
      $message_format
    );

    $message-dialog ?? self.bless(:$message-dialog) !! Nil;
  }

  method new_with_markup (
    GtkWindow() $parent,
    Int()       $flags,             # GtkDialogFlags flags
    Int()       $type,              # GtkMessageType type
    Int()       $buttons,           # GtkButtonsType buttons
    Str         $message_format
  )
    is also<new-with-markup>
  {
    my $message-dialog = gtk_message_dialog_new(
      $parent,
      $flags,
      $type,
      $buttons,
      $message_format
    );

    $message-dialog ?? self.bless(:$message-dialog) !! Nil;
  }

  # Type: GtkWidget
  method image (:$raw = False) is rw is DEPRECATED {
    Proxy.new:
      FETCH => -> $                { self.get-image($raw) },
      STORE => -> $, GtkImage() \i { self.set_image(i)    };
  }

  # Type: GtkMessageType
  method message-type is rw  {
    my $gv = GLib::Value.new( GLib::Value.gtypeFromType(GtkMessageType) );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('message-type', $gv)
        );
        GtkMessageTypeEnum( $gv.enum )
      },
      STORE => -> $,  $val is copy {
        warn 'message-type is a construct-only attribute'
      }
    );
  }

  # Type: char
  method secondary-text is rw  {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('secondary-text', $gv)
        );
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('secondary-text', $gv);
      }
    );
  }

  # Type: gboolean
  method secondary-use-markup is rw  {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('secondary-use-markup', $gv)
        );
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('secondary-use-markup', $gv);
      }
    );
  }

  # Type: char
  method text is rw  {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('text', $gv)
        );
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('text', $gv);
      }
    );
  }

  # Type: gboolean
  method use-markup is rw  {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('use-markup', $gv)
        );
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('use-markup', $gv);
      }
    );
  }

  # ↓↓↓↓ SIGNALS ↓↓↓↓
  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  method get_image (:$raw = False) is also<get-image> {
    my $i = gtk_message_dialog_get_image($!md);

    $i ??
      ( $raw ?? $i !! GTK::Image.new($i, :!ref) )
      !!
      Nil;
  }

  method get_message_area (:$raw = False)
    is also<
      get-message-area
      message_area
      message-area
    >
  {
    my $ma = gtk_message_dialog_get_message_area($!md);

    $ma ??
      ( $raw ?? $ma !! GTK::Box.new($ma, :!ref) )
      !!
      Nil;
  }

  method format_secondary_markup (Str() $message_format)
    is also<format-secondary-markup>
  {
    gtk_message_dialog_format_secondary_markup($!md, $message_format);
  }

  method format_secondary_text (Str() $message_format)
    is also<format-secondary-text>
  {
    gtk_message_dialog_format_secondary_text($!md, $message_format);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gtk_message_dialog_get_type, $n, $t );
  }

  method set_image (GtkImage() $image) {
    gtk_message_dialog_set_image($!md, $image);
  }

  method set_markup (Str() $str) is also<set-markup> {
    gtk_message_dialog_set_markup($!md, $str);
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
