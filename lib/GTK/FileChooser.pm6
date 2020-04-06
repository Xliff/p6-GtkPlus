use v6.c;

use Method::Also;

use GTK::Raw::Types;

use GTK::Box;

use GTK::Roles::FileChooser;

our subset FileChooserWidgetAncestry is export
  where GtkFileChooserWidget | GtkFileChooser | BoxAncestry;

class GTK::FileChooser is GTK::Box {
  also does GTK::Roles::FileChooser;

  has GtkFileChooserWidget $!fcw is implementor;

  method bless(*%attrinit) {
    my $o = self.CREATE.BUILDALL(Empty, %attrinit);
    $o.setType($o.^name);
    $o;
  }

  submethod BUILD (:$filechooserwidget) {
    given $filechooserwidget {
      when    FileChooserWidgetAncestry { self.setFileChooserWidget($_) }
      when    GTK::FileChooser          { }
      default                           { }
    }
  }

  method setFileChooserWidget (FileChooserWidgetAncestry $_) {
    my $to-parent;
    $!fcw = do {
      when GtkFileChooserWidget {
        $to-parent = cast(GtkBox, $_);
        $_
      }

      when GtkFileChooser {
        $to-parent = cast(GtkBox, $_);
        $!fc = $_;
        cast(GtkFileChooserWidget, $_)
      }

      default {
        $to-parent = $_;
        cast(GtkFileChooserWidget, $_);
      }
    }
    self.setBox($to-parent);
    self.roleInit-FileChooser unless $!fc;
  }

  method GTK::Raw::Definitions::GtkFileChooserWidget
    is also<GtkFileChooserWidget>
  { $!fcw }

  proto method new (|)
  { * }

  multi method new (GtkFileChooserWidget $filechooserwidget, :$ref = True) {
    return Nil unless $filechooserwidget;

    my $o = self.bless(:$filechooserwidget);
    $o.ref if $ref;
    $o;
  }
  multi method new (Int() $action) {
    my GtkFileChooserAction $a = $action;
    my $filechooserwidget = gtk_file_chooser_widget_new($a);

    $filechooserwidget ?? self.bless(:$filechooserwidget) !! Nil;
  }

  method get_type {
    state ($n, $t);

    GTK::Widget.unstable_get_type( &gtk_file_chooser_widget_get_type, $n, $t );
  }

}

### /usr/include/gtk-3.0/gtk/gtkfilechooserwidget.h

sub gtk_file_chooser_widget_get_type ()
  returns GType
  is native(gtk)
  is export
{ * }

sub gtk_file_chooser_widget_new (GtkFileChooserAction $action)
  returns GtkFileChooserWidget
  is native(gtk)
  is export
{ * }
