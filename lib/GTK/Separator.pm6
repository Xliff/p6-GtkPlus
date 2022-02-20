use v6.c;

use Method::Also;

use GTK::Raw::Types:ver<3.0.1146>;
use GTK::Raw::Separator:ver<3.0.1146>;

use GTK::Widget:ver<3.0.1146>;

use GTK::Roles::Orientable:ver<3.0.1146>;

our subset SeparatorAncestry
  where GtkSeparator | GtkOrientable | GtkWidgetAncestry;

class GTK::Separator:ver<3.0.1146> is GTK::Widget {
  also does GTK::Roles::Orientable;

  has GtkSeparator $!s is implementor;

  method bless(*%attrinit) {
    my $o = self.CREATE.BUILDALL(Empty, %attrinit);
    $o.setType($o.^name);
    $o;
  }

  submethod BUILD(:$separator) {
    my $to-parent;
    given $separator {
      when SeparatorAncestry {
        $!s = do {
          when GtkSeparator {
            $to-parent = cast(GtkWidget, $_);
            $_;
          }
          when GtkOrientable {
            $!or = $_;                                    # GTK::Roles::Orientable
            $to-parent = cast(GtkWidget, $_);
            cast(GtkSeparator, $_);
          }
          default {
            $to-parent = $_;
            cast(GtkSeparator, $_);
          }
        };
        $!or //= cast(GtkOrientable, $separator);   # GTK::Roles::Orientable
        self.setWidget($to-parent);
      }
      when GTK::Separator {
      }
      default {
      }
    }
  }

  method GTK::Raw::Definitions::GtkSeparator
    is also<
      Separator
      GtkSeparatore
    >
  { $!s }

  multi method new (SeparatorAncestry $separator, :$ref = True) {
    return Nil unless $separator;

    my $o = self.bless(:$separator);
    $o.ref if $ref;
    $o;
  }
  multi method new(:$horizontal, :$vertical)  {
    die qq:to/D/ unless $horizontal ^^ $vertical;
      Please specify only ONE of \$horizontal and \$vertical when { ''
      }creating a GTK::Separator"
      D

    my guint $o = do {
      when $horizontal { GTK_ORIENTATION_HORIZONTAL.Int; }
      when $vertical   {   GTK_ORIENTATION_VERTICAL.Int; }
    };
    my $separator = gtk_separator_new($o);

    $separator ?? self.bless(:$separator) !! Nil;
  }

  method new-h-separator(GTK::Separator:U: ) is also<new_h_separator> {
    my guint $o = GTK_ORIENTATION_HORIZONTAL.Int;
    my $separator = gtk_separator_new($o);

    $separator ?? self.bless(:$separator) !! Nil;
  }

  method new-v-separator(GTK::Separator:U: ) is also<new_v_separator> {
    my gint $o = GTK_ORIENTATION_VERTICAL.Int;
    my $separator = gtk_separator_new($o);
    
    $separator ?? self.bless(:$separator) !! Nil;
  }

  method get_type is also<get-type> {
    state ($n, $t);
    GTK::Widget.unstable_get_type( &gtk_separator_get_type, $n, $t );
  }

}
