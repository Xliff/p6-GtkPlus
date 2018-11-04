use v6.c;

use Method::Also;
use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::CellRendererToggle;
use GTK::Raw::Types;

use GTK::CellRenderer;

use GTK::Roles::Signals::Generic;

my subset Ancestry where GtkCellRendererToggle | GtkCellRenderer | GtkWidget;

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
      when Ancestry {
        $!crt = do {
          when GtkCellRenderer | GtkWidget {
            $to-parent = $_;
            nativecast(GtkCellRendererToggle, $_);
          }
          when GtkCellRendererToggle {
            $to-parent = nativecast(GtkCellRenderer, $_);
            $_;
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

  method GTK::Raw::Types::GtkCellRendererToggle {
    $!crt;
  }

  multi method new {
    my $celltoggle = gtk_cell_renderer_toggle_new();
    self.bless(:$celltoggle);
  }
  multi method new (Ancestry $celltoggle) {
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
        my gboolean $s = self.RESOLVE-BOOL($setting);
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
        my gboolean $s = self.RESOLVE-BOOL($setting);
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
        my gboolean $r = self.RESOLVE-BOOL($radio);
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
        $gv.boolean = self.RESOLVE-BOOL($val);
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
        $gv.int = self.RESOLVE-INT($val);
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

