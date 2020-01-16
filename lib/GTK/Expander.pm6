use v6.c;

use Method::Also;

use GTK::Raw::Expander;
use GTK::Raw::Types;

use GTK::Bin;
use GTK::Widget;

our subset ExpanderAncestry is export where GtkExpander | BinAncestry;

class GTK::Expander is GTK::Bin {
  has GtkExpander $!e is implementor;

  method bless(*%attrinit) {
    use nqp;
    my $o = nqp::create(self).BUILDALL(Empty, %attrinit);
    $o.setType($o.^name);
    $o;
  }

  submethod BUILD(:$expander) {
    my $to-parent;
    given $expander {
      when ExpanderAncestry {
        $!e = do {
          when GtkExpander {
            $to-parent = cast(GtkBin, $_);
            $_;
          }

          default {
            $to-parent = $_;
            cast(GtkExpander, $_);
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

  method GTK::Raw::Definitions::GtkExpander
    is also<
      Expander
      GtkExpander
    >
  { $!e }

  multi method new (ExpanderAncestry $expander) {
    return Nil unless $expander;

    my $o = self.bless(:$expander);
    $o.upref;
    $o;
  }
  multi method new (Str $label) {
    my $expander = gtk_expander_new($label);

    $expander ?? self.bless(:$expander) !! Nil;
  }
  multi method new (Str $label, :$mnemonic) {
    my $expander = do {
      with $mnemonic { gtk_expander_new_with_mnemonic($label); }
      else           { gtk_expander_new($label); }
    };

    $expander ?? self.bless(:$expander) !! Nil;
  }
  multi method new(|c) {
    die "No matching constructor for: ({ c.map( *.^name ).join(', ') })";
  }

  method new_with_mnemonic (Str() $label) is also<new-with-mnemonic> {
    my $expander = gtk_expander_new_with_mnemonic($label);

    $expander ?? self.bless(:$expander) !! Nil;
  }


  # ↓↓↓↓ SIGNALS ↓↓↓↓

  # Is originally:
  # GtkExpander, gpointer --> void
  method activate {
    self.connect($!e, 'activate');
  }

  method notify-expanded is also<notify_expanded> {
    self.connect-gparam($!e, 'notify::expanded');
  }
  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  method expanded is rw {
    Proxy.new(
      FETCH => sub ($) {
        so gtk_expander_get_expanded($!e);
      },
      STORE => sub ($, Int() $expanded is copy) {
        my gboolean $e = $expanded.so.Int;

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

  method label_fill is rw is also<label-fill> {
    Proxy.new(
      FETCH => sub ($) {
        so gtk_expander_get_label_fill($!e);
      },
      STORE => sub ($, Int() $label_fill is copy) {
        my gboolean $lf = $label_fill.so.Int;

        gtk_expander_set_label_fill($!e, $lf);
      }
    );
  }

  method label_widget (:$raw = False, :$widget = False)
    is rw
    is also<label-widget>
  {
    Proxy.new(
      FETCH => sub ($) {
        my $w = gtk_expander_get_label_widget($!e);

        ReturnWidget($w, $raw, $widget);
      },
      STORE => sub ($, GtkWidget() $label_widget is copy) {
        gtk_expander_set_label_widget($!e, $label_widget);
      }
    );
  }

  method resize_toplevel is rw is also<resize-toplevel> {
    Proxy.new(
      FETCH => sub ($) {
        so gtk_expander_get_resize_toplevel($!e);
      },
      STORE => sub ($, Int() $resize_toplevel is copy) {
        my gboolean $rt = $resize_toplevel.so.Int;

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

  method use_markup is rw is also<use-markup> {
    Proxy.new(
      FETCH => sub ($) {
        so gtk_expander_get_use_markup($!e);
      },
      STORE => sub ($, Int() $use_markup is copy) {
        my gboolean $um = $use_markup.so.Int;

        gtk_expander_set_use_markup($!e, $um);
      }
    );
  }

  method use_underline is rw is also<use-underline> {
    Proxy.new(
      FETCH => sub ($) {
        so gtk_expander_get_use_underline($!e);
      },
      STORE => sub ($, Int() $use_underline is copy) {
        my gboolean $uu = $use_underline.so.Int;

        gtk_expander_set_use_underline($!e, $uu);
      }
    );
  }
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  method get_type is also<get-type> {
    state ($n, $t);

    GTK::Widget.unstable_get_type( &gtk_expander_get_type, $n, $t );
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
