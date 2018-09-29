use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::Expander;
use GTK::Raw::Types;

use GTK::Bin;

class GTK::Expander is GTK::Bin {
  has GtkExpander $!e;

  method bless(*%attrinit) {
    use nqp;
    my $o = nqp::create(self).BUILDALL(Empty, %attrinit);
    $o.setType('GTK::Expander');
    $o;
  }

  submethod BUILD(:$expander) {
    my $to-parent;
    given $expander {
      when GtkExpander | GtkWidget {
        $!e = do {
          when GtkWidget {
            $to-parent = $_;
            nativecast(GtkExpander, $_);
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
  }

  multi method new (Str $label) {
    my $expander = gtk_expander_new($label);
    self.bless(:$expander);
  }
  multi method new (GtkWidget $expander) {
    self.bless($expander);
  }
  multi method new (Str $label, :$mnemonic) {
    my $expander = do {
      with $mnemonic { gtk_expander_new_with_mnemonic($label); }
      else           { gtk_expander_new($label); }
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
        so gtk_expander_get_expanded($!e);
      },
      STORE => sub ($, $expanded is copy) {
        my gboolean $e = self.RESOLVE-BOOL($expanded);
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
        so gtk_expander_get_label_fill($!e);
      },
      STORE => sub ($, Int() $label_fill is copy) {
        my gboolean $lf = self.RESOLVE-BOOL($label_fill);
        gtk_expander_set_label_fill($!e, $lf);
      }
    );
  }

  method label_widget is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_expander_get_label_widget($!e);
      },
      STORE => sub ($, GtkWidget() $label_widget is copy) {
        gtk_expander_set_label_widget($!e, $label_widget);
      }
    );
  }

  method resize_toplevel is rw {
    Proxy.new(
      FETCH => sub ($) {
        so gtk_expander_get_resize_toplevel($!e);
      },
      STORE => sub ($, Int() $resize_toplevel is copy) {
        my gboolean $rt = self.RESOLVE-BOOL($resize_toplevel);
        gtk_expander_set_resize_toplevel($!e, $rt);
      }
    );
  }

  # Deprecated, and unused.
  #
  # method spacing is rw {
  #   Proxy.new(
  #     FETCH => sub ($) {
  #       gtk_expander_get_spacing($!e);
  #     },
  #     STORE => sub ($, Int() $spacing is copy) {
  #       gtk_expander_set_spacing($!e, $s);
  #     }
  #   );
  # }

  method use_markup is rw {
    Proxy.new(
      FETCH => sub ($) {
        so gtk_expander_get_use_markup($!e);
      },
      STORE => sub ($, Int() $use_markup is copy) {
        my gboolean $um = self.RESOLVE-BOOL($use_markup);
        gtk_expander_set_use_markup($!e, $um);
      }
    );
  }

  method use_underline is rw {
    Proxy.new(
      FETCH => sub ($) {
        so gtk_expander_get_use_underline($!e);
      },
      STORE => sub ($, Int() $use_underline is copy) {
        my gboolean $uu = self.RESOLVE-BOOL($use_underline);
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
