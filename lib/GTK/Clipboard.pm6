use v6.c;

use Method::Also;
use NativeCall;


use GTK::Raw::Clipboard;
use GTK::Raw::Types;

use GLib::Roles::Object;
use GTK::Roles::Signals::Generic;
use GTK::Roles::Types;

class GTK::Clipboard {
  also does GLib::Roles::Object;
  also does GTK::Roles::Signals::Generic;
  also does GTK::Roles::Types;

  has GtkClipboard $!cb is implementor;

  submethod BUILD(:$clipboard) {
    self!setObject($!cb = $clipboard);        # GLib::Roles::Object
  }

  submethod DESTROY {
    self.disconnect-all($_) for %!signals;
  }

  method GTK::Raw::Types::GtkClipboard is also<Clipboard> { $!cb }

  multi method new (Int $sel) {
    GTK::Clipboard.get($sel);
  }
  multi method new (GdkAtom $sel) {
    GTK::Clipboard.get_a($sel);
  }
  multi method new (GdkDisplay() $display, GdkAtom $sel) {
    GTK::Clipboard.get_for_display($display, $sel);
  }
  multi method new (GdkDisplay() $display) {
    GTK::Clipboard.get_default($display);
  }
  # Static methods used in multi new(). Should these just be eliminated
  # for the default object accessors?
  method get_a(GdkAtom $sel) {
    my $clipboard = gtk_clipboard_get_a($sel);
    self.bless(:$clipboard);
  }
  method get(int64 $sel) {
    my $clipboard = gtk_clipboard_get($sel);
    self.bless(:$clipboard);
  }

  method get_default(GdkDisplay() $display) is also<get-default> {
    my $clipboard = gtk_clipboard_get_default($display);
    self.bless(:$clipboard);
  }

  method get_for_display (GdkDisplay() $display, GdkAtom $selection)
    is also<get-for-display>
  {
    my $clipboard = gtk_clipboard_get_for_display($display, $selection);
    self.bless(:$clipboard);
  }

  # ↓↓↓↓ SIGNALS ↓↓↓↓

  # Is originally:
  # GtkClipboard, GdkEvent, gpointer --> void
  method owner-change is also<owner_change> {
    self.connect-event($!cb, 'owner-change');
  }

  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  #      - or -
  # Minor helper function for masochists.

  method text is rw {
    Proxy.new(
      FETCH => -> $ {
        warn 'GTK::Clipboard.text does not support retrieval' if $DEBUG;
        '';
      },
      STORE => -> $, Str() $text {
        self.set_text($text, -1);
      }
    );
  }

  method image is rw {
    Proxy.new(
      FETCH => -> $ {
        warn 'GTK::Clipboard.image does not support retrieval' if $DEBUG;
        Nil;
      },
      STORE => -> $, GdkPixbuf() $pix {
        self.set_image($pix);
      }
    );
  }

  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  method clear {
    gtk_clipboard_clear($!cb);
  }

  method get_display is also<get-display> {
    gtk_clipboard_get_display($!cb);
  }

  method get_owner is also<get-owner> {
    gtk_clipboard_get_owner($!cb);
  }

  method get_selection is also<get-selection> {
    gtk_clipboard_get_selection($!cb);
  }

  method get_type is also<get-type> {
    gtk_clipboard_get_type();
  }

  method request_contents (
    GdkAtom $target,
    &callback,
    gpointer $user_data = gpointer
  )
    is also<request-contents>
  {
    gtk_clipboard_request_contents($!cb, $target, &callback, $user_data);
  }

  method request_image (
    &callback,
    gpointer $user_data = gpointer
  )
    is also<request-image>
  {
    gtk_clipboard_request_image($!cb, &callback, $user_data);
  }

  method request_rich_text (
    GtkTextBuffer() $buffer,
    &callback,
    gpointer $user_data = gpointer
  )
    is also<request-rich-text>
  {
    gtk_clipboard_request_rich_text($!cb, $buffer, &callback, $user_data);
  }

