use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::LevelBar;
use GTK::Raw::Types;

use GTK::Widget;

use GTK::Roles::Orientable;

class GTK::LevelBar is GTK::Widget {
  also does GTK::Roles::Orientable;

  has GtkLevelBar $!lb;

  method bless(*%attrinit) {
    my $o = self.CREATE.BUILDALL(Empty, %attrinit);
    $o.setType('GTK::LevelBar');
    $o;
  }

  submethod BUILD(:$level) {
    my $to-parent;
    given $level {
      when GtkLevelBar | GtkWidget {
        $!lb = do {
          when GtkWidget   {
            $to-parent = $_;
            nativecast(GtkLevelBar, $_);
          }
          when GtkLevelBar {
            $to-parent = nativecast(GtkWidget, $_);
            $_;
          }
        };
        self.setWidget($to-parent);
      }
      when GTK::LevelBar {
      }
      default {
      }
    }
    # For GTK::Roles::Orientable
    $!or = nativecast(GtkOrientable, $!lb);
  }

  multi method new {
    my $level = gtk_level_bar_new();
    self.bless(:$level);
  }
  multi method new (GtkWidget $level) {
    self.bless(:$level);
  }

  method new_for_interval (Num() $max_value) {
    my gdouble $mv = $max_value;
    my $level = gtk_level_bar_new_for_interval($!lb, $mv);
    self.bless(:$level);
  }

  # ↓↓↓↓ SIGNALS ↓↓↓↓

  # Is originally:
  # GtkLevelBar, gchar, gpointer --> void
  method offset-changed {
    self.connect-string($!lb, 'offset-changed');
  }

  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  method inverted is rw {
    Proxy.new(
      FETCH => sub ($) {
        so gtk_level_bar_get_inverted($!lb);
      },
      STORE => sub ($, $inverted is copy) {
        my gboolean $i = self.RESOLVE-BOOL($inverted);
        gtk_level_bar_set_inverted($!lb, $i);
      }
    );
  }

  method max_value is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_level_bar_get_max_value($!lb);
      },
      STORE => sub ($, Num() $value is copy) {
        my gdouble $v = $value;
        gtk_level_bar_set_max_value($!lb, $v);
      }
    );
  }

  method min_value is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_level_bar_get_min_value($!lb);
      },
      STORE => sub ($, Num() $value is copy) {
        my gdouble $v = $value;
        gtk_level_bar_set_min_value($!lb, $v);
      }
    );
  }

  method mode is rw {
    Proxy.new(
      FETCH => sub ($) {
        GtkLevelBarMode( gtk_level_bar_get_mode($!lb) );
      },
      STORE => sub ($, $mode is copy) {
        my guint32 $m = self.RESOLVE-uint($mode);
        gtk_level_bar_set_mode($!lb, $m);
      }
    );
  }

  method value is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_level_bar_get_value($!lb);
      },
      STORE => sub ($, Num() $value is copy) {
        my gdouble $v = $value;
        gtk_level_bar_set_value($!lb, $v);
      }
    );
  }
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  method get_offset_value (gchar $name, Num() $value) {
    my gdouble $v = $value;
    gtk_level_bar_get_offset_value($!lb, $name, $v);
  }

  method get_type {
    gtk_level_bar_get_type();
  }

  method add_offset_value(Str() $name, Num() $value) {
    my gdouble $v = $value;
    gtk_level_bar_add_offset_value($!lb, $name, $v);
  }

  method remove_offset_value(Str() $name) {
    gtk_level_bar_remove_offset_value($!lb, $name);
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
