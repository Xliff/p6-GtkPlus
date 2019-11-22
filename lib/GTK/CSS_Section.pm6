use v6.c;

use GTK::Compat::Types;

use GTK::Raw::Types;
use GTK::Raw::CSS_Section;

use GTK::CSSProvider;

# BOXED TYPE

class GTK::CSS_Section {
  has GtkCssSection $!css_s is implementor;

  submethod BUILD (:$section) {
    $!css_s = $section;
  }

  method get_end_line {
    gtk_css_section_get_end_line($!css_s);
  }

  method get_end_position {
    gtk_css_section_get_end_position($!css_s);
  }

  method get_file {
    #GTK::Compat::File.new(
      gtk_css_section_get_file($!css_s)
    #);
  }

  method get_parent {
    gtk_css_section_get_parent($!css_s);
  }

  method get_section_type {
    gtk_css_section_get_section_type($!css_s);
  }

  method get_start_line {
    gtk_css_section_get_start_line($!css_s);
  }

  method get_start_position {
    gtk_css_section_get_start_position($!css_s);
  }

  method get_type {
    GtkCssSectionType( gtk_css_section_get_type() );
  }

  method ref {
    gtk_css_section_ref($!css_s);
    self;
  }

  method unref {
    gtk_css_section_unref($!css_s);
  }

}
