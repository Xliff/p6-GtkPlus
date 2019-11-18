use v6.c;

use Method::Also;
use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::LevelBar;
use GTK::Raw::Types;

use GTK::Widget;

use GTK::Roles::Orientable;

our subset LevelBarAncestry is export 
  where GtkLevelBar | GtkOrientable | WidgetAncestry;

class GTK::LevelBar is GTK::Widget {
  also does GTK::Roles::Orientable;

  has GtkLevelBar $!lb is implementor;

  method bless(*%attrinit) {
    my $o = self.CREATE.BUILDALL(Empty, %attrinit);
    $o.setType($o.^name);
    $o;
  }

  submethod BUILD(:$level) {
    my $to-parent;
    given $level {
      when LevelBarAncestry {
        $!lb = do {
          when GtkLevelBar {
            $to-parent = nativecast(GtkWidget, $_);
            $_;
          }
          when GtkOrientable {
            $!or = $_;                              # GTK::Roles::Orientable
            $to-parent = nativecast(GtkWidget, $_);
            nativecast(GtkLevelBar, $_);
          }
          default {
            $to-parent = $_;
            nativecast(GtkLevelBar, $_);
          }
        };
        $!or //= nativecast(GtkOrientable, $!lb);   # GTK::Roles::Orientable
        self.setWidget($to-parent);
      }
      when GTK::LevelBar {
      }
      default {
      }
    }
  }
  
  method GTK::Raw::Types::GtkLevelBar is also<LevelBar> { $!lb }

  multi method new (LevelBarAncestry $level) {
    my $o = self.bless(:$level);
    $o.upref;
    $o;
  }
  multi method new {
    my $level = gtk_level_bar_new();
    self.bless(:$level);
  }

  method new_for_interval (Num() $max_value) is also<new-for-interval> {
    my gdouble $mv = $max_value;
    my $level = gtk_level_bar_new_for_interval($!lb, $mv);
    self.bless(:$level);
  }

  # ↓↓↓↓ SIGNALS ↓↓↓↓

  # Is originally:
  # GtkLevelBar, gchar, gpointer --> void
  method offset-changed is also<offset_changed> {
    self.connect-string($!lb, 'offset-changed');
  }

  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  method inverted is rw {
    Proxy.new(
      FETCH => sub ($) {
        so gtk_level_bar_get_inverted($!lb);
      },
      STORE => sub ($, Int() $inverted is copy) {
        my gboolean $i = self.RESOLVE-BOOL($inverted);
        gtk_level_bar_set_inverted($!lb, $i);
      }
    );
  }

  method max_value is rw is also<max-value> {
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

  method min_value is rw is also<min-value> {
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
      STORE => sub ($, Int() $mode is copy) {
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
  method get_offset_value (Str $name, Num() $value)
    is also<get-offset-value>
  {
    my gdouble $v = $value;
    gtk_level_bar_get_offset_value($!lb, $name, $v);
  }

  method get_type is also<get-type> {
    state ($n, $t);
    GTK::Widget.unstable_get_type( &gtk_level_bar_get_type, $n, $t );
  }

  method add_offset_value(Str() $name, Num() $value)
    is also<add-offset-value>
  {
    my gdouble $v = $value;
    gtk_level_bar_add_offset_value($!lb, $name, $v);
  }

  method remove_offset_value(Str() $name) is also<remove-offset-value> {
    gtk_level_bar_remove_offset_value($!lb, $name);
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
