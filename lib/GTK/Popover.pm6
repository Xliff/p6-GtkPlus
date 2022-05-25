use v6.c;

use Method::Also;

use GTK::Raw::Popover:ver<3.0.1146>;
use GTK::Raw::Types:ver<3.0.1146>;

use GTK::Bin:ver<3.0.1146>;

our subset GtkPopoverAncestry is export of Mu
  when GtkPopover | GtkBinAncestry;

class GTK::Popover:ver<3.0.1146> is GTK::Bin {
  has GtkPopover $!p is implementor;

  method bless(*%attrinit) {
    my $o = self.CREATE.BUILDALL(Empty, %attrinit);
    $o.setType($o.^name);
    $o;
  }

  submethod BUILD( :$gtk-popover ) {
    self.setGtkPopover($gtk-popover) if $gtk-popover;
  }

  method GTK::Raw::Definitions::GtkPopover
    is also<
      Popover
      GtkPopover
    >
  { $!p }

  method setGtkPopover(GtkPopoverAncestry $_) {
    my $to-parent;

    $!p = do  {
      when GtkPopover {
        $to-parent = cast(GtkBin, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GtkPopover, $_);
      }

    }
    self.setGtkBin($to-parent);
  }

  multi method new (GtkPopoverAncestry $gtk-popover, :$ref = True, *%others) {
    return Nil unless $gtk-popover;

    my $o = self.bless( :$gtk-popover, |%others );
    $o.ref if $ref;
    $o;
  }
  multi method new (*%others) {
    self.new_relative_to(GtkWidget, |%others);
  }

  method new_relative_to(GtkWidget() $relative, *%others)
    is also<new-relative-to>
  {
    my $gtk-popover = gtk_popover_new($relative);

    $gtk-popover ?? self.bless(:$gtk-popover, |%others) !! Nil;
  }

  method new_from_model (GtkWidget() $relative, GMenuModel $model, *%others)
    is also<new-from-model>
  {
    my $gtk-popover = gtk_popover_new_from_model($relative, $model);

    $gtk-popover ?? self.bless(:$gtk-popover, |%others) !! Nil;
  }

  # ↓↓↓↓ SIGNALS ↓↓↓↓

  # Is originally:
  # GtkPopover, gpointer --> void
  method closed {
    self.connect($!p, 'closed');
  }
  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  method constrain_to is rw is also<constrain-to> {
    Proxy.new(
      FETCH => sub ($) {
        GtkPopoverConstraintEnum( gtk_popover_get_constrain_to($!p) );
      },
      STORE => sub ($, Int() $constraint is copy) {
        my uint32 $c = $constraint;

        gtk_popover_set_constrain_to($!p, $c);
      }
    );
  }

  method default_widget (:$raw = False, :$widget = False)
    is rw is also<default-widget>
  {
    Proxy.new(
      FETCH => sub ($) {
        my $w = gtk_popover_get_default_widget($!p);

        self.ReturnWidget($w, $raw, $widget);
      },
      STORE => sub ($, GtkWidget() $widget is copy) {
        gtk_popover_set_default_widget($!p, $widget);
      }
    );
  }

  method modal is rw {
    Proxy.new(
      FETCH => sub ($) {
        so gtk_popover_get_modal($!p);
      },
      STORE => sub ($, Int() $modal is copy) {
        my gboolean $m = $modal.so.Int;

        gtk_popover_set_modal($!p, $m);
      }
    );
  }

  method position is rw {
    Proxy.new(
      FETCH => sub ($) {
        GtkPositionTypeEnum( gtk_popover_get_position($!p) );
      },
      STORE => sub ($, Int() $position is copy) {
        my uint32 $p = $position;

        gtk_popover_set_position($!p, $p);
      }
    );
  }

  method relative_to (:$raw = False, :$widget = False)
    is rw is also<relative-to>
  {
    Proxy.new(
      FETCH => sub ($) {
        my $w = gtk_popover_get_relative_to($!p);

        self.ReturnWidget($w, $raw, $widget);
      },
      STORE => sub ($, GtkWidget() $relative_to is copy) {
        gtk_popover_set_relative_to($!p, $relative_to);
      }
    );
  }

  method transitions_enabled is rw is also<transitions-enabled> {
    Proxy.new(
      FETCH => sub ($) {
        so gtk_popover_get_transitions_enabled($!p);
      },
      STORE => sub ($, Int() $transitions_enabled is copy) {
        my gboolean $te = $transitions_enabled.so.Int;

        gtk_popover_set_transitions_enabled($!p, $te);
      }
    );
  }
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  method bind_model (GMenuModel() $model, Str() $action_namespace)
    is also<bind-model>
  {
    gtk_popover_bind_model($!p, $model, $action_namespace);
  }

  method get_pointing_to (GdkRectangle() $rect) is also<get-pointing-to> {
    gtk_popover_get_pointing_to($!p, $rect);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    GTK::Widget.unstable_get_type( &gtk_popover_get_type, $n, $t );
  }

  method popdown {
    gtk_popover_popdown($!p);
  }

  method popup {
    gtk_popover_popup($!p);
  }

  method set_pointing_to (GdkRectangle() $rect) is also<set-pointing-to> {
    gtk_popover_set_pointing_to($!p, $rect);
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
