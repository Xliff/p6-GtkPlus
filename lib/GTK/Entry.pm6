use v6.c;

use Method::Also;
use NativeCall;

use Pango::Raw::Types;
use Pango::AttrList;

use GTK::Compat::Types;
use GTK::Raw::Entry;
use GTK::Raw::Types;

use GTK::Widget;
use GTK::EntryBuffer;

use GTK::Roles::Editable;
use GTK::Roles::Signals::Entry;

our subset EntryAncestry is export 
  where GtkEntry | GtkEditable | WidgetAncestry;

class GTK::Entry is GTK::Widget {
  also does GTK::Roles::Editable;
  also does GTK::Roles::Signals::Entry;

  has GtkEntry $!e is implementor;

  method bless(*%attrinit) {
    my $o = self.CREATE.BUILDALL(Empty, %attrinit);
    $o.setType($o.^name);
    $o;
  }

  submethod BUILD(:$entry) {
    given $entry {
      when EntryAncestry {
        self.setEntry($entry);
      }
      when GTK::Entry {
      }
      default {
      }
    }
  }

  method setEntry($entry) {
    my $to-parent;
    $!e = do given $entry {
      when GtkEntry {
        $to-parent = nativecast(GtkWidget, $_);
        $_;
      }
      when GtkEditable {
        $!er = $_;                              # GTK::Roles::Editable
        $to-parent = nativecast(GtkWidget, $_);
        nativecast(GtkEntry, $_);
      }
      when WidgetAncestry {
        $to-parent = $_;
        nativecast(GtkEntry, $_);
      }
    };
    self.setWidget($to-parent);
    $!er //= nativecast(GtkEditable, $!e);      # GTK::Roles::Editable
  }

  submethod DESTROY {
    self.disconnect-all($_) for %!signals-e;
  }

  multi method new (EntryAncestry $entry) {
    my $o = self.bless(:$entry);
    $o.upref;
    $o;
  }
  multi method new {
    my $entry = gtk_entry_new();
    self.bless(:$entry);
  }

  multi method new_with_buffer (GtkEntryBuffer() $b)
    is also<new-with-buffer>
  {
    my $entry = gtk_entry_new_with_buffer($b);
    self.bless(:$entry);
  }

