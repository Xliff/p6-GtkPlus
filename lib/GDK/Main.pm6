use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GDK::Raw::Main;

class GDK::Main {

  method new {
    warn 'GDK::Main is a static class and does not need instantiation.'
      if $DEBUG;

    GDK::Main;
  }

  method add_option_entries_libgtk_only (GOptionGroup() $group) {
    gdk_add_option_entries_libgtk_only($group);
  }

  method disable_multidevice {
    gdk_disable_multidevice();
  }

  method get_display_arg_name {
    gdk_get_display_arg_name();
  }

  method get_program_class {
    gdk_get_program_class();
  }

  multi method init {
    my $v = CArray[Str].new;

    samewith(0, $v);
  }
  multi method init (Int() $argc, CArray[Str] $argv) {
    gdk_init($argc, $argv);
  }

  method init_check (Int() $argc, CArray[Str] $argv) {
    gdk_init_check($argc, $argv);
  }

  method notify_startup_complete {
    gdk_notify_startup_complete();
  }

  method notify_startup_complete_with_id (Str $startup_id) {
    gdk_notify_startup_complete_with_id($startup_id);
  }

  method parse_args (Int() $argc, CArray[Str] $argv) {
    gdk_parse_args($argc, $argv);
  }

  method pre_parse_libgtk_only {
    gdk_pre_parse_libgtk_only();
  }

  method screen_height {
    gdk_screen_height();
  }

  method screen_height_mm {
    gdk_screen_height_mm();
  }

  method screen_width {
    gdk_screen_width();
  }

  method screen_width_mm {
    gdk_screen_width_mm();
  }

  method set_allowed_backends (Str() $backends) {
    gdk_set_allowed_backends($backends);
  }

  method set_program_class (Str() $program_class) {
    gdk_set_program_class($program_class);
  }

}
