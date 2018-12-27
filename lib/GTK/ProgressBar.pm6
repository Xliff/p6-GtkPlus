use v6.c;

use Method::Also;
use NativeCall;

use Pango::Raw::Types;

use GTK::Compat::Types;
use GTK::Raw::Label;
use GTK::Raw::ProgressBar;
use GTK::Raw::Types;

use GTK::Widget;

use GTK::Roles::Orientable;

my subset Ancestry
  where GtkProgressBar | GtkOrientable | GtkBuilder | GtkWidget;

class GTK::ProgressBar is GTK::Widget {
  also does GTK::Roles::Orientable;

  has GtkProgressBar $!bar;

  method bless(*%attrinit) {
    my $o = self.CREATE.BUILDALL(Empty, %attrinit);
    $o.setType('GTK::ProgressBar');
    $o;
  }

  submethod BUILD(:$bar) {
    my $to-parent;
    given $bar {
      when Ancestry {
        $!bar = do {
          when GtkProgressBar {
            $to-parent = nativecast(GtkProgressBar, $_);
            $_;
          }
          when GtkOrientable {
            $!or = $_;                                # GTK::Roles::Orientable
            $to-parent = nativecast(GtkProgressBar, $_);
            nativecast(GtkProgressBar, $_);
          }
          default {
            $to-parent = $_;
            nativecast(GtkProgressBar, $_);
          }
        };
        self.setWidget($to-parent);
      }
      when GTK::ProgressBar {
      }
      default {
      }
    }
    $!or = nativecast(GtkOrientable, $!bar);          # GTK::Roles::Orientable
  }

  multi method new (GtkWidget $bar) {
    my $o = self.bless(:$bar);
    $o.upref;
    $o;
  }
  multi method new {
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
      STORE => sub ($, Int() $mode is copy) {
        my uint32 $m = self.RESOLVE-UINT($mode);
        gtk_progress_bar_set_ellipsize($!bar, $m);
      }
    );
  }

  method fraction is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_progress_bar_get_fraction($!bar);
      },
      STORE => sub ($, Num() $fraction is copy) {
        my gdouble $f = $fraction;
        gtk_progress_bar_set_fraction($!bar, $f);
      }
    );
  }

  method inverted is rw {
    Proxy.new(
      FETCH => sub ($) {
        so gtk_progress_bar_get_inverted($!bar);
      },
      STORE => sub ($, Int() $inverted is copy) {
        my gboolean $i = self.RESOLVE-BOOL($inverted);
        gtk_progress_bar_set_inverted($!bar, $i);
      }
    );
  }

  method pulse_step is rw is also<pulse-step> {
    Proxy.new(
      FETCH => sub ($) {
        gtk_progress_bar_get_pulse_step($!bar);
      },
      STORE => sub ($, Num() $fraction is copy) {
        my gdouble $f = $fraction;
        gtk_progress_bar_set_pulse_step($!bar, $f);
      }
    );
  }

  method show_text is rw is also<show-text> {
    Proxy.new(
      FETCH => sub ($) {
        so gtk_progress_bar_get_show_text($!bar);
      },
      STORE => sub ($, Int() $show_text is copy) {
        my gboolean $st = self.RESOLVE-BOOL($show_text);
        gtk_progress_bar_set_show_text($!bar, $st);
      }
    );
  }

  method text is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_progress_bar_get_text($!bar);
      },
      STORE => sub ($, Str() $text is copy) {
        gtk_progress_bar_set_text($!bar, $text);
      }
    );
  }
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  method get_type is also<get-type> {
    gtk_progress_bar_get_type();
  }

  method pulse {
    gtk_progress_bar_pulse($!bar);
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
