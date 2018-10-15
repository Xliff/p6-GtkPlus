use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::Types;

use GTK::Roles::Signals::ShortcutsSection;

use GTK::Box;

subset ParentChild where GtkShortcutsSection | GtkWidget;

class GTK::ShortcutsSection is GTK::Box {
  also does GTK::Roles::Signals::ShortcutsSection;

  has GtkShortcutsSection $!ss;

  method bless(*%attrinit) {
    my $o = self.CREATE.BUILDALL(Empty, %attrinit);
    $o.setType('GTK::ShortcutsSection');
    $o;
  }

  submethod BUILD(:$section) {
    my $to-parent;
    given $section {
      when ParentChild {
        $!ss = do {
          when GtkWidget {
            $to-parent = $_;
            nativecast(GtkShortcutsSection, $_);
          }
          when GtkShortcutsSection  {
            $to-parent = nativecast(GtkBox, $_);
            $_;
          }
        }
        self.setBox($to-parent);
      }
      when GTK::ShortcutsSection {
      }
      default {
      }
    }
  }

  submethod DESTROY {
    self.disconnect($_, %!signals-ss) for %!signals-ss.keys
  }

  method new (ParentChild $section) {
    self.bless(:$section);
  }

  # ↓↓↓↓ SIGNALS ↓↓↓↓

  # Is originally:
  # GtkShortcutsSection, gint, gpointer --> gboolean
  method change-current-page {
    self.connect-change-current-page($!ss);
  }

  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ PROPERTIES ↓↓↓↓

  # Type: guint
  method max-height is rw {
    my GTK::Compat::Value $gv .= new( G_TYPE_UINT );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new( self.prop_get($!ss, 'max-height', $gv); );
        $gv.uint;
      },
      STORE => -> $, Int() $val is copy {
        $gv.uint = self.RESOLVE-UINT($val);
        self.prop_set($!ss, 'max-height', $gv);
      }
    );
  }

  # Type: gchar
  method section-name is rw {
    my GTK::Compat::Value $gv .= new( G_TYPE_STRING );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new( self.prop_get($!ss, 'section-name', $gv); );
        $gv.string
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set($!ss, 'section-name', $gv);
      }
    );
  }

  # Type: gchar
  method title is rw {
    my GTK::Compat::Value $gv .= new( G_TYPE_STRING );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new( self.prop_get($!ss, 'title', $gv); );
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set($!ss, 'title', $gv);
      }
    );
  }

  # Type: gchar
  method view-name is rw {
    my GTK::Compat::Value $gv .= new( G_TYPE_STRING );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new( self.prop_get($!ss, 'view-name', $gv); );
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set($!ss, 'view-name', $gv);
      }
    );
  }

  # ↑↑↑↑ PROPERTIES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  # ↑↑↑↑ METHODS ↑↑↑↑

}
