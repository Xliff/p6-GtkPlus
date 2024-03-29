use v6.c;

use Method::Also;

use GTK::Raw::CellRendererToggle:ver<3.0.1146>;
use GTK::Raw::Types:ver<3.0.1146>;

use GLib::Value;
use GTK::CellRenderer:ver<3.0.1146>;

use GTK::Roles::Signals::Generic:ver<3.0.1146>;

our subset CellRendererToggleAncestry is export
  where GtkCellRendererToggle | GtkCellRenderer;

class GTK::CellRendererToggle:ver<3.0.1146> is GTK::CellRenderer {
  also does GTK::Roles::Signals::Generic;

  has GtkCellRendererToggle $!crt is implementor;

  method bless(*%attrinit) {
    my $o = self.CREATE.BUILDALL(Empty, %attrinit);
    $o.setType($o.^name);
    $o;
  }

  submethod BUILD(:$celltoggle) {
    my $to-parent;
    given $celltoggle {
      when CellRendererToggleAncestry {
        $!crt = do {
          when GtkCellRendererToggle {
            $to-parent = cast(GtkCellRenderer, $_);
            $_;
          }
          default {
            $to-parent = $_;
            cast(GtkCellRendererToggle, $_);
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

  method GTK::Raw::Definitions::GtkCellRendererToggle
    is also<
      CellRendererToggle
      GtkCellRendererToggle
    >
  { $!crt }

  multi method new (CellRendererToggleAncestry $celltoggle) {
    $celltoggle ?? self.bless(:$celltoggle) !! Nil;
  }
  multi method new {
    my $celltoggle = gtk_cell_renderer_toggle_new();

    $celltoggle ?? self.bless(:$celltoggle) !! Nil;
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
        my gboolean $s = $setting.Int.so;

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
        my gboolean $s = $setting.Int.so;

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
        my gboolean $r = $radio.Int.so;

        gtk_cell_renderer_toggle_set_radio($!crt, $r);
      }
    );
  }
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ PROPERTIES ↓↓↓↓

  # Type: gboolean
  method inconsistent is rw {
    my GLib::Value $gv .= new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('inconsistent', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('inconsistent', $gv)
      }
    );
  }

  # Type: gint
  method indicator-size is rw is also<indicator_size> {
    my GLib::Value $gv .= new( G_TYPE_INT );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('indicator-size', $gv);
        $gv.int;
      },
      STORE => -> $, Int() $val is copy {
        $gv.int = $val;
        self.prop_set('indicator-size', $gv)
      }
    );
  }

  # ↑↑↑↑ PROPERTIES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gtk_cell_renderer_toggle_get_type, $n, $t );
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
