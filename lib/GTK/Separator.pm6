use v6.c;

use Method::Also;
use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::Types;
use GTK::Raw::Separator;

use GTK::Widget;

class GTK::Separator is GTK::Widget {
  has GtkSeparator $!s;

  method bless(*%attrinit) {
    my $o = self.CREATE.BUILDALL(Empty, %attrinit);
    $o.setType('GTK::Separator');
    $o;
  }

  submethod BUILD(:$separator) {
    my $to-parent;
    given $separator {
      when GtkSeparator | GtkWidget {
        $!s = do {
          when GtkWidget {
            $to-parent = $_;
            nativecast(GtkSeparator, $_);
          }
          when GtkSeparator {
            $to-parent = nativecast(GtkWidget, $_);
            $_;
          }
        };
        self.setWidget($to-parent);
      }
      when GTK::Separator {
      }
      default {
      }
    }
  }

  multi method new (GtkWidget $separator) {
    self.bless(:$separator);
  }
  multi method new(:$horizontal, :$vertical)  {
    die "Please specify only ONE of \$horizontal and \$vertical when creating a GTK::Separator"
      unless $horizontal ^^ $vertical;

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

