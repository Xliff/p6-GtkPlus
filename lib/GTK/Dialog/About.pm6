use v6.c;

use Method::Also;
use NativeCall;

use GTK::Compat::Types;
use GTK::Dialog::Raw::About;
use GTK::Raw::Types;

use GTK::Dialog;

my subset Ancestry
  where GtkAboutDialog | GtkDialog | GtkWindow | GtkBin | GtkContainer |
        GtkBuilder     | GtkWidget;

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
      when Ancestry {
        $!ad = do {
          when GtkAboutDialog  {
            $to-parent = nativecast(GtkDialog, $_);
            $_;
          }
          default {
            $to-parent = $_;
            nativecast(GtkAboutDialog, $_);
          }
        }
        self.setDialog($to-parent);
      }
      when GTK::Dialog::About {
      }
      default {
      }
    }
  }

  multi method new (Ancestry $about) {
    my $o = self.bless(:$about);
    $o.upref;
    $o;
  }
  multi method new {
    my $about = gtk_about_dialog_new();
    self.bless(:$about);
  }

  # ↓↓↓↓ SIGNALS ↓↓↓↓

  # Is originally:
  # GtkAboutDialog, gchar, gpointer --> gboolean
  method activate-link is also<activate_link> {
    self.connect-activate-link($!ad);
  }
  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  method artists is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_about_dialog_get_artists($!ad);
      },
      STORE => sub ($, $artists is copy) {
        die qq:to/D/ unless $artists ~~ (Str, Array).any;
Cannot accept { $artists.^name } for GTK::Dialog::About.artists
D

        my $a = self.RESOLVE-GSTRV($artists);
        gtk_about_dialog_set_artists($!ad, $a);
      }
    );
  }

  method authors is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_about_dialog_get_authors($!ad);
      },
      STORE => sub ($, $authors is copy) {
        die qq:to/D/ unless $authors ~~ (Str, Array).any;
Cannot accept { $authors.^name } for GTK::Dialog::About.authors
D

        my $a = self.RESOLVE-GSTRV($authors);
        gtk_about_dialog_set_authors($!ad, $a);
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
      STORE => sub ($, $documenters is copy) {
        die qq:to/D/.chomp unless $documenters ~~ (Str, Array).any;
Cannot accept { $documenters.^name } for GTK::Dialog::About.documenters
D

        my $d = self.RESOLVE-GSTRV($documenters);
        gtk_about_dialog_set_documenters($!ad, $d);
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

  method license_type is rw is also<license-type> {
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
      STORE => sub ($, GdkPixbuf() $logo is copy) {
        gtk_about_dialog_set_logo($!ad, $logo);
      }
    );
  }

  method logo_icon_name is rw is also<logo-icon-name> {
    Proxy.new(
      FETCH => sub ($) {
        gtk_about_dialog_get_logo_icon_name($!ad);
      },
      STORE => sub ($, Str() $icon_name is copy) {
        gtk_about_dialog_set_logo_icon_name($!ad, $icon_name);
      }
    );
  }

  method program_name is rw is also<program-name> {
    Proxy.new(
      FETCH => sub ($) {
        gtk_about_dialog_get_program_name($!ad);
      },
      STORE => sub ($, Str() $name is copy) {
        gtk_about_dialog_set_program_name($!ad, $name);
      }
    );
  }

  method translator_credits is rw is also<translator-credits> {
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

  method website_label is rw is also<website-label> {
    Proxy.new(
      FETCH => sub ($) {
        gtk_about_dialog_get_website_label($!ad);
      },
      STORE => sub ($, Str() $website_label is copy) {
        gtk_about_dialog_set_website_label($!ad, $website_label);
      }
    );
  }

  method wrap_license is rw is also<wrap-license> {
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
  method add_credit_section (Str() $section_name, @people)
    is also<add-credit-section>
  {
    my $ac = self.RESOLVE-GSTR(@people);
    gtk_about_dialog_add_credit_section($!ad, $section_name, $ac);
  }

  method get_type is also<get-type> {
    gtk_about_dialog_get_type();
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
