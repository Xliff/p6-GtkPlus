use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::StatusBar;
use GTK::Raw::Types;

use GTK::Bin;

class GTK:: is GTK::Bin {
  has Gtk $!sb;

  submethod BUILD(:$statusbar) {
    given $statusbar {
      when GtkStatusBar | GtkWidget {
        $!sb = do given {
          when GtkStatusBar { $statusbar; }
          when GtkWidget    { nativecast(GtkStatusBar, $statusbar); }
        };
        self.setBin($statusbar);
      }
      when GTK::StatusBar {
      }
      default {
      }
    }
  }

  method new () {
    my $statusbar = gtk_statusbar_new();
    self.bless(:$statusbar)
  }

  # ↓↓↓↓ SIGNALS ↓↓↓↓

  # Is originally:
  # GtkStatusbar, guint, gchar, gpointer --> void
  method text-popped {
    self.connect($!sb, 'text-popped');
  }

  # Is originally:
  # GtkStatusbar, guint, gchar, gpointer --> void
  method text-pushed {
    self.connect($!sb, 'text-pushed');
  }
  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  method get_context_id (gchar $context_description) {
    gtk_statusbar_get_context_id($!sb, $context_description);
  }

  method get_message_area {
    gtk_statusbar_get_message_area($!sb);
  }

  method get_type {
    gtk_statusbar_get_type();
  }

  method pop (guint $context_id) {
    my guint $ci = $context_id +& 0xffff;
    gtk_statusbar_pop($!sb, $ci);
  }

  method push (Int() $context_id, gchar $text) {
    my guint $ci = $context_id +& 0xffff;
    gtk_statusbar_push($!sb, $ci, $text);
  }

  method remove (Int() $context_id, Int() $message_id) {
    my guint ($ci, $mi) = ($context_id, $message_id) >>+&<< (0xffff xx 2);
    gtk_statusbar_remove($!sb, $context_id, $message_id);
  }

  method remove_all (guint $context_id) {
    my guint $ci = $context_id +& 0xffff;
    gtk_statusbar_remove_all($!sb, $ci);
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
