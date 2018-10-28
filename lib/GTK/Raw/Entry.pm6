use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::Types;

unit package GTK::Raw::GtkEntry;

sub gtk_entry_get_current_icon_drag_source (GtkEntry $entry)
  returns gint
  is native($LIBGTK)
  is export
  { * }

# (GtkEntry $entry, GtkEntryIconPosition $icon_pos)
sub gtk_entry_get_icon_activatable (GtkEntry $entry, uint32 $icon_pos)
  returns uint32
  is native($LIBGTK)
  is export
  { * }

# (GtkEntry $entry, GtkEntryIconPosition $icon_pos, GdkRectangle $icon_area)
sub gtk_entry_get_icon_area (GtkEntry $entry, uint32 $icon_pos, GdkRectangle $icon_area)
  is native($LIBGTK)
  is export
  { * }

sub gtk_entry_get_icon_at_pos (GtkEntry $entry, gint $x, gint $y)
  returns gint
  is native($LIBGTK)
  is export
  { * }

# (GtkEntry $entry, GtkEntryIconPosition $icon_pos)
sub gtk_entry_get_icon_gicon (GtkEntry $entry, uint32 $icon_pos)
  returns GIcon
  is native($LIBGTK)
  is export
  { * }

# (GtkEntry $entry, GtkEntryIconPosition $icon_pos)
sub gtk_entry_get_icon_name (GtkEntry $entry, uint32 $icon_pos)
  returns Str
  is native($LIBGTK)
  is export
  { * }

# (GtkEntry $entry, GtkEntryIconPosition $icon_pos)
sub gtk_entry_get_icon_pixbuf (GtkEntry $entry, uint32 $icon_pos)
  returns GdkPixbuf
  is native($LIBGTK)
  is export
  { * }

# (GtkEntry $entry, GtkEntryIconPosition $icon_pos)
sub gtk_entry_get_icon_sensitive (GtkEntry $entry, uint32 $icon_pos)
  returns uint32
  is native($LIBGTK)
  is export
  { * }

# (GtkEntry $entry, GtkEntryIconPosition $icon_pos)
sub gtk_entry_get_icon_stock (GtkEntry $entry, uint32 $icon_pos)
  returns Str
  is native($LIBGTK)
  is export
  { * }

# (GtkEntry $entry, GtkEntryIconPosition $icon_pos)
sub gtk_entry_get_icon_storage_type (GtkEntry $entry, uint32 $icon_pos)
  returns uint32 # GtkImageType
  is native($LIBGTK)
  is export
  { * }

# (GtkEntry $entry, GtkEntryIconPosition $icon_pos)
sub gtk_entry_get_icon_tooltip_markup (GtkEntry $entry, uint32 $icon_pos)
  returns Str
  is native($LIBGTK)
  is export
  { * }

# (GtkEntry $entry, GtkEntryIconPosition $icon_pos)
sub gtk_entry_get_icon_tooltip_text (GtkEntry $entry, uint32 $icon_pos)
  returns Str
  is native($LIBGTK)
  is export
  { * }

sub gtk_entry_get_invisible_char (GtkEntry $entry)
  returns gunichar
  is native($LIBGTK)
  is export
  { * }

sub gtk_entry_get_layout (GtkEntry $entry)
  returns PangoLayout
  is native($LIBGTK)
  is export
  { * }

sub gtk_entry_get_layout_offsets (GtkEntry $entry, gint $x, gint $y)
  is native($LIBGTK)
  is export
  { * }

sub gtk_entry_get_text_area (GtkEntry $entry, GdkRectangle $text_area)
  is native($LIBGTK)
  is export
  { * }

sub gtk_entry_get_text_length (GtkEntry $entry)
  returns guint16
  is native($LIBGTK)
  is export
  { * }

sub gtk_entry_get_type ()
  returns GType
  is native($LIBGTK)
  is export
  { * }

sub gtk_entry_grab_focus_without_selecting (GtkEntry $entry)
  is native($LIBGTK)
  is export
  { * }

sub gtk_entry_im_context_filter_keypress (GtkEntry $entry, GdkEventKey $event)
  returns uint32
  is native($LIBGTK)
  is export
  { * }

sub gtk_entry_layout_index_to_text_index (GtkEntry $entry, gint $layout_index)
  returns gint
  is native($LIBGTK)
  is export
  { * }

sub gtk_entry_new ()
  returns GtkWidget
  is native($LIBGTK)
  is export
  { * }

sub gtk_entry_new_with_buffer (GtkEntryBuffer $buffer)
  returns GtkWidget
  is native($LIBGTK)
  is export
  { * }

