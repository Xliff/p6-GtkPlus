use v6.c;

use Method::Also;

use GTK::Raw::EventBox:ver<3.0.1146>;
use GTK::Raw::Types:ver<3.0.1146>;

use GTK::Bin:ver<3.0.1146>;

our subset GtkEventBoxAncestry is export of Mu
  where GtkEventBox | BinAncestry;

our constant EventBoxAncestry is export := GtkEventBoxAncestry;

class GTK::EventBox:ver<3.0.1146> is GTK::Bin {
  has GtkEventBox $!eb is implementor;

  method bless(*%attrinit) {
    my $o = self.CREATE.BUILDALL(Empty, %attrinit);
    $o.setType($o.^name);
    $o;
  }

  submethod BUILD(:$event-box) {
    self.setGtkEventBox($event-box) if $event-box;
  }

  method setGtkEventBox (GtkEventBoxAncestry $_) {
    my $to-parent;
    
    $!eb = do {
      when GtkEventBox  {
        $to-parent = cast(GtkBin, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GtkEventBox, $_);
      }
    }
    self.setBin($to-parent);
  }

  method GTK::Raw::Definitions::GtkEventBox
    is also<
      EventBox
      GtkEventBox
    >
  { $!eb }

  multi method new (EventBoxAncestry $event-box, :$ref = True) {
    return Nil unless $event-box;

    my $o = self.bless(:$event-box);
    $o.ref if $ref;
    $o;
  }
  multi method new {
    my $event-box = gtk_event_box_new();

    $event-box ?? self.bless(:$event-box) !! Nil;
  }

  # ↓↓↓↓ SIGNALS ↓↓↓↓
  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  method above_child is rw is also<above-child> {
    Proxy.new(
      FETCH => sub ($) {
        so gtk_event_box_get_above_child($!eb);
      },
      STORE => sub ($, Int() $above_child is copy) {
        my gboolean $ab = $above_child.so.Int;

        gtk_event_box_set_above_child($!eb, $ab);
      }
    );
  }

  method visible_window is rw is also<visible-window> {
    Proxy.new(
      FETCH => sub ($) {
        so gtk_event_box_get_visible_window($!eb);
      },
      STORE => sub ($, Int() $visible_window is copy) {
        my gboolean $vw = $visible_window.so.Int;

        gtk_event_box_set_visible_window($!eb, $vw);
      }
    );
  }

  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ PROPERTIES ↓↓↓↓
  # ↑↑↑↑ PROPERTIES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  method get_type is also<get-type> {
    state ($n, $t);

    GTK::Widget.unstable_get_type( &gtk_event_box_get_type, $n, $t );
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
