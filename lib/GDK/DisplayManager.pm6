use v6.c;

use Method::Also;
use NativeCall;

use GDK::Raw::Types;
use GDK::Raw::DisplayManager;

use GLib::GList;
use GDK::Display;

use GTK::Roles::Signals::Generic;

class GDK::DisplayManager {
  also does GTK::Roles::Signals::Generic;

  has GdkDisplayManager $!dm is implementor;

  submethod BUILD(:$manager) {
    $!dm = $manager;
  }

  method GDK::Raw::Definitions::GdkDisplayManager
    is also<GdkDisplayManager>
  { $!dm }

  multi method new (GdkDisplayManager $manager) {
    $manager ?? self.bless(:$manager) !! Nil;
  }
  multi method new {
    GDK::DisplayManager.get;
  }
  method get {
    my $manager = gdk_display_manager_get();

    $manager ?? self.bless(:$manager) !! Nil;
  }

  # ↓↓↓↓ SIGNALS ↓↓↓↓
  # Is originally:
  # GdkDisplayManager, GdkDisplay, gpointer --> void
  method display-opened is also<display_opened> {
    self.connect($!dm, 'display-opened');
  }
  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  method default_display is rw is also<default-display> {
    Proxy.new(
      FETCH => sub ($) {
        GTK::Display.new(
          gdk_display_manager_get_default_display($!dm);
        );
      },
      STORE => sub ($, GdkDisplay() $display is copy) {
        gdk_display_manager_set_default_display($!dm, $display)
      }
    );
  }
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ PROPERTIES ↓↓↓↓
  # ↑↑↑↑ PROPERTIES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  method get_type is also<get-type> {
    state ($n, $t);
    unstable_get_type( self.^name, &gdk_display_manager_get_type, $n, $t );
  }

  method list_displays (:$glist = False, :$raw = False)
    is also<list-displays>
  {
    my $dl = gdk_display_manager_list_displays;

    return Nil unless $dl;
    return $dl if $glist;

    # Should be GSList, but GList is compatible.
    $dl = GLib::GList.new($dl) but GLib::Roles::ListData[GdkDisplay];

    $raw ?? $dl.Array !! $dl.Array.map({ GDK::Display.new($_) });
  }

  method open_display (Str() $name) is also<open-display> {
    my $display = gdk_display_manager_open_display($!dm, $name);

    $display ??
      ( $raw ?? $display ?? GDK::Display.new($display) )
      !!
      Nil;
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
