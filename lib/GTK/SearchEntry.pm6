use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::SearchEntry;
use GTK::Raw::Types;

use GTK::Entry;

class GTK::SearchEntry is GTK::Entry {
  has GtkSearchEntry $!se;

  method bless(*%attrinit) {
    use nqp;
    my $o = nqp::create(self).BUILDALL(Empty, %attrinit);
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
  }

  multi method new {
    my $searchentry = gtk_search_entry_new();
    self.bless(:$searchentry);
  }
  multi method new (GtkWidget $searchentry) {
    self.bless(:$searchentry);
  }

  # ↓↓↓↓ SIGNALS ↓↓↓↓
  method activate {
    self.connect($!se, 'activate');
  }

  method backspace {
    self.connect($!se, 'backspace');
  }

  method copy-clipboard {
    self.connect($!se, 'copy-clipboard');
  }

  method cut-clipboard {
    self.connect($!se, 'cut-clipboard');
  }

  # Is actually:
  # (GtkEntry     *entry,
  #  GtkDeleteType type,
  #  gint          count,
  #  gpointer      user_data)
  method delete-from-cursor {
    self.connect($!se, 'delete-from-cursor');
  }

  # Is actually:
  #  (GtkEntry            *entry,
  #   GtkEntryIconPosition icon_pos,
  #   GdkEvent            *event,
  #   gpointer             user_data)
  method icon-release {
    self.connect($!se, 'icon-release');
  }

  # Is actually:
  # (GtkEntry *entry,
  #  gchar    *string,
  #  gpointer  user_data)
  method insert-at-cursor {
    self.connect($!se, 'insert-at-cursor');
  }

  method insert-emoji {
    self.connect($!se, 'insert-emoji');
  }

  # Is actually:
  # (GtkEntry       *entry,
  #  GtkMovementStep step,
  #  gint            count,
  #  gboolean        extend_selection,
  #  gpointer        user_data)
  method move-cursor {
    self.connect($!se, 'move-cursor');
  }

  method paste-clipboard {
    self.connect($!se, 'paste-clipboard');
  }

  # is actually:
  # (GtkEntry  *entry,
  #  GtkWidget *widget,
  #  gpointer   user_data)
  method populate-popup {
    self.connect($!se, 'populate-popup');
  }

  # Is actually:
  # (GtkEntry *entry,
  #  gchar    *preedit,
  #  gpointer  user_data)
  method preedit-changed {
    self.connect($!se, 'preedit-changed');
  }

  method toggle-overwrite {
    self.connect($!se, 'toggle-overwrite');
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
