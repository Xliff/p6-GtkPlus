use v6.c;

use Method::Also;
use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::Statusbar;
use GTK::Raw::Types;

use GTK::Box;

use GTK::Roles::Signals::Statusbar;

my subset Ancestry
  where GtkStatusbar | GtkBox | GtkOrientable | GtkContainer | GtkBuilder |
        GtkWidget;

class GTK::Statusbar is GTK::Box {
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
      when Ancestry {
        $!sb = do {
          when GtkStatusbar {
            $to-parent = nativecast(GtkBin, $_);
            $_;
          }
          default {
            $to-parent = $_;
            nativecast(GtkStatusbar, $_);
          }
        };
        self.setBox($to-parent);
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

  multi method new (GtkWidget $statusbar) {
    my $o = self.bless(:$statusbar);
    $o.upref;
    $o;
  }
  multi method new {
    my $statusbar = gtk_statusbar_new();
    self.bless(:$statusbar)
  }

  # ↓↓↓↓ SIGNALS ↓↓↓↓

  # Is originally:
  # GtkStatusbar, guint, gchar, gpointer --> void
  method text-popped is also<text_popped> {
    self.connect-text($!sb, 'text-popped');
  }

  # Is originally:
  # GtkStatusbar, guint, gchar, gpointer --> void
  method text-pushed is also<text_pushed> {
    self.connect-text($!sb, 'text-pushed');
  }

  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  method get_context_id (Str() $context_description)
    is also<get-context-id>
  {
    gtk_statusbar_get_context_id($!sb, $context_description);
  }

  method get_message_area is also<get-message-area> {
    gtk_statusbar_get_message_area($!sb);
  }

  method get_type is also<get-type> {
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

  method remove_all (Int() $context_id) is also<remove-all> {
    my guint $ci = self.RESOLVE-UINT($context_id);
    gtk_statusbar_remove_all($!sb, $ci);
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
