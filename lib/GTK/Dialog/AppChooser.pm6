use v6.c;

use Method::Also;
use NativeCall;


use GTK::Dialog::Raw::AppChooser:ver<3.0.1146>;
use GTK::Raw::Types:ver<3.0.1146>;

use GLib::Value;
use GTK::Dialog:ver<3.0.1146>;

use GTK::Roles::AppChooser:ver<3.0.1146>;

my subset Ancestry
  where GtkAppChooserDialog | GtkAppChooser | GtkDialog | GtkWindow |
        GtkContainer        | GtkBuilder    | GtkWidget;

class GTK::Dialog::AppChooser:ver<3.0.1146> is GTK::Dialog {
  also does GTK::Roles::AppChooser;

  has GtkAppChooserDialog $!acd is implementor;

  method bless(*%attrinit) {
    my $o = self.CREATE.BUILDALL(Empty, %attrinit);
    $o.setType('GTK::Dialog::AppChooser');
    $o;
  }

  submethod BUILD(:$dialog) {
    my $to-parent;
    given $dialog {
      when Ancestry {
        $!acd = do {
          when GtkAppChooserDialog {
            $to-parent = nativecast(GtkDialog, $_);
            $_;
          }
          when GtkAppChooser {
            $!ac = $_;                                # GTK::Roles::AppChooser
            $to-parent = nativecast(GtkDialog, $_);
            nativecast(GtkAppChooserDialog, $_);
          }
          default {
            $to-parent = $_;
            nativecast(GtkAppChooserDialog, $_);
          }
        }
        self.setDialog($to-parent);
      }
      when GTK::Dialog::AppChooser {
      }
      default {
      }
    }
    $!ac //= nativecast(GtkAppChooser, $!acd)        # GTK::Roles::AppChooser
  }

  multi method new (Ancestry $dialog) {
    my $o = self.bless($dialog);
    $o.upref;
    $o;
  }
  multi method new (
    GtkWindow() $parent,
    Int() $flags,               # GtkDialogFlags $flags,
    GFile $file
  ) {
    my guint $f = self.RESOLVE-UINT($flags);
    my $dialog = gtk_app_chooser_dialog_new($parent, $f, $file);
    self.bless(:$dialog);
  }

  method new_for_content_type (
    GtkWindow() $parent,
    Int() $flags,               # GtkDialogFlags $flags,
    Str() $content_type
  )
    is also<new-for-content-type>
  {
    my guint $f = self.RESOLVE-UINT($flags);
    my $dialog = gtk_app_chooser_dialog_new_for_content_type(
      $parent, $f, $content_type
    );
    self.bless(:$dialog);
  }

  # ↓↓↓↓ SIGNALS ↓↓↓↓
  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ PROPERTIES ↓↓↓↓

  # Type: GFile
  method gfile is rw {
    my GLib::Value $gv .= new( G_TYPE_OBJECT );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new( self.prop_get('gfile', $gv) );
        nativecast(GFile, $gv.object);
      },
      STORE => -> $, GFile() $val is copy {
        $gv.object = $val;
        self.prop_set('gfile', $gv);
      }
    );
  }

  # Type: gchar
  method heading is rw {
    my GLib::Value $gv .= new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new( self.prop_get('heading', $gv) );
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('heading', $gv);
      }
    );
  }

  # ↑↑↑↑ PROPERTIES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  method get_type is also<get-type> {
    gtk_app_chooser_dialog_get_type();
  }

  method get_widget is also<get-widget> {
    gtk_app_chooser_dialog_get_widget($!acd);
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