sub gtk_entry_progress_pulse (GtkEntry $entry)
  is native($LIBGTK)
  is export
  { * }

sub gtk_entry_reset_im_context (GtkEntry $entry)
  is native($LIBGTK)
  is export
  { * }

# (GtkEntry $entry, GtkEntryIconPosition $icon_pos, gboolean $activatable)
sub gtk_entry_set_icon_activatable (GtkEntry $entry, uint32 $icon_pos, gboolean $activatable)
  is native($LIBGTK)
  is export
  { * }

# (GtkEntry $entry, GtkEntryIconPosition $icon_pos, GtkTargetList $target_list, GdkDragAction $actions)
sub gtk_entry_set_icon_drag_source (GtkEntry $entry, uint32 $icon_pos, GtkTargetList $target_list, uint32 $actions)
  is native($LIBGTK)
  is export
  { * }

# (GtkEntry $entry, GtkEntryIconPosition $icon_pos, GIcon $icon)
sub gtk_entry_set_icon_from_gicon (GtkEntry $entry, uint32 $icon_pos, GIcon $icon)
  is native($LIBGTK)
  is export
  { * }

# (GtkEntry $entry, GtkEntryIconPosition $icon_pos, gchar $icon_name)
sub gtk_entry_set_icon_from_icon_name (GtkEntry $entry, uint32 $icon_pos, gchar $icon_name)
  is native($LIBGTK)
  is export
  { * }

# (GtkEntry $entry, GtkEntryIconPosition $icon_pos, GdkPixbuf $pixbuf)
sub gtk_entry_set_icon_from_pixbuf (GtkEntry $entry, uint32 $icon_pos, GdkPixbuf $pixbuf)
  is native($LIBGTK)
  is export
  { * }

# (GtkEntry $entry, GtkEntryIconPosition $icon_pos, gchar $stock_id)
sub gtk_entry_set_icon_from_stock (GtkEntry $entry, uint32 $icon_pos, gchar $stock_id)
  is native($LIBGTK)
  is export
  { * }

# (GtkEntry $entry, GtkEntryIconPosition $icon_pos, gboolean $sensitive)
sub gtk_entry_set_icon_sensitive (GtkEntry $entry, uint32 $icon_pos, gboolean $sensitive)
  is native($LIBGTK)
  is export
  { * }

# (GtkEntry $entry, GtkEntryIconPosition $icon_pos, gchar $tooltip)
sub gtk_entry_set_icon_tooltip_markup (GtkEntry $entry, uint32 $icon_pos, gchar $tooltip)
  is native($LIBGTK)
  is export
  { * }

# (GtkEntry $entry, GtkEntryIconPosition $icon_pos, gchar $tooltip)
sub gtk_entry_set_icon_tooltip_text (GtkEntry $entry, uint32 $icon_pos, gchar $tooltip)
  is native($LIBGTK)
  is export
  { * }

sub gtk_entry_text_index_to_layout_index (GtkEntry $entry, gint $text_index)
  returns gint
  is native($LIBGTK)
  is export
  { * }

sub gtk_entry_unset_invisible_char (GtkEntry $entry)
  is native($LIBGTK)
  is export
  { * }

sub gtk_entry_get_attributes (GtkEntry $entry)
  returns PangoAttrList
  is native($LIBGTK)
  is export
  { * }

sub gtk_entry_get_has_frame (GtkEntry $entry)
  returns uint32
  is native($LIBGTK)
  is export
  { * }

sub gtk_entry_get_overwrite_mode (GtkEntry $entry)
  returns uint32
  is native($LIBGTK)
  is export
  { * }

sub gtk_entry_get_buffer (GtkEntry $entry)
  returns GtkEntryBuffer
  is native($LIBGTK)
  is export
  { * }

sub gtk_entry_get_input_purpose (GtkEntry $entry)
  returns uint32 # GtkInputPurpose
  is native($LIBGTK)
  is export
  { * }

sub gtk_entry_get_cursor_hadjustment (GtkEntry $entry)
  returns GtkAdjustment
  is native($LIBGTK)
  is export
  { * }

sub gtk_entry_get_activates_default (GtkEntry $entry)
  returns uint32
  is native($LIBGTK)
  is export
  { * }

sub gtk_entry_get_alignment (GtkEntry $entry)
  returns gfloat
  is native($LIBGTK)
  is export
  { * }

sub gtk_entry_get_inner_border (GtkEntry $entry)
  returns GtkBorder
  is native($LIBGTK)
  is export
  { * }

