use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::SeparatorToolItem;
use GTK::Raw::Types;

use GTK::ToolItem;

class GTK::SeparatorToolItem is GTK::ToolItem {
  has GtkSeparatorToolItem $!sti;

  submethod BUILD(:$separator) {
    given $separator {
      when GtkSepartorToolItem | GtkWidget {
        $!sti = do {
          when GtkWidget {
            nativecast(GtkSeparatorToolItem , $separator);
          }
          when GtkSeparatorToolItem {
            $separator;
          }
        };
        self.setToolItem($separator);
      }
      when GTK::SeparatorToolItem {
      }
      default {
      }
    }
    self.setType('GTK::SeparatorToolItem');
  }

  method new {
    my $separator = gtk_separator_tool_item_new();
    self.bless(:$separator);
  }

  # ↓↓↓↓ SIGNALS ↓↓↓↓
  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  method draw is rw {
    Proxy.new(
      FETCH => sub ($) {
        Bool( gtk_separator_tool_item_get_draw($!sti) );
      },
      STORE => sub ($, Int() $draw is copy) {
        my gboolean $d = $draw == 0 ?? 0 !! 1;
        gtk_separator_tool_item_set_draw($!sti, $d);
      }
    );
  }
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  method get_type {
    gtk_separator_tool_item_get_type();
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
