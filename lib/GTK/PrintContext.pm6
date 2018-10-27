use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::PrintContext;
use GTK::Raw::Types;

use GTK::Roles::Types;

class GTK::PrintContext {
  also does GTK::Roles::Types;

  has GtkPrintContext $!pc;

  submethod BUILD(:$context) {
    $!pc = $context;
  }

  method new (GtkPrintContext() $context) {
    self.bless(:$context);
  }

  # ↓↓↓↓ SIGNALS ↓↓↓↓
  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ PROPERTIES ↓↓↓↓
  # ↑↑↑↑ PROPERTIES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  method create_pango_context {
    gtk_print_context_create_pango_context($!pc);
  }

  method create_pango_layout {
    gtk_print_context_create_pango_layout($!pc);
  }

  method get_cairo_context {
    gtk_print_context_get_cairo_context($!pc);
  }

  method get_dpi_x {
    gtk_print_context_get_dpi_x($!pc);
  }

  method get_dpi_y {
    gtk_print_context_get_dpi_y($!pc);
  }

  method get_hard_margins (
    Num() $top,
    Num() $bottom,
    Num() $left,
    Num() $right
  ) {
    my gdouble ($t, $b, $l, $r) = ($top, $bottom, $left, $right);
    gtk_print_context_get_hard_margins($!pc, $t, $b, $l, $r);
  }

  method get_height {
    gtk_print_context_get_height($!pc);
  }

  method get_page_setup {
    gtk_print_context_get_page_setup($!pc);
  }

  method get_pango_fontmap {
    gtk_print_context_get_pango_fontmap($!pc);
  }

  method get_type {
    gtk_print_context_get_type();
  }

  method get_width {
    gtk_print_context_get_width($!pc);
  }

  method set_cairo_context (cairo_t $cr, Num() $dpi_x, Num() $dpi_y) {
    my gdouble ($dx, $dy) = ($dpi_x, $dpi_y);
    gtk_print_context_set_cairo_context($!pc, $cr, $dx, $dy);
  }

  # ↑↑↑↑ METHODS ↑↑↑↑

}
