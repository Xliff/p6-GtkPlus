use v6.c;

use Method::Also;
use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::Types;

use GTK::Box;
use GTK::SizeGroup;

my subset ParentChild where GtkShortcutsGroup | GtkWidget;

class GTK::ShortcutsGroup is GTK::Box {
  has GtkShortcutsGroup $!sg;

  method bless(*%attrinit) {
    my $o = self.CREATE.BUILDALL(Empty, %attrinit);
    $o.setType('GTK::ShortcutsGroup');
    $o;
  }

  submethod BUILD(:$group) {
    my $to-parent;
    given $group {
      when ParentChild {
        $!sg = do {
          when GtkWidget {
            $to-parent = $_;
            nativecast(GtkShortcutsGroup, $_);
          }
          when GtkShortcutsGroup  {
            $to-parent = nativecast(GtkBox, $_);
            $_;
          }
        }
        self.setBox($to-parent);
      }
      when GTK::ShortcutsGroup {
      }
      default {
      }
    }
  }

  method new (ParentChild $group) {
    self.bless(:$group);
  }

  # ↓↓↓↓ SIGNALS ↓↓↓↓
  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ PROPERTIES ↓↓↓↓

  # Type: GtkSizeGroup
  method accel-size-group is rw is also<accel_size_group> {
    my GTK::Compat::Value $gv .= new( G_TYPE_POINTER );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new( warn "accel-size-group does not allow reading" );
        GTK::SizeGroup.new( nativecast(GtkSizeGroup, $gv.pointer ) );
      },
      STORE => -> $, GtkSizeGroup() $val is copy {
        $gv.pointer = $val;
        self.prop_set('accel-size-group', $gv);
      }
    );
  }

  # Type: guint
  method height is rw {
    my GTK::Compat::Value $gv .= new( G_TYPE_UINT );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new( self.prop_get('height', $gv); );
        $gv.uint;
      },
      STORE => -> $, Int() $val is copy {
        warn "height does not allow writing"
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

  # Type: GtkSizeGroup
  method title-size-group is rw is also<title_size_group> {
    my GTK::Compat::Value $gv .= new( G_TYPE_POINTER );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new( warn "title-size-group does not allow reading" );
        GTK::SizeGroup.new( nativecast(GtkSizeGroup, $gv.pointer) );
      },
      STORE => -> $, GtkSizeGroup() $val is copy {
        $gv.poiner = $val;
        self.prop_set('title-size-group', $gv);
      }
    );
  }

  # Type: gchar
  method view is rw {
    my GTK::Compat::Value $gv .= new( G_TYPE_STRING );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new( self.prop_get('view', $gv); );
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('view', $gv);
      }
    );
  }

  # ↑↑↑↑ PROPERTIES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  # ↑↑↑↑ METHODS ↑↑↑↑

}

