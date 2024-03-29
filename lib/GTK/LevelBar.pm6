use v6.c;

use Method::Also;

use GTK::Raw::LevelBar:ver<3.0.1146>;
use GTK::Raw::Types:ver<3.0.1146>;

use GTK::Widget:ver<3.0.1146>;

use GTK::Roles::Orientable:ver<3.0.1146>;

our subset LevelBarAncestry is export
  where GtkLevelBar | GtkOrientable | GtkWidgetAncestry;

class GTK::LevelBar:ver<3.0.1146> is GTK::Widget {
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
            $to-parent = cast(GtkWidget, $_);
            $_;
          }
          when GtkOrientable {
            $!or = $_;                              # GTK::Roles::Orientable
            $to-parent = cast(GtkWidget, $_);
            cast(GtkLevelBar, $_);
          }
          default {
            $to-parent = $_;
            cast(GtkLevelBar, $_);
          }
        };
        $!or //= cast(GtkOrientable, $!lb);   # GTK::Roles::Orientable
        self.setWidget($to-parent);
      }
      when GTK::LevelBar {
      }
      default {
      }
    }
  }

  method GTK::Raw::Definitions::GtkLevelBar
    is also<
      LevelBar
      GtkLevelBar
    >
  { $!lb }

  multi method new (LevelBarAncestry $level, :$ref = True) {
    return Nil unless $level;

    my $o = self.bless(:$level);
    $o.ref if $ref;
    $o;
  }
  multi method new {
    my $level = gtk_level_bar_new();

    $level ?? self.bless(:$level) !! Nil;
  }

  method new_for_interval (Num() $max_value) is also<new-for-interval> {
    my gdouble $mv = $max_value;
    my $level = gtk_level_bar_new_for_interval($!lb, $mv);

    $level ?? self.bless(:$level) !! Nil;
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
        my gboolean $i = $inverted.so.Int;

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
        my gdouble $v = $value.so.Int;

        gtk_level_bar_set_min_value($!lb, $v);
      }
    );
  }

  method mode is rw {
    Proxy.new(
      FETCH => sub ($) {
        GtkLevelBarModeEnum( gtk_level_bar_get_mode($!lb) );
      },
      STORE => sub ($, Int() $mode is copy) {
        my guint32 $m = $mode;

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

  proto method get_offset_value (|)
    is also<get-offset-value>
  { * }

  multi method get_offset_value (Str() $name) {
    my $o = callwith($name, $, :all);

    $o ?? $o[1] !! Nil;
  }
  multi method get_offset_value (Str $name, $value is rw, :$all = False) {
    my gdouble $v = 0e0;

    my $rv = gtk_level_bar_get_offset_value($!lb, $name, $v);
    $value = $v;

    $all.not ?? $rv !! ($rv, $value);
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
