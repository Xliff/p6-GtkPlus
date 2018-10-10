use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::CellRendererPixbuf;
use GTK::Raw::Types;

use GTK::CellRenderer;

class GTK::CellRendererPixbuf is GTK::CellRenderer {
  has GtkCellRendererPixbuf $!crp;

  method bless(*%attrinit) {
    my $o = self.CREATE.BUILDALL(Empty, %attrinit);
    $o.setType('GTK::CellRendererPixbuf');
    $o;
  }

  submethod BUILD(:$cellpix) {
    my $to-parent;
    given $cellpix {
      when GtkCellRendererPixbuf | GtkCellRenderer {
        $! = do {
          when GtkCellRenderer {
            $to-parent = $_;
            nativecast(GtkCellRendererPixbuf, $_);
          }
          when GtkCellRendererPixbuf {
            $to-parent = nativecast(GtkCellRenderer, $_);
            $_;
          }
        }
        self.setCellRenderer($to-parent);
      }
      when GTK::CellRendererPixbuf {
      }
      default {
      }
    }
  }

  multi method new {
    my $cellpix = gtk_cell_renderer_pixbuf_new();
    self.bless(:$cellpix);
  }
  multi method new (GtkCellRendererPixbuf $cellpix) {
    self.bless(:$cellpix);
  }
  multi method new (GtkCellRenderer $cellpix) {
    self.bless(:$cellpix);
  }

  method GTK::Raw::Types::GtkCellRendererPixbuf {
    $!crp;
  }

  # ↓↓↓↓ SIGNALS ↓↓↓↓
  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # Type: gboolean
  method follow-state is rw {
    my GTK::Compat::Value $gv .= new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new( self.prop_get($!crp, 'follow-state', $gv); );
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = self.RESOLVE-BOOL($val);
        self.prop_set($!crp, 'follow-state', $gv);
      }
    );
  }

  # Type: GIcon
  method gicon is rw {
    my GTK::Compat::Value $gv .= new( G_TYPE_POINTER );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new( self.prop_get($!crp, 'gicon', $gv); );
        nativecast(GIcon, $gv.pointer);
      },
      STORE => -> $, GIcon() $val is copy {
        $gv.pointer = $val;
        self.prop_set($!crp, 'gicon', $gv);
      }
    );
  }

  # Type: gchar
  method icon-name is rw {
    my GTK::Compat::Value $gv .= new(G_TYPE_STRING);
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new( self.prop_get($!crp, 'icon-name', $gv); );
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set($!crp, 'icon-name', $gv);
      }
    );
  }

  # Type: GdkPixbuf
  method pixbuf is rw {
    my GTK::Compat::Value $gv .= new(G_TYPE_POINTER);
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new( self.prop_get($!crp, 'pixbuf', $gv); );
        GTK::Compat::Pixbuf.new( nativecast(GdkPixbuf, $gv.pointer) );
      },
      STORE => -> $, GdkPixbuf() $val is copy {
        $gv.pointer = $val;
        self.prop_set($!crp, 'pixbuf', $gv);
      }
    );
  }

  # Type: GdkPixbuf
  method pixbuf-expander-closed is rw {
    my GTK::Compat::Value $gv .= new( G_TYPE_POINTER );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new( self.prop_get($!crp, 'pixbuf-expander-closed', $gv); );
        GTK::Compat::Pixbuf.new( nativecast(GdkPixbuf, $gv.pointer) );
      },
      STORE => -> $, GdkPixbuf() $val is copy {
        $gv.pointer = $val;
        self.prop_set($!crp, 'pixbuf-expander-closed', $gv);
      }
    );
  }

  # Type: GdkPixbuf
  method pixbuf-expander-open is rw {
    my GTK::Compat::Value $gv .= new( G_TYPE_POINTER );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new( self.prop_get($!crp, 'pixbuf-expander-open', $gv); );
        GTK::Compat::Pixbuf.new( nativecast(GdkPixbuf, $gv.pointer) );
      },
      STORE => -> $, GdkPixbuf() $val is copy {
        $gv.pointer = $val;
        self.prop_set($!crp, 'pixbuf-expander-open', $gv);
      }
    );
  }

  # Type: gchar
  method stock-detail is rw {
    my GTK::Compat::Value $gv .= new( G_TYPE_STRING );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new( self.prop_get($!crp, 'stock-detail', $gv); );
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set($!crp, 'stock-detail', $gv);
      }
    );
  }

  # Type: gchar
  method stock-id is rw {
    my GTK::Compat::Value $gv .= new( G_TYPE_STRING );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new( self.prop_get($!crp, 'stock-id', $gv); );
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set($!crp, 'stock-id', $gv);
      }
    );
  }

  # Type: guint
  method stock-size is rw {
    my GTK::Compat::Value $gv .= new( G_TYPE_INT );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new( self.prop_get($!crp, 'stock-size', $gv); );
        $gv.int;
      },
      STORE => -> $, Int() $val is copy {
        $gv.int = self.RESOLVE-INT($val);
        self.prop_set($!crp, 'stock-size', $gv);
      }
    );
  }

  # Type: CairoSurface (cairo_surface_t)
  method surface is rw {
    my GTK::Compat::Value $gv .= new( G_TYPE_POINTER );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new( self.prop_get($!crp, 'surface', $gv); );
        nativecast(cairo_surface_t, $gv.pointer);
      },
      STORE => -> $, cairo_surface_t $val is copy {
        $gv.pointer = $val;
        self.prop_set($!crp, 'surface', $gv);
      }
    );
  }

  # ↑↑↑↑ PROPERTIES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  method get_type {
    gtk_cell_renderer_pixbuf_get_type();
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
