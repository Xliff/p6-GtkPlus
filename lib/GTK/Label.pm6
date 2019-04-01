use v6.c;

use Method::Also;
use NativeCall;

use Pango::Raw::Types;

use GTK::Compat::Types;
use GTK::Raw::Label;
use GTK::Raw::Types;

use Pango::AttrList;
use Pango::Layout;

use GTK::Widget;

our subset LabelAncestry is export where GtkLabel | WidgetAncestry;

class GTK::Label is GTK::Widget {
  has GtkLabel $!l;

  method bless(*%attrinit) {
    my $o = self.CREATE.BUILDALL(Empty, %attrinit);
    $o.setType('GTK::Label');
    $o;
  }

  submethod BUILD(:$label) {
    given $label {
      when LabelAncestry {
        self.setLabel($label);
      }
      when GTK::Label {
      }
      default {
      }
    }
  }
  
  method GTK::Raw::Types::GtkLabel is also<Label> { $!l }

  multi method new (LabelAncestry $label) {
    my $o = self.bless(:$label);
    $o.upref;
    $o;
  }
  multi method new ($text = Str) {
    my $label = gtk_label_new($text);
    self.bless(:$label);
  }

  method setLabel(LabelAncestry $label) {
    my $to-parent;
    $!l = do given $label {
      when GtkLabel  {
        $to-parent = nativecast(GtkWidget, $_);
        $_;
      }
      default {
        $to-parent = $_;
        nativecast(GtkLabel, $label);
      }
    };
    self.setWidget($to-parent);
  }

  method new_with_mnemonic ($text) is also<new-with-mnemonic> {
    my $label = gtk_label_new_with_mnemonic($text);
    self.bless(:$label);
  }

  # Signals

  # Is originally:
  # GtkLabel, gpointer --> void
  method activate-current-link is also<activate_current_link> {
    self.connect($!l, 'activate-current-link');
  }

  # Is originally:
  # GtkLabel, Str(), gpointer --> gboolean
  method activate-link is also<activate_link> {
    self.connect-activate-link($!l);
  }

  # Is originally:
  # GtkLabel, gpointer --> void
  method copy-clipboard is also<copy_clipboard> {
    self.connect($!l, 'copy-clipboard');
  }

  # Is originally:
  # GtkLabel, GtkMovementStep, gint, gboolean, gpointer --> void
  method move-cursor is also<move_cursor> {
    self.connect-move-cursor2($!l, 'move-cursor');
  }

  # Is originally:
  # GtkLabel, GtkMenu, gpointer --> void
  method populate-popup is also<populate_popup> {
    self.connect-menu($!l, 'populate-popup');
  }

  ## Properties.

