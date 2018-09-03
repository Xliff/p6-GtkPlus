use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::Label;
use GTK::Raw::ProgressBar;
use GTK::Raw::Types;

use GTK::Widget;

class GTK::ProgressBar is GTK::Widget {
  has GtkProgressBar $!bar;

  submethod BUILD(:$bar) {
    given $bar {
      when GtkProgressBar | GtkWidget {
        $!bar = do {
          when GtkWidget      { nativecast(GtkProgressBar, $bar); }
          when GtkProgressBar { $bar; }
        };
        self.setWidget($bar);
      }
      when GTK::ProgressBar {
      }
      default {
      }
    }
    self.setType('GTK::ProgressBar');
  }

  method new () {
    my $bar = gtk_progress_bar_new();
    self.bless(:$bar);
  }

  # ↓↓↓↓ SIGNALS ↓↓↓↓
  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  method ellipsize is rw {
    Proxy.new(
      FETCH => sub ($) {
        PangoEllipsizeMode( gtk_progress_bar_get_ellipsize($!bar) );
      },
      STORE => sub ($, $mode is copy) {
        my uint32 $m = do given $mode {
          when PangoEllipsizeMode { $mode.Int;      }
          when uint32             { $mode;          }
          when Int                { $mode +& 0xffff }
          default                 {
            die "Invalid type { $mode.^name } passed to GTK::ProgressBar.ellipsize!";
          }
        }

        gtk_progress_bar_set_ellipsize($!bar, $mode);
      }
    );
  }

  method fraction is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_progress_bar_get_fraction($!bar);
      },
      STORE => sub ($, $fraction is copy) {
        my gdouble $f = $fraction.Num;
        gtk_progress_bar_set_fraction($!bar, $f);
      }
    );
  }

  method inverted is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_progress_bar_get_inverted($!bar);
      },
      STORE => sub ($, $inverted is copy) {
        gtk_progress_bar_set_inverted($!bar, $inverted);
      }
    );
  }

  method pulse_step is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_progress_bar_get_pulse_step($!bar);
      },
      STORE => sub ($, $fraction is copy) {
        gtk_progress_bar_set_pulse_step($!bar, $fraction);
      }
    );
  }

  method show_text is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_progress_bar_get_show_text($!bar);
      },
      STORE => sub ($, $show_text is copy) {
        gtk_progress_bar_set_show_text($!bar, $show_text);
      }
    );
  }

  method text is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_progress_bar_get_text($!bar);
      },
      STORE => sub ($, $text is copy) {
        gtk_progress_bar_set_text($!bar, $text);
      }
    );
  }
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  method get_type () {
    gtk_progress_bar_get_type();
  }

  method pulse () {
    gtk_progress_bar_pulse($!bar);
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
