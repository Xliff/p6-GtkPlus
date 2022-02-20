use v6.c;

use Method::Also;

use GTK::Raw::TextChildAnchor:ver<3.0.1146>;
use GTK::Raw::Types:ver<3.0.1146>;

use GTK::Widget:ver<3.0.1146>;

use GLib::Roles::Object;
use GLib::Roles::ListData;

class GTK::TextChildAnchor:ver<3.0.1146> {
  also does GLib::Roles::Object;

  has GtkTextChildAnchor $!ta is implementor;

  submethod BUILD(:$anchor) {
    self!setObject($!ta = $anchor);
  }

  method GTK::Raw::Definitions::GtkTextChildAnchor
    is also<
      TextChildAnchor
      GtkTextChildAnchor
    >
  { $!ta }

  multi method new (GtkTextChildAnchor $anchor) {
    return Nil unless $anchor;

    my $o = self.bless(:$anchor);
    #o.upref;
    $o;
  }
  multi method new {
    my $anchor = gtk_text_child_anchor_new();

    $anchor ?? self.bless(:$anchor) !! Nil;
  }

  # ↓↓↓↓ SIGNALS ↓↓↓↓
  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ PROPERTIES ↓↓↓↓
  # ↑↑↑↑ PROPERTIES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  method get_deleted is also<get-deleted> {
    so gtk_text_child_anchor_get_deleted($!ta);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gtk_text_child_anchor_get_type, $n, $t );
  }

  # Create a new GLib::GList when working.
  method get_widgets (:$glist = False, :$raw = False, :$widget = False)
    is also<get-widgets>
  {
    my $wl = gtk_text_child_anchor_get_widgets($!ta);

    return Nil unless $wl;
    return $wl if $glist;

    $wl = GLib::GList.new($wl) but GLib::Roles::ListData[GtkWidget];
    $wl.Array.map({ ReturnWidget($_, $raw, $widget) });
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
