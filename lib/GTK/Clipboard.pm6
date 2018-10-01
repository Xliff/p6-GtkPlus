use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::Clipboard;
use GTK::Raw::Types;

class GTK::Clipboard {
  has GtkClipboard $!cb;

  submethod BUILD(:$clipboard) {
    $!cb = $clipboard
  }

  method GTK::Raw::Types::GtkClipboard {
    $!cb;
  }

  multi method new (GdkAtom $sel) {
    my $clipboard = GTK::Clipboard.get($sel);
    self.bless(:$clipboard);
  }
  multi method new (GdkDisplay $display, GdkAtom $sel) {
    my $clipboard = GTK::Clipboard.get_for_display($display, $sel);
    self.bless(:$clipboard);
  }
  multi method new (GdkDisplay $display) {
    my $clipboard = GTK::Clipboard.get_default($display);
    self.bless(:$clipboard);
  }

  # Static methods used in multi new(). Should these just be eliminated
  # for the default object accessors?
  method get(GdkAtom $sel) {
    gtk_clipboard_get($sel);
  }

  method get_default(GdkDisplay $display) {
    gtk_clipboard_get_default($display);
  }

  method get_for_display (GdkDisplay $display, GdkAtom $selection) {
    gtk_clipboard_get_for_display($display, $selection);
  }

  # ↓↓↓↓ SIGNALS ↓↓↓↓

  # Is originally:
  # GtkClipboard, GdkEvent, gpointer --> void
  method owner-change {
    self.connect($!cb, 'owner-change');
  }

  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  method clear {
    gtk_clipboard_clear($!cb);
  }

  method get_display {
    gtk_clipboard_get_display($!cb);
  }

  method get_owner {
    gtk_clipboard_get_owner($!cb);
  }

  method get_selection {
    gtk_clipboard_get_selection($!cb);
  }

  method get_type {
    gtk_clipboard_get_type();
  }

  method request_contents (
    GdkAtom $target,
    GtkClipboardReceivedFunc $callback,
    gpointer $user_data
  ) {
    gtk_clipboard_request_contents($!cb, $target, $callback, $user_data);
  }

  method request_image (
    GtkClipboardImageReceivedFunc $callback,
    gpointer $user_data
  ) {
    gtk_clipboard_request_image($!cb, $callback, $user_data);
  }

  method request_rich_text (
    GtkTextBuffer() $buffer,
    GtkClipboardRichTextReceivedFunc $callback,
    gpointer $user_data
  ) {
    gtk_clipboard_request_rich_text($!cb, $buffer, $callback, $user_data);
  }

  method request_targets (
    GtkClipboardTargetsReceivedFunc $callback,
    gpointer $user_data
  ) {
    gtk_clipboard_request_targets($!cb, $callback, $user_data);
  }

  method request_text (
    GtkClipboardTextReceivedFunc $callback,
    gpointer $user_data
  ) {
    gtk_clipboard_request_text($!cb, $callback, $user_data);
  }

  method request_uris (
    GtkClipboardURIReceivedFunc $callback,
    gpointer $user_data
  ) {
    gtk_clipboard_request_uris($!cb, $callback, $user_data);
  }

  method set_can_store (GtkTargetEntry() $targets, gint $n_targets) {
    gtk_clipboard_set_can_store($!cb, $targets, $n_targets);
  }

  method set_image (GdkPixbuf $pixbuf) {
    gtk_clipboard_set_image($!cb, $pixbuf);
  }

  method set_text (gchar $text, gint $len) {
    gtk_clipboard_set_text($!cb, $text, $len);
  }

  method set_with_data (
    GtkTargetEntry() $targets,
    guint $n_targets,
    GtkClipboardGetFunc $get_func,
    GtkClipboardClearFunc $clear_func,
    gpointer $user_data
  ) {
    gtk_clipboard_set_with_data(
      $!cb,
      $targets,
      $n_targets,
      $get_func,
      $clear_func,
      $user_data
    );
  }

  method set_with_owner (
    GtkTargetEntry() $targets,
    guint $n_targets,
    GtkClipboardGetFunc $get_func,
    GtkClipboardClearFunc $clear_func,
    GObject $owner
  ) {
    gtk_clipboard_set_with_owner(
      $!cb,
      $targets,
      $n_targets,
      $get_func,
      $clear_func,
      $owner
    );
  }

  method store {
    gtk_clipboard_store($!cb);
  }

  method wait_for_contents (GdkAtom $target) {
    gtk_clipboard_wait_for_contents($!cb, $target);
  }

  method wait_for_image () {
    gtk_clipboard_wait_for_image($!cb);
  }

  method wait_for_rich_text (
    GtkTextBuffer() $buffer,
    GdkAtom $format,
    gsize $length
  ) {
    gtk_clipboard_wait_for_rich_text($!cb, $buffer, $format, $length);
  }

  method wait_for_targets (GdkAtom $targets, gint $n_targets) {
    gtk_clipboard_wait_for_targets($!cb, $targets, $n_targets);
  }

  method wait_for_text {
    gtk_clipboard_wait_for_text($!cb);
  }

  method wait_for_uris {
    gtk_clipboard_wait_for_uris($!cb);
  }

  method wait_is_image_available {
    gtk_clipboard_wait_is_image_available($!cb);
  }

  method wait_is_rich_text_available (GtkTextBuffer() $buffer) {
    gtk_clipboard_wait_is_rich_text_available($!cb, $buffer);
  }

  method wait_is_target_available (GdkAtom $target) {
    gtk_clipboard_wait_is_target_available($!cb, $target);
  }

  method wait_is_text_available {
    gtk_clipboard_wait_is_text_available($!cb);
  }

  method wait_is_uris_available {
    gtk_clipboard_wait_is_uris_available($!cb);
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
