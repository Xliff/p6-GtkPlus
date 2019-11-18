use v6.c;

use Method::Also;
use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::Types;

use GTK::Box;

our subset ShortcutsSectionAncestry is export 
  where GtkShortcutsSection | BoxAncestry;

class GTK::ShortcutsSection is GTK::Box {
  has GtkShortcutsSection $!ss is implementor;

  method bless(*%attrinit) {
    my $o = self.CREATE.BUILDALL(Empty, %attrinit);
    $o.setType($o.^name);
    $o;
  }

  submethod BUILD(:$section) {
    my $to-parent;
    given $section {
      when ShortcutsSectionAncestry {
        $!ss = do {
          when GtkShortcutsSection  {
            $to-parent = nativecast(GtkBox, $_);
            $_;
          }
          default {
            $to-parent = $_;
            nativecast(GtkShortcutsSection, $_);
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

  method new (ShortcutsSectionAncestry $section) {
    my $o = self.bless(:$section);
    $o.upref;
    $o;
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
        $gv = GTK::Compat::Value.new( self.prop_get('max-height', $gv) );
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
        $gv = GTK::Compat::Value.new( self.prop_get('section-name', $gv) );
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
        $gv = GTK::Compat::Value.new( self.prop_get('title', $gv) );
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
        $gv = GTK::Compat::Value.new( self.prop_get('view-name', $gv) );
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
