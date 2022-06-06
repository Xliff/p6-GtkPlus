use v6.c;

use Method::Also;
use NativeCall;

use GDK::RGBA;

use GTK::Raw::CellView:ver<3.0.1146>;
use GTK::Raw::Types:ver<3.0.1146>;

use GLib::Value;
use GTK::CellArea:ver<3.0.1146>;
use GTK::CellAreaContext:ver<3.0.1146>;
use GTK::TreePath:ver<3.0.1146>;
use GTK::Widget:ver<3.0.1146>;

use GTK::Roles::CellLayout:ver<3.0.1146>;
use GTK::Roles::Orientable:ver<3.0.1146>;
use GTK::Roles::TreeModel:ver<3.0.1146>;

our subset CellViewAncestry is export
  where GtkCellView | GtkCellLayout | GtkOrientable | GtkWidgetAncestry;

class GTK::CellView:ver<3.0.1146> is GTK::Widget {
  also does GTK::Roles::CellLayout;
  also does GTK::Roles::Orientable;

  has GtkCellView $!cv is implementor;

  method bless(*%attrinit) {
    my $o = self.CREATE.BUILDALL(Empty, %attrinit);
    $o.setType($o.^name);
    $o;
  }

  submethod BUILD(:$cellview) {
    my $to-parent;
    given $cellview {
      when CellViewAncestry {
        $!cv = do {
          when GtkCellView {
            $to-parent = cast(GtkWidget, $_);
            $_;
          }
          when GtkOrientable {
            $!or = $_;                          # GTK::Roles::Orientable
            $to-parent = cast(GtkWidget, $_);
            cast(GtkCellView, $_);
          }
          when GtkCellLayout {
            $!cl = $_;                          # GTK::Roles::CellLayout
            $to-parent = cast(GtkWidget, $_);
            cast(GtkCellView, $_);
          }
          when GtkWidgetAncestry {
            $to-parent = $_;
            cast(GtkCellView, $_);
          }

        }
        self.setWidget($to-parent);
        $!or //= cast(GtkOrientable, $!cv);   # GTK::Roles::Orientable
        $!cl //= cast(GtkCellLayout, $!cv);   # GTK::Roles::CellLayout
      }
      when GTK::CellView {
      }
      default {
      }
    }
  }

  method GTK::Raw::Definitions::GtkCellView
    is also<GtkCellView>
  { $!cv }

  multi method new (CellViewAncestry $cellview, :$ref = True) {
    return unless $cellview;

    my $o = self.bless(:$cellview);
    $o.ref if $ref;
    $o;
  }
  multi method new {
    my $cellview = gtk_cell_view_new();

    $cellview ?? self.bless(:$cellview) !! Nil
  }

  method new_with_context (GtkCellAreaContext() $context)
    is also<new-with-context>
  {
    my $cellview = gtk_cell_view_new_with_context($context);

    $cellview ?? self.bless(:$cellview) !! Nil
  }

  method new_with_markup (Str() $m) is also<new-with-markup> {
    my $cellview = gtk_cell_view_new_with_markup($m);
    self.bless(:$cellview);
  }

  method new_with_pixbuf (Str() $p) is also<new-with-pixbuf> {
    my $cellview = gtk_cell_view_new_with_pixbuf($p);

    $cellview ?? self.bless(:$cellview) !! Nil
  }

  method new_with_text (Str() $t) is also<new-with-text> {
    my $cellview = gtk_cell_view_new_with_text($t);

    $cellview ?? self.bless(:$cellview) !! Nil
  }

  # ↓↓↓↓ SIGNALS ↓↓↓↓
  method displayed_row (:$raw = False) is rw is also<displayed-row> {
    Proxy.new(
      FETCH => sub ($) {
        my $tp = gtk_cell_view_get_displayed_row($!cv);

        $tp ??
          ( $raw ?? $tp !! GTK::TreePath.new($tp) )
          !!
          Nil;
      },
      STORE => sub ($, GtkTreePath() $path is copy) {
        gtk_cell_view_set_displayed_row($!cv, $path);
      }
    );
  }

