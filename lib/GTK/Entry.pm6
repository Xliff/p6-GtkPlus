use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::Entry;
use GTK::Raw::Types;

use GTK::Widget;
use GTK::EntryBuffer;

use GTK::Roles::Editable;
use GTK::Roles::Signals::Entry;

class GTK::Entry is GTK::Widget {
  also does GTK::Roles::Editable;
  also does GTK::Roles::Signals::Entry;

  has GtkEntry $!e;

  method bless(*%attrinit) {
    my $o = self.CREATE.BUILDALL(Empty, %attrinit);
    $o.setType('GTK::Entry');
    $o;
  }

  submethod BUILD(:$entry) {
    given $entry {
      when GtkEntry | GtkWidget {
        self.setEntry($entry);
      }
      when GTK::Entry {
      }
      default {
      }
    }
    # For GTK::Roles::Editable
    $!er = nativecast(GtkEditable, $!e);
  }

  submethod DESTROY {
    self.disconnect-all($_) for %!signals-e;
  }

  multi method new {
    my $entry = gtk_entry_new();
    self.bless(:$entry);
  }
  multi method new (GtkWidget $entry) {
    self.bless(:$entry);
  }

  multi method new_with_buffer (GTK::EntryBuffer $b) {
    samewith($b.buffer);
  }
  multi method new_with_buffer (GtkEntryBuffer $b) {
    my $entry = gtk_entry_new_with_buffer($b);
    self.bless(:$entry);
  }

  method setEntry($entry) {
    my $to-parent;
    $!e = do given $entry {
      when GtkWidget {
        $to-parent = $_;
        nativecast(GtkEntry, $_);
      }
      when GtkEntry {
        $to-parent = nativecast(GtkWidget, $_);
        $_;
      }
    };
    self.setWidget($to-parent);
  }

  method GTK::Raw::Types::GtkEntry {
    $!e;
  }
  method entry {
    $!e;
  }

  # ↓↓↓↓ SIGNALS ↓↓↓↓

  # Is originally:
  # GtkEntry, gpointer --> void
  method activate {
    self.connect($!e, 'activate');
  }

  # Is originally:
  # GtkEntry, gpointer --> void
  method backspace {
    self.connect($!e, 'backspace');
  }

  # Is originally:
  # GtkEntry, gpointer --> void
  method copy-clipboard {
    self.connect($!e, 'copy-clipboard');
  }

  # Is originally:
  # GtkEntry, gpointer --> void
  method cut-clipboard {
    self.connect($!e, 'cut-clipboard');
  }

  # Is originally:
  # GtkEntry, GtkDeleteType, gint, gpointer --> void
  method delete-from-cursor {
    self.connect-delete($!e, 'delete-from-cursor');
  }

  # Is originally:
  # GtkEntry, GtkEntryIconPosition, GdkEvent, gpointer --> void
  method icon-press {
    self.connect-entry-icon($!e, 'icon-press');
  }

  # Is originally:
  # GtkEntry, GtkEntryIconPosition, GdkEvent, gpointer --> void
  method icon-release {
    self.connect-entry-icon($!e, 'icon-release');
  }

  # Is originally:
  # GtkEntry, gchar, gpointer --> void
  method insert-at-cursor {
    self.connect-string($!e, 'insert-at-cursor');
  }

  # Is originally:
  # GtkEntry, gpointer --> void
  method insert-emoji {
    self.connect($!e, 'insert-emoji');
  }

  # Is originally:
  # GtkEntry, GtkMovementStep, gint, gboolean, gpointer --> void
  method move-cursor {
    self.connect-move-cursor2($!e, 'move-cursor');
  }

  # Is originally:
  # GtkEntry, gpointer --> void
  method paste-clipboard {
    self.connect($!e, 'paste-clipboard');
  }

  # Is originally:
  # GtkEntry, GtkWidget, gpointer --> void
  method populate-popup {
    self.connect-widget($!e, 'populate-popup');
  }

  # Is originally:
  # GtkEntry, gchar, gpointer --> void
  method preedit-changed {
    self.connect-string($!e, 'preedit-changed');
  }

