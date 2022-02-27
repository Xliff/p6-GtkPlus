use v6.c;

use Method::Also;

use GTK::Raw::Revealer:ver<3.0.1146>;
use GTK::Raw::Types:ver<3.0.1146>;

use GLib::Value;
use GTK::Bin:ver<3.0.1146>;

our subset RevealerAncestry is export
  where GtkRevealer | BinAncestry;

class GTK::Revealer:ver<3.0.1146> is GTK::Bin {
  has GtkRevealer $!r is implementor;

  method bless(*%attrinit) {
    my $o = self.CREATE.BUILDALL(Empty, %attrinit);
    $o.setType($o.^name);
    $o;
  }

  submethod BUILD(:$revealer) {
    my $to-parent;
    given $revealer {
      when RevealerAncestry {
        $!r = do {
          when GtkRevealer {
            $to-parent = cast(GtkBin, $_);
            $_;
          }
          default {
            $to-parent = $_;
            cast(GtkRevealer, $_);
          }
        }
        self.setBin($to-parent);
      }
      when GTK::Revealer {
      }
      default {
      }
    }
  }

  multi method new (RevealerAncestry $revealer, :$ref = True) {
    my $o = self.bless(:$revealer);
    $o.ref if $ref;
    $o;
  }
  multi method new {
    my $revealer = gtk_revealer_new();

    $revealer ?? self.bless(:$revealer) !! Nil;
  }

  # ↓↓↓↓ SIGNALS ↓↓↓↓
  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # Type: gboolean
  method child-revealed is rw is also<child_revealed> {
    my GLib::Value $gv .= new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('child-revealed', $gv)
        );
        $gv.boolean;
      },
      STORE => -> $, $val is copy {
        warn "child-revealed does not allow writing"
      }
    );
  }


  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  method reveal_child is rw is also<reveal-child> {
    Proxy.new(
      FETCH => sub ($) {
        so gtk_revealer_get_reveal_child($!r);
      },
      STORE => sub ($, $reveal_child is copy) {
        my gboolean $rc = $reveal_child.so.Int;

        gtk_revealer_set_reveal_child($!r, $rc);
      }
    );
  }

  method transition_duration is rw is also<transition-duration> {
    Proxy.new(
      FETCH => sub ($) {
        gtk_revealer_get_transition_duration($!r);
      },
      STORE => sub ($, Int() $duration is copy) {
        my guint $d = $duration;

        gtk_revealer_set_transition_duration($!r, $d);
      }
    );
  }

  method transition_type is rw is also<transition-type> {
    Proxy.new(
      FETCH => sub ($) {
        GtkRevealerTransitionTypeEnum( gtk_revealer_get_transition_type($!r) );
      },
      STORE => sub ($, Int() $transition is copy) {
        my uint32 $t = $transition;

        gtk_revealer_set_transition_type($!r, $t);
      }
    );
  }
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  method get_child_revealed is also<get-child-revealed> {
    so gtk_revealer_get_child_revealed($!r);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    GTK::Widget.unstable_get_type( &gtk_revealer_get_type, $n, $t );
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
