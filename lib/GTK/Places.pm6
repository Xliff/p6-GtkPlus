use v6.c;

use NativeCall;

use GTK::Compat::GSList;
use GTK::Compat::Types;
use GTK::Raw::Places;
use GTK::Raw::Types;

use GTK::ScrolledWindow;

class GTK::Places is GTK::ScrolledWindow {
  has GtkPlaces $!ps;

  method bless(*%attrinit) {
    use nqp;
    my $o = nqp::create(self).BUILDALL(Empty, %attrinit);
    $o.setType('GTK::Places');
    $o;
  }

  submethod BUILD(:$places) {
    my $to-parent;
    given $places {
      when GtkPlaces | GtkWidget {
        $!ps = do {
          when GtkWidget {
            $to-parent = $_;
            nativecast(GtkPlaces, $_);
          }
          when GtkPlaces  {
            $to-parent = nativecast(GtkScrolledWindow, $_);
            $_;
          }
        }
        self.setScrolledWindow($to-parent);
      }
      when GTK::Places {
      }
      default {
      }
    }
  }

  multi method new {
    my $places = gtk_places_sidebar_new();
    self.bless(:$places);
  }
  multi method new (GtkWidget $places) {
    self.bless(:$places);
  }

  # ↓↓↓↓ SIGNALS ↓↓↓↓

  # Is originally:
  # GtkPlacesSidebar, gint, gpointer --> gint
  method drag-action-ask {
    self.connect($!ps, 'drag-action-ask');
  }

  # Is originally:
  # GtkPlacesSidebar, GdkDragContext, GObject, gpointer, gpointer --> gint
  method drag-action-requested {
    self.connect($!ps, 'drag-action-requested');
  }

  # Is originally:
  # GtkPlacesSidebar, GObject, gpointer, gint, gpointer --> void
  method drag-perform-drop {
    self.connect($!ps, 'drag-perform-drop');
  }

  # Is originally:
  # GtkPlacesSidebar, GMountOperation, gpointer --> void
  method mount {
    self.connect($!ps, 'mount');
  }

  # Is originally:
  # GtkPlacesSidebar, GObject, GtkPlacesOpenFlags, gpointer --> void
  method open-location {
    self.connect($!ps, 'open-location');
  }

  # Is originally:
  # GtkPlacesSidebar, GtkWidget, GFile, GVolume, gpointer --> void
  method populate-popup {
    self.connect($!ps, 'populate-popup');
  }

  # Is originally:
  # GtkPlacesSidebar, gpointer --> void
  method show-connect-to-server {
    self.connect($!ps, 'show-connect-to-server');
  }

  # Is originally:
  # GtkPlacesSidebar, gpointer --> void
  method show-enter-location {
    self.connect($!ps, 'show-enter-location');
  }

  # Is originally:
  # GtkPlacesSidebar, gchar, gchar, gpointer --> void
  method show-error-message {
    self.connect($!ps, 'show-error-message');
  }

  # Is originally:
  # GtkPlacesSidebar, gpointer --> void
  method show-other-locations {
    self.connect($!ps, 'show-other-locations');
  }

  # Is originally:
  # GtkPlacesSidebar, GtkPlacesOpenFlags, gpointer --> void
  method show-other-locations-with-flags {
    self.connect($!ps, 'show-other-locations-with-flags');
  }

  # Is originally:
  # GtkPlacesSidebar, GtkPlacesOpenFlags, gpointer --> void
  method show-starred-location {
    self.connect($!ps, 'show-starred-location');
  }

  # Is originally:
  # GtkPlacesSidebar, GMountOperation, gpointer --> void
  method unmount {
    self.connect($!ps, 'unmount');
  }
  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  method local_only is rw {
    Proxy.new(
      FETCH => sub ($) {
        so gtk_places_sidebar_get_local_only($!ps);
      },
      STORE => sub ($, Int() $local_only is copy) {
        my gboolean $lo = self.RESOLVE-BOOL($local_only);
        gtk_places_sidebar_set_local_only($!ps, $lo);
      }
    );
  }

