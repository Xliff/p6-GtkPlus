use v6.c;

use Method::Also;

use GTK::Raw::WindowGroup;
use GTK::Raw::Types;

use GLib::GList;
use GLib::Roles::ListData;
use GTK::Widget;

use GLib::Roles::Object;

class GTK::WindowGroup {
  also does GLib::Roles::Object;

  has GtkWindowGroup $!wg is implementor;

  submethod BUILD(:$group) {
    self!setObject($group);
  }

  submethod DESTROY {
    self.downref;
  }

  method GTK::Raw::Definitions::GtkWindowGroup
    is also<
      WindowGroup
      GtkWindowGroup
    >
  { $!wg }

  multi method new (GtkWindowGroup $group, :$ref = True) {
    return Nil unless $group;

    my $o = self.bless(:$group);
    $o.ref if $ref;
    $o;
  }
  multi method new {
    my $group = gtk_window_group_new();

    $group ?? self.bless(:$group) !! Nil;
  }

  # ↓↓↓↓ SIGNALS ↓↓↓↓
  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ PROPERTIES ↓↓↓↓
  # ↑↑↑↑ PROPERTIES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  method add_window (GtkWindow() $window) is also<add-window> {
    gtk_window_group_add_window($!wg, $window);
  }

  method get_current_device_grab (
    GdkDevice() $device,
    :$raw = False,
    :$widget = False
  )
    is also<get-current-device-grab>
  {
    my $w = gtk_window_group_get_current_device_grab($!wg, $device);

    ReturnWidget($w, $raw, $widget);
  }

  method get_current_grab (:$raw = False, :$widget = False)
    is also<get-current-grab>
  {
    my $w = gtk_window_group_get_current_grab($!wg);

    ReturnWidget($w, $raw, $widget);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gtk_window_group_get_type, $n, $t );
  }

  method list_windows (:$glist = False, :$raw = False) is also<list-windows> {
    my $wl = gtk_window_group_list_windows($!wg);

    return Nil unless $wl;
    return $wl if $glist;

    $wl = GLib::GList.new($wl) but GLib::Roles::ListData[GtkWindow];
    $raw ?? $wl.Array !! $wl.Array.map({ ::('GTK::Window').new($_) });
  }

  method remove_window (GtkWindow() $window) is also<remove-window> {
    gtk_window_group_remove_window($!wg, $window);
  }

  # ↑↑↑↑ METHODS ↑↑↑↑

}
