use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::Types;

unit package GTK::Raw::ProgressBar;

sub gtk_progress_bar_get_type ()
  returns GType
  is native(gtk)
  is export
  { * }

sub gtk_progress_bar_new ()
  returns GtkWidget
  is native(gtk)
  is export
  { * }

sub gtk_progress_bar_pulse (GtkProgressBar $pbar)
  is native(gtk)
  is export
  { * }

sub gtk_progress_bar_get_pulse_step (GtkProgressBar $pbar)
  returns gdouble
  is native(gtk)
  is export
  { * }

sub gtk_progress_bar_get_show_text (GtkProgressBar $pbar)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_progress_bar_get_ellipsize (GtkProgressBar $pbar)
  returns uint32 # PangoEllipsizeMode
  is native(gtk)
  is export
  { * }

sub gtk_progress_bar_get_inverted (GtkProgressBar $pbar)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_progress_bar_get_fraction (GtkProgressBar $pbar)
  returns gdouble
  is native(gtk)
  is export
  { * }

sub gtk_progress_bar_get_text (GtkProgressBar $pbar)
  returns Str
  is native(gtk)
  is export
  { * }

sub gtk_progress_bar_set_pulse_step (GtkProgressBar $pbar, gdouble $fraction)
  is native(gtk)
  is export
  { * }

sub gtk_progress_bar_set_show_text (GtkProgressBar $pbar, gboolean $show_text)
  is native(gtk)
  is export
  { * }

# (GtkProgressBar $pbar, PangoEllipsizeMode $mode)
sub gtk_progress_bar_set_ellipsize (GtkProgressBar $pbar, uint32 $mode)
  is native(gtk)
  is export
  { * }

sub gtk_progress_bar_set_inverted (GtkProgressBar $pbar, gboolean $inverted)
  is native(gtk)
  is export
  { * }

sub gtk_progress_bar_set_fraction (GtkProgressBar $pbar, gdouble $fraction)
  is native(gtk)
  is export
  { * }

sub gtk_progress_bar_set_text (GtkProgressBar $pbar, gchar $text)
  is native(gtk)
  is export
  { * }