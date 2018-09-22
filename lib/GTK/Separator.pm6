use v6.c;

use GTK::Raw::Types;
use GTK::Raw::Separator;

use GTK::Widget;

class GTK::Separator is GTK::Widget {

  method bless(*%attrinit) {
    use nqp;
    my $o = nqp::create(self).BUILDALL(Empty, %attrinit);
    $o.setType('GTK::Label');
    $o;
  }

  submethod BUILD(:$separator) {
    my $to-parent;
    given $separator {
      when GtkSeparator | GtkWidget {
        $!l = do {
          when GtkWidget {
            $to-parent = $_;
            nativecast(GtkSeparator, $label);
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

  method new(:$horizontal, :$vertical)  {
    die "Please specify only ONE of \$horizontal and \$vertical when creating a GTK::Separator"
      unless $horizontal ^^ $vertical;

    my guint $o = do {
      when $horizontal { GTK_ORIENTATION_HORIZONTAL.Int; }
      when $vertical   {   GTK_ORIENTATION_VERTICAL.Int; }
    };

    my $separator = gtk_separator_new($o)
    self.bless(:$separator);
  }

  method new-h-separator(GTK::Separator:U: ) {
    my guint $o = GTK_ORIENTATION_HORIZONTAL.Int;
    my $separator = gtk_separator_new($o);
    self.bless(:$separator);
  }

  method new-v-separator(GTK::Separator:U: ) {
    my gint $o = GTK_ORIENTATION_VERTICAL.Int;
    my $separator = gtk_separator_new($o);
    self.bless(:$separator);
  }

  method get_type {
    gtk_separator_get_type();
  }

}