  method request_targets (
    &callback,
    gpointer $user_data = gpointer
  )
    is also<request-targets>
  {
    gtk_clipboard_request_targets($!cb, &callback, $user_data);
  }

  method request_text (
    &callback,
    gpointer $user_data = gpointer
  )
    is also<request-text>
  {
    gtk_clipboard_request_text($!cb, &callback, $user_data);
  }

  method request_uris (
    &callback,
    gpointer $user_data = gpointer
  )
    is also<request-uris>
  {
    gtk_clipboard_request_uris($!cb, &callback, $user_data);
  }

  method set_can_store (GtkTargetEntry() $targets, Int() $n_targets)
    is also<set-can-store>
  {
    my gint $nt = self.RESOLVE-INT($n_targets);
    gtk_clipboard_set_can_store($!cb, $targets, $nt);
  }

  method set_image (GdkPixbuf() $pixbuf) is also<set-image> {
    gtk_clipboard_set_image($!cb, $pixbuf);
  }

  method set_text (Str() $text, Int() $len) is also<set-text> {
    my gint $l = self.RESOLVE-INT($len);
    gtk_clipboard_set_text($!cb, $text, $l);
  }

  method set_with_data (
    GtkTargetEntry() $targets,
    Int() $n_targets,
    &get_func,
    &clear_func,
    gpointer $user_data = gpointer
  )
    is also<set-with-data>
  {
    my gint $nt = self.RESOLVE-INT($n_targets);
    gtk_clipboard_set_with_data(
      $!cb,
      $targets,
      $nt,
      &get_func,
      &clear_func,
      $user_data
    );
  }

  method set_with_owner (
    GtkTargetEntry() $targets,
    Int() $n_targets,
    &get_func,
    &clear_func,
    GObject() $owner
  )
    is also<set-with-owner>
  {
    my gint $nt = self.RESOLVE-INT($n_targets);
    gtk_clipboard_set_with_owner(
      $!cb,
      $targets,
      $nt,
      &get_func,
      &clear_func,
      $owner
    );
  }

  method store {
    gtk_clipboard_store($!cb);
  }

  method wait_for_contents (GdkAtom $target) is also<wait-for-contents> {
    gtk_clipboard_wait_for_contents($!cb, $target);
  }

  method wait_for_image is also<wait-for-image> {
    gtk_clipboard_wait_for_image($!cb);
  }

  method wait_for_rich_text (
    GtkTextBuffer() $buffer,
    GdkAtom $format,
    gsize $length
  )
    is also<wait-for-rich-text>
  {
    gtk_clipboard_wait_for_rich_text($!cb, $buffer, $format, $length);
  }

  method wait_for_targets (GdkAtom $targets, Int() $n_targets)
    is also<wait-for-targets>
  {
    my gint $nt = self.RESOLVE-INT($n_targets);
    gtk_clipboard_wait_for_targets($!cb, $targets, $nt);
  }

  method wait_for_text is also<wait-for-text> {
    gtk_clipboard_wait_for_text($!cb);
  }

  method wait_for_uris is also<wait-for-uris> {
    gtk_clipboard_wait_for_uris($!cb);
  }

  method wait_is_image_available is also<wait-is-image-available> {
    gtk_clipboard_wait_is_image_available($!cb);
  }

  method wait_is_rich_text_available (GtkTextBuffer() $buffer)
    is also<wait-is-rich-text-available>
  {
    gtk_clipboard_wait_is_rich_text_available($!cb, $buffer);
  }

  method wait_is_target_available (GdkAtom $target)
    is also<wait-is-target-available>
  {
    gtk_clipboard_wait_is_target_available($!cb, $target);
  }

  method wait_is_text_available is also<wait-is-text-available> {
    gtk_clipboard_wait_is_text_available($!cb);
  }

  method wait_is_uris_available is also<wait-is-uris-available> {
    gtk_clipboard_wait_is_uris_available($!cb);
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
