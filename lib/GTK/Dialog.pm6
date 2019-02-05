use v6.c;

use Method::Also;
use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::Dialog;
use GTK::Raw::Types;

use GTK::Box;
use GTK::HeaderBar;
use GTK::Window;

my subset Ancestry
  where GtkDialog | GtkWindow | GtkBin | GtkContainer | GtkBuilder |
        GtkWidget;

class GTK::Dialog is GTK::Window {
  has GtkDialog $!d;

  method bless(*%attrinit) {
    my $o = self.CREATE.BUILDALL(Empty, %attrinit);
    $o.setType('GTK::Dialog');
    $o;
  }

  submethod BUILD(:$dialog) {
    given $dialog {
      when Ancestry {
        self.setDialog($dialog);
      }
      when GTK::Dialog {
      }
      default {
      }
    }
  }

  method setDialog($dialog) {
    my $to-parent;
    $!d = do given $dialog {
      when GtkDialog {
        $to-parent = nativecast(GtkWindow, $_);
        $_;
      }
      default {
        $to-parent = $_;
        nativecast(GtkDialog, $_);
      }
    }
    self.setWindow($to-parent);
  }

  multi method new (Ancestry $dialog) {
    my $o = self.bless(:$dialog);
    $o.upref;
    $o;
  }
  multi method new {
    my $dialog = gtk_dialog_new();
    self.bless(:$dialog);
  }


  # Yes, I'm poking fun at the '...' limitation, at this point.
  # This method can be pulled (or better yet ignored) if you lack
  # a funny bone.
  method new_with_button(
   Str()       $title,
   GtkWindow() $parent,
   uint32      $flags,          # GtkDialogFlags $flags
   Str()       $button_text,
   Int()       $button_response_id
  )
    is also<new-with-button>
  {
    my gint $br = self.RESOLVE-INT($button_response_id);
    my $dialog = gtk_dialog_new_with_buttons(
      $title,
      $parent,
      $flags,
      $button_text,
      $br,
      Str
    );
    self.bless(:$dialog);
  }

  multi method new-with-buttons(
    Str()       $title,
    GtkWindow() $parent,
    uint32      $flags,          # GtkDialogFlags $flags
    *%buttons
  ) {
   self.new_with_buttons($title, $parent, $flags, %buttons);
  }
  multi method new_with_buttons(
    Str()       $title,
    GtkWindow() $parent,
    uint32      $flags,          # GtkDialogFlags $flags
    *%buttons
  ) {
    samewith($title, $parent, $flags, %buttons.pairs.Array);
  }
  multi method new-with-buttons(
    Str()       $title,
    GtkWindow() $parent,
    uint32      $flags,          # GtkDialogFlags $flags
    @buttons
  ) {
    self.new_with_buttons($title, $parent, $flags, @buttons);
  }
  multi method new_with_buttons(
    Str()       $title,
    GtkWindow() $parent,
    uint32      $flags,          # GtkDialogFlags $flags
    @buttons
  ) {
    die '@buttons cannot be empty' unless +@buttons;
    die '\@buttons is not an array of pair objects!'
      unless @buttons.all ~~ Pair;
    my $fb = @buttons.shift;
    my $o = GTK::Dialog.new_with_button(
      $title,
      $parent,
      $flags,
      $fb.key,
      self.RESOLVE-INT($fb.value)
    );
    $o.add_buttons(@buttons);
    $o;
  }

  # ↓↓↓↓ SIGNALS ↓↓↓↓
  # Is originally:

  # GtkDialog, gpointer --> void
  method close {
    self.connect($!d, 'close');
  }

  # Is originally:
  # GtkDialog, gint, gpointer --> void
  # - Made multi so as to not conflict with the method implementing
  #   gtk_response_dialog()
  multi method response {
    self.connect-int($!d, 'response');
  }
  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  method add_action_widget (GtkWidget() $child, Int() $response_id)
    is also<add-action-widget>
  {
    my gint $ri = self.RESOLVE-INT($response_id);
    gtk_dialog_add_action_widget($!d, $child, $ri);
  }

  multi method add-buttons(%buttons) {
    self.add_buttons(%buttons);
  }
  multi method add_buttons(%buttons) {
    samewith(%buttons.pairs);
  }
  multi method add-buttons(*@buttons) {
    self.add_buttons(@buttons);
  }
  multi method add_buttons(*@buttons) {
    die '\@buttons is not an array of pair objects!'
      unless @buttons.all ~~ Pair;
    self.add_button( .key, self.RESOLVE-INT(.value) ) for @buttons;
  }

  method add_button (Str() $button_text, Int() $response_id)
    is also<add-button>
  {
    my gint $ri = self.RESOLVE-INT($response_id);
    gtk_dialog_add_button($!d, $button_text, $ri);
  }

  method get_action_area is also<get-action-area> {
    GTK::Box.new( gtk_dialog_get_action_area($!d) );
  }

  method get_content_area is also<get-content-area> {
    GTK::Box.new( gtk_dialog_get_content_area($!d) );
  }

  method get_header_bar is also<get-header-bar> {
    GTK::HeaderBar.new( gtk_dialog_get_header_bar($!d) );
  }

  method get_response_for_widget (GtkWidget() $widget)
    is also<get-response-for-widget>
  {
    gtk_dialog_get_response_for_widget($!d, $widget);
  }

  method get_type is also<get-type> {
    gtk_dialog_get_type();
  }

  method get_widget_for_response (Int() $response_id)
    is also<get-widget-for-response>
  {
    my gint $ri = self.RESOLVE-INT($response_id);
    gtk_dialog_get_widget_for_response($!d, $ri);
  }

  # Class method.. but deprecated
  method alternative_dialog_button_order (GdkScreen $screen)
    is DEPRECATED
    is also<alternative-dialog-button-order>
  {
    gtk_alternative_dialog_button_order($screen);
  }

  multi method response (Int() $response_id) {
    my gint $ri = self.RESOLVE-INT($response_id);
    gtk_dialog_response($!d, $ri);
  }

  method run {
    self.response.tap({ self.hide }) unless self.is-connected('response');
    my gint $rc = gtk_dialog_run($!d);
    GtkResponseType( $rc );
  }

  method set_alternative_button_order_from_array (
    Int() $n_params,
    Int @new_order
  )
    is DEPRECATED
    is also<set-alternative-button-order-from-array>
  {
    my gint $np = self.RESOLVE-INT($n_params);
    my CArray[gint] $no = CArray[gint].new;
    my $i = 0;
    $no[$i++] = $_ for @new_order;

    gtk_dialog_set_alternative_button_order_from_array($!d, $np, $no);
  }

  method set_default_response (Int() $response_id)
    is also<set-default-response>
  {
    my gint $ri = self.RESOLVE-INT($response_id);
    gtk_dialog_set_default_response($!d, $ri);
  }

  method set_response_sensitive (Int() $response_id, Int() $setting)
    is also<set-response-sensitive>
  {
    my gint $ri = self.RESOLVE-INT($response_id);
    my gboolean $s = self.RESOLVE-BOOL($setting);
    gtk_dialog_set_response_sensitive($!d, $ri, $s);
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