  # Is originally:
  # GtkEntry, gpointer --> void
  method toggle-overwrite {
    self.connect($!e, 'toggle-overwrite');
  }

  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓

  # Needs refinement

  method activates_default is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_entry_get_activates_default($!e);
      },
      STORE => sub ($, $setting is copy) {
        gtk_entry_set_activates_default($!e, $setting);
      }
    );
  }

  method alignment is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_entry_get_alignment($!e);
      },
      STORE => sub ($, $xalign is copy) {
        gtk_entry_set_alignment($!e, $xalign);
      }
    );
  }

  method attributes is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_entry_get_attributes($!e);
      },
      STORE => sub ($, $attrs is copy) {
        gtk_entry_set_attributes($!e, $attrs);
      }
    );
  }

  method buffer is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_entry_get_buffer($!e);
      },
      STORE => sub ($, $buffer is copy) {
        gtk_entry_set_buffer($!e, $buffer);
      }
    );
  }

  method completion is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_entry_get_completion($!e);
      },
      STORE => sub ($, $completion is copy) {
        gtk_entry_set_completion($!e, $completion);
      }
    );
  }

  method cursor_hadjustment is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_entry_get_cursor_hadjustment($!e);
      },
      STORE => sub ($, $adjustment is copy) {
        gtk_entry_set_cursor_hadjustment($!e, $adjustment);
      }
    );
  }

  method has_frame is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_entry_get_has_frame($!e);
      },
      STORE => sub ($, $setting is copy) {
        gtk_entry_set_has_frame($!e, $setting);
      }
    );
  }

  method inner_border is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_entry_get_inner_border($!e);
      },
      STORE => sub ($, $border is copy) {
        gtk_entry_set_inner_border($!e, $border);
      }
    );
  }

  method input_hints is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_entry_get_input_hints($!e);
      },
      STORE => sub ($, $hints is copy) {
        gtk_entry_set_input_hints($!e, $hints);
      }
    );
  }

  method input_purpose is rw {
    Proxy.new(
      FETCH => sub ($) {
        GtkInputPurpose( gtk_entry_get_input_purpose($!e) );
      },
      STORE => sub ($, Int $purpose is copy) {
        my uint32 $p = $purpose;
        gtk_entry_set_input_purpose($!e, $p);
      }
    );
  }

  method max_length is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_entry_get_max_length($!e);
      },
      STORE => sub ($, $max is copy) {
        gtk_entry_set_max_length($!e, $max);
      }
    );
  }

  method max_width_chars is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_entry_get_max_width_chars($!e);
      },
      STORE => sub ($, $n_chars is copy) {
        gtk_entry_set_max_width_chars($!e, $n_chars);
      }
    );
  }

  method overwrite_mode is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_entry_get_overwrite_mode($!e);
      },
      STORE => sub ($, $overwrite is copy) {
        gtk_entry_set_overwrite_mode($!e, $overwrite);
      }
    );
  }

  method placeholder_text is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_entry_get_placeholder_text($!e);
      },
      STORE => sub ($, $text is copy) {
        gtk_entry_set_placeholder_text($!e, $text);
      }
    );
  }

  method progress_fraction is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_entry_get_progress_fraction($!e);
      },
      STORE => sub ($, $fraction is copy) {
        gtk_entry_set_progress_fraction($!e, $fraction);
      }
    );
  }

  method progress_pulse_step is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_entry_get_progress_pulse_step($!e);
      },
      STORE => sub ($, $fraction is copy) {
        gtk_entry_set_progress_pulse_step($!e, $fraction);
      }
    );
  }

  method tabs is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_entry_get_tabs($!e);
      },
      STORE => sub ($, $tabs is copy) {
        gtk_entry_set_tabs($!e, $tabs);
      }
    );
  }

  method text is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_entry_get_text($!e);
      },
      STORE => sub ($, $text is copy) {
        gtk_entry_set_text($!e, $text);
      }
    );
  }

  method visibility is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_entry_get_visibility($!e);
      },
      STORE => sub ($, $visible is copy) {
        gtk_entry_set_visibility($!e, $visible);
      }
    );
  }

  method width_chars is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_entry_get_width_chars($!e);
      },
      STORE => sub ($, $n_chars is copy) {
        gtk_entry_set_width_chars($!e, $n_chars);
      }
    );
  }
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  method get_current_icon_drag_source {
    gtk_entry_get_current_icon_drag_source($!e);
  }

  method get_icon_activatable (
    Int() $icon_pos,          # GtkEntryIconPosition $icon_pos,
  ) {
    my uint32 $ip = self.RESOLVE-INT($icon_pos);
    gtk_entry_get_icon_activatable($!e, $ip);
  }

  method get_icon_area (
    Int() $icon_pos,          # GtkEntryIconPosition $icon_pos,
    GdkRectangle() $icon_area
  ) {
    my uint32 $ip = self.RESOLVE-INT($icon_pos);
    gtk_entry_get_icon_area($!e, $ip, $icon_area);
  }

  method get_icon_at_pos (Int() $x, Int() $y) {
    my @i = ($x, $y);
    my gint ($xx, $yy) = self.RESOLVE-INT(@i);
    gtk_entry_get_icon_at_pos($!e, $x, $y);
  }

  method get_icon_gicon (
    Int() $icon_pos,          # GtkEntryIconPosition $icon_pos,
  ) {
    my uint32 $ip = self.RESOLVE-INT($icon_pos);
    gtk_entry_get_icon_gicon($!e, $ip);
  }

  method get_icon_name (
    Int() $icon_pos,          # GtkEntryIconPosition $icon_pos,
  ) {
    my uint32 $ip = self.RESOLVE-INT($icon_pos);
    gtk_entry_get_icon_name($!e, $ip);
  }

  method get_icon_pixbuf (
    Int() $icon_pos,          # GtkEntryIconPosition $icon_pos,
  ) {
    my uint32 $ip = self.RESOLVE-INT($icon_pos);
    gtk_entry_get_icon_pixbuf($!e, $ip);
  }

  method get_icon_sensitive (
    Int() $icon_pos,          # GtkEntryIconPosition $icon_pos,
  ) {
    my uint32 $ip = self.RESOLVE-INT($icon_pos);
    gtk_entry_get_icon_sensitive($!e, $ip);
  }

  method get_icon_stock (
    Int() $icon_pos,          # GtkEntryIconPosition $icon_pos,
  ) {
    my uint32 $ip = self.RESOLVE-INT($icon_pos);
    gtk_entry_get_icon_stock($!e, $ip);
  }

  method get_icon_storage_type (
    Int() $icon_pos,          # GtkEntryIconPosition $icon_pos,
  ) {
    my uint32 $ip = self.RESOLVE-INT($icon_pos);
    GtkImageType( gtk_entry_get_icon_storage_type($!e, $ip) );
  }

  method get_icon_tooltip_markup (
    Int() $icon_pos,          # GtkEntryIconPosition $icon_pos,
  ) {
    my uint32 $ip = self.RESOLVE-INT($icon_pos);
    gtk_entry_get_icon_tooltip_markup($!e, $ip);
  }

  method get_icon_tooltip_text (
    Int() $icon_pos,          # GtkEntryIconPosition $icon_pos,
  ) {
    my uint32 $ip = self.RESOLVE-INT($icon_pos);
    gtk_entry_get_icon_tooltip_text($!e, $icon_pos);
  }

  method get_invisible_char {
    gtk_entry_get_invisible_char($!e);
  }

  method get_layout {
    gtk_entry_get_layout($!e);
  }

  method get_layout_offsets (Int() $x, Int() $y) {
    my @i = ($x, $y);
    my gint ($xx, $yy) = self.RESOLVE-INT(@i);
    gtk_entry_get_layout_offsets($!e, $xx, $yy);
  }

  method get_text_area (GdkRectangle() $text_area) {
    gtk_entry_get_text_area($!e, $text_area);
  }

  method get_text_length {
    gtk_entry_get_text_length($!e);
  }

  method get_type {
    gtk_entry_get_type();
  }

  method grab_focus_without_selecting {
    gtk_entry_grab_focus_without_selecting($!e);
  }

  method im_context_filter_keypress (GdkEventKey $event) {
    gtk_entry_im_context_filter_keypress($!e, $event);
  }

  method layout_index_to_text_index (Int() $layout_index) {
    my gint $li = self.RESOLVE-INT($layout_index);
    gtk_entry_layout_index_to_text_index($!e, $li);
  }

  method progress_pulse {
    gtk_entry_progress_pulse($!e);
  }

  method reset_im_context {
    gtk_entry_reset_im_context($!e);
  }

  method set_icon_activatable (
    Int() $icon_pos,          # GtkEntryIconPosition $icon_pos,
    Int() $activatable
  ) {
    my uint32 $ip = self.RESOLVE-INT($icon_pos);
    my gboolean $a = self.RESOLVE-BOOL($activatable);
    gtk_entry_set_icon_activatable($!e, $ip, $a);
  }

  method set_icon_drag_source (
    Int() $icon_pos,          # GtkEntryIconPosition $icon_pos,
    GtkTargetList() $target_list,
    Int() $actions            # GdkDragAction $actions
  ) {
    my @u = ($icon_pos, $actions);
    my uint32 ($ip, $a) = self.RESOLVE-INT(@u);
    gtk_entry_set_icon_drag_source($!e, $ip, $target_list, $a);
  }

  method set_icon_from_gicon (
    Int() $icon_pos,          # GtkEntryIconPosition $icon_pos,
    GIcon $icon
  ) {
    my uint32 $ip = self.RESOLVE-INT($icon_pos);
    gtk_entry_set_icon_from_gicon($!e, $ip, $icon);
  }

  method set_icon_from_icon_name (
    Int() $icon_pos,          # GtkEntryIconPosition $icon_pos,
    Str() $icon_name
  ) {
    my uint32 $ip = self.RESOLVE-INT($icon_pos);
    gtk_entry_set_icon_from_icon_name($!e, $ip, $icon_name);
  }

  method set_icon_from_pixbuf (
    Int() $icon_pos,          # GtkEntryIconPosition $icon_pos,
    GdkPixbuf() $pixbuf
  ) {
    my uint32 $ip = self.RESOLVE-INT($icon_pos);
    gtk_entry_set_icon_from_pixbuf($!e, $ip, $pixbuf);
  }

  method set_icon_from_stock (
    Int() $icon_pos,          # GtkEntryIconPosition $icon_pos,
    gchar $stock_id
  ) {
    my uint32 $ip = self.RESOLVE-INT($icon_pos);
    gtk_entry_set_icon_from_stock($!e, $ip, $stock_id);
  }

  method set_icon_sensitive (
    Int() $icon_pos,          # GtkEntryIconPosition $icon_pos,
    gboolean $sensitive
  ) {
    my uint32 $ip = self.RESOLVE-INT($icon_pos);
    gtk_entry_set_icon_sensitive($!e, $ip, $sensitive);
  }

  method set_icon_tooltip_markup (
    Int() $icon_pos,          # GtkEntryIconPosition $icon_pos,
    Str() $tooltip
  ) {
    my uint32 $ip = self.RESOLVE-INT($icon_pos);
    gtk_entry_set_icon_tooltip_markup($!e, $ip, $tooltip);
  }

  method set_icon_tooltip_text (
    Int() $icon_pos,          # GtkEntryIconPosition $icon_pos,
    Str() $tooltip
  ) {
    my uint32 $ip = self.RESOLVE-INT($icon_pos);
    gtk_entry_set_icon_tooltip_text($!e, $ip, $tooltip);
  }

  method text_index_to_layout_index (Int() $text_index) {
    my gint $ti = self.RESOLVE-INT($text_index);
    gtk_entry_text_index_to_layout_index($!e, $text_index);
  }

  method unset_invisible_char {
    gtk_entry_unset_invisible_char($!e);
  }

}
