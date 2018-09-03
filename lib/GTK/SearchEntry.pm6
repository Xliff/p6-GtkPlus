use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::SearchEntry;
use GTK::Raw::Types;

use GTK::Entry;

class GTK::SearchEntry is GTK::Entry {
  has Gtk $!se;

  submethod BUILD(:$searchentry) {
    given $searchentry {
      when GtkSearchEntry | GtkWidget {
        $!se = do {
          when GtkWidget      { nativecast(GtkSearchEntry, $searchentry); }
          when GtkSearchEntry { $searchentry; }
        };
        self.setEntry($searchentrty);
      }
      when GTK::SearchEntry {
      }
      default {
      }
    }
    self.setType('GTK::SearchEntry');
  }

  method new {
    my $searchentry = gtk_search_entry_new($!se);
    self.bless(:$searchentry);
  }

  # ↓↓↓↓ SIGNALS ↓↓↓↓
  method activate {
    self.connect($!sb, 'activate');
  }

  method backspace {
    self.connect($!sb, 'backspace');
  }

  method copy-clipboard {
    self.connect($!sb, 'copy-clipboard');
  }

  method cut-clipboard {
    self.connect($!sb, 'cut-clipboard');
  }

  # Is actually:
  # (GtkEntry     *entry,
  #  GtkDeleteType type,
  #  gint          count,
  #  gpointer      user_data)
  method delete-from-cursor {
    self.connect($!sb, 'delete-from-cursor');
  }

  # Is actually:
  #  (GtkEntry            *entry,
  #   GtkEntryIconPosition icon_pos,
  #   GdkEvent            *event,
  #   gpointer             user_data)
  method icon-release {
    self.connect($!sb, 'icon-release');
  }

  # Is actually:
  # (GtkEntry *entry,
  #  gchar    *string,
  #  gpointer  user_data)
  method insert-at-cursor {
    self.connect($!sb, 'insert-at-cursor');
  }

  method insert-emoji {
    self.connect($!sb, 'insert-emoji');
  }

  # Is actually:
  # (GtkEntry       *entry,
  #  GtkMovementStep step,
  #  gint            count,
  #  gboolean        extend_selection,
  #  gpointer        user_data)
  method move-cursor {
    self.connect($!sb, 'move-cursor');
  }

  method paste-clipboard {
    self.connect($!sb, 'paste-clipboard');
  }

  # is actually:
  # (GtkEntry  *entry,
  #  GtkWidget *widget,
  #  gpointer   user_data)
  method populate-popup {
    self.connect($!sb, 'populate-popup');
  }

  # Is actually:
  # (GtkEntry *entry,
  #  gchar    *preedit,
  #  gpointer  user_data)
  method preedit-changed {
    self.connect($!sb, 'preedit-changed');
  }

  method toggle-overwrite {
    self.connect($!sb, 'toggle-overwrite');
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
