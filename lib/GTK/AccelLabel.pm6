use v6.c;

use Method::Also;
use NativeCall;


use GTK::Raw::AccelLabel;
use GTK::Raw::Types;

use GTK::Label;

our subset AccelLabelAncestry is export where GtkAccelLabel | LabelAncestry;

class GTK::AccelLabel is GTK::Label {
  has GtkAccelLabel $!al is implementor;

  method bless(*%attrinit) {
    my $o = self.CREATE.BUILDALL(Empty, %attrinit);
    $o.setType($o.^name);
    $o;
  }

  submethod BUILD(:$alabel) {
    my $to-parent;
    given $alabel {
      when AccelLabelAncestry {
        $!al = do {
          when GtkAccelLabel {
            $to-parent = nativecast(GtkLabel, $_);
            $_;
          }
          when LabelAncestry {
            $to-parent = $_;
            nativecast(GtkAccelLabel, $_);
          }
        };
        self.setLabel($to-parent);
      }
      when GTK::AccelLabel {
      }
      default {
      }
    }
  }

  multi method new (AccelLabelAncestry $alabel, :$ref = True) {
    return Nil unless $alabel;

    my $o = self.bless(:$alabel);
    $o.ref if $ref;
    $o;
  }
  multi method new (Str $label) {
    my $alabel = gtk_accel_label_new($label);

    $alabel ?? self.bless(:$alabel) !! Nil;
  }


  # ↓↓↓↓ SIGNALS ↓↓↓↓
  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  method accel_widget is rw is also<accel-widget> {
    Proxy.new(
      FETCH => sub ($) {
        # This should actually return a GTK::Widget, but again... we'd need
        # some way of identifying the type of widget. GTK may not provide this
        # information, so it is up to the caller to perform the necessary
        # acrobatics.
        gtk_accel_label_get_accel_widget($!al);
      },
      STORE => sub ($, GtkWidget() $accel_widget is copy) {
        gtk_accel_label_set_accel_widget($!al, $accel_widget);
      }
    );
  }
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  method get_accel (
    Int() $accelerator_key,
    Int() $accelerator_mods is rw
  )
    is also<get-accel>
  {
    my guint @u = ($accelerator_key, $accelerator_mods);
    my uint32 ($ak, $am) = self.RESOLVE-UINT(@u);
    my $rc = gtk_accel_label_get_accel($!al, $ak, $am);
    $accelerator_mods = $am;
    $rc;
  }

  method get_accel_width is also<get-accel-width> {
    gtk_accel_label_get_accel_width($!al);
  }

  method get_type is also<get-type> {
    state ($n, $t);
    GTK::Widget.unstable_get_type( &gtk_accel_label_get_type, $n, $t );
  }

  method refetch {
    gtk_accel_label_refetch($!al);
  }

  method set_accel (
    Int() $accelerator_key,       # guint $accelerator_key,
    Int() $accelerator_mods       # GdkModifierType $accelerator_mods
  )
    is also<set-accel>
  {
    my @u = ($accelerator_key, $accelerator_mods);
    my uint32 ($ak, $am) = self.RESOLVE-UINT(@u);

    gtk_accel_label_set_accel($!al, $ak, $am);
  }

  method set_accel_closure (GClosure $accel_closure)
    is also<set-accel-closure>
  {
    gtk_accel_label_set_accel_closure($!al, $accel_closure);
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