  # Refine for GFile
  method location is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_places_sidebar_get_location($!ps);
      },
      STORE => sub ($, $location is copy) {
        die "GFile NYI";
        GFile.new(
          gtk_places_sidebar_set_location($!ps, $location)
        );
      }
    );
  }

  method open_flags is rw {
    Proxy.new(
      FETCH => sub ($) {
        GtkPlacesOpenFlags( gtk_places_sidebar_get_open_flags($!ps) );
      },
      STORE => sub ($, Int() $flags is copy) {
        my uint32 $f = self.RESOLVE-UINT($flags);
        gtk_places_sidebar_set_open_flags($!ps, $f);
      }
    );
  }

  method show_connect_to_server is rw {
    Proxy.new(
      FETCH => sub ($) {
        so gtk_places_sidebar_get_show_connect_to_server($!ps);
      },
      STORE => sub ($, Int() $show_connect_to_server is copy) {
        my gboolean $scs = self.RESOLVE-BOOL($show_connect_to_server);
        gtk_places_sidebar_set_show_connect_to_server($!ps, $scs);
      }
    );
  }

  method show_desktop is rw {
    Proxy.new(
      FETCH => sub ($) {
        so gtk_places_sidebar_get_show_desktop($!ps);
      },
      STORE => sub ($, Int() $show_desktop is copy) {
        my gboolean $sd = self.RESOLVE-BOOL($show_desktop);
        gtk_places_sidebar_set_show_desktop($!ps, $sd);
      }
    );
  }

  method show_enter_location is rw {
    Proxy.new(
      FETCH => sub ($) {
        so gtk_places_sidebar_get_show_enter_location($!ps);
      },
      STORE => sub ($, Int() $show_enter_location is copy) {
        my gboolean $sel = self.RESOLVE-BOOL($show_enter_location);
        gtk_places_sidebar_set_show_enter_location($!ps, $sel);
      }
    );
  }

  method show_other_locations is rw {
    Proxy.new(
      FETCH => sub ($) {
        so gtk_places_sidebar_get_show_other_locations($!ps);
      },
      STORE => sub ($, Int() $show_other_locations is copy) {
        my gboolean $sol = self.RESOLVE-BOOL($show_other_locations);
        gtk_places_sidebar_set_show_other_locations($!ps, $sol);
      }
    );
  }

  method show_recent is rw {
    Proxy.new(
      FETCH => sub ($) {
        so gtk_places_sidebar_get_show_recent($!ps);
      },
      STORE => sub ($, Int() $show_recent is copy) {
        my gboolean $sr = self.RESOLVE-BOOL($show_recent);
        gtk_places_sidebar_set_show_recent($!ps, $sr);
      }
    );
  }

  method show_starred_location is rw {
    Proxy.new(
      FETCH => sub ($) {
        so gtk_places_sidebar_get_show_starred_location($!ps);
      },
      STORE => sub ($, Int() $show_starred_location is copy) {
        my gboolean $ssl = self.RESOLVE-BOOL($show_starred_location);
        gtk_places_sidebar_set_show_starred_location($!ps, $ssl);
      }
    );
  }

  method show_trash is rw {
    Proxy.new(
      FETCH => sub ($) {
        so gtk_places_sidebar_get_show_trash($!ps);
      },
      STORE => sub ($, Int() $show_trash is copy) {
        my gboolean $st = self.RESOLVE-BOOL($show_trash);
        gtk_places_sidebar_set_show_trash($!ps, $st);
      }
    );
  }
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  method add_shortcut (GFile $location) {
    gtk_places_sidebar_add_shortcut($!ps, $location);
  }

  method get_nth_bookmark (Int() $n) {
    die "GFile NYI";
    my $nn = self.RESOLVE-INT($n);
    GFile.new(  gtk_places_sidebar_get_nth_bookmark($!ps, $nn) );
  }

  method get_type {
    gtk_places_sidebar_get_type();
  }

  method list_shortcuts {
    GTK::Compat::GSList.new((gtk_places_sidebar_list_shortcuts($!ps) );
  }

  method remove_shortcut (GFile $location) {
    gtk_places_sidebar_remove_shortcut($!ps, $location);
  }

  method set_drop_targets_visible (
    Int() $visible,
    GdkDragContext $context = GdkDragContext
  ) {
    my $v = self.RESOLVE-BOOL($visible);
    gtk_places_sidebar_set_drop_targets_visible($!ps, $v, $context);
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
