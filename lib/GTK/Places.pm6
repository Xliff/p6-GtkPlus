use v6.c;

use Method::Also;

use GLib::GSList;

use GTK::Raw::Places:ver<3.0.1146>;
use GTK::Raw::Types:ver<3.0.1146>;

use GLib::GSList;

use GTK::ScrolledWindow:ver<3.0.1146>;

use GIO::Roles::GFile;
use GTK::Roles::Signals::Places:ver<3.0.1146>;

our subset PlacesAncestry is export
  where GtkPlacesSidebar | ScrolledWindowAncestry;

class GTK::Places:ver<3.0.1146> is GTK::ScrolledWindow {
  also does GTK::Roles::Signals::Places;

  has GtkPlacesSidebar $!ps is implementor;

  method bless(*%attrinit) {
    my $o = self.CREATE.BUILDALL(Empty, %attrinit);
    $o.setType($o.^name);
    $o;
  }

  submethod BUILD(:$places) {
    my $to-parent;
    given $places {
      when PlacesAncestry {
        $!ps = do {
          when GtkPlacesSidebar {
            $to-parent = cast(GtkScrolledWindow, $_);
            $_;
          }
          default {
            $to-parent = $_;
            cast(GtkPlacesSidebar, $_);
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

  submethod DESTROY {
    self.disconnect-all($_) for %!signals-p;
  }

  method GTK::Raw::Definitions::GtkPlacesSidebar is also<Places> { $!ps }

  multi method new (PlacesAncestry $places, :$ref = True) {
    my $o = self.bless(:$places);
    $o.ref if $ref;
    $o;
  }
  multi method new {
    my $places = gtk_places_sidebar_new();

    $places ?? self.bless(:$places) !! Nil;
  }

  # ↓↓↓↓ SIGNALS ↓↓↓↓

  # Is originally:
  # GtkPlacesSidebar, gint, gpointer --> gint
  method drag-action-ask is also<drag_action_ask> {
    self.connect-int-rint($!ps, 'drag-action-ask');
  }

  # Is originally:
  # GtkPlacesSidebar, GdkDragContext, GObject, gpointer, gpointer --> gint
  method drag-action-requested is also<drag_action_requested> {
    self.connect-drag-action-requested($!ps);
  }

  # Is originally:
  # GtkPlacesSidebar, GObject, gpointer, gint, gpointer --> void
  method drag-perform-drop is also<drag_perform_drop> {
    self.connect-drag-perform-drop($!ps);
  }

  # Is originally:
  # GtkPlacesSidebar, GMountOperation, gpointer --> void
  method mount {
    self.connect-mount_op($!ps, 'mount');
  }

  # Is originally:
  # GtkPlacesSidebar, GObject, GtkPlacesOpenFlags, gpointer --> void
  method open-location is also<open_location> {
    self.connect-open-location($!ps);
  }

  # Is originally:
  # GtkPlacesSidebar, GtkWidget, GFile, GVolume, gpointer --> void
  method populate-popup is also<populate_popup> {
    self.connect-populate-popup($!ps);
  }

  # Is originally:
  # GtkPlacesSidebar, gpointer --> void
  method show-connect-to-server is also<show_connect_to_server> {
    self.connect($!ps, 'show-connect-to-server');
  }

  # Is originally:
  # GtkPlacesSidebar, gpointer --> void
  method show-enter-location is also<show_enter_location> {
    self.connect($!ps, 'show-enter-location');
  }

  # Is originally:
  # GtkPlacesSidebar, gchar, gchar, gpointer --> void
  method show-error-message is also<show_error_message> {
    self.connect-strstr($!ps, 'show-error-message');
  }

  # Is originally:
  # GtkPlacesSidebar, gpointer --> void
  method show-other-locations is also<show_other_locations> {
    self.connect($!ps, 'show-other-locations');
  }

  # Is originally:
  # GtkPlacesSidebar, GtkPlacesOpenFlags, gpointer --> void
  method show-other-locations-with-flags
    is also<show_other_locations_with_flags>
  {
    self.connect-uint($!ps, 'show-other-locations-with-flags');
  }

  # Is originally:
  # GtkPlacesSidebar, GtkPlacesOpenFlags, gpointer --> void
  method show-starred-location is also<show_starred_location> {
    self.connect-uint($!ps, 'show-starred-location');
  }

  # Is originally:
  # GtkPlacesSidebar, GMountOperation, gpointer --> void
  method unmount {
    self.connect-mount_op($!ps, 'unmount');
  }
  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  method local_only is rw is also<local-only> {
    Proxy.new(
      FETCH => sub ($) {
        so gtk_places_sidebar_get_local_only($!ps);
      },
      STORE => sub ($, Int() $local_only is copy) {
        my gboolean $lo = $local_only.so.Int;

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
      STORE => sub ($, GFile() $location is copy) {
        gtk_places_sidebar_set_location($!ps, $location)
      }
    );
  }

  method open_flags is rw is also<open-flags> {
    Proxy.new(
      FETCH => sub ($) {
        GtkPlacesOpenFlagsEnum( gtk_places_sidebar_get_open_flags($!ps) );
      },
      STORE => sub ($, Int() $flags is copy) {
        my uint32 $f = $flags;

        gtk_places_sidebar_set_open_flags($!ps, $f);
      }
    );
  }

  # method show_connect_to_server is rw is also<show-connect-to-server> {
  #   Proxy.new(
  #     FETCH => sub ($) {
  #       so gtk_places_sidebar_get_show_connect_to_server($!ps);
  #     },
  #     STORE => sub ($, Int() $show_connect_to_server is copy) {
  #       my gboolean $scs = $show_connect_to_server;
  #       gtk_places_sidebar_set_show_connect_to_server($!ps, $scs);
  #     }
  #   );
  # }

  method show_desktop is rw is also<show-desktop> {
    Proxy.new(
      FETCH => sub ($) {
        so gtk_places_sidebar_get_show_desktop($!ps);
      },
      STORE => sub ($, Int() $show_desktop is copy) {
        my gboolean $sd = $show_desktop.so.Int;

        gtk_places_sidebar_set_show_desktop($!ps, $sd);
      }
    );
  }

  method show_enterlocation is rw is also<show-enterlocation> {
    Proxy.new(
      FETCH => sub ($) {
        so gtk_places_sidebar_get_show_enter_location($!ps);
      },
      STORE => sub ($, Int() $show_enter_location is copy) {
        my gboolean $sel = $show_enter_location.so.Int;

        gtk_places_sidebar_set_show_enter_location($!ps, $sel);
      }
    );
  }

  method show_otherlocations is rw is also<show-otherlocations> {
    Proxy.new(
      FETCH => sub ($) {
        so gtk_places_sidebar_get_show_other_locations($!ps);
      },
      STORE => sub ($, Int() $show_other_locations is copy) {
        my gboolean $sol = $show_other_locations.so.Int;

        gtk_places_sidebar_set_show_other_locations($!ps, $sol);
      }
    );
  }

  method show_recent is rw is also<show-recent> {
    Proxy.new(
      FETCH => sub ($) {
        so gtk_places_sidebar_get_show_recent($!ps);
      },
      STORE => sub ($, Int() $show_recent is copy) {
        my gboolean $sr = $show_recent.so.Int;

        gtk_places_sidebar_set_show_recent($!ps, $sr);
      }
    );
  }

  method show_starredlocation is rw is also<show-starredlocation> {
    Proxy.new(
      FETCH => sub ($) {
        so gtk_places_sidebar_get_show_starred_location($!ps);
      },
      STORE => sub ($, Int() $show_starred_location is copy) {
        my gboolean $ssl = $show_starred_location.so.Int;

        gtk_places_sidebar_set_show_starred_location($!ps, $ssl);
      }
    );
  }

  method show_trash is rw is also<show-trash> {
    Proxy.new(
      FETCH => sub ($) {
        so gtk_places_sidebar_get_show_trash($!ps);
      },
      STORE => sub ($, Int() $show_trash is copy) {
        my gboolean $st = $show_trash.so.Int;

        gtk_places_sidebar_set_show_trash($!ps, $st);
      }
    );
  }
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  method add_shortcut (GFile() $location) is also<add-shortcut> {
    gtk_places_sidebar_add_shortcut($!ps, $location);
  }

  method get_nth_bookmark (Int() $n, :$raw = False) is also<get-nth-bookmark> {
    my $nn = $n;
    my $f = gtk_places_sidebar_get_nth_bookmark($!ps, $nn);

    $raw ??
      ( $f ?? $f !! GLib::Roles::GFile.new-file-obj($f) )
      !!
      Nil;
  }

  method get_type is also<get-type> {
    state ($n, $t);

    GTK::Widget.unstable_get_type( &gtk_places_sidebar_get_type, $n, $t );
  }

  method list_shortcuts (:$glist = False, :$raw = False)
    is also<list-shortcuts>
  {
    my $sl = gtk_places_sidebar_list_shortcuts($!ps);

    return Nil unless $sl;
    return $sl if     $glist;

    $sl = GLib::GList.new($sl) but GLib::Roles::ListData[GFile];

    $raw ??
      $sl.Array
      !!
      $sl.Array.map({ GIO::Roles::GFile.new-file-obj($_) });
  }

  method remove_shortcut (GFile() $location) is also<remove-shortcut> {
    gtk_places_sidebar_remove_shortcut($!ps, $location);
  }

  method set_drop_targets_visible (
    Int() $visible,
    GdkDragContext() $context = GdkDragContext
  )
    is also<set-drop-targets-visible>
  {
    my gboolean $v = $visible.so.Int;

    gtk_places_sidebar_set_drop_targets_visible($!ps, $v, $context);
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
