use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::Types;

unit package GTK::Raw::Expander;

sub gtk_expander_get_type ()
  returns GType
  is native(gtk)
  is export
  { * }

sub gtk_expander_new (gchar $label)
  returns GtkWidget
  is native(gtk)
  is export
  { * }

sub gtk_expander_new_with_mnemonic (gchar $label)
  returns GtkWidget
  is native(gtk)
  is export
  { * }

sub gtk_expander_get_label_widget (GtkExpander $expander)
  returns GtkWidget
  is native(gtk)
  is export
  { * }

sub gtk_expander_get_use_underline (GtkExpander $expander)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_expander_get_label (GtkExpander $expander)
  returns Str
  is native(gtk)
  is export
  { * }

sub gtk_expander_get_expanded (GtkExpander $expander)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_expander_get_use_markup (GtkExpander $expander)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_expander_get_spacing (GtkExpander $expander)
  returns gint
  is native(gtk)
  is export
  { * }

sub gtk_expander_get_resize_toplevel (GtkExpander $expander)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_expander_get_label_fill (GtkExpander $expander)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_expander_set_label_widget (
  GtkExpander $expander,
  GtkWidget $label_widget
)
  is native(gtk)
  is export
  { * }

sub gtk_expander_set_use_underline (
  GtkExpander $expander,
  gboolean $use_underline
)
  is native(gtk)
  is export
  { * }

sub gtk_expander_set_label (GtkExpander $expander, gchar $label)
  is native(gtk)
  is export
  { * }

sub gtk_expander_set_expanded (GtkExpander $expander, gboolean $expanded)
  is native(gtk)
  is export
  { * }

sub gtk_expander_set_use_markup (GtkExpander $expander, gboolean $use_markup)
  is native(gtk)
  is export
  { * }

sub gtk_expander_set_spacing (GtkExpander $expander, gint $spacing)
  is native(gtk)
  is export
  { * }

sub gtk_expander_set_resize_toplevel (GtkExpander $expander, gboolean $resize_toplevel)
  is native(gtk)
  is export
  { * }

sub gtk_expander_set_label_fill (GtkExpander $expander, gboolean $label_fill)
  is native(gtk)
  is export
  { * }