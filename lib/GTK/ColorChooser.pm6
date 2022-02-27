use v6.c;

use Method::Also;
use NativeCall;

use GDK::RGBA;

use GTK::Raw::ColorChooser:ver<3.0.1146>;
use GTK::Raw::Label:ver<3.0.1146>;
use GTK::Raw::Types:ver<3.0.1146>;

use GLib::Value;
use GTK::Box:ver<3.0.1146>;

use GTK::Roles::ColorChooser:ver<3.0.1146>;

our subset GtkColorChooserAncestry is export
  where GtkColorChooserWidget | GtkColorChooser | GtkBoxAncestry;

class GTK::ColorChooser:ver<3.0.1146> is GTK::Box {
  also does GTK::Roles::ColorChooser;

  has GtkColorChooserWidget $!ccw is implementor;

  # Note that the attribute for the widget is also the attribute provided
  # by the role. This is a special case.

  method bless(*%attrinit) {
    my $o = self.CREATE.BUILDALL(Empty, %attrinit);
    $o.setType($o.^name);
    $o;
  }

  submethod BUILD (:$chooser) {
    self.setGtkColorChooser($chooser) if $chooser;
  }

  method setGtkColorChooser (GtkColorChooserAncestry $_) {
    my $to-parent;

    $!ccw = do {
      when GtkColorChooserWidget {
        $to-parent = nativecast(GtkBox, $_);
        $_;
      }

      when GtkColorChooser {
        $to-parent = nativecast(GtkBox, $_);
        nativecast(GtkColorChooserWidget, $_);
      }

      when GtkBoxAncestry {
        $to-parent = $_;
        nativecast(GtkColorChooserWidget, $_);
      }
    }
    self.roleInit-GtkColorChooser;
    self.setBox($to-parent);
 }

  multi method new (GtkColorChooserAncestry $chooser, :$ref = True) {
    return Nil unless $chooser;

    my $o = self.bless(:$chooser);
    $o.ref if $ref;
    $o;
  }
  multi method new {
    my $chooser = gtk_color_chooser_widget_new();

    $chooser ?? self.bless(:$chooser) !! Nil;
  }


  # ↓↓↓↓ SIGNALS ↓↓↓↓

  # All signals implemented by GTK::Role::ColorChooser

  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ PROPERTIES ↓↓↓↓
  # Type: gboolean

  method show-editor is rw {
    my GLib::Value $gv .= new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('show-editor', $gv)
        );
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('show-editor', $gv);
      }
    );
  }

  # ↑↑↑↑ PROPERTIES ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓

  # All attributes immplemented by GTK::Role::ColorChooser

  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  method get_type is also<get-type> {
    state ($n, $t);

    GTK::Widget.unstable_get_type(
      &gtk_color_chooser_widget_get_type,
      $n,
      $t
    );
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
