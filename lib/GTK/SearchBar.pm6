use v6.c;

use Method::Also;

use GTK::Raw::SearchBar;
use GTK::Raw::Types;

use GTK::Bin;

our subset SearchBarAncestry is export
  where GtkSearchBar | BinAncestry;

class GTK::SearchBar is GTK::Bin {
  has GtkSearchBar $!sb is implementor;

  method bless(*%attrinit) {
    my $o = self.CREATE.BUILDALL(Empty, %attrinit);
    $o.setType($o.^name);
    $o;
  }

  submethod BUILD(:$searchbar) {
    my $to-parent;
    given $searchbar {
      when SearchBarAncestry {
        $!sb = do {
          when GtkSearchBar {
            $to-parent = cast(GtkBin, $_);
            $_;
          }
          default {
            $to-parent = $_;
            cast(GtkSearchBar, $_);
          }
        }
        self.setBin($to-parent);
      }
      when GTK::SearchBar {
      }
      default {
      }
    }
  }

  method GTK::Raw::Definitions::GtkSearchBar
    is also<
      SearchBar
      GtkSearchBar
    >
  { $!sb }

  multi method new (SearchBarAncestry $searchbar, :$ref = True) {
    return Nil unless $searchbar;

    my $o = self.bless(:$searchbar);
    $o.ref if $ref;
    $o;
  }
  multi method new {
    my $searchbar = gtk_search_bar_new();

    $searchbar ?? self.bless(:$searchbar) !! Nil;
  }

  # ↓↓↓↓ SIGNALS ↓↓↓↓
  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  method search_mode is rw is also<search-mode> {
    Proxy.new(
      FETCH => sub ($) {
        so gtk_search_bar_get_search_mode($!sb);
      },
      STORE => sub ($, Int() $search_mode is copy) {
        my gboolean $sm = $search_mode.so.Int;

        gtk_search_bar_set_search_mode($!sb, $sm);
      }
    );
  }

  method show_close_button is rw is also<show-close-button> {
    Proxy.new(
      FETCH => sub ($) {
        so gtk_search_bar_get_show_close_button($!sb);
      },
      STORE => sub ($, Int() $visible is copy) {
        my gboolean $v = $visible.so.Int;

        gtk_search_bar_set_show_close_button($!sb, $v);
      }
    );
  }
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  method connect_entry (GtkEntry() $entry) is also<connect-entry> {
    gtk_search_bar_connect_entry($!sb, $entry);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    GTK::Widget.unstable_get_type( &gtk_search_bar_get_type, $n, $t );
  }

  method handle_event (GdkEvent() $event) is also<handle-event> {
    so gtk_search_bar_handle_event($!sb, $event);
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