sub gtk_entry_get_progress_fraction (GtkEntry $entry)
  returns gdouble
  is native($LIBGTK)
  is export
  { * }

sub gtk_entry_get_width_chars (GtkEntry $entry)
  returns gint
  is native($LIBGTK)
  is export
  { * }

sub gtk_entry_get_progress_pulse_step (GtkEntry $entry)
  returns gdouble
  is native($LIBGTK)
  is export
  { * }

sub gtk_entry_get_completion (GtkEntry $entry)
  returns GtkEntryCompletion
  is native($LIBGTK)
  is export
  { * }

sub gtk_entry_get_max_width_chars (GtkEntry $entry)
  returns gint
  is native($LIBGTK)
  is export
  { * }

sub gtk_entry_get_text (GtkEntry $entry)
  returns Str
  is native($LIBGTK)
  is export
  { * }

sub gtk_entry_get_visibility (GtkEntry $entry)
  returns uint32
  is native($LIBGTK)
  is export
  { * }

sub gtk_entry_get_max_length (GtkEntry $entry)
  returns gint
  is native($LIBGTK)
  is export
  { * }

sub gtk_entry_get_tabs (GtkEntry $entry)
  returns PangoTabArray
  is native($LIBGTK)
  is export
  { * }

sub gtk_entry_get_input_hints (GtkEntry $entry)
  returns uint32 # GtkInputHints
  is native($LIBGTK)
  is export
  { * }

sub gtk_entry_get_placeholder_text (GtkEntry $entry)
  returns Str
  is native($LIBGTK)
  is export
  { * }

sub gtk_entry_set_attributes (GtkEntry $entry, PangoAttrList $attrs)
  is native($LIBGTK)
  is export
  { * }

sub gtk_entry_set_has_frame (GtkEntry $entry, gboolean $setting)
  is native($LIBGTK)
  is export
  { * }

sub gtk_entry_set_overwrite_mode (GtkEntry $entry, gboolean $overwrite)
  is native($LIBGTK)
  is export
  { * }

sub gtk_entry_set_buffer (GtkEntry $entry, GtkEntryBuffer $buffer)
  is native($LIBGTK)
  is export
  { * }

# (GtkEntry $entry, GtkInputPurpose $purpose)
sub gtk_entry_set_input_purpose (GtkEntry $entry, uint32 $purpose)
  is native($LIBGTK)
  is export
  { * }

sub gtk_entry_set_cursor_hadjustment (GtkEntry $entry, GtkAdjustment $adjustment)
  is native($LIBGTK)
  is export
  { * }

sub gtk_entry_set_activates_default (GtkEntry $entry, gboolean $setting)
  is native($LIBGTK)
  is export
  { * }

sub gtk_entry_set_alignment (GtkEntry $entry, gfloat $xalign)
  is native($LIBGTK)
  is export
  { * }

sub gtk_entry_set_inner_border (GtkEntry $entry, GtkBorder $border)
  is native($LIBGTK)
  is export
  { * }

sub gtk_entry_set_progress_fraction (GtkEntry $entry, gdouble $fraction)
  is native($LIBGTK)
  is export
  { * }

sub gtk_entry_set_width_chars (GtkEntry $entry, gint $n_chars)
  is native($LIBGTK)
  is export
  { * }

sub gtk_entry_set_progress_pulse_step (GtkEntry $entry, gdouble $fraction)
  is native($LIBGTK)
  is export
  { * }

sub gtk_entry_set_completion (GtkEntry $entry, GtkEntryCompletion $completion)
  is native($LIBGTK)
  is export
  { * }

sub gtk_entry_set_max_width_chars (GtkEntry $entry, gint $n_chars)
  is native($LIBGTK)
  is export
  { * }

sub gtk_entry_set_text (GtkEntry $entry, gchar $text)
  is native($LIBGTK)
  is export
  { * }

sub gtk_entry_set_visibility (GtkEntry $entry, gboolean $visible)
  is native($LIBGTK)
  is export
  { * }

sub gtk_entry_set_max_length (GtkEntry $entry, gint $max)
  is native($LIBGTK)
  is export
  { * }

sub gtk_entry_set_tabs (GtkEntry $entry, PangoTabArray $tabs)
  is native($LIBGTK)
  is export
  { * }

# (GtkEntry $entry, GtkInputHints $hints)
sub gtk_entry_set_input_hints (GtkEntry $entry, uint32 $hints)
  is native($LIBGTK)
  is export
  { * }

sub gtk_entry_set_placeholder_text (GtkEntry $entry, gchar $text)
  is native($LIBGTK)
  is export
  { * }