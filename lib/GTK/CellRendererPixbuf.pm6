use v6.c;

use Method::Also;

use GTK::Raw::CellRendererPixbuf;
use GTK::Raw::Types;

use GLib::Value;
use GTK::CellRenderer;

class GTK::CellRendererPixbuf is GTK::CellRenderer {
  has GtkCellRendererPixbuf $!crp is implementor;

  method bless(*%attrinit) {
    my $o = self.CREATE.BUILDALL(Empty, %attrinit);
    $o.setType($o.^name);
    $o;
  }

  submethod BUILD(:$cellpix) {
    my $to-parent;
    given $cellpix {
      when GtkCellRendererPixbuf | GtkCellRenderer {
        $! = do {
          when GtkCellRenderer {
            $to-parent = $_;
            cast(GtkCellRendererPixbuf, $_);
          }
          when GtkCellRendererPixbuf {
            $to-parent = cast(GtkCellRenderer, $_);
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

    $cellpix ?? self.bless(:$cellpix) !! Nil;
  }
  # This screams for ancestry logic.
  multi method new (GtkCellRendererPixbuf $cellpix) {
    $cellpix ?? self.bless(:$cellpix) !! Nil;
  }
  multi method new (GtkCellRenderer $cellpix) {
    $cellpix ?? self.bless(:$cellpix) !! Nil;
  }

  method GTK::Raw::Definitions::GtkCellRendererPixbuf
    is also<GtkCellRendererPixbuf>
  { $!crp }

  # ↓↓↓↓ SIGNALS ↓↓↓↓
  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # Type: gboolean
  method follow-state is rw is also<follow_state> {
    my GLib::Value $gv .= new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => -> $ {
        self.prop_get('follow-state', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('follow-state', $gv)
      }
    );
  }

  # Type: GIcon
  method gicon is rw {
    my GLib::Value $gv .= new( G_TYPE_POINTER );
    Proxy.new(
      FETCH => -> $ {
        self.prop_get('gicon', $gv);
        cast(GIcon, $gv.pointer);
      },
      STORE => -> $, GIcon() $val is copy {
        $gv.pointer = $val;
        self.prop_set('gicon', $gv)
      }
    );
  }

  # Type: gchar
  method icon-name is rw is also<icon_name> {
    my GLib::Value $gv .= new(G_TYPE_STRING);
    Proxy.new(
      FETCH => -> $ {
        self.prop_get('icon-name', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('icon-name', $gv)
      }
    );
  }

  # Type: GdkPixbuf
  method pixbuf is rw {
    my GLib::Value $gv .= new( G_TYPE_OBJECT );
    Proxy.new(
      FETCH => -> $ {
        self.prop_get('pixbuf', $gv);
        GDK::Pixbuf.new( cast(GdkPixbuf, $gv.object) );
      },
      STORE => -> $, GdkPixbuf() $val is copy {
        $gv.object = $val;
        self.prop_set('pixbuf', $gv)
      }
    );
  }

  # Type: GdkPixbuf
  method pixbuf-expander-closed is rw is also<pixbuf_expander_closed> {
    my GLib::Value $gv .= new( G_TYPE_POINTER );
    Proxy.new(
      FETCH => -> $ {
        self.prop_get('pixbuf-expander-closed', $gv);
        GDK::Pixbuf.new( cast(GdkPixbuf, $gv.pointer) );
      },
      STORE => -> $, GdkPixbuf() $val is copy {
        $gv.pointer = $val;
        self.prop_set('pixbuf-expander-closed', $gv)
      }
    );
  }

  # Type: GdkPixbuf
  method pixbuf-expander-open is rw is also<pixbuf_expander_open> {
    my GLib::Value $gv .= new( G_TYPE_POINTER );
    Proxy.new(
      FETCH => -> $ {
        self.prop_get('pixbuf-expander-open', $gv);
        GDK::Pixbuf.new( cast(GdkPixbuf, $gv.pointer) );
      },
      STORE => -> $, GdkPixbuf() $val is copy {
        $gv.pointer = $val;
        self.prop_set('pixbuf-expander-open', $gv)
      }
    );
  }

  # Type: gchar
  method stock-detail is rw is also<stock_detail> {
    my GLib::Value $gv .= new( G_TYPE_STRING );
    Proxy.new(
      FETCH => -> $ {
        self.prop_get('stock-detail', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('stock-detail', $gv)
      }
    );
  }

  # Type: gchar
  method stock-id is rw is also<stock_id> {
    my GLib::Value $gv .= new( G_TYPE_STRING );
    Proxy.new(
      FETCH => -> $ {
        self.prop_get('stock-id', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('stock-id', $gv)
      }
    );
  }

  # Type: guint
  method stock-size is rw is also<stock_size> {
    my GLib::Value $gv .= new( G_TYPE_INT );
    Proxy.new(
      FETCH => -> $ {
        self.prop_get('stock-size', $gv);
        $gv.int;
      },
      STORE => -> $, Int() $val is copy {
        $gv.int = $val;
        self.prop_set('stock-size', $gv)
      }
    );
  }

  # Type: CairoSurface (cairo_surface_t)
  method surface is rw {
    my GLib::Value $gv .= new( G_TYPE_POINTER );
    Proxy.new(
      FETCH => -> $ {
        self.prop_get('surface', $gv);
        cast(cairo_surface_t, $gv.pointer);
      },
      STORE => -> $, cairo_surface_t $val is copy {
        $gv.pointer = $val;
        self.prop_set('surface', $gv)
      }
    );
  }

  # ↑↑↑↑ PROPERTIES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gtk_cell_renderer_pixbuf_get_type, $n, $t );
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
