use v6.c;

use Method::Also;

use GTK::Raw::Types;
use GTK::Raw::CSS_Section;

use GTK::CSSProvider;

# BOXED TYPE

class GTK::CSS_Section {
  has GtkCssSection $!css_s;

  submethod BUILD (:$section) {
    $!css_s = $section;
  }

  method GTK::Raw::Definitions::GtkCssSection
    is also<GtkCssSection>
  { $!css_s }

  method new (GtkCssSection $section) {
    $section ?? self.bless(:$section) !! Nil;
  }

  method get_end_line
    is also<
      get-end-line
      end-line
      end_line
    >
  {
    gtk_css_section_get_end_line($!css_s);
  }

  method get_end_position
    is also<
      get-end-position
      end-position
      end_position
    >
  {
    gtk_css_section_get_end_position($!css_s);
  }

  method get_file (:$raw = False)
    is also<
      get-file
      file
    >
  {
    my $f = gtk_css_section_get_file($!css_s);

    $f ??
      ( $raw ?? $f !! GLib::Roles::GFile.new-file-obj($f) )
      !!
      Nil;
  }

  method get_parent (:$raw = False)
    is also<
      get-parent
      parent
    >
  {
    my $p = gtk_css_section_get_parent($!css_s);

    $p ??
      ( $raw ?? $p !! GTK::CSS_Section.new($p) )
      !!
      Nil;
  }

  method get_section_type
    is also<
      get-section-type
      section-type
      section_type
    >
  {
    GtkCssSectionTypeEnum( gtk_css_section_get_section_type($!css_s) );
  }

  method get_start_line
    is also<
      get-start-line
      start-line
      start_line
    >
  {
    gtk_css_section_get_start_line($!css_s);
  }

  method get_start_position
    is also<
      get-start-position
      start_position
      start-position
    >
  {
    gtk_css_section_get_start_position($!css_s);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gtk_css_section_get_type, $n, $t );
  }

  method ref is also<upref> {
    gtk_css_section_ref($!css_s);
    self;
  }

  method unref is also<downref> {
    gtk_css_section_unref($!css_s);
  }

}
