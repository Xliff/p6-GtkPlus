use v6.c;

use Method::Also;
use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::Types;

use GTK::Box;

subset ParentChild where GtkShortcutsSection | GtkWidget;

class GTK::ShortcutsSection is GTK::Box {
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

  method new (ParentChild $section) {
    self.bless(:$section);
  }

  # ↓↓↓↓ SIGNALS ↓↓↓↓

  # Is originally:
  # GtkShortcutsSection, gint, gpointer --> gboolean
  method change-current-page is also<change_current_page> {
    self.connect-int-ruint($!ss);
  }

  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ PROPERTIES ↓↓↓↓

  # Type: guint
  method max-height is rw is also<max_height> {
    my GTK::Compat::Value $gv .= new( G_TYPE_UINT );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new( self.prop_get('max-height', $gv); );
        $gv.uint;
      },
      STORE => -> $, Int() $val is copy {
        $gv.uint = self.RESOLVE-UINT($val);
        self.prop_set('max-height', $gv);
      }
    );
  }

  # Type: gchar
  method section-name is rw is also<section_name> {
    my GTK::Compat::Value $gv .= new( G_TYPE_STRING );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new( self.prop_get('section-name', $gv); );
        $gv.string
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('section-name', $gv);
      }
    );
  }

  # Type: gchar
  method title is rw {
    my GTK::Compat::Value $gv .= new( G_TYPE_STRING );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new( self.prop_get('title', $gv); );
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('title', $gv);
      }
    );
  }

  # Type: gchar
  method view-name is rw is also<view_name> {
    my GTK::Compat::Value $gv .= new( G_TYPE_STRING );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new( self.prop_get('view-name', $gv); );
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('view-name', $gv);
      }
    );
  }

  # ↑↑↑↑ PROPERTIES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  # ↑↑↑↑ METHODS ↑↑↑↑

}