  method angle is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_label_get_angle($!l);
      },
      STORE => sub ($, Num() $angle is copy) {
        my gdouble $a = $angle;
        gtk_label_set_angle($!l, $a);
      }
    );
  }
  
  # PangoAttrList
  method attributes is rw {
    Proxy.new(
      FETCH => sub ($) {
        Pango::AttrList.new( gtk_label_get_attributes($!l) );
      },
      STORE => sub ($, PangoAttrList() $attrs is copy) {
        gtk_label_set_attributes($!l, $attrs);
      }
    );
  }

  method ellipsize is rw {
    Proxy.new(
      FETCH => sub ($) {
        PangoEllipsizeMode( gtk_label_get_ellipsize($!l) );
      },
      STORE => sub ($, Int() $mode is copy) {
        my uint32 $m = self.RESOLVE-UINT($mode);
        gtk_label_set_ellipsize($!l, $mode);
      }
    );
  }

  method justify is rw {
    Proxy.new(
      FETCH => sub ($) {
        GtkJustification( gtk_label_get_justify($!l) );
      },
      STORE => sub ($, Int() $jtype is copy) {
        my uint32 $jt = self.RESOLVE-UINT($jtype);
        gtk_label_set_justify($!l, $jt);
      }
    );
  }

  method label is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_label_get_label($!l);
      },
      STORE => sub ($, Str() $str is copy) {
        gtk_label_set_label($!l, $str);
      }
    );
  }

  method line_wrap is rw
    is also<
      line-wrap
      wrap
    >
  {
    Proxy.new(
      FETCH => sub ($) {
        Bool( gtk_label_get_line_wrap($!l) );
      },
      STORE => sub ($, Int() $wrap is copy) {
        my gboolean $w = self.RESOLVE-BOOL($wrap);
        gtk_label_set_line_wrap($!l, $w);
      }
    );
  }

  method line_wrap_mode is rw
    is also<
      line-wrap-mode
      wrap-mode
      wrap_mode
    >
  {
    Proxy.new(
      FETCH => sub ($) {
        PangoWrapMode( gtk_label_get_line_wrap_mode($!l) );
      },
      STORE => sub ($, Int() $wrap_mode is copy) {
        my uint32 $wm = self.RESOLVE-UINT($wrap_mode);
        gtk_label_set_line_wrap_mode($!l, $wm);
      }
    );
  }

  method lines is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_label_get_lines($!l);
      },
      STORE => sub ($, Int() $lines is copy) {
        my gint $l = self.RESOLVE-INT($lines);
        gtk_label_set_lines($!l, $l);
      }
    );
  }

  method max_width_chars is rw is also<max-width-chars> {
    Proxy.new(
      FETCH => sub ($) {
        gtk_label_get_max_width_chars($!l);
      },
      STORE => sub ($, Int() $n_chars is copy) {
        my gint $nc = self.RESOLVE-INT($n_chars);
        gtk_label_set_max_width_chars($!l, $n_chars);
      }
    );
  }

  method mnemonic_widget is rw is also<mnemonic-widget> {
    Proxy.new(
      FETCH => sub ($) {
        # Needs widget resolution.
        gtk_label_get_mnemonic_widget($!l);
      },
      STORE => sub ($, GtkWidget() $widget is copy) {
        gtk_label_set_mnemonic_widget($!l, $widget);
      }
    );
  }

  method selectable is rw {
    Proxy.new(
      FETCH => sub ($) {
        Bool( gtk_label_get_selectable($!l) );
      },
      STORE => sub ($, Int() $setting is copy) {
        my gboolean $s = self.RESOLVE-BOOL($setting);
        gtk_label_set_selectable($!l, $s);
      }
    );
  }

  method single_line_mode is rw is also<single-line-mode> {
    Proxy.new(
      FETCH => sub ($) {
        Bool( gtk_label_get_single_line_mode($!l) );
      },
      STORE => sub ($, Int() $single_line_mode is copy) {
        my gboolean $sl = self.RESOLVE-BOOL($single_line_mode);
        gtk_label_set_single_line_mode($!l, $sl);
      }
    );
  }

  method text is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_label_get_text($!l);
      },
      STORE => sub ($, Str() $str is copy) {
        gtk_label_set_text($!l, $str);
      }
    );
  }

  method track_visited_links is rw is also<track-visited-links> {
    Proxy.new(
      FETCH => sub ($) {
        Bool( gtk_label_get_track_visited_links($!l) );
      },
      STORE => sub ($, Int() $track_links is copy) {
        my gboolean $tl = self.RESOLVE-BOOL($track_links);
        gtk_label_set_track_visited_links($!l, $tl);
      }
    );
  }

  method use_markup is rw is also<use-markup> {
    Proxy.new(
      FETCH => sub ($) {
        Bool( gtk_label_get_use_markup($!l) );
      },
      STORE => sub ($, Int() $setting is copy) {
        my gboolean $s = self.RESOLVE-BOOL($setting);
        gtk_label_set_use_markup($!l, $s);
      }
    );
  }

  method use_underline is rw is also<use-underline> {
    Proxy.new(
      FETCH => sub ($) {
        Bool( gtk_label_get_use_underline($!l) );
      },
      STORE => sub ($, Int() $setting is copy) {
        my gboolean $s = self.RESOLVE-BOOL($setting);
        gtk_label_set_use_underline($!l, $s);
      }
    );
  }

  method width_chars is rw is also<width-chars> {
    Proxy.new(
      FETCH => sub ($) {
        gtk_label_get_width_chars($!l);
      },
      STORE => sub ($, Int() $n_chars is copy) {
        my gint $nc = self.RESOLVE-INT($n_chars);
        gtk_label_set_width_chars($!l, $nc);
      }
    );
  }

  method xalign is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_label_get_xalign($!l);
      },
      STORE => sub ($, Num() $xalign is copy) {
        my gfloat $xa = $xalign;
        gtk_label_set_xalign($!l, $xa);
      }
    );
  }

  method yalign is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_label_get_yalign($!l);
      },
      STORE => sub ($, Num() $yalign is copy) {
        my gfloat $ya = $yalign;
        gtk_label_set_yalign($!l, $ya);
      }
    );
  }

  method get_current_uri is also<get-current-uri> {
    gtk_label_get_current_uri($!l);
  }

  method get_layout 
    is also<
      get-layout
      layout
    > 
  {
    Pango::Layout.new( gtk_label_get_layout($!l) );
  }

  method get_layout_offsets (Int() $x, Int() $y)
    is also<get-layout-offsets>
  {
    my @i = ($x, $y);
    my gint ($xx, $yy) = self.RESOLVE-INT(@i);
    gtk_label_get_layout_offsets($!l, $xx, $yy);
  }

  method get_mnemonic_keyval is also<get-mnemonic-keyval> {
    gtk_label_get_mnemonic_keyval($!l);
  }

  method get_selection_bounds (Int() $start, Int() $end)
    is also<get-selection-bounds>
  {
    my @i = ($start, $end);
    my gint ($s, $e) = self.RESOLVE-INT(@i);
    gtk_label_get_selection_bounds($!l, $start, $end);
  }

  method get_type is also<get-type> {
    state ($n, $t);
    GTK::Widget.unstable_get_type( &gtk_label_get_type, $n, $t);
  }

  method select_region (Int() $start_offset, Int() $end_offset)
    is also<select-region>
  {
    my @i = ($start_offset, $end_offset);
    my gint ($so, $eo) = self.RESOLVE-INT(@i);
    gtk_label_select_region($!l, $so, $eo);
  }

  method set_markup (Str() $str) is also<set-markup> {
    gtk_label_set_markup($!l, $str);
  }

  method set_markup_with_mnemonic (Str() $str)
    is also<set-markup-with-mnemonic>
  {
    gtk_label_set_markup_with_mnemonic($!l, $str);
  }

  method set_pattern (Str() $pattern) is also<set-pattern> {
    gtk_label_set_pattern($!l, $pattern);
  }

  method set_text_with_mnemonic (Str() $str)
    is also<set-text-with-mnemonic>
  {
    gtk_label_set_text_with_mnemonic($!l, $str);
  }

}
