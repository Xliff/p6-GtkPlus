use v6.c;

use Method::Also;

use Pango::Raw::Types;

use GTK::Raw::Label;
use GTK::Raw::Types;

use Pango::AttrList;
use Pango::Layout;

use GTK::Widget;

our subset LabelAncestry is export where GtkLabel | WidgetAncestry;

class GTK::Label is GTK::Widget {
  has GtkLabel $!l is implementor;

  method bless(*%attrinit) {
    my $o = self.CREATE.BUILDALL(Empty, %attrinit);
    $o.setType($o.^name);
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

  method GTK::Raw::Definitions::GtkLabel
    is also<
      Label
      GtkLabel
    >
  { $!l }

  multi method new (GTK::Widget $label) {
    samewith($label.Widget);
  }
  multi method new (LabelAncestry $label, :$ref = True) {
    return Nil unless $label;

    my $o = self.bless(:$label);
    $o.ref if $ref;
    $o;
  }
  multi method new ($text is copy = Str) {
    $text .= Str if $text && $text.^can('Str').elems;

    die "Cannot create a label from a { $text.^name } object."
      unless $text ~~ Str;

    my $label = gtk_label_new($text);

    $label ?? self.bless(:$label) !! Nil;
  }

  method setLabel(LabelAncestry $label) {
    my $to-parent;
    $!l = do given $label {
      when GtkLabel  {
        $to-parent = cast(GtkWidget, $_);
        $_;
      }
      default {
        $to-parent = $_;
        cast(GtkLabel, $label);
      }
    };
    self.setWidget($to-parent);
  }

  method new_with_mnemonic ($text) is also<new-with-mnemonic> {
    my $label = gtk_label_new_with_mnemonic($text);

    $label ?? self.bless(:$label) !! Nil;
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
  method attributes (:$raw = False) is rw {
    Proxy.new(
      FETCH => sub ($) {
        my $al = gtk_label_get_attributes($!l);

        $al ??
          ( $raw ?? $al !! Pango::AttrList.new($al) )
          !!
          Nil;
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
        my uint32 $m = $mode;

        gtk_label_set_ellipsize($!l, $m);
      }
    );
  }

  method justify is rw {
    Proxy.new(
      FETCH => sub ($) {
        GtkJustificationEnum( gtk_label_get_justify($!l) );
      },
      STORE => sub ($, Int() $jtype is copy) {
        my uint32 $jt = $jtype;

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
        my gboolean $w = $wrap.so.Int;

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
        my uint32 $wm = $wrap_mode;

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
        my gint $l = $lines;

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
        my gint $nc = $n_chars;

        gtk_label_set_max_width_chars($!l, $n_chars);
      }
    );
  }

  method mnemonic_widget (:$raw = False, :$widget = False)
    is rw
    is also<mnemonic-widget>
  {
    Proxy.new(
      FETCH => sub ($) {
        my $w = gtk_label_get_mnemonic_widget($!l);

        self.ReturnWidget($w, $raw, $widget);
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
        my gboolean $s = $setting.so.Int;

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
        my gboolean $sl = $single_line_mode.so.Int;

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
        my gboolean $tl = $track_links.so.Int;

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
        my gboolean $s = $setting.so.Int;

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
        my gboolean $s = $setting.so.Int;

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
        my gint $nc = $n_chars;

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

  method get_layout (:$raw = False)
    is also<
      get-layout
      layout
    >
  {
    my $pl = gtk_label_get_layout($!l);

    $pl ??
      ( $raw ?? $pl !! Pango::Layout.new($pl) )
      !!
      Nil;
  }

  proto method get_layout_offsets (|)
    is also<get-layout-offsets>
  { * }

  multi method get_layout_offsets {
    samewith($, $);
  }
  multi method get_layout_offsets ($x is rw, $y is rw) {
    my gint ($xx, $yy) = 0 xx 2;

    gtk_label_get_layout_offsets($!l, $xx, $yy);
    ($x, $y) = ($xx, $yy);
  }

  method get_mnemonic_keyval is also<get-mnemonic-keyval> {
    gtk_label_get_mnemonic_keyval($!l);
  }

  proto method get_selection_bounds (|)
    is also<get-selection-bounds>
  { * }

  multi method get_selection_bounds {
    samewith($, $);
  }
  multi method get_selection_bounds ($start is rw, $end is rw) {
    my gint ($s, $e) = 0 xx 2;

    gtk_label_get_selection_bounds($!l, $s, $e);
    ($start, $end) = ($s, $e);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    GTK::Widget.unstable_get_type( &gtk_label_get_type, $n, $t);
  }

  method select_region (Int() $start_offset, Int() $end_offset)
    is also<select-region>
  {
    my gint ($so, $eo) = ($start_offset, $end_offset);

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
