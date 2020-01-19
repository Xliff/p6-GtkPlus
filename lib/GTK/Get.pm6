use v6.c;

use Method::Also;

use GTK::Raw::Types;
use GTK::Raw::Main;

use GDK::Event;

use GLib::Roles::StaticClass;

class GTK::Get {
  also does GLib::Roles::StaticClass;

  method binary_age is also<binary-age> {
    gtk_get_binary_age();
  }

  method check_version (
    Int() $major,
    Int() $minor,
    Int() $micro
  )
    is also<check-version>
  {
    my guint ($mj, $mn ,$mc) = ($major, $minor, $micro);

    gtk_check_version($mj, $mn, $mc);
  }

  method current_event (:$raw = False) is also<current-event> {
    my $e = gtk_get_current_event();

    $e ??
      ( $raw ?? $e !! GDK::Event.new($e) )
      !!
      Nil;
  }

  method current_event_device is also<current-event-device> {
    gtk_get_current_event_device();
  }

  method current_event_state (Int() $state) is also<current-event-state> {
    my guint $s = $state;

    gtk_get_current_event_state($s);
  }

  method current_event_time is also<current-event-time> {
    gtk_get_current_event_time();
  }

  method default_language (:$raw = False) is also<default-language> {
    my $l = gtk_get_default_language();

    $l ??
      ( $raw ?? $l !! Pango::Language.new($l) )
      !!
      Nil;
  }

  method event_widget (GdkEvent() $e, :$raw = False, :$widget = False)
    is also<event-widget>
  {
    my $w = gtk_get_event_widget($e);

    self.ReturnWidget($w, $raw, $widget);
  }

  method interface_age is also<interface-age> {
    gtk_get_interface_age();
  }

  method locale_direction is also<locale-direction> {
    gtk_get_locale_direction();
  }

  method major_version is also<major-version> {
    gtk_get_major_version();
  }

  method micro_version is also<micro-version> {
    gtk_get_micro_version();
  }

  method minor_version is also<minor-version> {
    gtk_get_minor_version();
  }

  method option_group (Int() $open_default_display) is also<option-group> {
    my gboolean $odd = $open_default_display.so.Int;

    gtk_get_option_group($odd);
  }

}
