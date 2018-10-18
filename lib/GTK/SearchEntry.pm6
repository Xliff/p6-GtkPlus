use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::SearchEntry;
use GTK::Raw::Types;

use GTK::Entry;

use GTK::Roles::Editable;

class GTK::SearchEntry is GTK::Entry {
  also does GTK::Roles::Editable;

  has GtkSearchEntry $!se;

  method bless(*%attrinit) {
    my $o = self.CREATE.BUILDALL(Empty, %attrinit);
    $o.setType('GTK::SearchEntry');
    $o;
  }

  submethod BUILD(:$searchentry) {
    my $to-parent;
    given $searchentry {
      when GtkSearchEntry | GtkWidget {
        $!se = do {
          when GtkWidget {
            $to-parent = $_;
            nativecast(GtkSearchEntry, $_);
          }
          when GtkSearchEntry {
            $to-parent = nativecast(GtkEntry, $_);
            $searchentry;
          }
        };
        self.setEntry($to-parent);
      }
      when GTK::SearchEntry {
      }
      default {
      }
    }
    # For GTK::Roles::GtkEditable
    $!er = nativecast(GtkEditable, $!se);
  }

  multi method new {
    my $searchentry = gtk_search_entry_new();
    self.bless(:$searchentry);
  }
  multi method new (GtkWidget $searchentry) {
    self.bless(:$searchentry);
  }

  # ↓↓↓↓ SIGNALS ↓↓↓↓

  # Is originally:
  # GtkSearchEntry, gpointer --> void
  method next-match {
    self.connect($!se, 'next-match');
  }

  # Is originally:
  # GtkSearchEntry, gpointer --> void
  method previous-match {
    self.connect($!se, 'previous-match');
  }

  # Is originally:
  # GtkSearchEntry, gpointer --> void
  method search-changed {
    self.connect($!se, 'search-changed');
  }

  # Is originally:
  # GtkSearchEntry, gpointer --> void
  method stop-search {
    self.connect($!se, 'stop-search');
  }

  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  method get_type {
    gtk_search_entry_get_type();
  }

  method handle_event (GdkEvent $event) {
    gtk_search_entry_handle_event($!se, $event);
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
