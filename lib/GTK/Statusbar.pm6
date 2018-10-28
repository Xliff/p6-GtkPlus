use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::Statusbar;
use GTK::Raw::Types;

use GTK::Bin;

use GTK::Roles::Signals::Statusbar;

class GTK::Statusbar is GTK::Bin {
  also does GTK::Roles::Signals::Statusbar;

  has GtkStatusbar $!sb;

  method bless(*%attrinit) {
    my $o = self.CREATE.BUILDALL(Empty, %attrinit);
    $o.setType('GTK::Statusbar');
    $o;
  }

  submethod BUILD(:$statusbar) {
    my $to-parent;
    given $statusbar {
      when GtkStatusbar | GtkWidget {
        $!sb = do {
          when GtkStatusbar {
            $to-parent = nativecast(GtkBin, $_);
            $_;
          }
          when GtkWidget {
            $to-parent = $_;
            nativecast(GtkStatusbar, $_);
          }
        };
        self.setBin($to-parent);
      }
      when GTK::Statusbar {
      }
      default {
      }
    }
  }

  submethod DESTROY {
    self.disconnect-all($_) for %!signals-sb;
  }

  multi method new {
    my $statusbar = gtk_statusbar_new();
    self.bless(:$statusbar)
  }
  multi method new (GtkWidget $statusbar) {
    self.bless(:$statusbar);
  }

  # ↓↓↓↓ SIGNALS ↓↓↓↓

  # Is originally:
  # GtkStatusbar, guint, gchar, gpointer --> void
  method text-popped {
    self.connect-text($!sb, 'text-popped');
  }

  # Is originally:
  # GtkStatusbar, guint, gchar, gpointer --> void
  method text-pushed {
    self.connect-text($!sb, 'text-pushed');
  }

  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  method get_context_id (Str() $context_description) {
    gtk_statusbar_get_context_id($!sb, $context_description);
  }

  method get_message_area {
    gtk_statusbar_get_message_area($!sb);
  }

  method get_type {
    gtk_statusbar_get_type();
  }

  method pop (Int() $context_id) {
    my guint $ci = self.RESOLVE-UINT($context_id);
    gtk_statusbar_pop($!sb, $ci);
  }

  method push (Int() $context_id, Str() $text) {
    my guint $ci = self.RESOLVE-UINT($context_id);
    gtk_statusbar_push($!sb, $ci, $text);
  }

  method remove (Int() $context_id, Int() $message_id) {
    my @u = ($context_id, $message_id);
    my guint ($ci, $mi) = self.RESOLVE-UINT(@u);
    gtk_statusbar_remove($!sb, $ci, $mi);
  }

  method remove_all (Int() $context_id) {
    my guint $ci = self.RESOLVE-UINT($context_id);
    gtk_statusbar_remove_all($!sb, $ci);
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
