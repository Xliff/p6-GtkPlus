use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Dialog::Raw::AppChooser;
use GTK::Raw::Types;

use GTK::Dialog;

use GTK::Roles::AppChooser;

subset ParentChild where GtkAppChooserDialog | GtkDialog;

class GTK::Dialog::AppChooser is GTK::Dialog {
  also does GTK::Roles::AppChooser;

  has GtkAppChooserDialog $!acd;

  method bless(*%attrinit) {
    my $o = self.CREATE.BUILDALL(Empty, %attrinit);
    $o.setType('GTK::Dialog::AppChooser');
    $o;
  }

  submethod BUILD(:$dialog) {
    my $to-parent;
    given $dialog {
      when ParentChild {
        $!acd = do {
          when GtkWidget {
            $to-parent = $_;
            nativecast(GtkAppChooserDialog, $_);
          }
          when GtkAppChooserDialog {
            $to-parent = nativecast(GtkDialog, $_);
            $_;
          }
        }
        self.setParent($to-parent);
      }
      when GTK::Dialog::AppChooser {
      }
      default {

      }
    }
    $!ac = nativecast(GtkAppChooser, $!acd)     # GTK::Roles::AppChooser
  }

  method new (
    GtkWindow() $parent,
    Int() $flags,               # GtkDialogFlags $flags,
    GFile $file
  ) {
    my guint $f = self.RESOLVE-UINT($flags);
    gtk_app_chooser_dialog_new($parent, $f, $file);
  }

  method new_for_content_type (
    GtkWindow() $parent,
    Int() $flags,               # GtkDialogFlags $flags,
    Str() $content_type
  ) {
    my guint $f = self.RESOLVE-UINT($flags);
    gtk_app_chooser_dialog_new_for_content_type($parent, $f, $content_type);
  }

  # ↓↓↓↓ SIGNALS ↓↓↓↓
  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ PROPERTIES ↓↓↓↓

  # Type: GFile
  method gfile is rw {
    my GTK::Compat::Value $gv .= new( G_TYPE_OBJECT );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new( self.prop_get($!acd, 'gfile', $gv); );
        nativecast(GFile, $gv.object);
      },
      STORE => -> $, GFile() $val is copy {
        $gv.object = $val;
        self.prop_set($!acd, 'gfile', $gv);
      }
    );
  }

  # Type: gchar
  method heading is rw {
    my GTK::Compat::Value $gv .= new( G_TYPE_STRING );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new( self.prop_get($!acd, 'heading', $gv); );
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set($!acd, 'heading', $gv);
      }
    );
  }

  # ↑↑↑↑ PROPERTIES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  method get_type {
    gtk_app_chooser_dialog_get_type();
  }

  method get_widget {
    gtk_app_chooser_dialog_get_widget($!acd);
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
