use v6.c;

use NativeCall;

use Pango::Raw::Types;

use GLib::Raw::Definitions;
use GLib::Raw::Structs;
use GDK::Raw::Definitions;
use GDK::Raw::Structs;
use GTK::Raw::Definitions:ver<3.0.1146>;
use GTK::Raw::Structs:ver<3.0.1146>;

unit package GTK::Raw::Main:ver<3.0.1146>;

sub gtk_get_binary_age ()
  returns guint
  is native(gtk)
  is export
{ * }

sub gtk_get_current_event ()
  returns GdkEvent
  is native(gtk)
  is export
{ * }

sub gtk_get_current_event_device ()
  returns GdkDevice
  is native(gtk)
  is export
{ * }

sub gtk_get_current_event_state (
  guint $state # GdkModifierType $state
)
  returns uint32
  is native(gtk)
  is export
{ * }

sub gtk_get_current_event_time ()
  returns guint32
  is native(gtk)
  is export
{ * }

sub gtk_get_default_language ()
  returns PangoLanguage
  is native(gtk)
  is export
{ * }

sub gtk_get_event_widget (GdkEvent $event)
  returns GtkWidget
  is native(gtk)
  is export
{ * }

sub gtk_check_version (
  guint $required_major,
  guint $required_minor,
  guint $required_micro
)
  returns Str
  is native(gtk)
  is export
{ * }

sub gtk_device_grab_add (
  GtkWidget $widget,
  GdkDevice $device,
  gboolean $block_others
)
  is native(gtk)
  is export
{ * }

sub gtk_device_grab_remove (GtkWidget $widget, GdkDevice $device)
  is native(gtk)
  is export
{ * }

sub gtk_disable_setlocale ()
  is native(gtk)
  is export
{ * }

sub gtk_events_pending ()
  returns uint32
  is native(gtk)
  is export
{ * }

sub gtk_false ()
  returns uint32
  is native(gtk)
  is export
{ * }

sub gtk_grab_add (GtkWidget $widget)
  is native(gtk)
  is export
{ * }

sub gtk_grab_get_current ()
  returns GtkWidget
  is native(gtk)
  is export
{ * }

sub gtk_grab_remove (GtkWidget $widget)
  is native(gtk)
  is export
{ * }

sub gtk_init (gint $argc, CArray[Str] $argv)
  is native(gtk)
  is export
{ * }

sub gtk_init_abi_check (
  gint $argc,
  Str $argv,
  gint $num_checks,
  size_t $sizeof_GtkWindow,
  size_t $sizeof_GtkBox
)
  is native(gtk)
  is export
{ * }

sub gtk_init_check (gint $argc, Str $argv)
  returns uint32
  is native(gtk)
  is export
{ * }

sub gtk_init_check_abi_check (
  gint $argc,
  Str $argv,
  gint $num_checks,
  size_t $sizeof_GtkWindow,
  size_t $sizeof_GtkBox
)
  returns uint32
  is native(gtk)
  is export
{ * }

sub gtk_init_with_args (
  gint $argc,
  Str $argv,
  Str $parameter_string,
  GOptionEntry $entries,
  Str $translation_domain,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(gtk)
  is export
{ * }

sub gtk_key_snooper_install (
  &snooper (GtkWidget, GdkEventKey, Pointer --> gint),
  gpointer $func_data
)
  returns guint
  is native(gtk)
  is export
{ * }

sub gtk_key_snooper_remove (guint $snooper_handler_id)
  is native(gtk)
  is export
{ * }

sub gtk_main ()
  is native(gtk)
  is export
{ * }

sub gtk_main_do_event (GdkEvent $event)
  is native(gtk)
  is export
{ * }

sub gtk_main_iteration ()
  returns uint32
  is native(gtk)
  is export
{ * }

sub gtk_main_iteration_do (gboolean $blocking)
  returns uint32
  is native(gtk)
  is export
{ * }

sub gtk_main_level ()
  returns guint
  is native(gtk)
  is export
{ * }

sub gtk_main_quit ()
  is native(gtk)
  is export
{ * }

sub gtk_parse_args (gint $argc, CArray[Str] $argv)
  returns uint32
  is native(gtk)
  is export
{ * }

sub gtk_propagate_event (GtkWidget $widget, GdkEvent $event)
  is native(gtk)
  is export
{ * }

sub gtk_true ()
  returns uint32
  is native(gtk)
  is export
{ * }

sub gtk_get_interface_age ()
  returns guint
  is native(gtk)
  is export
{ * }

sub gtk_get_locale_direction ()
  returns uint32 # GtkTextDirection
  is native(gtk)
  is export
{ * }

sub gtk_get_major_version ()
  returns guint
  is native(gtk)
  is export
{ * }

sub gtk_get_micro_version ()
  returns guint
  is native(gtk)
  is export
{ * }

sub gtk_get_minor_version ()
  returns guint
  is native(gtk)
  is export
{ * }

sub gtk_get_option_group (gboolean $open_default_display)
  returns GOptionGroup
  is native(gtk)
  is export
{ * }
