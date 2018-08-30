use v6.c;

use GTK::Compat::Types;
use GTK::Raw::Label;
use GTK::Raw::Types;

use GTK::Widget;

class GTK::Label is GTK::Widget {
  has $!l;

  submethod BUILD(:$label) {
    given $label {
      when GtkLabel | GtkWidget {
        $!l = do {
          when GtkLabel  { $label; }
          when GtkWidget { nativecast(GtkLabel,$label); }
        };
        self.setWidget($label);
      }
      when GTK::Label {
      }
      default {
      }
    }
  }

  method new($text = Str) {
    my $label = gtk_label_new($text);
    self.bless(:$label);
  }

  method setLabel($label) {
    self.setWidget( $!l = nativecast(GtkLabel, $label) );
  }

  method new_with_mnemonic ($text) {
    my $label = gtk_label_new_with_mnemonic($text);
    self.bless(:$label);
  }

  # Signals
  method activate-current-link {
    self.connect($!l, 'activate-current-link');
  }

  method activate-link {
    self.connect($!l, 'activate-link');
  }

  method copy-clipboard {
    self.connect($!l, 'copy-clipboard');
  }

  method move-cursor {
    self.connect($!l, 'move-cursor');
  }

  method popupate-popup {
    self.connect($!l, 'populate-popup');
  }

  ## Properties.

  method angle is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_label_get_angle($!l);
      },
      STORE => sub ($, $angle is copy) {
        gtk_label_set_angle($!l, $angle);
      }
    );
  }

  method attributes is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_label_get_attributes($!l);
      },
      STORE => sub ($, $attrs is copy) {
        gtk_label_set_attributes($!l, $attrs);
      }
    );
  }

  method ellipsize is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_label_get_ellipsize($!l);
      },
      STORE => sub ($, $mode is copy) {
        gtk_label_set_ellipsize($!l, $mode);
      }
    );
  }

  method justify is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_label_get_justify($!l);
      },
      STORE => sub ($, $jtype is copy) {
        gtk_label_set_justify($!l, $jtype);
      }
    );
  }

  method label is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_label_get_label($!l);
      },
      STORE => sub ($, $str is copy) {
        gtk_label_set_label($!l, $str);
      }
    );
  }

  method line_wrap is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_label_get_line_wrap($!l);
      },
      STORE => sub ($, $wrap is copy) {
        gtk_label_set_line_wrap($!l, $wrap);
      }
    );
  }

  method line_wrap_mode is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_label_get_line_wrap_mode($!l);
      },
      STORE => sub ($, $wrap_mode is copy) {
        gtk_label_set_line_wrap_mode($!l, $wrap_mode);
      }
    );
  }

  method lines is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_label_get_lines($!l);
      },
      STORE => sub ($, $lines is copy) {
        gtk_label_set_lines($!l, $lines);
      }
    );
  }

  method max_width_chars is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_label_get_max_width_chars($!l);
      },
      STORE => sub ($, $n_chars is copy) {
        gtk_label_set_max_width_chars($!l, $n_chars);
      }
    );
  }

  method mnemonic_widget is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_label_get_mnemonic_widget($!l);
      },
      STORE => sub ($, $widget is copy) {
        gtk_label_set_mnemonic_widget($!l, $widget);
      }
    );
  }

  method selectable is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_label_get_selectable($!l);
      },
      STORE => sub ($, $setting is copy) {
        gtk_label_set_selectable($!l, $setting);
      }
    );
  }

  method single_line_mode is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_label_get_single_line_mode($!l);
      },
      STORE => sub ($, $single_line_mode is copy) {
        gtk_label_set_single_line_mode($!l, $single_line_mode);
      }
    );
  }

  method text is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_label_get_text($!l);
      },
      STORE => sub ($, $str is copy) {
        gtk_label_set_text($!l, $str);
      }
    );
  }

  method track_visited_links is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_label_get_track_visited_links($!l);
      },
      STORE => sub ($, $track_links is copy) {
        gtk_label_set_track_visited_links($!l, $track_links);
      }
    );
  }

  method use_markup is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_label_get_use_markup($!l);
      },
      STORE => sub ($, $setting is copy) {
        gtk_label_set_use_markup($!l, $setting);
      }
    );
  }

  method use_underline is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_label_get_use_underline($!l);
      },
      STORE => sub ($, $setting is copy) {
        gtk_label_set_use_underline($!l, $setting);
      }
    );
  }

  method width_chars is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_label_get_width_chars($!l);
      },
      STORE => sub ($, $n_chars is copy) {
        gtk_label_set_width_chars($!l, $n_chars);
      }
    );
  }

  method xalign is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_label_get_xalign($!l);
      },
      STORE => sub ($, $xalign is copy) {
        gtk_label_set_xalign($!l, $xalign);
      }
    );
  }

  method yalign is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_label_get_yalign($!l);
      },
      STORE => sub ($, $yalign is copy) {
        gtk_label_set_yalign($!l, $yalign);
      }
    );
  }

  method get_current_uri {
    gtk_label_get_current_uri($!l);
  }

  method get_layout {
    gtk_label_get_layout($!l);
  }

  method get_layout_offsets (gint $x, gint $y) {
    gtk_label_get_layout_offsets($!l, $x, $y);
  }

  method get_mnemonic_keyval {
    gtk_label_get_mnemonic_keyval($!l);
  }

  method get_selection_bounds (gint $start, gint $end) {
    gtk_label_get_selection_bounds($!l, $start, $end);
  }

  method get_type {
    gtk_label_get_type();
  }

  method select_region (gint $start_offset, gint $end_offset) {
    gtk_label_select_region($!l, $start_offset, $end_offset);
  }

  method set_markup (gchar $str) {
    gtk_label_set_markup($!l, $str);
  }

  method set_markup_with_mnemonic (gchar $str) {
    gtk_label_set_markup_with_mnemonic($!l, $str);
  }

  method set_pattern (gchar $pattern) {
    gtk_label_set_pattern($!l, $pattern);
  }

  method set_text_with_mnemonic (gchar $str) {
    gtk_label_set_text_with_mnemonic($!l, $str);
  }

}