  method draw_sensitive is rw is also<draw-sensitive> {
    Proxy.new(
      FETCH => sub ($) {
        so gtk_cell_view_get_draw_sensitive($!cv);
      },
      STORE => sub ($, $draw_sensitive is copy) {
        my gboolean $d = $draw_sensitive.so.Int;

        gtk_cell_view_set_draw_sensitive($!cv, $d);
      }
    );
  }

  method fit_model is rw is also<fit-model> {
    Proxy.new(
      FETCH => sub ($) {
        so gtk_cell_view_get_fit_model($!cv);
      },
      STORE => sub ($, $fit_model is copy) {
        my gboolean $f = $fit_model.so.Int;

        gtk_cell_view_set_fit_model($!cv, $f);
      }
    );
  }

  method model (:$raw = False) is rw {
    Proxy.new(
      FETCH => sub ($) {
        my $tm = gtk_cell_view_get_model($!cv);

        $tm ??
          ( $raw ?? $tm !! GTK::Roles::TreeModel.new-treemodel-obj($tm) )
          !!
          Nil
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
    my GLib::Value $gv .= new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        warn "background does not allow reading" if $DEBUG;
        Nil;
      },
      STORE => -> $, Int() $val is copy {
        $gv.string = $val;
        self.prop_set('background', $gv);
      }
    );
  }

  # Type: GdkColor
  method background-gdk is rw is also<background_gdk> {
    my GLib::Value $gv .= new( G_TYPE_POINTER );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new( self.prop_get('background-gdk', $gv) );
        cast(GdkColor, $gv.pointer);
      },
      STORE => -> $, GdkColor $val is copy {
        $gv.pointer = $val;
        self.prop_set('background-gdk', $gv);
      }
    );
  }

  # Type: GdkRGBA
  method background-rgba is rw is also<background_rgba> {
    my GLib::Value $gv .= new( G_TYPE_POINTER );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('background-rgba', $gv)
        );
        cast(GDK::RGBA, $gv.pointer);
      },
      STORE => -> $, GDK::RGBA $val is copy {
        $gv.pointer = cast(Pointer, $val);
        self.prop_set('background-rgba', $gv);
      }
    );
  }

  # Type: gboolean
  method background-set is rw is also<background_set> {
    my GLib::Value $gv .= new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('background-set', $gv)
        );
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('background-set', $gv);
      }
    );
  }

  # Type: GtkCellArea
  method cell-area (:$raw = False) is rw is also<cell_area> {
    my GLib::Value $gv .= new( G_TYPE_POINTER );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new( self.prop_get('cell-area', $gv) );

        return unless $gv.pointer;

        my $v = cast(GtkCellArea, $gv.pointer);

        $raw ?? $v !! GTK::CellArea.new($v);
      },
      STORE => -> $, GtkCellArea() $val is copy {
        $gv.pointer = $val;
        self.prop_set('cell-area', $gv);
      }
    );
  }

  # Type: GtkCellAreaContext
  method cell-area-context (:$raw = False) is rw is also<cell_area_context> {
    my GLib::Value $gv .= new( G_TYPE_POINTER );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('cell-area-context', $gv)
        );

        return unless $gv.pointer;

        my $v = cast(GtkCellAreaContext, $gv.pointer);

        $raw ?? $v !! GTK::CellAreaContext.new($v);
      },
      STORE => -> $, GtkCellAreaContext() $val is copy {
        $gv.pointer = $val;
        self.prop_set('cell-area-context', $gv);
      }
    );
  }

  # ↑↑↑↑ PROPERTIES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  method get_size_of_row (
    GtkTreePath() $path,
    GtkRequisition() $requisition
  )
    is also<get-size-of-row>
  {
    gtk_cell_view_get_size_of_row($!cv, $path, $requisition);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    GTK::Widget.unstable_get_type( &gtk_cell_view_get_type, $n, $t );
  }

  method set_background_color (GdkColor $color)
    is also<set-background-color>
  {
    gtk_cell_view_set_background_color($!cv, $color);
  }

  method set_background_rgba (GDK::RGBA() $rgba)
    is also<set-background-rgba>
  {
    gtk_cell_view_set_background_rgba($!cv, $rgba);
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
