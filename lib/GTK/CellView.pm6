use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::CellView;
use GTK::Raw::Types;

use GTK::TreePath;
use GTK::Widget;

use GTK::Roles::CellLayout;

class GTK::CellView is GTK::Widget {
  also does GTK::Roles::CellLayout;

  has GtkCellView $!cv;

  method bless(*%attrinit) {
    my $o = self.CREATE.BUILDALL(Empty, %attrinit);
    $o.setType('GTK::CellView');
    $o;
  }

  submethod BUILD(:$cellview) {
    my $to-parent;
    given $cellview {
      when GtkCellView | GtkWidget {
        $!cv = do {
          when GtkWidget {
            $to-parent = $_;
            nativecast(GtkCellView, $_);
          }
          when GtkCellView {
            $to-parent = nativecast(GtkWidget, $_);
            $_;
          }
        }
        self.setWidget($to-parent);
      }
      when GTK::CellView {
      }
      default {
      }
    }
    # For GTK::Roles::CellLayout
    $!cl = nativecast(GtkCellLayout, $!cv);
  }

  method GTK::Raw::Types::CellView {
    $!cv;
  }

  method new {
    my $cellview = gtk_cell_view_new();
    self.bless(:$cellview);
  }

  method new_with_context (GtkCellAreaContext() $context) {
    my $cellview = gtk_cell_view_new_with_context($context);
    self.bless(:$cellview);
  }

  method new_with_markup (Str() $m) {
    my $cellview = gtk_cell_view_new_with_markup($m);
    self.bless(:$cellview);
  }

  method new_with_pixbuf (Str() $p) {
    my $cellview = gtk_cell_view_new_with_pixbuf($p);
    self.bless(:$cellview);
  }

  method new_with_text (Str() $t) {
    my $cellview = gtk_cell_view_new_with_text($t);
    self.bless(:$cellview);
  }

  # ↓↓↓↓ SIGNALS ↓↓↓↓
  method displayed_row is rw {
    Proxy.new(
      FETCH => sub ($) {
        GTK::TreePath.new( gtk_cell_view_get_displayed_row($!cv) );
      },
      STORE => sub ($, GtkTreePath() $path is copy) {
        gtk_cell_view_set_displayed_row($!cv, $path);
      }
    );
  }

  method draw_sensitive is rw {
    Proxy.new(
      FETCH => sub ($) {
        so gtk_cell_view_get_draw_sensitive($!cv);
      },
      STORE => sub ($, $draw_sensitive is copy) {
        my gboolean $d = self.RESOLVE-BOOL($draw_sensitive);
        gtk_cell_view_set_draw_sensitive($!cv, $d);
      }
    );
  }

  method fit_model is rw {
    Proxy.new(
      FETCH => sub ($) {
        so gtk_cell_view_get_fit_model($!cv);
      },
      STORE => sub ($, $fit_model is copy) {
        my gboolean $f = self.RESOLVE-BOOL($fit_model);
        gtk_cell_view_set_fit_model($!cv, $f);
      }
    );
  }

  method model is rw {
    Proxy.new(
      FETCH => sub ($) {
        so gtk_cell_view_get_model($!cv);
      },
      STORE => sub ($, GtkTreeModel() $model is copy) {
        gtk_cell_view_set_model($!cv, $model);
      }
    );
  }

  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ PROPERTIES ↓↓↓↓

  # Type: gchar
  method background is rw {
    my GTK::Compat::Value $gv .= new( G_TYPE_STRING );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new( warn "background does not allow reading" );
        $gv.string;
      },
      STORE => -> $, Int() $val is copy {
        $gv.string = $val;
        self.prop_set($!cv, 'background', $gv);
      }
    );
  }

  # Type: GdkColor
  method background-gdk is rw {
    my GTK::Compat::Value $gv .= new( G_TYPE_POINTER );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new( self.prop_get($!cv, 'background-gdk', $gv); );
        nativecast(GdkColor, $gv.pointer);
      },
      STORE => -> $, GdkColor $val is copy {
        $gv.pointer = $val;
        self.prop_set($!cv, 'background-gdk', $gv);
      }
    );
  }

  # Type: GdkRGBA
  method background-rgba is rw {
    my GTK::Compat::Value $gv .= new( G_TYPE_POINTER );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new( self.prop_get($!cv, 'background-rgba', $gv); );
        nativecast(GTK::Compat::RGBA, $gv.pointer);
      },
      STORE => -> $, GTK::Compat::RGBA $val is copy {
        $gv.pointer = nativecast(Pointer, $val);
        self.prop_set($!cv, 'background-rgba', $gv);
      }
    );
  }

  # Type: gboolean
  method background-set is rw {
    my GTK::Compat::Value $gv .= new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new( self.prop_get($!cv, 'background-set', $gv); );
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = self.RESOLVE-BOOL($val);
        self.prop_set($!cv, 'background-set', $gv);
      }
    );
  }

  # Type: GtkCellArea
  method cell-area is rw {
    my GTK::Compat::Value $gv .= new( G_TYPE_POINTER );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new( self.prop_get($!cv, 'cell-area', $gv); );
        GTK::CellArea.new( nativecast(GtkCellArea, $gv.pointer) );
      },
      STORE => -> $, GtkCellArea() $val is copy {
        $gv.pointer = $val;
        self.prop_set($!cv, 'cell-area', $gv);
      }
    );
  }

  # Type: GtkCellAreaContext
  method cell-area-context is rw {
    my GTK::Compat::Value $gv .= new( G_TYPE_POINTER );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new( self.prop_get($!cv, 'cell-area-context', $gv); );
        GTK::CellAreaContext.new( nativecast(GtkCellAreaContext, $gv.pointer) );
      },
      STORE => -> $, GtkCellAreaContext() $val is copy {
        $gv.pointer = $val;
        self.prop_set($!cv, 'cell-area-context', $gv);
      }
    );
  }

  # Type: gboolean
  method draw-sensitive is rw {
    my GTK::Compat::Value $gv .= new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new( self.prop_get($!cv, 'draw-sensitive', $gv); );
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = self.RESOLVE-BOOL($val);
        self.prop_set($!cv, 'draw-sensitive', $gv);
      }
    );
  }

  # Type: gboolean
  method fit-model is rw {
    my GTK::Compat::Value $gv .= new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new( self.prop_get($!cv, 'fit-model', $gv); );
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = self.RESOLVE-BOOLEAN($val);
        self.prop_set($!cv, 'fit-model', $gv);
      }
    );
  }

  # ↑↑↑↑ PROPERTIES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  method get_size_of_row (GtkTreePath() $path, GtkRequisition() $requisition) {
    gtk_cell_view_get_size_of_row($!cv, $path, $requisition);
  }

  method get_type {
    gtk_cell_view_get_type();
  }

  method set_background_color (GdkColor $color) {
    gtk_cell_view_set_background_color($!cv, $color);
  }

  method set_background_rgba (GTK::Compat::RGBA() $rgba) {
    gtk_cell_view_set_background_rgba($!cv, $rgba);
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
