use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::AccelLabel;
use GTK::Raw::Types;

use GTK::Label;

class GTK::AccelLabel is GTK::Label {
  has GtkAccelLabel $!a1;

  submethod BUILD(:$alabel) {
    given $alabel {
      when GtkAccelLabel | GtkWidget {
        $!al = do {
          when GtkAccelLabel { $alabel; }
          when GtkWidget     { nativecast(GtkAccelLabel); }
        };
        self.setLabel($alabel);
      }
      when GTK::AccelLabel {
      }
      default {
      }
    }
  }

  method new {
    my $alabel = gtk_accel_label_new();
    self.bless(:$alabel);
  }

  # ↓↓↓↓ SIGNALS ↓↓↓↓
  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  method accel_widget is rw {
    Proxy.new(
      FETCH => sub ($) {
        # This should actually return a GTK::Widget, but again... we'd need
        # some way of identifying the type of widget. GTK may not provide this
        # information, so it is up to the caller to perform the necessary
        # acrobatics.
        gtk_accel_label_get_accel_widget($!al);
      },
      STORE => sub ($, $accel_widget is copy) {
        my $aw = do given $accel_widget {
          when GTK::Widget { $accel_widget.widget }
          when GtkWidget   { $accel_widget }
        };
        gtk_accel_label_set_accel_widget($!al, $aw);
      }
    );
  }
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  method get_accel (guint $accelerator_key, GdkModifierType $accelerator_mods is rw) {
    my uint32 $am = $accelerator_mods.Int;

    my $rc = gtk_accel_label_get_accel($!al, $accelerator_key, $am);
    $accelerator_mods = $am;
    $rc;
  }

  method get_accel_width {
    gtk_accel_label_get_accel_width($!al);
  }

  method get_type {
    gtk_accel_label_get_type();
  }

  method refetch {
    gtk_accel_label_refetch($!al);
  }

  method set_accel (guint $accelerator_key, GdkModifierType $accelerator_mods) {
    my uint32 $am = $accel_mods.Int;

    gtk_accel_label_set_accel($!al, $accelerator_key, $am);
  }

  method set_accel_closure (GClosure $accel_closure) {
    gtk_accel_label_set_accel_closure($!al, $accel_closure);
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