  method GTK::Raw::Types::GtkEntry is also<entry> {
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
  method copy-clipboard is also<copy_clipboard> {
    self.connect($!e, 'copy-clipboard');
  }

  # Is originally:
  # GtkEntry, gpointer --> void
  method cut-clipboard is also<cut_clipboard> {
    self.connect($!e, 'cut-clipboard');
  }

  # Is originally:
  # GtkEntry, GtkDeleteType, gint, gpointer --> void
  method delete-from-cursor is also<delete_from_cursor> {
    self.connect-delete($!e, 'delete-from-cursor');
  }

  # Is originally:
  # GtkEntry, GtkEntryIconPosition, GdkEvent, gpointer --> void
  method icon-press is also<icon_press> {
    self.connect-entry-icon($!e, 'icon-press');
  }

  # Is originally:
  # GtkEntry, GtkEntryIconPosition, GdkEvent, gpointer --> void
  method icon-release is also<icon_release> {
    self.connect-entry-icon($!e, 'icon-release');
  }

  # Is originally:
  # GtkEntry, gchar, gpointer --> void
  method insert-at-cursor is also<insert_at_cursor> {
    self.connect-string($!e, 'insert-at-cursor');
  }

  # Is originally:
  # GtkEntry, gpointer --> void
  method insert-emoji is also<insert_emoji> {
    self.connect($!e, 'insert-emoji');
  }

  # Is originally:
  # GtkEntry, GtkMovementStep, gint, gboolean, gpointer --> void
  method move-cursor is also<move_cursor> {
    self.connect-move-cursor2($!e, 'move-cursor');
  }

  # Is originally:
  # GtkEntry, gpointer --> void
  method paste-clipboard is also<paste_clipboard> {
    self.connect($!e, 'paste-clipboard');
  }

  # Is originally:
  # GtkEntry, GtkWidget, gpointer --> void
  method populate-popup is also<populate_popup> {
    self.connect-widget($!e, 'populate-popup');
  }

  # Is originally:
  # GtkEntry, gchar, gpointer --> void
  method preedit-changed is also<preedit_changed> {
    self.connect-string($!e, 'preedit-changed');
  }

  # Is originally:
  # GtkEntry, gpointer --> void
  method toggle-overwrite is also<toggle_overwrite> {
    self.connect($!e, 'toggle-overwrite');
  }

  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓

  # Needs refinement

  method activates_default is rw is also<activates-default> {
    Proxy.new(
      FETCH => sub ($) {
        so gtk_entry_get_activates_default($!e);
      },
      STORE => sub ($, Int() $setting is copy) {
        my gboolean $s = self.RESOLVE-BOOL($setting);
        gtk_entry_set_activates_default($!e, $s);
      }
    );
  }

  method alignment is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_entry_get_alignment($!e);
      },
      STORE => sub ($, Num() $align is copy) {
        my gfloat $a = $align;
        gtk_entry_set_alignment($!e, $a);
      }
    );
  }

  method attributes is rw {
    Proxy.new(
      FETCH => sub ($) {
        Pango::AttrList.new( gtk_entry_get_attributes($!e) );
      },
      STORE => sub ($, PangoAttrList() $attrs is copy) {
        gtk_entry_set_attributes($!e, $attrs);
      }
    );
  }

  method buffer is rw {
    Proxy.new(
      FETCH => sub ($) {
        GTK::EntryBuffer.new( gtk_entry_get_buffer($!e) );
      },
      STORE => sub ($, GtkEntryBuffer() $buffer is copy) {
        gtk_entry_set_buffer($!e, $buffer);
      }
    );
  }

  method completion is rw {
    Proxy.new(
      FETCH => sub ($) {
        GTK::EntryCompletion.new( gtk_entry_get_completion($!e) );
      },
      STORE => sub ($, GtkEntryCompletion() $completion is copy) {
        gtk_entry_set_completion($!e, $completion);
      }
    );
  }

  method cursor_hadjustment is rw is also<cursor-hadjustment> {
    Proxy.new(
      FETCH => sub ($) {
        GTK::Adjustment.new( gtk_entry_get_cursor_hadjustment($!e) );
      },
      STORE => sub ($, GtkAdjustment() $adjustment is copy) {
        gtk_entry_set_cursor_hadjustment($!e, $adjustment);
      }
    );
  }

  method has_frame is rw is also<has-frame> {
    Proxy.new(
      FETCH => sub ($) {
        so gtk_entry_get_has_frame($!e);
      },
      STORE => sub ($, Int() $setting is copy) {
        my gboolean $s = self.RESOLVE-BOOL($setting);
        gtk_entry_set_has_frame($!e, $s);
      }
    );
  }

  method inner_border is rw is also<inner-border> {
    Proxy.new(
      FETCH => sub ($) {
        gtk_entry_get_inner_border($!e);
      },
      STORE => sub ($, GtkBorder $border is copy) {
        gtk_entry_set_inner_border($!e, $border);
      }
    );
  }

  method input_hints is rw is also<input-hints> {
    Proxy.new(
      FETCH => sub ($) {
        GtkInputHints( gtk_entry_get_input_hints($!e) );
      },
      STORE => sub ($, Int() $hints is copy) {
        my guint $h = self.RESOLVE-UINT($hints);
        gtk_entry_set_input_hints($!e, $h);
      }
    );
  }

  method input_purpose is rw is also<input-purpose> {
    Proxy.new(
      FETCH => sub ($) {
        GtkInputPurpose( gtk_entry_get_input_purpose($!e) );
      },
      STORE => sub ($, Int() $purpose is copy) {
        my uint32 $p = self.RESOLVE-UINT($purpose);
        gtk_entry_set_input_purpose($!e, $p);
      }
    );
  }

  method max_length is rw is also<max-length> {
    Proxy.new(
      FETCH => sub ($) {
        gtk_entry_get_max_length($!e);
      },
      STORE => sub ($, $max is copy) {
        gtk_entry_set_max_length($!e, $max);
      }
    );
  }

  method max_width_chars is rw is also<max-width-chars> {
    Proxy.new(
      FETCH => sub ($) {
        gtk_entry_get_max_width_chars($!e);
      },
      STORE => sub ($, $n_chars is copy) {
        gtk_entry_set_max_width_chars($!e, $n_chars);
      }
    );
  }

  method overwrite_mode is rw is also<overwrite-mode> {
    Proxy.new(
      FETCH => sub ($) {
        so gtk_entry_get_overwrite_mode($!e);
      },
      STORE => sub ($, Int() $overwrite is copy) {
        my guint $o = self.RESOLVE-UINT($overwrite);
        gtk_entry_set_overwrite_mode($!e, $o);
      }
    );
  }

  method placeholder_text is rw is also<placeholder-text> {
    Proxy.new(
      FETCH => sub ($) {
        gtk_entry_get_placeholder_text($!e);
      },
      STORE => sub ($, Str() $text is copy) {
        gtk_entry_set_placeholder_text($!e, $text);
      }
    );
  }

  method progress_fraction is rw is also<progress-fraction> {
    Proxy.new(
      FETCH => sub ($) {
        gtk_entry_get_progress_fraction($!e);
      },
      STORE => sub ($, Num() $fraction is copy) {
        my gdouble $f = $fraction;
        gtk_entry_set_progress_fraction($!e, $f);
      }
    );
  }

  method progress_pulse_step is rw is also<progress-pulse-step> {
    Proxy.new(
      FETCH => sub ($) {
        gtk_entry_get_progress_pulse_step($!e);
      },
      STORE => sub ($, Num() $fraction is copy) {
        my gdouble $f = $fraction;
        gtk_entry_set_progress_pulse_step($!e, $f);
      }
    );
  }

  method tabs is rw {
    Proxy.new(
      FETCH => sub ($) {
        Pango::Tabs.new( gtk_entry_get_tabs($!e) );
      },
      STORE => sub ($, PangoTabArray() $tabs is copy) {
        gtk_entry_set_tabs($!e, $tabs);
      }
    );
  }

  method text is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_entry_get_text($!e);
      },
      STORE => sub ($, Str() $text is copy) {
        gtk_entry_set_text($!e, $text);
      }
    );
  }

  method visibility is rw {
    Proxy.new(
      FETCH => sub ($) {
        so gtk_entry_get_visibility($!e);
      },
      STORE => sub ($, Int() $visible is copy) {
        my gboolean $v = self.RESOLVE-BOOL($visible);
        gtk_entry_set_visibility($!e, $v);
      }
    );
  }

  method width_chars is rw is also<width-chars> {
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

  # Type: gint
  method cursor-position is rw  {
    my GTK::Compat::Value $gv .= new( G_TYPE_INT );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get('cursor-position', $gv)
        );
        $gv.int;
      },
      STORE => -> $, Int() $val is copy {
        warn "cursor-position does not allow writing"
      }
    );
  }

  # Type: gboolean
  method editable is rw  {
    my GTK::Compat::Value $gv .= new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get('editable', $gv)
        );
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('editable', $gv);
      }
    );
  }

  # Type: gboolean
  method enable-emoji-completion is rw  {
    my GTK::Compat::Value $gv .= new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get('enable-emoji-completion', $gv)
        );
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('enable-emoji-completion', $gv);
      }
    );
  }

  # Type: gchar
  method im-module is rw  {
    my GTK::Compat::Value $gv .= new( G_TYPE_STRING );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get('im-module', $gv)
        );
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('im-module', $gv);
      }
    );
  }
  
  # Type: guint
  method invisible-char is rw  {
    my GTK::Compat::Value $gv .= new( G_TYPE_UINT );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get('invisible-char', $gv)
        );
        $gv.uint;
      },
      STORE => -> $, Int() $val is copy {
        $gv.uint = $val;
        self.prop_set('invisible-char', $gv);
      }
    );
  }

  # Type: gboolean
  method invisible-char-set is rw  {
    my GTK::Compat::Value $gv .= new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get('invisible-char-set', $gv)
        );
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('invisible-char-set', $gv);
      }
    );
  }
  
  # Type: gboolean
  method populate-all is rw  {
    my GTK::Compat::Value $gv .= new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get('populate-all', $gv)
        );
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('populate-all', $gv);
      }
    );
  }

  # Type: gboolean
  method primary-icon-activatable is rw  {
    my GTK::Compat::Value $gv .= new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get('primary-icon-activatable', $gv)
        );
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('primary-icon-activatable', $gv);
      }
    );
  }
  
  # GIcon us supposedly 
  # # Type: GIcon
  # method primary-icon-gicon is rw  {
  #   my GTK::Compat::Value $gv .= new( -type- );
  #   Proxy.new(
  #     FETCH => -> $ {
  #       $gv = GTK::Compat::Value.new(
  #         self.prop_get('primary-icon-gicon', $gv)
  #       );
  #       #$gv.TYPE
  #     },
  #     STORE => -> $,  $val is copy {
  #       #$gv.TYPE = $val;
  #       self.prop_set('primary-icon-gicon', $gv);
  #     }
  #   );
  # }

  # Type: gchar
  method primary-icon-name is rw  {
    my GTK::Compat::Value $gv .= new( G_TYPE_STRING );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get('primary-icon-name', $gv)
        );
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('primary-icon-name', $gv);
      }
    );
  }
  
  # Type: GdkPixbuf
  method primary-icon-pixbuf is rw  {
    my GTK::Compat::Value $gv .= new( GTK::Compat::Pixbuf.get_type );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get('primary-icon-pixbuf', $gv)
        );
        GTK::Compat::Pixbuf.new(
          nativecast(GdkPixbuf, $gv.object)
        );
      },
      STORE => -> $, GdkPixbuf() $val is copy {
        $gv.object = $val;
        self.prop_set('primary-icon-pixbuf', $gv);
      }
    );
  }

  # Type: gboolean
  method primary-icon-sensitive is rw  {
    my GTK::Compat::Value $gv .= new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get('primary-icon-sensitive', $gv)
        );
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('primary-icon-sensitive', $gv);
      }
    );
  }

  # Type: gchar
  method primary-icon-stock is rw  is DEPRECATED( “primary-icon-name” ) {
    my GTK::Compat::Value $gv .= new( G_TYPE_STRING );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get('primary-icon-stock', $gv)
        );
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('primary-icon-stock', $gv);
      }
    );
  }
  
  # Type: GtkImageType (uint32)
  method primary-icon-storage-type is rw  {
    my GTK::Compat::Value $gv .= new( G_TYPE_UINT );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get('primary-icon-storage-type', $gv)
        );
        GtkImageType( $gv.uint);
      },
      STORE => -> $,  $val is copy {
        warn "primary-icon-storage-type does not allow writing"
      }
    );
  }
  
  # Type: gchar
  method primary-icon-tooltip-markup is rw  {
    my GTK::Compat::Value $gv .= new( G_TYPE_STRING );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get('primary-icon-tooltip-markup', $gv)
        );
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('primary-icon-tooltip-markup', $gv);
      }
    );
  }
  
  # Type: gchar
  method primary-icon-tooltip-text is rw  {
    my GTK::Compat::Value $gv .= new( G_TYPE_STRING );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get('primary-icon-tooltip-text', $gv)
        );
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('primary-icon-tooltip-text', $gv);
      }
    );
  }

  # Type: gint
  method scroll-offset is rw  {
    my GTK::Compat::Value $gv .= new( G_TYPE_INT );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get('scroll-offset', $gv)
        );
        $gv.int;
      },
      STORE => -> $, Int() $val is copy {
        warn "scroll-offset does not allow writing"
      }
    );
  }
  
  # Type: gboolean
  method secondary-icon-activatable is rw  {
    my GTK::Compat::Value $gv .= new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get('secondary-icon-activatable', $gv)
        );
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('secondary-icon-activatable', $gv);
      }
    );
  }
  
  # GIcon is supposedly deprecated.
  # # Type: GIcon
  # method secondary-icon-gicon is rw  {
  #   my GTK::Compat::Value $gv .= new( -type- );
  #   Proxy.new(
  #     FETCH => -> $ {
  #       $gv = GTK::Compat::Value.new(
  #         self.prop_get('secondary-icon-gicon', $gv)
  #       );
  #       #$gv.TYPE
  #     },
  #     STORE => -> $,  $val is copy {
  #       #$gv.TYPE = $val;
  #       self.prop_set('secondary-icon-gicon', $gv);
  #     }
  #   );
  # }
  
  # Type: gchar
  method secondary-icon-name is rw  {
    my GTK::Compat::Value $gv .= new( G_TYPE_STRING );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get('secondary-icon-name', $gv)
        );
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('secondary-icon-name', $gv);
      }
    );
  }
  
  # Type: GdkPixbuf
  method secondary-icon-pixbuf is rw  {
    my GTK::Compat::Value $gv .= new( GTK::Compat::Pixbuf.get_type );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get('secondary-icon-pixbuf', $gv)
        );
        GTK::Compat::Pixbuf.new( 
          nativecast(GdkPixbuf, $gv.objecty)
        );
      },
      STORE => -> $, GdkPixbuf() $val is copy {
        $gv.object = $val;
        self.prop_set('secondary-icon-pixbuf', $gv);
      }
    );
  }
  
  # Type: gboolean
  method secondary-icon-sensitive is rw  {
    my GTK::Compat::Value $gv .= new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get('secondary-icon-sensitive', $gv)
        );
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('secondary-icon-sensitive', $gv);
      }
    );
  }

  # Type: gchar
  method secondary-icon-stock is rw  is DEPRECATED( “secondary-icon-name” ) {
    my GTK::Compat::Value $gv .= new( G_TYPE_STRING );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get('secondary-icon-stock', $gv)
        );
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('secondary-icon-stock', $gv);
      }
    );
  }

  # Type: GtkImageType (uint32)
  method secondary-icon-storage-type is rw  {
    my GTK::Compat::Value $gv .= new( G_TYPE_UINT );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get('secondary-icon-storage-type', $gv)
        );
        GtkImageType( $gv.uint );
      },
      STORE => -> $,  $val is copy {
        warn "secondary-icon-storage-type does not allow writing"
      }
    );
  }
 
  # Type: gchar
  method secondary-icon-tooltip-markup is rw  {
    my GTK::Compat::Value $gv .= new( G_TYPE_STRING );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get('secondary-icon-tooltip-markup', $gv)
        );
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('secondary-icon-tooltip-markup', $gv);
      }
    );
  }
  
  # Type: gchar
  method secondary-icon-tooltip-text is rw  {
    my GTK::Compat::Value $gv .= new( G_TYPE_STRING );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get('secondary-icon-tooltip-text', $gv)
        );
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('secondary-icon-tooltip-text', $gv);
      }
    );
  }
  
  # Type: gint
  method selection-bound is rw  {
    my GTK::Compat::Value $gv .= new( G_TYPE_INT );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get('selection-bound', $gv)
        );
        $gv.int;
      },
      STORE => -> $, Int() $val is copy {
        warn "selection-bound does not allow writing"
      }
    );
  }

  # Type: gboolean
  method show-emoji-icon is rw  {
    my GTK::Compat::Value $gv .= new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get('show-emoji-icon', $gv)
        );
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('show-emoji-icon', $gv);
      }
    );
  }

  # Type: guint
  method text-length is rw  {
    my GTK::Compat::Value $gv .= new( G_TYPE_UINT );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get('text-length', $gv)
        );
        $gv.uint;
      },
      STORE => -> $, Int() $val is copy {
        warn "text-length does not allow writing"
      }
    );
  }
  
  # Type: gboolean
  method truncate-multiline is rw  {
    my GTK::Compat::Value $gv .= new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get('truncate-multiline', $gv)
        );
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('truncate-multiline', $gv);
      }
    );
  }

  # Type: gfloat
  method xalign is rw  {
    my GTK::Compat::Value $gv .= new( G_TYPE_FLOAT );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get('xalign', $gv)
        );
        $gv.float;
      },
      STORE => -> $, Num() $val is copy {
        $gv.float = $val;
        self.prop_set('xalign', $gv);
      }
    );
  }

  method get_current_icon_drag_source
    is also<get-current-icon-drag-source>
  {
    gtk_entry_get_current_icon_drag_source($!e);
  }

  method get_icon_activatable (
    Int() $icon_pos,          # GtkEntryIconPosition $icon_pos,
  )
    is also<get-icon-activatable>
  {
    my uint32 $ip = self.RESOLVE-INT($icon_pos);
    gtk_entry_get_icon_activatable($!e, $ip);
  }

  method get_icon_area (
    Int() $icon_pos,          # GtkEntryIconPosition $icon_pos,
    GdkRectangle $icon_area
  )
    is also<get-icon-area>
  {
    my uint32 $ip = self.RESOLVE-INT($icon_pos);
    gtk_entry_get_icon_area($!e, $ip, $icon_area);
  }

  method get_icon_at_pos (Int() $x, Int() $y) is also<get-icon-at-pos> {
    my @i = ($x, $y);
    my gint ($xx, $yy) = self.RESOLVE-INT(@i);
    gtk_entry_get_icon_at_pos($!e, $x, $y);
  }

  method get_icon_gicon (
    Int() $icon_pos,          # GtkEntryIconPosition $icon_pos,
  )
    is also<get-icon-gicon>
  {
    my uint32 $ip = self.RESOLVE-INT($icon_pos);
    gtk_entry_get_icon_gicon($!e, $ip);
  }

  method get_icon_name (
    Int() $icon_pos,          # GtkEntryIconPosition $icon_pos,
  )
    is also<get-icon-name>
  {
    my uint32 $ip = self.RESOLVE-INT($icon_pos);
    gtk_entry_get_icon_name($!e, $ip);
  }

  method get_icon_pixbuf (
    Int() $icon_pos,          # GtkEntryIconPosition $icon_pos,
  )
    is also<get-icon-pixbuf>
  {
    my uint32 $ip = self.RESOLVE-INT($icon_pos);
    gtk_entry_get_icon_pixbuf($!e, $ip);
  }

  method get_icon_sensitive (
    Int() $icon_pos,          # GtkEntryIconPosition $icon_pos,
  )
    is also<get-icon-sensitive>
  {
    my uint32 $ip = self.RESOLVE-INT($icon_pos);
    gtk_entry_get_icon_sensitive($!e, $ip);
  }

  method get_icon_stock (
    Int() $icon_pos,          # GtkEntryIconPosition $icon_pos,
  )
    is also<get-icon-stock>
  {
    my uint32 $ip = self.RESOLVE-INT($icon_pos);
    gtk_entry_get_icon_stock($!e, $ip);
  }

  method get_icon_storage_type (
    Int() $icon_pos,          # GtkEntryIconPosition $icon_pos,
  )
    is also<get-icon-storage-type>
  {
    my uint32 $ip = self.RESOLVE-INT($icon_pos);
    GtkImageType( gtk_entry_get_icon_storage_type($!e, $ip) );
  }

  method get_icon_tooltip_markup (
    Int() $icon_pos,          # GtkEntryIconPosition $icon_pos,
  )
    is also<get-icon-tooltip-markup>
  {
    my uint32 $ip = self.RESOLVE-INT($icon_pos);
    gtk_entry_get_icon_tooltip_markup($!e, $ip);
  }

  method get_icon_tooltip_text (
    Int() $icon_pos,          # GtkEntryIconPosition $icon_pos,
  )
    is also<get-icon-tooltip-text>
  {
    my uint32 $ip = self.RESOLVE-INT($icon_pos);
    gtk_entry_get_icon_tooltip_text($!e, $icon_pos);
  }

  method get_invisible_char is also<get-invisible-char> {
    gtk_entry_get_invisible_char($!e);
  }

  method get_layout is also<get-layout> {
    gtk_entry_get_layout($!e);
  }

  method get_layout_offsets (Int() $x, Int() $y)
    is also<get-layout-offsets>
  {
    my @i = ($x, $y);
    my gint ($xx, $yy) = self.RESOLVE-INT(@i);
    gtk_entry_get_layout_offsets($!e, $xx, $yy);
  }

  method get_text_area (GdkRectangle() $text_area) is also<get-text-area> {
    gtk_entry_get_text_area($!e, $text_area);
  }

  method get_text_length is also<get-text-length> {
    gtk_entry_get_text_length($!e);
  }

  method get_type is also<get-type> {
    state ($n, $t);
    GTK::Widget.unstable_get_type( &gtk_entry_get_type, $n, $t );
  }

  method grab_focus_without_selecting
    is also<grab-focus-without-selecting>
  {
    gtk_entry_grab_focus_without_selecting($!e);
  }

  method im_context_filter_keypress (GdkEventKey $event)
    is also<im-context-filter-keypress>
  {
    gtk_entry_im_context_filter_keypress($!e, $event);
  }

  method layout_index_to_text_index (Int() $layout_index)
    is also<layout-index-to-text-index>
  {
    my gint $li = self.RESOLVE-INT($layout_index);
    gtk_entry_layout_index_to_text_index($!e, $li);
  }

  method progress_pulse is also<progress-pulse> {
    gtk_entry_progress_pulse($!e);
  }

  method reset_im_context is also<reset-im-context> {
    gtk_entry_reset_im_context($!e);
  }

  method set_icon_activatable (
    Int() $icon_pos,          # GtkEntryIconPosition $icon_pos,
    Int() $activatable
  )
    is also<set-icon-activatable>
  {
    my uint32 $ip = self.RESOLVE-INT($icon_pos);
    my gboolean $a = self.RESOLVE-BOOL($activatable);
    gtk_entry_set_icon_activatable($!e, $ip, $a);
  }

  method set_icon_drag_source (
    Int() $icon_pos,          # GtkEntryIconPosition $icon_pos,
    GtkTargetList() $target_list,
    Int() $actions            # GdkDragAction $actions
  )
    is also<set-icon-drag-source>
  {
    my @u = ($icon_pos, $actions);
    my uint32 ($ip, $a) = self.RESOLVE-INT(@u);
    gtk_entry_set_icon_drag_source($!e, $ip, $target_list, $a);
  }

  method set_icon_from_gicon (
    Int() $icon_pos,          # GtkEntryIconPosition $icon_pos,
    GIcon $icon
  )
    is also<set-icon-from-gicon>
  {
    my uint32 $ip = self.RESOLVE-INT($icon_pos);
    gtk_entry_set_icon_from_gicon($!e, $ip, $icon);
  }

  method set_icon_from_icon_name (
    Int() $icon_pos,          # GtkEntryIconPosition $icon_pos,
    Str() $icon_name
  )
    is also<set-icon-from-icon-name>
  {
    my uint32 $ip = self.RESOLVE-INT($icon_pos);
    gtk_entry_set_icon_from_icon_name($!e, $ip, $icon_name);
  }

  method set_icon_from_pixbuf (
    Int() $icon_pos,          # GtkEntryIconPosition $icon_pos,
    GdkPixbuf() $pixbuf
  )
    is also<set-icon-from-pixbuf>
  {
    my uint32 $ip = self.RESOLVE-INT($icon_pos);
    gtk_entry_set_icon_from_pixbuf($!e, $ip, $pixbuf);
  }

  method set_icon_from_stock (
    Int() $icon_pos,          # GtkEntryIconPosition $icon_pos,
    Str() $stock_id
  )
    is also<set-icon-from-stock>
  {
    my uint32 $ip = self.RESOLVE-INT($icon_pos);
    gtk_entry_set_icon_from_stock($!e, $ip, $stock_id);
  }

  method set_icon_sensitive (
    Int() $icon_pos,          # GtkEntryIconPosition $icon_pos,
    Int() $sensitive
  )
    is also<set-icon-sensitive>
  {
    my uint32 $ip = self.RESOLVE-INT($icon_pos);
    my gboolean $s = self.RESOLVE-BOOL($sensitive);
    gtk_entry_set_icon_sensitive($!e, $ip, $s);
  }

  method set_icon_tooltip_markup (
    Int() $icon_pos,          # GtkEntryIconPosition $icon_pos,
    Str() $tooltip
  )
    is also<set-icon-tooltip-markup>
  {
    my uint32 $ip = self.RESOLVE-INT($icon_pos);
    gtk_entry_set_icon_tooltip_markup($!e, $ip, $tooltip);
  }

  method set_icon_tooltip_text (
    Int() $icon_pos,          # GtkEntryIconPosition $icon_pos,
    Str() $tooltip
  )
    is also<set-icon-tooltip-text>
  {
    my uint32 $ip = self.RESOLVE-INT($icon_pos);
    gtk_entry_set_icon_tooltip_text($!e, $ip, $tooltip);
  }

  method text_index_to_layout_index (Int() $text_index)
    is also<text-index-to-layout-index>
  {
    my gint $ti = self.RESOLVE-INT($text_index);
    gtk_entry_text_index_to_layout_index($!e, $text_index);
  }

  method unset_invisible_char is also<unset-invisible-char> {
    gtk_entry_unset_invisible_char($!e);
  }

}
