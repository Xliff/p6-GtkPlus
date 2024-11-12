use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Structs;
use GLib::Raw::Object;
use GDK::Raw::Definitions;
use GTK::Raw::Definitions:ver<3.0.1146>;
use GTK::Raw::Structs:ver<3.0.1146>;

unit package GTK::Raw::AccelGroup:ver<3.0.1146>;

sub gtk_accel_group_activate (
  GtkAccelGroup $accel_group,
  GQuark $accel_quark,
  GObject $acceleratable,
  guint $accel_key,
  uint32 $accel_mods            # GdkModifierType $accel_mods
)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_accel_group_connect (
  GtkAccelGroup $accel_group,
  guint $accel_key,
  uint32 $accel_mods,           # GdkModifierType $accel_mods,
  uint32 $accel_flags,          # GtkAccelFlags $accel_flags,
  GClosure $closure
)
  is native(gtk)
  is export
  { * }

sub gtk_accel_group_connect_by_path (
  GtkAccelGroup $accel_group,
  Str $accel_path,
  GClosure $closure
)
  is native(gtk)
  is export
  { * }

sub gtk_accel_group_disconnect (
  GtkAccelGroup $accel_group,
  GClosure $closure
)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_accel_group_disconnect_key (
  GtkAccelGroup $accel_group,
  guint $accel_key,
  uint32 $accel_mods            # GdkModifierType $accel_mods
)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_accel_group_find (
  GtkAccelGroup $accel_group,
  GtkAccelGroupFindFunc $find_func,
  gpointer $data
)
  returns GtkAccelKey
  is native(gtk)
  is export
  { * }

sub gtk_accel_group_from_accel_closure (GClosure $closure)
  returns GtkAccelGroup
  is native(gtk)
  is export
  { * }

sub gtk_accel_group_get_is_locked (GtkAccelGroup $accel_group)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_accel_group_get_modifier_mask (GtkAccelGroup $accel_group)
  returns uint32 # GdkModifierType
  is native(gtk)
  is export
  { * }

sub gtk_accel_group_get_type ()
  returns GType
  is native(gtk)
  is export
  { * }

sub gtk_accel_groups_activate (
  GObject $object,
  guint $accel_key,
  uint32 $accel_mods            # GdkModifierType $accel_mods
)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_accel_groups_from_object (GObject $object)
  returns GSList
  is native(gtk)
  is export
  { * }

sub gtk_accelerator_get_default_mod_mask ()
  returns uint32 # GdkModifierType
  is native(gtk)
  is export
  { * }

sub gtk_accelerator_get_label (
  guint $accelerator_key,
  uint32 $accel_mods            # GdkModifierType $accelerator_mods
)
  returns Str
  is native(gtk)
  is export
  { * }

sub gtk_accelerator_get_label_with_keycode (
  GdkDisplay $display,
  guint $accelerator_key,
  guint $keycode,
  uint32 $accel_mods            # GdkModifierType $accel_mods
)
  returns Str
  is native(gtk)
  is export
  { * }

sub gtk_accelerator_name (
  guint $accelerator_key,
  uint32 $accel_mods            # GdkModifierType $accel_mods
)
  returns Str
  is native(gtk)
  is export
  { * }

sub gtk_accelerator_name_with_keycode (
  GdkDisplay $display,
  guint $accelerator_key,
  guint $keycode,
  uint32 $accel_mods            # GdkModifierType $accel_mods
)
  returns Str
  is native(gtk)
  is export
  { * }

sub gtk_accelerator_parse (
  Str $accelerator,
  guint $accelerator_key is rw,
  uint32 $accel_mods     is rw        # GdkModifierType $accel_mods
)
  is native(gtk)
  is export
  { * }

sub gtk_accelerator_parse_with_keycode (
  Str $accelerator,
  guint $accelerator_key   is rw,
  guint $accelerator_codes is rw,
  uint32 $accel_mods       is rw      # GdkModifierType $accel_mods
)
  is native(gtk)
  is export
  { * }

sub gtk_accelerator_set_default_mod_mask (
  uint32 $accel_mods            # GdkModifierType $accel_mods
)
  is native(gtk)
  is export
  { * }

sub gtk_accelerator_valid (
  guint $keyval,
  uint32 $accel_mods            # GdkModifierType $accel_mods
)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_accel_group_lock (GtkAccelGroup $accel_group)
  is native(gtk)
  is export
  { * }

sub gtk_accel_group_new ()
  returns GtkAccelGroup
  is native(gtk)
  is export
  { * }

sub gtk_accel_group_query (
  GtkAccelGroup $accel_group,
  guint $accel_key,
  uint32 $accel_mods,           # GdkModifierType $accel_mods
  guint $n_entries
)
  returns GtkAccelGroupEntry
  is native(gtk)
  is export
  { * }

sub gtk_accel_group_unlock (GtkAccelGroup $accel_group)
  is native(gtk)
  is export
  { * }
