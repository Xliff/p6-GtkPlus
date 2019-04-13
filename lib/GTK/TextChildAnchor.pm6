use v6.c;

use Method::Also;
use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::TextChildAnchor;
use GTK::Raw::Types;

use GTK::Compat::Roles::Object;
use GTK::Compat::Roles::ListData;

class GTK::TextChildAnchor {
  also does GTK::Compat::Roles::Object;
  
  has GtkTextChildAnchor $!ta;

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

  # Create a new GTK::Compat::GList when working.
  method get_widgets is also<get-widgets> {
    my $l = GTK::Compat::GList.new( gtk_text_child_anchor_get_widgets($!ta) )
      but GTK::Compat::Roles::ListData[GtkWidget];
    $l.Array.map({ GTK::Widget.new($_) with $_ });
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
