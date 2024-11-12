use v6.c;

use NativeCall;

use Method::Also;

use GTK::Raw::Actionable:ver<3.0.1146>;
use GTK::Raw::Types:ver<3.0.1146>;

role GTK::Roles::Actionable:ver<3.0.1146> {
  has GtkActionable $!action is implementor;

  method roleInit-GtkActionable {
    return if $!action;

    my \i    = findProperImplementor( self.^attributes );
    $!action = cast( GtkActionable, i.get_value(self) );
  }

  method GTK::Raw::Definitions::GtkActionable
    is also<GtkActionable>
  { $!action }

  # ↓↓↓↓ SIGNALS ↓↓↓↓
  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  method action_name is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_actionable_get_action_name($!action);
      },
      STORE => sub ($, Str() $action_name is copy) {
        gtk_actionable_set_action_name($!action, $action_name);
      }
    );
  }

  # Alias back to action_target_value
  method action_target is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_actionable_get_action_target_value($!action);
      },
      STORE => sub ($, GVariant() $target_value is copy) {
        gtk_actionable_set_action_target_value($!action, $target_value);
      }
    );
  }
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  method get_gtkactionable_type {
    state ($n, $t);

    GTK::Widget.unstable_get_type( &gtk_actionable_get_type, $n, $t );
  }

  method set_detailed_action_name (Str() $detailed_action_name) {
    gtk_actionable_set_detailed_action_name($!action, $detailed_action_name);
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}

use GLib::Roles::Object;

our subset GtkActionableAncestry is export of Mu
  where GtkActionable | GObject;

class GTK::Actionable {
  also does GLib::Roles::Object;
  also does GTK::Roles::Actionable;

  submethod BUILD ( :$gtk-actionable ) {
    self.setGtkActionable($gtk-actionable) if $gtk-actionable;
  }

  method setGtkActionable(GtkActionableAncestry $_) {
    my $to-parent;

    $!action = do {
      when GtkActionable {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GtkActionable, $_);
      }
    }
  }

  method get_type {
    self.get_gtkactionable_type
  }
}
