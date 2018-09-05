use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::Popover;
use GTK::Raw::Types;

use GTK::Bin;

class GTK::Popover is GTK::Bin {
  has GtkPopover $!p;

  submethod BUILD(:$popover) {
      when GtkPopover | GtkWidget {
        self.setPopover($popover);
      when GTK::Popover {
      }
      default {
      }
    }
    self.setType('GTK::Popover');
  }

  method setPopover($popover) {
    my $to-parent;
    $!p = do given $popover {
      when GtkWidget {
        $to-parent = $_;
        nativecast(GtkPopover, $_);
      }
      when GtkPopover {
        $to-parent = nativecast(GtkBin, $_);
        $_;
      }
    }
    self.setBin($to-parent);
  }

  method new {
    my $popover = gtk_popover_new($!p);
    self.bless(:$popover);
  }

  method new_from_model (GMenuModel $model) {
    my $popover = gtk_popover_new_from_model($model);
    self.bless(:$popover);
  }

  # ↓↓↓↓ SIGNALS ↓↓↓↓

  # Is originally:
  # GtkPopover, gpointer --> void
  method closed {
    self.connect($!p, 'closed');
  }
  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  method constrain_to is rw {
    Proxy.new(
      FETCH => sub ($) {
        GtkPopoverConstraint( gtk_popover_get_constrain_to($!p) );
      },
      STORE => sub ($, Int() $constraint is copy) {
        my uint32 $c = $constraint +& 0xffff;
        gtk_popover_set_constrain_to($!p, $c);
      }
    );
  }

  method default_widget is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_popover_get_default_widget($!p);
      },
      STORE => sub ($, $widget is copy) {
        my $w = do given $widget {
          when GTK::Widget { .widget; }
          when GtkWidget   { $_;      }
          default {
            die "Invalid type { .^name } passed to { ::?CLASS }.default_widget";
          }
        }
        gtk_popover_set_default_widget($!p, $w);
      }
    );
  }

  method modal is rw {
    Proxy.new(
      FETCH => sub ($) {
        Bool( gtk_popover_get_modal($!p) );
      },
      STORE => sub ($, Int() $modal is copy) {
        my gboolean $m = $modal == 0 ?? 0 !! 1;
        gtk_popover_set_modal($!p, $m);
      }
    );
  }

  method position is rw {
    Proxy.new(
      FETCH => sub ($) {
        GtkPositionType( gtk_popover_get_position($!p) );
      },
      STORE => sub ($, Int() $position is copy) {
        my uint32 $p = $position +& 0xffff;
        gtk_popover_set_position($!p, $p);
      }
    );
  }

  method relative_to is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_popover_get_relative_to($!p);
      },
      STORE => sub ($, $relative_to is copy) {
        my $rt = do given $relative_to {
          when GTK::Widget { .widget };
          when GtkWidget   { $_      };
          default {
            die "Invalid type { .^name } passed to { ::?CLASS }.relative_to";
          }
        }
        gtk_popover_set_relative_to($!p, $rt);
      }
    );
  }

  method transitions_enabled is rw {
    Proxy.new(
      FETCH => sub ($) {
        Bool( gtk_popover_get_transitions_enabled($!p) );
      },
      STORE => sub ($, Int() $transitions_enabled is copy) {
        my gboolean $te = $transitions_enabled == 0 ?? 0 !! 1;
        gtk_popover_set_transitions_enabled($!p, $te);
      }
    );
  }
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  method bind_model (GMenuModel $model, gchar $action_namespace) {
    gtk_popover_bind_model($!p, $model, $action_namespace);
  }

  method get_pointing_to (GdkRectangle $rect) {
    gtk_popover_get_pointing_to($!p, $rect);
  }

  method get_type {
    gtk_popover_get_type();
  }

  method popdown {
    gtk_popover_popdown($!p);
  }

  method popup {
    gtk_popover_popup($!p);
  }

  method set_pointing_to (GdkRectangle $rect) {
    gtk_popover_set_pointing_to($!p, $rect);
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
