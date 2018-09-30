use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Dialog::Raw::About;
use GTK::Raw::Types;

use GTK::Dialog;

class GTK::Dialog::About is GTK::Dialog {
  has GtkAboutDialog $!ad;

  method bless(*%attrinit) {
    use nqp;
    my $o = nqp::create(self).BUILDALL(Empty, %attrinit);
    $o.setType('GTK::Dialog::About');
    $o;
  }

  submethod BUILD(:$about) {
    my $to-parent;
    given $about {
      when GtkAboutDialog | GtkWidget {
        $! = do {
          when GtkWidget {
            $to-parent = $_;
            nativecast(GtkAboutDialog, $_);
          }
          when GtkAboutDialog  {
            $to-parent = nativecast(GtkDialog, $_);
            $_;
          }
        }
        self.setParent($to-parent);
      }
      when GTK::Dialog::About {
      }
      default {
      }
    }
  }

  multi method new {
    my $about = gtk_about_dialog_new();
    self.bless(:$about);
  }
  multi method new (GtkWidget $about) {
    self.bless(:$about);
  }

  # ↓↓↓↓ SIGNALS ↓↓↓↓

  # Is originally:
  # GtkAboutDialog, gchar, gpointer --> gboolean
  method activate-link {
    self.connect($!ad, 'activate-link');
  }
  # ↑↑↑↑ SIGNALS ↑↑↑↑

  method !getGStrv($l) {
    # Look into self.CALLING-METHOD to properly set $meth.
    my GStrv @a;
    my $meth = self.CALLING-METHOD;
    do given $l {
      when Str {
        @a = self.RESOLVE-GSTRV($l.Array);
      }
      when Array {
        die "Array must contain strings for assignment to { ::?CLASS.^name }.{ $meth }"
          unless $l.all ~~ Str;
        @a = self.RESOLVE-GSTRV($l);
      }
      default {
        die "Invalid type { .^name } passed to { ::?CLASS.^name }.{ $meth }";
      }
    }
    @a;
  }

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  method artists is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_about_dialog_get_artists($!ad);
      },
      STORE => sub ($, Array() $artists is copy) {
        gtk_about_dialog_set_artists(
          $!ad,
          self!getGStrv($artists);
        );
      }
    );
  }

  method authors is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_about_dialog_get_authors($!ad);
      },
      STORE => sub ($,  Array() $authors is copy) {
        gtk_about_dialog_set_authors(
          $!ad,
          self!getGStrv($authors);
        );
      }
    );
  }

  method comments is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_about_dialog_get_comments($!ad);
      },
      STORE => sub ($, Str() $comments is copy) {
        gtk_about_dialog_set_comments($!ad, $comments);
      }
    );
  }

  method copyright is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_about_dialog_get_copyright($!ad);
      },
      STORE => sub ($, Str() $copyright is copy) {
        gtk_about_dialog_set_copyright($!ad, $copyright);
      }
    );
  }

  method documenters is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_about_dialog_get_documenters($!ad);
      },
      STORE => sub ($, Array() $documenters is copy) {
        gtk_about_dialog_set_documenters(
          $!ad,
          self!getGStrv($documenters);
        );
      }
    );
  }

  method license is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_about_dialog_get_license($!ad);
      },
      STORE => sub ($, Str() $license is copy) {
        gtk_about_dialog_set_license($!ad, $license);
      }
    );
  }

  method license_type is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_about_dialog_get_license_type($!ad);
      },
      STORE => sub ($, Int() $license_type is copy) {
        my uint32 $lt = self.RESOLVE-UINT($license_type);
        gtk_about_dialog_set_license_type($!ad, $lt);
      }
    );
  }

  method logo is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_about_dialog_get_logo($!ad);
      },
      STORE => sub ($, GdkPixbuf $logo is copy) {
        gtk_about_dialog_set_logo($!ad, $logo);
      }
    );
  }

  method logo_icon_name is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_about_dialog_get_logo_icon_name($!ad);
      },
      STORE => sub ($, Str() $icon_name is copy) {
        gtk_about_dialog_set_logo_icon_name($!ad, $icon_name);
      }
    );
  }

  method program_name is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_about_dialog_get_program_name($!ad);
      },
      STORE => sub ($, Str() $name is copy) {
        gtk_about_dialog_set_program_name($!ad, $name);
      }
    );
  }

  method translator_credits is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_about_dialog_get_translator_credits($!ad);
      },
      STORE => sub ($, Str() $translator_credits is copy) {
        gtk_about_dialog_set_translator_credits(
          $!ad, $translator_credits
        );
      }
    );
  }

  method version is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_about_dialog_get_version($!ad);
      },
      STORE => sub ($, Str() $version is copy) {
        gtk_about_dialog_set_version($!ad, $version);
      }
    );
  }

  method website is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_about_dialog_get_website($!ad);
      },
      STORE => sub ($, Str() $website is copy) {
        gtk_about_dialog_set_website($!ad, $website);
      }
    );
  }

  method website_label is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_about_dialog_get_website_label($!ad);
      },
      STORE => sub ($, Str() $website_label is copy) {
        gtk_about_dialog_set_website_label($!ad, $website_label);
      }
    );
  }

  method wrap_license is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_about_dialog_get_wrap_license($!ad);
      },
      STORE => sub ($, Bool() $wrap_license is copy) {
        my gboolean $wl = self.RESOLVE-BOOL($wrap_license);
        gtk_about_dialog_set_wrap_license($!ad, $wl);
      }
    );
  }
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  method add_credit_section (Str() $section_name, Str() $people) {
    gtk_about_dialog_add_credit_section($!ad, $section_name, $people);
  }

  method get_type {
    gtk_about_dialog_get_type();
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
