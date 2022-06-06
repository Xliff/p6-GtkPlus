use v6.c;

use Method::Also;

use GTK::Raw::SearchEntry:ver<3.0.1146>;
use GTK::Raw::Types:ver<3.0.1146>;

use GTK::Entry:ver<3.0.1146>;

our subset SearchEntryAncestry is export
  where GtkSearchEntry | EntryAncestry;

class GTK::SearchEntry:ver<3.0.1146> is GTK::Entry {
  has GtkSearchEntry $!se is implementor;

  method bless(*%attrinit) {
    my $o = self.CREATE.BUILDALL(Empty, %attrinit);
    $o.setType($o.^name);
    $o;
  }

  submethod BUILD(:$searchentry) {
    my $to-parent;
    given $searchentry {
      when SearchEntryAncestry {
        $!se = do {
          when GtkSearchEntry {
            $to-parent = cast(GtkEntry, $_);
            $searchentry;
          }
          default {
            $to-parent = $_;
            cast(GtkSearchEntry, $_);

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

  method GTK::Raw::Definitions::GtkSearchEntry
    is also<
      SearchEntry
      GtkSearchEntry
    >
  { $!se }

  multi method new (SearchEntryAncestry $searchentry, :$ref = True) {
    return Nil unless $searchentry;

    my $o = self.bless(:$searchentry);
    $o.ref if $ref;
    $o;
  }
  multi method new {
    my $searchentry = gtk_search_entry_new();

    $searchentry ?? self.bless(:$searchentry) !! Nil;
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
    state ($n, $t);

    GTK::Widget.unstable_get_type( &gtk_search_entry_get_type, $n, $t );
  }

  method handle_event (GdkEvent() $event) is also<handle-event> {
    gtk_search_entry_handle_event($!se, $event);
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
