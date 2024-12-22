use v6.c;

use Method::Also;
use NativeCall;

use GLib::Raw::Traits;
use GTK::Raw::Dialog:ver<3.0.1146>;
use GTK::Raw::Types:ver<3.0.1146>;

use GTK::Box:ver<3.0.1146>;
use GTK::HeaderBar:ver<3.0.1146>;
use GTK::Window:ver<3.0.1146>;

our subset GtkDialogAncestry is export of Mu
  where GtkDialog | GtkWindowAncestry;

constant DialogAncestry is export = GtkDialogAncestry;

class GTK::Dialog:ver<3.0.1146> is GTK::Window {
  has GtkDialog $!d is implementor;

  submethod BUILD ( :$dialog ) {
    self.setGtkDialog($dialog) if $dialog;
  }

  method setGtkDialog ($_) is also<setDialog> {
    my $to-parent;

    say "Dialog is a { .^name }";

    $!d = do {
      when GtkDialog {
        $to-parent = nativecast(GtkWindow, $_);
        $_;
      }
      default {
        $to-parent = $_;
        nativecast(GtkDialog, $_);
      }
    }
    self.setGtkWindow($to-parent);
  }

  method GTK::Raw::Definitions::GtkDialog
    is also<GtkDialog>
  { $!d }

  multi method new (GtkDialogAncestry $dialog, :$ref = True) {
    return Nil unless $dialog;

    my $o = self.bless(:$dialog);
    $o.ref if $ref;
    $o;
  }
  multi method new {
    my $dialog = gtk_dialog_new();

    $dialog ?? self.bless( :$dialog ) !! Nil;
  }

  proto method new_with_buttons (|)
    is also<new-with-buttons>
  { * }

