use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::Button;
use GTK::Raw::Types;

use GTK::Bin;

class GTK::Button is GTK::Bin {
  has GtkButton $!b;

  method bless(*%attrinit) {
    use nqp;
    my $o = nqp::create(self).BUILDALL(Empty, %attrinit);
    $o.setType('GTK::Button');
    $o;
  }

  submethod BUILD(:$button) {
    given $button {
      when GtkButton | GtkWidget {
        self.setButton($button);
      }
      when GTK::Button {
        my $c = ::?CLASS.^name;
        warn "To copy a { $c } object, use { $c }.clone.";
      }
      default {
        # Throw exception here
      }
    }
  }

  method setButton($button) {
    my $to-parent;
    $!b = do given $button {
      when GtkWidget {
        $to-parent = $_;
        nativecast(GtkButton, $_);
      }
      when GtkButton {
        $to-parent = nativecast(GtkBin, $_);
        $_;
      }
    };
    self.setBin($button);
  }

  multi method new {
    my $button = gtk_button_new();
    self.bless(:$button);
  }

  multi method new(GtkWidget :$button) {
    self.bless(:$button);
  }

  method new_with_mnemonic (GTK::Button:U: gchar $label) {
    my $button = gtk_button_new_with_mnemonic($label);
    self.bless(:$button, :bin($button), :container($button), :widget($button))
  }

  method new_from_icon_name (GTK::Button:U: gchar $icon_name, GtkIconSize $size) {
    my $button = gtk_button_new_from_icon_name($icon_name, $size);
    self.bless(:$button);
  }

  method new_from_stock (GTK::Button:U: gchar $stock_id) {
    my $button = gtk_button_new_from_stock($stock_id);
    self.bless(:$button);
  }

  method new_with_label (GTK::Button:U: gchar $label) {
    my $button = gtk_button_new_with_label($label);
    self.bless(:$button);
  }

  # Renamed from "clicked" due to conflict with the signal.
  method emit-clicked {
    gtk_button_clicked($!b);
  }

  multi method get_alignment (Num() $xalign is rw, Num() $yalign is rw)
    is DEPRECATED
  {
    my gfloat ($xa, $ya) = ($xalign, $yalign);
    my $rc = gtk_button_get_alignment($!b, $xa, $ya);
    ($xalign, $yalign) = ($xa, $ya);
    $rc;
  }
  multi method get_alignment is DEPRECATED {
    my ($x, $y);
    samewith($x, $y);
    ($x, $y);
  }

  method get_event_window {
    gtk_button_get_event_window($!b);
  }

  # Used for type checking at the C level.
  #method get_type () {
  #  gtk_button_get_type();
  #}


  method set_alignment (Num() $xalign, Num() $yalign) {
    my gfloat ($xa, $ya) = ($xalign, $yalign);
    gtk_button_set_alignment($!b, $xalign, $yalign);
  }

  method always_show_image is rw {
    Proxy.new(
      FETCH => sub ($) {
        Bool( gtk_button_get_always_show_image($!b) );
      },
      STORE => sub ($, Int() $always_show is copy) {
        my gboolean $as = self.RESOLVE-BOOL($always_show);
        gtk_button_set_always_show_image($!b, $as);
      }
    );
  }

  method focus_on_click is rw {
    Proxy.new(
      FETCH => sub ($) {
        Bool( gtk_button_get_focus_on_click($!b) );
      },
      STORE => sub ($, Int() $focus_on_click is copy) {
        my gboolean $fc = self.RESOLVE-BOOL($focus_on_click);
        gtk_button_set_focus_on_click($!b, $fc);
      }
    );
  }

  method image is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_button_get_image($!b);
      },
      STORE => sub ($, GtkWidget() $image is copy) {
        gtk_button_set_image($!b, $image);
      }
    );
  }

  method image_position is rw {
    Proxy.new(
      FETCH => sub ($) {
        GtkPositionType( gtk_button_get_image_position($!b) );
      },
      STORE => sub ($, Int() $position is copy) {
        my uint32 $p = self.RESOLVE-UINT($position);
        gtk_button_set_image_position($!b, $p);
      }
    );
  }

  method label is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_button_get_label($!b);
      },
      STORE => sub ($, gchar $label is copy) {
        gtk_button_set_label($!b, $label);
      }
    );
  }

  method relief is rw {
    Proxy.new(
      FETCH => sub ($) {
        GtkReliefStyle( gtk_button_get_relief($!b) );
      },
      STORE => sub ($, Int() $relief is copy) {
        my uint32 $r = self.RESOLVE-UINT($relief);
        gtk_button_set_relief($!b, $r);
      }
    );
  }

  method use_stock is rw {
    Proxy.new(
      FETCH => sub ($) {
        Bool( gtk_button_get_use_stock($!b) );
      },
      STORE => sub ($, Int() $use_stock is copy) {
        my gboolean $us = self.RESOLVE-BOOL($use_stock);
        gtk_button_set_use_stock($!b, $us);
      }
    );
  }

  method use_underline is rw {
    Proxy.new(
      FETCH => sub ($) {
        Bool( gtk_button_get_use_underline($!b) );
      },
      STORE => sub ($, $use_underline is copy) {
        my gboolean $uu = self.RESOLVE-BOOL($use_underline);
        gtk_button_set_use_underline($!b, $use_underline);
      }
    );
  }

  # Is originally:
  # GtkButton, gpointer --> void
  method activate {
    self.connect($!b, 'activate');
  }

  # Is originally:
  # GtkButton, gpointer --> void
  method clicked {
    self.connect($!b, 'clicked');
  }

  # Is originally:
  # GtkButton, gpointer --> void
  method enter {
    self.connect($!b, 'enter');
  }

  # Is originally:
  # GtkButton, gpointer --> void
  method leave {
    self.connect($!b, 'leave');
  }

  # Is originally:
  # GtkButton, gpointer --> void
  method pressed {
    self.connect($!b, 'pressed');
  }

  # Is originally:
  # GtkButton, gpointer --> void
  method released {
    self.connect($!b, 'released');
  }

}
