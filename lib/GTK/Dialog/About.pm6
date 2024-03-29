use v6.c;

use Method::Also;
use NativeCall;

use GTK::Raw::Types:ver<3.0.1146>;
use GTK::Dialog::Raw::About:ver<3.0.1146>;

use GTK::Dialog:ver<3.0.1146>;

my subset AboutDialogAncestry is export of Mu
  where GtkAboutDialog | DialogAncestry;

class GTK::Dialog::About:ver<3.0.1146> is GTK::Dialog {
  has GtkAboutDialog $!ad is implementor;

  method bless(*%attrinit) {
    my $o = self.CREATE.BUILDALL(Empty, %attrinit);
    $o.setType($o.^name);
    $o;
  }

  submethod BUILD(:$about) {
    my $to-parent;
    given $about {
      when AboutDialogAncestry {
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

  multi method new (AboutDialogAncestry $about, :$ref = True) {
    return Nil unless $about;

    my $o = self.bless(:$about);
    $o.ref if $ref;
    $o;
  }
  multi method new {
    my $about = gtk_about_dialog_new();

    $about ?? self.bless(:$about) !! Nil;
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

        my $a = resolve-gstrv($artists ~~ Str ?? $artists.lines !! $artists);
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

        my $a = resolve-gstrv($authors ~~ Str ?? $authors.lines !! $authors);
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
      STORE => sub ($, $docs is copy) {
        die qq:to/D/.chomp unless $docs ~~ (Str, Array).any;
          Cannot accept { $docs.^name } for GTK::Dialog::About.documenters
          D

        my $d = resolve-gstrv($docs ~~ Str ?? $docs.lines !! $docs);
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
        my uint32 $lt = $license_type;

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
        my gboolean $wl = $wrap_license.so.Int;

        gtk_about_dialog_set_wrap_license($!ad, $wl);
      }
    );
  }
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  method add_credit_section (Str() $section_name, @people)
    is also<add-credit-section>
  {
    my $ac = resolve-gstrv(@people);

    gtk_about_dialog_add_credit_section($!ad, $section_name, $ac);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    GTK::Widget.unstable_get_type( &gtk_about_dialog_get_type, $n, $t );
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
