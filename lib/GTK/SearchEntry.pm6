use v6.c;

use Method::Also;
use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::SearchEntry;
use GTK::Raw::Types;

use GTK::Entry;

my subset Ancestry
  where GtkSearchEntry | GtkEntry  | GtkCellEditable | GtkEditable |
        GtkBuildable   | GtkWidget;


class GTK::SearchEntry is GTK::Entry {
  has GtkSearchEntry $!se;

  method bless(*%attrinit) {
    my $o = self.CREATE.BUILDALL(Empty, %attrinit);
    $o.setType('GTK::SearchEntry');
    $o;
  }

  submethod BUILD(:$searchentry) {
    my $to-parent;
    given $searchentry {
      when Ancestry {
        $!se = do {
          when GtkSearchEntry {
            $to-parent = nativecast(GtkEntry, $_);
            $searchentry;
          }
          default {
            $to-parent = $_;
            nativecast(GtkSearchEntry, $_);

          }
        };
        self.setEntry($to-parent);
      }
      when GTK::SearchEntry {
      }
      default {
      }
    }
  }

  multi method new (Ancestry $searchentry) {
    my $o = self.bless(:$searchentry);
    $o.upref;
    $o;
  }
  multi method new {
    my $searchentry = gtk_search_entry_new();
    self.bless(:$searchentry);
  }

  # ↓↓↓↓ SIGNALS ↓↓↓↓

  # Is originally:
  # GtkSearchEntry, gpointer --> void
  method next-match is also<next_match> {
    self.connect($!se, 'next-match');
  }

  # Is originally:
  # GtkSearchEntry, gpointer --> void
  method previous-match is also<previous_match> {
    self.connect($!se, 'previous-match');
  }

  # Is originally:
  # GtkSearchEntry, gpointer --> void
  method search-changed is also<search_changed> {
    self.connect($!se, 'search-changed');
  }

  # Is originally:
  # GtkSearchEntry, gpointer --> void
  method stop-search is also<stop_search> {
    self.connect($!se, 'stop-search');
  }

  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  method get_type is also<get-type> {
    gtk_search_entry_get_type();
  }

  method handle_event (GdkEvent $event) is also<handle-event> {
    gtk_search_entry_handle_event($!se, $event);
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
