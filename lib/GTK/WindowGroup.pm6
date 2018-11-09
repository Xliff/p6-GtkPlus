use v6.c;

use NativeCall;

use GTK::Compat::GList;
use GTK::Compat::Types;
use GTK::Raw::WindowGroup;
use GTK::Raw::Types;

class GTK::WindowGroup {
  has GtkWindowGroup $!wg;

  submethod BUILD(:$group) {
    $!wg = $group;
  }

  multi method new (GtkWindowGroup $group) {
    self.bless(:$group);
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
  method add_window (GtkWindow() $window) {
    gtk_window_group_add_window($!wg, $window);
  }

  method get_current_device_grab (GdkDevice $device) {
    gtk_window_group_get_current_device_grab($!wg, $device);
  }

  method get_current_grab {
    gtk_window_group_get_current_grab($!wg);
  }

  method get_type {
    gtk_window_group_get_type();
  }

  method list_windows {
    GTK::Compat::GList.new( gtk_window_group_list_windows($!wg) );
  }

  method remove_window (GtkWindow() $window) {
    gtk_window_group_remove_window($!wg, $window);
  }

  # ↑↑↑↑ METHODS ↑↑↑↑

}
