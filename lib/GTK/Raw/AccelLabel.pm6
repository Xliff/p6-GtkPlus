use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::Types;

unit package GTK::Raw::AccelLabel;

sub gtk_accel_label_get_accel (
  GtkAccelLabel $accel_label,
  guint $accelerator_key,
  uint32 $accelerator_mods is rw
)
  is native($LIBGTK)
  is export
  { * }

sub gtk_accel_label_get_accel_width (GtkAccelLabel $accel_label)
  returns guint
  is native($LIBGTK)
  is export
  { * }

sub gtk_accel_label_get_type ()
  returns GType
  is native($LIBGTK)
  is export
  { * }

sub gtk_accel_label_new (gchar $string)
  returns GtkWidget
  is native($LIBGTK)
  is export
  { * }

sub gtk_accel_label_refetch (GtkAccelLabel $accel_label)
  returns uint32
  is native($LIBGTK)
  is export
  { * }

sub gtk_accel_label_set_accel (
  GtkAccelLabel $accel_label,
  guint $accelerator_key,
  uint32 $accelerator_mods      # GdkModifierType $accelerator_mods
)
  is native($LIBGTK)
  is export
  { * }

sub gtk_accel_label_set_accel_closure (
  GtkAccelLabel $accel_label,
  GClosure $accel_closure
)
  is native($LIBGTK)
  is export
  { * }

sub gtk_accel_label_get_accel_widget (GtkAccelLabel $accel_label)
  returns GtkWidget
  is native($LIBGTK)
  is export
  { * }

sub gtk_accel_label_set_accel_widget (
  GtkAccelLabel $accel_label,
  GtkWidget $accel_widget
)
  is native($LIBGTK)
  is export
  { * }