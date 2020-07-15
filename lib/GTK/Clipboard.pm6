use v6.c;

use Method::Also;
use NativeCall;

use GTK::Raw::Clipboard;
use GTK::Raw::Types;

use GDK::Display;
use GDK::Pixbuf;
use GTK::Selection;

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

  method GTK::Raw::Definitions::GtkClipboard
    is also<
      Clipboard
      GtkClipboard
    >
  { $!cb }

  multi method new (Int() $sel) {
    GTK::Clipboard.get($sel);
  }
  multi method new (GdkAtom $sel, :$atom is required) {
    GTK::Clipboard.get_a($sel);
  }
  multi method new (
    GdkDisplay() $disp,
    GdkAtom $sel,
    :$display is required
  ) {
    GTK::Clipboard.get_for_display($disp, $sel);
  }
  multi method new (
    GdkDisplay() $disp,
    :$display is required
  ) {
    GTK::Clipboard.get_default($disp);
  }
  # Static methods used in multi new(). Should these just be eliminated
  # for the default object accessors?
  method get_a (GdkAtom $sel) {
    my $clipboard = gtk_clipboard_get_a($sel);

    $clipboard ?? self.bless( :$clipboard ) !! Nil;
  }
  method get (Int() $sel) {
    my GdkAtom $clipboard = gtk_clipboard_get($sel);

    $clipboard ?? self.bless( :$clipboard ) !! Nil;
  }

  method get_default (GdkDisplay() $display) is also<get-default> {
    my $clipboard = gtk_clipboard_get_default($display);

    $clipboard ?? self.bless(:$clipboard) !! Nil;
  }

  method get_for_display (GdkDisplay() $display, GdkAtom $selection)
    is also<get-for-display>
  {
    my $clipboard = gtk_clipboard_get_for_display($display, $selection);

    $clipboard ?? self.bless(:$clipboard) !! Nil;
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
      FETCH => sub ($) {
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
      FETCH => sub ($) {
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

  method get_display (:$raw = False) is also<get-display> {
    my $d = gtk_clipboard_get_display($!cb);

    $d ??
      ( $raw ?? $d !! GDK::Display.new($d) )
      !!
      Nil;
  }

  method get_owner (:$raw = False) is also<get-owner> {
    my $o = gtk_clipboard_get_owner($!cb);

    $o ??
      ( $raw ?? $o !! GLib::Roles::Object.new-object-obj($o) )
      !!
      Nil;
  }

  method get_selection (:$raw = False) is also<get-selection> {
    my $s = gtk_clipboard_get_selection($!cb);

    $s ??
      ( $raw ?? $s !! GTK::Selection.new($s) )
      !!
      Nil
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gtk_clipboard_get_type, $n, $t );
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
    my gint $nt = $n_targets;

    gtk_clipboard_set_can_store($!cb, $targets, $nt);
  }

  method set_image (GdkPixbuf() $pixbuf) is also<set-image> {
    gtk_clipboard_set_image($!cb, $pixbuf);
  }

  method set_text (Str() $text, Int() $len) is also<set-text> {
    my gint $l = $len;

    gtk_clipboard_set_text($!cb, $text, $l);
  }

  method set_with_data (
    gpointer $targets,
    Int() $n_targets,
    &get_func,
    &clear_func,
    gpointer $user_data = gpointer
  )
    is also<set-with-data>
  {
    my gint $nt = $n_targets;

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
    gpointer $targets,
    Int() $n_targets,
    &get_func,
    &clear_func,
    GObject() $owner
  )
    is also<set-with-owner>
  {
    my gint $nt = $n_targets;

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

  method wait_for_contents (GdkAtom $target, :$raw = False)
    is also<wait-for-contents>
  {
    my $s = gtk_clipboard_wait_for_contents($!cb, $target);

    $s ??
      ( $raw ?? $s !! GTK::Selection.new($s) )
      !!
      Nil;
  }

  method wait_for_image (:$raw = False) is also<wait-for-image> {
    my $p = gtk_clipboard_wait_for_image($!cb);

    $p ??
      ( $raw ?? $p !! GDK::Pixbuf.new($p) )
      !!
      Nil;
  }

  proto method wait_for_rich_text (|)
    is also<wait-for-rich-text>
  { * }

  multi method wait_for_rich_text (
    GtkTextBuffer() $buffer,
    GdkAtom $format,
    :$raw = False
  ) {
    my @r = callwith($buffer, $format, $, :all, :$raw);

    $raw.not ?? @r[0] !! @r;
  }
  multi method wait_for_rich_text (
    GtkTextBuffer() $buffer,
    GdkAtom $format,
    $length is rw,
    :$all = False,
    :$raw = False,
  ) {
    my gsize $l = 0;

    my $rv = gtk_clipboard_wait_for_rich_text($!cb, $buffer, $format, $l);
    $length = $l;

    return Nil unless $rv;

    $rv = $raw ?? $rv !! Buf.new( CArrayToArray($rv, $length) );
    $all.not ?? $rv !! ($rv, $length)
  }

  proto method wait_for_targets (|)
    is also<wait-for-targets>
  { * }

  multi method wait_for_targets (:$all = True, :$raw = False) {
    my $t = CArray[CArray[GdkAtom]].new;
    $t[0] = CArray[GdkAtom];
    my @r = samewith($t, $);

    @r[0] ??
      ( $raw ?? @r !! @r[1] )
      !!
      (False, ())
  }
  multi method wait_for_targets (
    CArray[CArray[GdkAtom]] $targets,
    $n_targets is rw,
    :$all = False,
    :$raw = False
  ) {
    my gint $nt = 0;

    my $rv = so gtk_clipboard_wait_for_targets($!cb, $targets, $nt);
    $n_targets = $nt;

    return Nil unless $rv;

    my $returned_targets = $targets[0] ??
      ( $raw ?? $targets[0] !! CArrayToArray($targets[0], $n_targets) )
      !!
      Nil;

    $all.not ?? $rv !! ($rv, $returned_targets, $n_targets);
  }

  method wait_for_text is also<wait-for-text> {
    gtk_clipboard_wait_for_text($!cb);
  }

  method wait_for_uris is also<wait-for-uris> {
    my $u = gtk_clipboard_wait_for_uris($!cb);

    $u ?? CStringArrayToArray($u) !! Nil
  }

  method wait_is_image_available is also<wait-is-image-available> {
    so gtk_clipboard_wait_is_image_available($!cb);
  }

  method wait_is_rich_text_available (GtkTextBuffer() $buffer)
    is also<wait-is-rich-text-available>
  {
    so gtk_clipboard_wait_is_rich_text_available($!cb, $buffer);
  }

  method wait_is_target_available (GdkAtom $target)
    is also<wait-is-target-available>
  {
    so gtk_clipboard_wait_is_target_available($!cb, $target);
  }

  method wait_is_text_available is also<wait-is-text-available> {
    so gtk_clipboard_wait_is_text_available($!cb);
  }

  method wait_is_uris_available is also<wait-is-uris-available> {
    so gtk_clipboard_wait_is_uris_available($!cb);
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
