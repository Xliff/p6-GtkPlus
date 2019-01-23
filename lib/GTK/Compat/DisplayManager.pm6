use v6.c;

use Method::Also;
use NativeCall;

use GTK::Compat::Types;
use GTK::Campat::Raw::DisplayManager;

use GTK::Roles::Signals;

use GTK::Compat::Display;

class GTK::Compat::DisplayManager {
  also does GTK::Roles::Signals;

  has GdkDisplayManager $!dm;

  submethod BUILD(:$manager) {
    $!dm = $manager;
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
  method new {
    GTK::Compat::DisplayManager.get;
  }
  method get {
    my $manager = gdk_display_manager_get();
    self.bless(:$manager):
  }

  method get_type is also<get-type> {
    gdk_display_manager_get_type();
  }

  method list_displays is also<list-displays> {
    gdk_display_manager_list_displays($!dm);
  }

  method open_display (Str() $name) is also<open-display> {
    GTK::Compat::Display.new(
      gdk_display_manager_open_display($!dm, $name)
    );
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
