use v6.c;

use Method::Also;
use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::CellRendererToggle;
use GTK::Raw::Types;

use GTK::Raw::Utils;

use GTK::CellRenderer;

use GTK::Roles::Signals::Generic;

our subset CellRendererToggleAncestry is export
  where GtkCellRendererToggle | GtkCellRenderer;

class GTK::CellRendererToggle is GTK::CellRenderer {
  also does GTK::Roles::Signals::Generic;

  has GtkCellRendererToggle $!crt;

  method bless(*%attrinit) {
    my $o = self.CREATE.BUILDALL(Empty, %attrinit);
    $o.setType('GTK::CellRendererToggle');
    $o;
  }

  submethod BUILD(:$celltoggle) {
    my $to-parent;
    given $celltoggle {
      when CellRendererToggleAncestry {
        $!crt = do {
          when GtkCellRendererToggle {
            $to-parent = nativecast(GtkCellRenderer, $_);
            $_;
          }
          default {
            $to-parent = $_;
            nativecast(GtkCellRendererToggle, $_);
          }
        }
        self.setCellRenderer($to-parent);
      }
      when GTK::CellRendererToggle {
      }
      default {
      }
    }
  }

  submethod DESTROY {
    self.disconnect-all(%!signals);
  }

  method GTK::Raw::Types::GtkCellRendererToggle
    is also<CellRendererToggle>
    { $!crt }

  multi method new {
    my $celltoggle = gtk_cell_renderer_toggle_new();
    self.bless(:$celltoggle);
  }
  multi method new (CellRendererToggleAncestry $celltoggle) {
    self.bless(:$celltoggle);
  }


  # ↓↓↓↓ SIGNALS ↓↓↓↓

  # Is originally:
  # GtkCellRendererToggle, gchar, gpointer --> void
  method toggled {
    self.connect-string($!crt, 'toggled');
  }

  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  method activatable is rw {
    Proxy.new(
      FETCH => sub ($) {
        so gtk_cell_renderer_toggle_get_activatable($!crt);
      },
      STORE => sub ($, Int() $setting is copy) {
        my gboolean $s = resolve-bool($setting);
        gtk_cell_renderer_toggle_set_activatable($!crt, $s);
      }
    );
  }

  method active is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_cell_renderer_toggle_get_active($!crt);
      },
      STORE => sub ($, Int() $setting is copy) {
        my gboolean $s = resolve-bool($setting);
        gtk_cell_renderer_toggle_set_active($!crt, $s);
      }
    );
  }

  method radio is rw {
    Proxy.new(
      FETCH => sub ($) {
        so gtk_cell_renderer_toggle_get_radio($!crt);
      },
      STORE => sub ($, Int() $radio is copy) {
        my gboolean $r = resolve-bool($radio);
        gtk_cell_renderer_toggle_set_radio($!crt, $r);
      }
    );
  }
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ PROPERTIES ↓↓↓↓

  # Type: gboolean
  method inconsistent is rw {
    my GTK::Compat::Value $gv .= new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new( self.prop_get('inconsistent', $gv); );
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = resolve-bool($val);
        self.prop_set('inconsistent', $gv);
      }
    );
  }

  # Type: gint
  method indicator-size is rw is also<indicator_size> {
    my GTK::Compat::Value $gv .= new( G_TYPE_INT );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new( self.prop_get('indicator-size', $gv); );
        $gv.int;
      },
      STORE => -> $, Int() $val is copy {
        $gv.int = resolve-int($val);
        self.prop_set('indicator-size', $gv);
      }
    );
  }

  # ↑↑↑↑ PROPERTIES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  method get_type is also<get-type> {
    gtk_cell_renderer_toggle_get_type();
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
