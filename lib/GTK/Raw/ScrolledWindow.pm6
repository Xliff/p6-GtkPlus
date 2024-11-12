use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Structs;
use GTK::Raw::Definitions:ver<3.0.1146>;
use GTK::Raw::Structs:ver<3.0.1146>;

unit package GTK::Raw::ScrolledWindow:ver<3.0.1146>;

sub gtk_scrolled_window_add_with_viewport (
  GtkScrolledWindow $scrolled_window,
  GtkWidget $child
)
  is native(gtk)
  is export
  { * }

sub gtk_scrolled_window_get_hscrollbar (GtkScrolledWindow $scrolled_window)
  returns GtkWidget
  is native(gtk)
  is export
  { * }

sub gtk_scrolled_window_get_placement (GtkScrolledWindow $scrolled_window)
  returns uint32 # GtkCornerType
  is native(gtk)
  is export
  { * }

sub gtk_scrolled_window_get_policy (
  GtkScrolledWindow $scrolled_window,
  uint32 $hpolicy is rw,                     # GtkPolicyType $hscrollbar_policy,
  uint32 $vpolicy is rw                      # GtkPolicyType $vscrollbar_policy
)
  is native(gtk)
  is export
  { * }

sub gtk_scrolled_window_get_type ()
  returns GType
  is native(gtk)
  is export
  { * }

sub gtk_scrolled_window_get_vscrollbar (GtkScrolledWindow $scrolled_window)
  returns GtkWidget
  is native(gtk)
  is export
  { * }

sub gtk_scrolled_window_new (
  GtkAdjustment $hadjustment,
  GtkAdjustment $vadjustment
)
  returns GtkWidget
  is native(gtk)
  is export
  { * }

sub gtk_scrolled_window_set_policy (
  GtkScrolledWindow $scrolled_window,
  uint32 $hp,                             # GtkPolicyType $hscrollbar_policy,
  uint32 $vp                              # GtkPolicyType $vscrollbar_policy
)
  is native(gtk)
  is export
  { * }

sub gtk_scrolled_window_unset_placement (GtkScrolledWindow $scrolled_window)
  is native(gtk)
  is export
  { * }

sub gtk_scrolled_window_get_hadjustment (GtkScrolledWindow $scrolled_window)
  returns GtkAdjustment
  is native(gtk)
  is export
  { * }

sub gtk_scrolled_window_get_capture_button_press (
  GtkScrolledWindow $scrolled_window
)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_scrolled_window_get_min_content_width (
  GtkScrolledWindow $scrolled_window
)
  returns gint
  is native(gtk)
  is export
  { * }

sub gtk_scrolled_window_get_propagate_natural_width (
  GtkScrolledWindow $scrolled_window
)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_scrolled_window_get_max_content_height (
  GtkScrolledWindow $scrolled_window
)
  returns gint
  is native(gtk)
  is export
  { * }

sub gtk_scrolled_window_get_overlay_scrolling (
  GtkScrolledWindow $scrolled_window
)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_scrolled_window_get_shadow_type (GtkScrolledWindow $scrolled_window)
  returns uint32 # GtkShadowType
  is native(gtk)
  is export
  { * }

sub gtk_scrolled_window_get_max_content_width (
  GtkScrolledWindow $scrolled_window
)
  returns gint
  is native(gtk)
  is export
  { * }

sub gtk_scrolled_window_get_min_content_height (
  GtkScrolledWindow $scrolled_window
)
  returns gint
  is native(gtk)
  is export
  { * }

sub gtk_scrolled_window_get_propagate_natural_height (
  GtkScrolledWindow $scrolled_window
)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_scrolled_window_get_kinetic_scrolling (
  GtkScrolledWindow $scrolled_window
)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_scrolled_window_get_vadjustment (GtkScrolledWindow $scrolled_window)
  returns GtkAdjustment
  is native(gtk)
  is export
  { * }

sub gtk_scrolled_window_set_hadjustment (
  GtkScrolledWindow $scrolled_window,
  GtkAdjustment $hadjustment
)
  is native(gtk)
  is export
  { * }

sub gtk_scrolled_window_set_capture_button_press (
  GtkScrolledWindow $scrolled_window,
  gboolean $capture_button_press
)
  is native(gtk)
  is export
  { * }

sub gtk_scrolled_window_set_min_content_width (
  GtkScrolledWindow $scrolled_window,
  gint $width
)
  is native(gtk)
  is export
  { * }

sub gtk_scrolled_window_set_propagate_natural_width (
  GtkScrolledWindow $scrolled_window,
  gboolean $propagate
)
  is native(gtk)
  is export
  { * }

sub gtk_scrolled_window_set_max_content_height (
  GtkScrolledWindow $scrolled_window,
  gint $height
)
  is native(gtk)
  is export
  { * }

sub gtk_scrolled_window_set_overlay_scrolling (
  GtkScrolledWindow $scrolled_window,
  gboolean $overlay_scrolling
)
  is native(gtk)
  is export
  { * }

sub gtk_scrolled_window_set_shadow_type (
  GtkScrolledWindow $scrolled_window,
  uint32 $st                              # GtkShadowType $type
)
  is native(gtk)
  is export
  { * }

sub gtk_scrolled_window_set_max_content_width (
  GtkScrolledWindow $scrolled_window,
  gint $width
)
  is native(gtk)
  is export
  { * }

sub gtk_scrolled_window_set_min_content_height (
  GtkScrolledWindow $scrolled_window,
  gint $height
)
  is native(gtk)
  is export
  { * }

sub gtk_scrolled_window_set_propagate_natural_height (
  GtkScrolledWindow $scrolled_window,
  gboolean $propagate
)
  is native(gtk)
  is export
  { * }

sub gtk_scrolled_window_set_kinetic_scrolling (
  GtkScrolledWindow $scrolled_window,
  gboolean $kinetic_scrolling
)
  is native(gtk)
  is export
  { * }

sub gtk_scrolled_window_set_vadjustment (
  GtkScrolledWindow $scrolled_window,
  GtkAdjustment $vadjustment
)
  is native(gtk)
  is export
  { * }