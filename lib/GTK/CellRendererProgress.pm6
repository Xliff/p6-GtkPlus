use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::CellRendererProgress;
use GTK::Raw::Types;

use GTK::CellRenderer;

class GTK::CellRendererProgress is GTK::CellRenderer {
  has GtkCellRendererProgress $!crp;

  method bless(*%attrinit) {
    my $o = self.CREATE.BUILDALL(Empty, %attrinit);
    $o.setType('GTK::CellRendereProgress');
    $o;
  }

  submethod BUILD(:$cellprogress) {
    my $to-parent;
    given $ {
      when GtkCellRendererProgress | GtkCellRenderer {
        $!crp = do {
          when GtkCellRenderer {
            $to-parent = $_;
            nativecast(GtkCellRendererProgress, $_);
          }
          when GtkCellRendererProgress  {
            $to-parent = nativecast(GtkCellRenderer, $_);
            $_;
          }
        }
        self.setCellRenderer($to-parent);
      }
      when GTK::CellRendererProgress {
      }
      default {
      }
    }
  }

  multi method new {
    my $cellprogress = gtk_cell_renderer_progress_new();
    self.bless(:$cellprogress);
  }
  multi method new (GtkCellRenderer $cellprogress) {
    self.bless(:$cellprogress);
  }
  multi method new (GtkCellRendererProgress $cellprogress) {
    self.bless(:$cellprogress);
  }

  # ↓↓↓↓ SIGNALS ↓↓↓↓
  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ PROPERTIES ↓↓↓↓

  # Type: gboolean
  method inverted is rw {
    my GTK::Compat::Value $gv .= new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new( self.prop_get($!crp, 'inverted', $gv); );
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = self.RESOLVE-BOOL($val);
        self.prop_set($!crp, 'inverted', $gv);
      }
    );
  }

  # Type: gint
  method pulse is rw {
    my GTK::Compat::Value $gv .= new( G_TYPE_INT );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new( self.prop_get($!crp, 'pulse', $gv); );
        $gv.int;
      },
      STORE => -> $, Int() $val is copy {
        $gv.int = self.RESOLVE-INT($val);
        self.prop_set($!crp, 'pulse', $gv);
      }
    );
  }

  # Type: gchar
  method text is rw {
    my GTK::Compat::Value $gv .= new( G_TYPE_STRING );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new( self.prop_get($!crp, 'text', $gv); );
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set($!crp, 'text', $gv);
      }
    );
  }

  # Type: gfloat
  method text-xalign is rw {
    my GTK::Compat::Value $gv .= new( G_TYPE_FLOAT );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new( self.prop_get($!crp, 'text-xalign', $gv); );
        $gv.float;
      },
      STORE => -> $, Num() $val is copy {
        $gv.float = $val;
        self.prop_set($!crp, 'text-xalign', $gv);
      }
    );
  }

  # Type: gfloat
  method text-yalign is rw {
    my GTK::Compat::Value $gv .= new( G_TYPE_FLOAT );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new( self.prop_get($!crp, 'text-yalign', $gv); );
        $gv.float;
      },
      STORE => -> $, Num() $val is copy {
        $gv.float = $val;
        self.prop_set($!crp, 'text-yalign', $gv);
      }
    );
  }

  # Type: gint
  method value is rw {
    my GTK::Compat::Value $gv .= new( G_TYPE_INT );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new( self.prop_get($!crp, 'value', $gv); );
        $gv.int;
      },
      STORE => -> $, Int() $val is copy {
        $gv.int = self.RESOLVE-INT($val);
        self.prop_set($!crp, 'value', $gv);
      }
    );
  }

  # ↑↑↑↑ PROPERTIES ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  method get_type () {
    gtk_cell_renderer_progress_get_type();
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
