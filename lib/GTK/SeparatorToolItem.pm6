use v6.c;

use Method::Also;

use GTK::Raw::SeparatorToolItem;
use GTK::Raw::Types;

use GTK::ToolItem;

our subset GtkSeparatorToolItemAncestry is export
  where GtkSeparatorToolItem | GtkToolItemAncestry;

class GTK::SeparatorToolItem is GTK::ToolItem {
  has GtkSeparatorToolItem $!sti is implementor;

  method bless(*%attrinit) {
    my $o = self.CREATE.BUILDALL(Empty, %attrinit);
    $o.setType(self.^name);
    $o;
  }

  submethod BUILD(:$separator) {
    self.setGtkSeparatorToolItem($separator) if $separator;
  }

  method setGtkSeparatorToolItem (GtkSeparatorToolItemAncestry $_) {
    my $to-parent;

    $!sti = do {
      when GtkSeparatorToolItem {
        $to-parent = cast(GtkToolItem, $_);
        $_;
      }
      default {
        $to-parent = $_;
        cast(GtkSeparatorToolItem, $_);
      }
    };
    self.setGtkToolItem($to-parent);
  }

  multi method new (GtkSeparatorToolItemAncestry $separator, :$ref = True) {
    return Nil unless $separator;

    my $o = self.bless(:$separator);
    $o.ref if $ref;
    $o;
  }
  multi method new {
    my $separator = gtk_separator_tool_item_new();

    $separator ?? self.bless(:$separator) !! Nil;
  }

  # ↓↓↓↓ SIGNALS ↓↓↓↓
  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  method draw is rw {
    Proxy.new(
      FETCH => sub ($) {
        so gtk_separator_tool_item_get_draw($!sti);
      },
      STORE => sub ($, Int() $draw is copy) {
        my gboolean $d = $draw.so.Int;

        gtk_separator_tool_item_set_draw($!sti, $d);
      }
    );
  }
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  method get_type is also<get-type> {
    state ($n, $t);

    GTK::Widget.unstable_get_type( &gtk_separator_tool_item_get_type, $n, $t );
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
