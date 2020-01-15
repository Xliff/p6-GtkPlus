use v6.c;

use Method::Also;
use NativeCall;

use GLib::GList;

use GTK::Raw::WindowGroup;
use GTK::Raw::Types;

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
    is also<WindowGroup>
    { $!wg }

  multi method new (GtkWindowGroup $group) {
    my $o = self.bless(:$group);
    $o.upref;
    $o;
  }
  multi method new {
    my $group = gtk_window_group_new();
    self.bless(:$group);
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

  method get_current_device_grab (GdkDevice() $device)
    is also<get-current-device-grab>
  {
    gtk_window_group_get_current_device_grab($!wg, $device);
  }

  method get_current_grab is also<get-current-grab> {
    gtk_window_group_get_current_grab($!wg);
  }

  method get_type is also<get-type> {
    gtk_window_group_get_type();
  }

  method list_windows is also<list-windows> {
    GLib::GList.new(
      GtkWindow, gtk_window_group_list_windows($!wg)
    );
  }

  method remove_window (GtkWindow() $window) is also<remove-window> {
    gtk_window_group_remove_window($!wg, $window);
  }

  # ↑↑↑↑ METHODS ↑↑↑↑

}