  multi method new_with_buttons (
    Str()        $title,
    GtkWindow() :$parent  = GtkWindow,
    Int()       :$flags   = GTK_DIALOG_MODAL +| GTK_DIALOG_DESTROY_WITH_PARENT,
                *%buttons
  ) {
    samewith($title, %buttons.pairs.Array, :$parent, :$flags);
  }
  multi method new_with_buttons (
    Str()        $title,
                 @buttons,
    Int()       :$flags    = GTK_DIALOG_MODAL +| GTK_DIALOG_DESTROY_WITH_PARENT,          # GtkDialogFlags $flags
    GtkWindow() :$parent   = GtkWindow
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
      $fb.value
    );
    $o.add_buttons(@buttons);
    $o;
  }

  # Yes, I'm poking fun at the '...' limitation, at this point.
  # This method can be pulled (or better yet ignored) if you lack
  # a funny bone.
  method new_with_button(
   Str()       $title,
   GtkWindow() $parent,
   Int()       $flags,          # GtkDialogFlags $flags
   Str()       $button_text,
   Int()       $button_response_id
  )
    is also<new-with-button>
  {
    my gint           $br = $button_response_id;
    my GtkDialogFlags $f  = $flags;

    my $dialog = gtk_dialog_new_with_buttons(
      $title,
      $parent,
      $f,
      $button_text,
      $br,
      Str
    );

    $dialog ?? self.bless( :$dialog ) !! Nil;
  }

  # Type: int
  method action-area-border is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_INT );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('action-area-border', $gv);
        $gv.int;
      },
      STORE => -> $, Int() $val is copy {
        warn 'action-area-border does not allow writing'
      }
    );
  }

  # Type: int
  method button-spacing is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_INT );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('button-spacing', $gv);
        $gv.int;
      },
      STORE => -> $, Int() $val is copy {
        warn 'button-spacing does not allow writing'
      }
    );
  }

  # Type: int
  method content-area-border is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_INT );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('content-area-border', $gv);
        $gv.int;
      },
      STORE => -> $, Int() $val is copy {
        warn 'content-area-border does not allow writing'
      }
    );
  }

  # Type: int
  method content-area-spacing is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_INT );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('content-area-spacing', $gv);
        $gv.int;
      },
      STORE => -> $, Int() $val is copy {
        warn 'content-area-spacing does not allow writing'
      }
    );
  }

  # Type: int
  method use-header-bar is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_INT );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('use-header-bar', $gv);
        $gv.int;
      },
      STORE => -> $, Int() $val is copy {
        $gv.int = $val;
        self.prop_set('use-header-bar', $gv);
      }
    );
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
    my gint $ri = $response_id;

    gtk_dialog_add_action_widget($!d, $child, $ri);
  }

  proto method add_buttons (|)
    is also<add-buttons>
  { * }

  multi method add_buttons(%buttons) {
    samewith( |%buttons.pairs );
  }
  multi method add_buttons(*@buttons) {
    die '\@buttons is not an array of pair objects!'
      unless @buttons.all ~~ Pair;
    self.add_button( .key, .value ) for @buttons;
  }

  method add_button (Str() $button_text, Int() $response_id)
    is also<add-button>
  {
    my gint $ri = $response_id;

    gtk_dialog_add_button($!d, $button_text, $ri);
  }

  method get_action_area ( :$raw = False )
    is also<
      get-action-area
      action_area
      action-area
    >
  {
    my $b = gtk_dialog_get_action_area($!d);

    $b ??
      ( $raw ?? $b !! GTK::Box.new($b) )
      !!
      Nil;
  }

  method get_content_area ( :$raw = False )
    is also<
      get-content-area
      content_area
      content-area
    >
  {
    my $b = gtk_dialog_get_content_area($!d);

    $b ??
      ( $raw ?? $b !! GTK::Box.new($b) )
      !!
      Nil;
  }

  method get_header_bar ( :$raw = False ) is also<get-header-bar> {
    my $hb = gtk_dialog_get_header_bar($!d);

    $hb ??
      ( $raw ?? $hb !! GTK::HeaderBar.new($hb ) )
      !!
      Nil;
  }

  method get_response_for_widget (GtkWidget() $widget)
    is also<get-response-for-widget>
  {
    gtk_dialog_get_response_for_widget($!d, $widget);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    GTK::Widget.unstable_get_type( &gtk_dialog_get_type, $n, $t );
  }

  method get_widget_for_response (Int() $response_id, :$raw = False)
    is also<get-widget-for-response>
  {
    my gint $ri = $response_id;

    propReturnObject(
      gtk_dialog_get_widget_for_response($!d, $ri),
      $raw,
      |GTK::Widget.getTypePair
    );
  }

  # Class method.. but deprecated
  method alternative_dialog_button_order (GdkScreen $screen)
    is DEPRECATED
    is also<alternative-dialog-button-order>
  {
    gtk_alternative_dialog_button_order($screen);
  }

  multi method response (Int() $response_id) {
    my gint $ri = $response_id;

    gtk_dialog_response($!d, $ri);
  }

  method run {
    self.response.tap( -> *@a { self.hide })
      unless self.is-connected('response');

    my gint $rc = gtk_dialog_run($!d);

    GtkResponseTypeEnum( $rc );
  }

  method set_alternative_button_order_from_array (
    Int() $n_params,
    Int   @new_order
  )
    is DEPRECATED
    is also<set-alternative-button-order-from-array>
  {
    my gint         $np = $n_params;
    my CArray[gint] $no = CArray[gint].new;
    my $i = 0;
    $no[$i++] = $_ for @new_order;

    gtk_dialog_set_alternative_button_order_from_array($!d, $np, $no);
  }

  method set_default_response (Int() $response_id)
    is also<set-default-response>
  {
    my gint $ri = $response_id;

    gtk_dialog_set_default_response($!d, $ri);
  }

  method set_response_sensitive (Int() $response_id, Int() $setting)
    is also<set-response-sensitive>
  {
    my gint $ri = $response_id;
    my gboolean $s = $setting.so.Int;

    gtk_dialog_set_response_sensitive($!d, $ri, $s);
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
