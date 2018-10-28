use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::Types;

unit package GTK::Dialog::Raw::About;

sub gtk_about_dialog_add_credit_section (
  GtkAboutDialog $about,
  gchar $section_name,
  CArray[Str] $people
)
  is native(gtk)
  is export
  { * }

sub gtk_about_dialog_get_type ()
  returns GType
  is native(gtk)
  is export
  { * }

sub gtk_about_dialog_new ()
  returns GtkWidget
  is native(gtk)
  is export
  { * }

sub gtk_about_dialog_get_translator_credits (GtkAboutDialog $about)
  returns Str
  is native(gtk)
  is export
  { * }

sub gtk_about_dialog_get_documenters (GtkAboutDialog $about)
  returns CArray[Str]
  is native(gtk)
  is export
  { * }

sub gtk_about_dialog_get_license (GtkAboutDialog $about)
  returns Str
  is native(gtk)
  is export
  { * }

sub gtk_about_dialog_get_artists (GtkAboutDialog $about)
  returns CArray[Str]
  is native(gtk)
  is export
  { * }

sub gtk_about_dialog_get_comments (GtkAboutDialog $about)
  returns Str
  is native(gtk)
  is export
  { * }

sub gtk_about_dialog_get_version (GtkAboutDialog $about)
  returns Str
  is native(gtk)
  is export
  { * }

sub gtk_about_dialog_get_program_name (GtkAboutDialog $about)
  returns Str
  is native(gtk)
  is export
  { * }

sub gtk_about_dialog_get_logo (GtkAboutDialog $about)
  returns GdkPixbuf
  is native(gtk)
  is export
  { * }

sub gtk_about_dialog_get_logo_icon_name (GtkAboutDialog $about)
  returns Str
  is native(gtk)
  is export
  { * }

sub gtk_about_dialog_get_authors (GtkAboutDialog $about)
  returns CArray[Str]
  is native(gtk)
  is export
  { * }

sub gtk_about_dialog_get_website (GtkAboutDialog $about)
  returns Str
  is native(gtk)
  is export
  { * }

sub gtk_about_dialog_get_website_label (GtkAboutDialog $about)
  returns Str
  is native(gtk)
  is export
  { * }

sub gtk_about_dialog_get_wrap_license (GtkAboutDialog $about)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_about_dialog_get_license_type (GtkAboutDialog $about)
  returns uint32 # GtkLicense
  is native(gtk)
  is export
  { * }

sub gtk_about_dialog_get_copyright (GtkAboutDialog $about)
  returns Str
  is native(gtk)
  is export
  { * }

sub gtk_about_dialog_set_translator_credits (
  GtkAboutDialog $about,
  CArray[Str] $translator_credits
)
  is native(gtk)
  is export
  { * }

sub gtk_about_dialog_set_documenters (
  GtkAboutDialog $about,
  CArray[Str] $documenters
)
  is native(gtk)
  is export
  { * }

sub gtk_about_dialog_set_license (
  GtkAboutDialog $about,
  gchar $license
)
  is native(gtk)
  is export
  { * }

sub gtk_about_dialog_set_artists (
  GtkAboutDialog $about,
  CArray[Str] $artists
)
  is native(gtk)
  is export
  { * }

sub gtk_about_dialog_set_comments (
  GtkAboutDialog $about,
  gchar $comments
)
  is native(gtk)
  is export
  { * }

sub gtk_about_dialog_set_version (
  GtkAboutDialog $about,
  gchar $version
)
  is native(gtk)
  is export
  { * }

sub gtk_about_dialog_set_program_name (
  GtkAboutDialog $about,
  gchar $name
)
  is native(gtk)
  is export
  { * }

sub gtk_about_dialog_set_logo (
  GtkAboutDialog $about,
  GdkPixbuf $logo
)
  is native(gtk)
  is export
  { * }

sub gtk_about_dialog_set_logo_icon_name (
  GtkAboutDialog $about,
  gchar $icon_name
)
  is native(gtk)
  is export
  { * }

sub gtk_about_dialog_set_authors (
  GtkAboutDialog $about,
  CArray[Str] $authors
)
  is native(gtk)
  is export
  { * }

sub gtk_about_dialog_set_website (
  GtkAboutDialog $about,
  gchar $website
)
  is native(gtk)
  is export
  { * }

sub gtk_about_dialog_set_website_label (
  GtkAboutDialog $about,
  gchar $website_label
)
  is native(gtk)
  is export
  { * }

sub gtk_about_dialog_set_wrap_license (
  GtkAboutDialog $about,
  gboolean $wrap_license
)
  is native(gtk)
  is export
  { * }

sub gtk_about_dialog_set_license_type (
  GtkAboutDialog $about,
  uint32 $license_type          # GtkLicense $license_type
)
  is native(gtk)
  is export
  { * }

sub gtk_about_dialog_set_copyright (
  GtkAboutDialog $about,
  gchar $copyright
)
  is native(gtk)
  is export
  { * }