use v6.c;

use Method::Also;
use NativeCall;


use GTK::Raw::TextChildAnchor;
use GTK::Raw::Types;

use GLib::Roles::Object;
use GLib::Roles::ListData;

class GTK::TextChildAnchor {
  also does GLib::Roles::Object;
  
  has GtkTextChildAnchor $!ta is implementor;

  submethod BUILD(:$anchor) {
    self!setObject($!ta = $anchor);
  }
  
  method GTK::Raw::Types::GtkTextChildAnchor 
    is also<TextChildAnchor>
    { $!ta }

  multi method new (GtkTextChildAnchor $anchor) {
    my $o = self.bless(:$anchor);
    #o.upref;
    $o;
  }
  multi method new {
    my $anchor = gtk_text_child_anchor_new();
    self.bless(:$anchor);
  }

  # ↓↓↓↓ SIGNALS ↓↓↓↓
  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ PROPERTIES ↓↓↓↓
  # ↑↑↑↑ PROPERTIES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  method get_deleted is also<get-deleted> {
    gtk_text_child_anchor_get_deleted($!ta);
  }

  method get_type is also<get-type> {
    state ($n, $t);
    unstable_get_type( self.^name, &gtk_text_child_anchor_get_type, $n, $t );
  }

  # Create a new GLib::GList when working.
  method get_widgets is also<get-widgets> {
    my $l = GLib::GList.new( gtk_text_child_anchor_get_widgets($!ta) )
      but GLib::Roles::ListData[GtkWidget];
    $l.Array.map({ GTK::Widget.new($_) with $_ });
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
