use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::;
use GTK::Raw::Types;

use GTK::Bin;

class GTK::Expander is GTK::Bin {
  has GtkExpander $!e;

  submethod BUILD(:$expander) {
    my $to-parent;
    given $expander {
      when GtkExpander | GtkWidget {
        $!e = do {
          when GtkWidget {
            $to-parent = $_;
            nativecast(Gtk , $_);
          }
          when GtkExpander {
            $to-parent = nativecast(GtkBin, $_);
            $_;
          }
        }
        self.setBin($to-parent);
      }
      when GTK::Expander {
      }
      default {
      }
    }
    self.setType('GTK::Expander');
  }

  multi method new {
    my $expander = gtk_expander_new();
    self.bless(:$expander);
  }
  multi method new(Str() :$mnemonic) {
    my $expander = do {
      with $mnemonic.defined { gtk_expander_new_with_mnemonic($label); }
      else                   { gtk_expander_new(); }
    };
    self.bless(:$expander);
  }

  method new_with_mnemonic (Str() $label) {
    my $expander = gtk_expander_new_with_mnemonic($label);
    self.bless(:$expander);
  }

  # ↓↓↓↓ SIGNALS ↓↓↓↓

  # Is originally:
  # GtkExpander, gpointer --> void
  method activate {
    self.connect($!e, 'activate');
  }
  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  method expanded is rw {
    Proxy.new(
      FETCH => sub ($) {
        Bool( gtk_expander_get_expanded($!e) );
      },
      STORE => sub ($, $expanded is copy) {
        my gboolean $e = $expanded == 0 ?? 0 !! 1;
        gtk_expander_set_expanded($!e, $e);
      }
    );
  }

  method label is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_expander_get_label($!e);
      },
      STORE => sub ($, Str() $label is copy) {
        gtk_expander_set_label($!e, $label);
      }
    );
  }

  method label_fill is rw {
    Proxy.new(
      FETCH => sub ($) {
        Bool( gtk_expander_get_label_fill($!e) );
      },
      STORE => sub ($, $label_fill is copy) {
        my gboolean $lf = $label_fill == 0 ?? 0 !! 1;
        gtk_expander_set_label_fill($!e, $lf);
      }
    );
  }

  method label_widget is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_expander_get_label_widget($!e);
      },
      STORE => sub ($, $label_widget is copy) {
        my $lw = do given $label_widget {
          GtkWidget   { $_;      }
          GTK::Widget { .widget; }
        };
        gtk_expander_set_label_widget($!e, $lw);
      }
    );
  }

  method resize_toplevel is rw {
    Proxy.new(
      FETCH => sub ($) {
        Bool( gtk_expander_get_resize_toplevel($!e) );
      },
      STORE => sub ($, Int() $resize_toplevel is copy) {
        my gboolean $rt = $resize_toplevel == 0 ?? 0 !! 1;
        gtk_expander_set_resize_toplevel($!e, $rt);
      }
    );
  }

  # Was asked earlier, best method for handling gint is:
  # ($$int +& 0x7fff) * ($int < 0 ?? -1 !! 1);

  # Deprecated, and unused.
  #
  # method spacing is rw {
  #   Proxy.new(
  #     FETCH => sub ($) {
  #       gtk_expander_get_spacing($!e);
  #     },
  #     STORE => sub ($, Int $spacing is copy) {
  #
  #       gtk_expander_set_spacing($!e, $s);
  #     }
  #   );
  # }

  method use_markup is rw {
    Proxy.new(
      FETCH => sub ($) {
        Bool( gtk_expander_get_use_markup($!e) );
      },
      STORE => sub ($, Int() $use_markup is copy) {
        my goolean $um = $use_markup == 0 ?? 0 !! 1;
        gtk_expander_set_use_markup($!e, $um);
      }
    );
  }

  method use_underline is rw {
    Proxy.new(
      FETCH => sub ($) {
        Bool( gtk_expander_get_use_underline($!e) );
      },
      STORE => sub ($, Int() $use_underline is copy) {
        my gboolean $uu = $use_underline == 0 ?? 0 !! 1
        gtk_expander_set_use_underline($!e, $uu);
      }
    );
  }
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  method get_type {
    gtk_expander_get_type();
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
