use v6.c;

use Method::Also;
use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::Types;
use GTK::Raw::Separator;

use GTK::Widget;

use GTK::Roles::Orientable;

my subset Ancestry
  where GtkSeparator | GtkOrientable | GtkBuildable | GtkWidget;

class GTK::Separator is GTK::Widget {
  also does GTK::Roles::Orientable;

  has GtkSeparator $!s;

  method bless(*%attrinit) {
    my $o = self.CREATE.BUILDALL(Empty, %attrinit);
    $o.setType('GTK::Separator');
    $o;
  }

  submethod BUILD(:$separator) {
    my $to-parent;
    given $separator {
      when Ancestry {
        $!s = do {
          when GtkSeparator {
            $to-parent = nativecast(GtkWidget, $_);
            $_;
          }
          when GtkOrientable {
            $!or = $_;                                # GTK::Roles::Orientable
            $to-parent = nativecast(GtkWidget, $_);
            nativecast(GtkSeparator, $_);
          }
          default {
            $to-parent = $_;
            nativecast(GtkSeparator, $_);
          }
        };
        self.setWidget($to-parent);
      }
      when GTK::Separator {
      }
      default {
      }
    }
    $!or //= nativecast(GtkOrientable, $separator);   # GTK::Roles::Orientable
  }

  multi method new (Ancestry $separator) {
    my $o = self.bless(:$separator);
    $o.upref;
    $o;
  }
  multi method new(:$horizontal, :$vertical)  {
    # Single line HEREDOC that spans more than one in the source!
    die qq:to/D/ unless $horizontal ^^ $vertical;
Please specify only ONE of \$horizontal and \$vertical when creating a {
}GTK::Separator"
D

    my guint $o = do {
      when $horizontal { GTK_ORIENTATION_HORIZONTAL.Int; }
      when $vertical   {   GTK_ORIENTATION_VERTICAL.Int; }
    };

    my $separator = gtk_separator_new($o);
    self.bless(:$separator);
  }

  method new-h-separator(GTK::Separator:U: ) is also<new_h_separator> {
    my guint $o = GTK_ORIENTATION_HORIZONTAL.Int;
    my $separator = gtk_separator_new($o);
    self.bless(:$separator);
  }

  method new-v-separator(GTK::Separator:U: ) is also<new_v_separator> {
    my gint $o = GTK_ORIENTATION_VERTICAL.Int;
    my $separator = gtk_separator_new($o);
    self.bless(:$separator);
  }

  method get_type is also<get-type> {
    gtk_separator_get_type();
  }

}
