use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::LevelBar;
use GTK::Raw::Types;

use GTK::Widget;

class GTK::LevelBar is GTK::Widget {
  has Gtk $!lb;

  submethod BUILD(:$level) {
    given $level {
      when GtkLevelBar | GtkWidget {
        $!lb = do {
          when GtkWidget   { nativecast(GtkLevelBar, $level); }
          when GtkLevelBar { $level; }
        };
        self.setWidget($level);
      }
      when GTK::LevelBar {
      }
      default {
      }
    }
    self.setType('GTK::LevelBar');
  }

  method new () {
    my $level = gtk_level_bar_new();
    self.bless(:$level);
  }

  method new_for_interval (Num() $max_value) {
    my gdouble $mv = $max_value;
    my $level = gtk_level_bar_new_for_interval($!lb, $mv);
    self.bless(:$level);
  }

  # ↓↓↓↓ SIGNALS ↓↓↓↓
  method offset-changed {
    self.connect($!lb, 'offset-changed');
  }
  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  method inverted is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_level_bar_get_inverted($!lb);
      },
      STORE => sub ($, $inverted is copy) {
        gtk_level_bar_set_inverted($!lb, $inverted);
      }
    );
  }

  method max_value is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_level_bar_get_max_value($!lb);
      },
      STORE => sub ($, $value is copy) {
        gtk_level_bar_set_max_value($!lb, $value);
      }
    );
  }

  method min_value is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_level_bar_get_min_value($!lb);
      },
      STORE => sub ($, $value is copy) {
        gtk_level_bar_set_min_value($!lb, $value);
      }
    );
  }

  method mode is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_level_bar_get_mode($!lb);
      },
      STORE => sub ($, $mode is copy) {
        gtk_level_bar_set_mode($!lb, $mode);
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
        gtk_level_bar_set_value($!lb, $name);
      }
    );
  }
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  method get_offset_value (gchar $name, Num() $value) {
    my gdouble $v = $value;
    gtk_level_bar_get_offset_value($!lb, $name, $v);
  }

  method get_type () {
    gtk_level_bar_get_type();
  }

  method add_offset_value(Str $name, Num() $value) {
    my gdouble $v = $value;
    gtk_level_bar_add_offset_value($!lb, $name, $v);
  }

  method remove_offset_value(Str $name) {
    gtk_level_bar_remove_offset_value($!lb, $name);
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
