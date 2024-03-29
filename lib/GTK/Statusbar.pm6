use v6.c;

use Method::Also;
use NativeCall;

use GTK::Raw::Statusbar:ver<3.0.1146>;
use GTK::Raw::Types:ver<3.0.1146>;

use GTK::Box:ver<3.0.1146>;

use GTK::Roles::Signals::Statusbar:ver<3.0.1146>;

our subset GtkStatusbarAncestry is export
  where GtkStatusbar | GtkBoxAncestry;

our constant StatusbarAncestry is export := GtkStatusbarAncestry;

class GTK::Statusbar:ver<3.0.1146> is GTK::Box {
  also does GTK::Roles::Signals::Statusbar;

  has GtkStatusbar $!sb is implementor;

  method bless(*%attrinit) {
    my $o = self.CREATE.BUILDALL(Empty, %attrinit);
    $o.setType($o.^name);
    $o;
  }

  submethod BUILD(:$statusbar) {
    self.setGtkStatusbar( $statusbar ) if $statusbar;
  }

  method setGtkStatusbar (GtkStatusbarAncestry $_) {
    my $to-parent;
    $!sb = do {
      when GtkStatusbar {
        $to-parent = nativecast(GtkBin, $_);
        $_;
      }
      default {
        $to-parent = $_;
        nativecast(GtkStatusbar, $_);
       }
    };
    self.setBox($to-parent);
  }

  method GTK::Raw::Definitions::GtkStatusbar
    is also<
      Statusbar
      GtkStatusbar
    >
  { $!sb }

  submethod DESTROY {
    self.disconnect-all($_) for %!signals-sb;
  }

  multi method new (GtkStatusbarAncestry $statusbar, :$ref = True) {
    return Nil unless $statusbar;

    my $o = self.bless(:$statusbar);
    $o.ref if $ref;
    $o;
  }
  multi method new {
    my $statusbar = gtk_statusbar_new();

    $statusbar ?? self.bless(:$statusbar) !! Nil;
  }

  # ↓↓↓↓ SIGNALS ↓↓↓↓

  # Is originally:
  # GtkStatusbar, guint, gchar, gpointer --> void
  method text-popped is also<text_popped> {
    self.connect-text($!sb, 'text-popped');
  }

  # Is originally:
  # GtkStatusbar, guint, gchar, gpointer --> void
  method text-pushed is also<text_pushed> {
    self.connect-text($!sb, 'text-pushed');
  }

  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  method get_context_id (Str() $context_description)
    is also<get-context-id>
  {
    gtk_statusbar_get_context_id($!sb, $context_description);
  }

  method get_message_area (:$raw = False, :$widget = False)
    is also<get-message-area>
  {
    my $w = gtk_statusbar_get_message_area($!sb);

    self.ReturnWidget($w, $raw, $widget);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    GTK::Widget.unstable_get_type( &gtk_statusbar_get_type, $n, $t );
  }

  method pop (Int() $context_id) {
    my guint $ci = $context_id;

    gtk_statusbar_pop($!sb, $ci);
  }

  method push (Int() $context_id, Str() $text) {
    my guint $ci = $context_id;

    gtk_statusbar_push($!sb, $ci, $text);
  }

  method remove (Int() $context_id, Int() $message_id) {
    my guint ($ci, $mi) = ($context_id, $message_id);

    gtk_statusbar_remove($!sb, $ci, $mi);
  }

  method remove_all (Int() $context_id) is also<remove-all> {
    my guint $ci = $context_id;

    gtk_statusbar_remove_all($!sb, $ci);
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
