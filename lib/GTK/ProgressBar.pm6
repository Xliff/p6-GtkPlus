use v6.c;

use Method::Also;

use Pango::Raw::Types;

use GTK::Raw::Label:ver<3.0.1146>;
use GTK::Raw::ProgressBar:ver<3.0.1146>;
use GTK::Raw::Types:ver<3.0.1146>;

use GTK::Widget:ver<3.0.1146>;

use GTK::Roles::Orientable:ver<3.0.1146>;

our subset ProgressBarAncestry is export
  where GtkProgressBar | GtkOrientable | GtkWidgetAncestry;

class GTK::ProgressBar:ver<3.0.1146> is GTK::Widget {
  also does GTK::Roles::Orientable;

  has GtkProgressBar $!bar is implementor;

  method bless(*%attrinit) {
    my $o = self.CREATE.BUILDALL(Empty, %attrinit);
    $o.setType($o.^name);
    $o;
  }

  submethod BUILD(:$bar) {
    my $to-parent;
    given $bar {
      when ProgressBarAncestry {
        $!bar = do {
          when GtkProgressBar {
            $to-parent = cast(GtkProgressBar, $_);
            $_;
          }
          when GtkOrientable {
            $!or = $_;                                # GTK::Roles::Orientable
            $to-parent = cast(GtkProgressBar, $_);
            cast(GtkProgressBar, $_);
          }
          default {
            $to-parent = $_;
            cast(GtkProgressBar, $_);
          }
        };
        $!or //= cast(GtkOrientable, $!bar);    # GTK::Roles::Orientable
        self.setWidget($to-parent);
      }
      when GTK::ProgressBar {
      }
      default {
      }
    }
  }

  multi method new (ProgressBarAncestry $bar, :$ref = True) {
    my $o = self.bless(:$bar);
    $o.ref if $ref;
    $o;
  }
  multi method new {
    my $bar = gtk_progress_bar_new();

    $bar ?? self.bless(:$bar) !! Nil;
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
        my uint32 $m = $mode;

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
        my gboolean $i = $inverted.so.Int;

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
        my gboolean $st = $show_text.so.Int;

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
    state ($n, $t);
    GTK::Widget.unstable_get_type( &gtk_progress_bar_get_type, $n, $t );
  }

  method pulse {
    gtk_progress_bar_pulse($!bar);
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
