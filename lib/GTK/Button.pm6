use v6.c;

use NativeCall;

use GTK::Bin;

use GTK::Raw::Button;
use GTK::Raw::Types;

class GTK::Button is GTK::Bin {

  has GtkButton $!b;

  submethod BUILD(:$button) {
    $!b = $button ~~ GtkButton ?? $button !! nativecast(GtkButton, $button)
  }

  multi method new {
    my $button = gtk_button_new();
    nextwith(:$button);
  }

  multi method new(:$button) {
    self.bless(
      :$button,
      :bin($button),
      :container($button),
      :widget($button)
    );
  }

  method new_with_mnemonic (GTK::Button:U: gchar $label) {
    my $button = gtk_button_new_with_mnemonic($label);
    self.bless(:$button, :bin($button), :container($button), :widget($button))
  }

  method new_from_icon_name (GTK::Button:U: gchar $icon_name, GtkIconSize $size) {
    gtk_button_new_from_icon_name($icon_name, $size);
  }

  method new_from_stock (GTK::Button:U: gchar $stock_id) {
    gtk_button_new_from_stock($stock_id);
  }

  method new_with_label (GTK::Button:U: gchar $label) {
    gtk_button_new_with_label($label);
  }

  # Renamed from "clicked" due to conflict with the signal.
  method button-clicked {
    gtk_button_clicked($!b);
  }

  method get_alignment (gfloat $xalign, gfloat $yalign) {
    gtk_button_get_alignment($!b, $xalign, $yalign);
  }

  method get_event_window {
    gtk_button_get_event_window($!b);
  }

  # Used for type checking at the C level.
  #method get_type () {
  #  gtk_button_get_type();
  #}


  method set_alignment (gfloat $xalign, gfloat $yalign) {
    gtk_button_set_alignment($!b, $xalign, $yalign);
  }

  method always_show_image is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_button_get_always_show_image($!b);
      },
      STORE => sub ($, $always_show is copy) {
        gtk_button_set_always_show_image($!b, $always_show);
      }
    );
  }

  method focus_on_click is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_button_get_focus_on_click($!b);
      },
      STORE => sub ($, $focus_on_click is copy) {
        gtk_button_set_focus_on_click($!b, $focus_on_click);
      }
    );
  }

  method image is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_button_get_image($!b);
      },
      STORE => sub ($, $image is copy) {
        gtk_button_set_image($!b, $image);
      }
    );
  }

  method image_position is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_button_get_image_position($!b);
      },
      STORE => sub ($, $position is copy) {
        gtk_button_set_image_position($!b, $position);
      }
    );
  }

  method label is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_button_get_label($!b);
      },
      STORE => sub ($, $label is copy) {
        gtk_button_set_label($!b, $label);
      }
    );
  }

  method relief is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_button_get_relief($!b);
      },
      STORE => sub ($, $relief is copy) {
        gtk_button_set_relief($!b, $relief);
      }
    );
  }

  method use_stock is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_button_get_use_stock($!b);
      },
      STORE => sub ($, $use_stock is copy) {
        gtk_button_set_use_stock($!b, $use_stock);
      }
    );
  }

  method use_underline is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_button_get_use_underline($!b);
      },
      STORE => sub ($, $use_underline is copy) {
        gtk_button_set_use_underline($!b, $use_underline);
      }
    );
  }

  # Signal void Action
  method activate {
    self.connect($!b, 'activate');
  }

  # Signal void Action
  method clicked {
    self.connect($!b, 'clicked');
  }

  # Signal void Run First
  method enter {
    self.connect($!b, 'enter');
  }

  # Signal void Run First
  method leave {
    self.connect($!b, 'leave');
  }

  # Signal void Run First
  method pressed {
    self.connect($!b, 'pressed');
  }

  # Signal void Run First
  method released {
    self.connect($!b, 'released');
  }
}
