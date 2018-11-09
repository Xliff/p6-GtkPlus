use v6.c;

use Method::Also;
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
  method create_pango_context is also<create-pango-context> {
    gtk_print_context_create_pango_context($!pc);
  }

  method create_pango_layout is also<create-pango-layout> {
    gtk_print_context_create_pango_layout($!pc);
  }

  method get_cairo_context is also<get-cairo-context> {
    gtk_print_context_get_cairo_context($!pc);
  }

  method get_dpi_x is also<get-dpi-x> {
    gtk_print_context_get_dpi_x($!pc);
  }

  method get_dpi_y is also<get-dpi-y> {
    gtk_print_context_get_dpi_y($!pc);
  }

  method get_hard_margins (
    Num() $top,
    Num() $bottom,
    Num() $left,
    Num() $right
  )
    is also<get-hard-margins>
  {
    my gdouble ($t, $b, $l, $r) = ($top, $bottom, $left, $right);
    gtk_print_context_get_hard_margins($!pc, $t, $b, $l, $r);
  }

  method get_height is also<get-height> {
    gtk_print_context_get_height($!pc);
  }

  method get_page_setup is also<get-page-setup> {
    gtk_print_context_get_page_setup($!pc);
  }

  method get_pango_fontmap is also<get-pango-fontmap> {
    gtk_print_context_get_pango_fontmap($!pc);
  }

  method get_type is also<get-type> {
    gtk_print_context_get_type();
  }

  method get_width is also<get-width> {
    gtk_print_context_get_width($!pc);
  }

  method set_cairo_context (cairo_t $cr, Num() $dpi_x, Num() $dpi_y)
    is also<set-cairo-context>
  {
    my gdouble ($dx, $dy) = ($dpi_x, $dpi_y);
    gtk_print_context_set_cairo_context($!pc, $cr, $dx, $dy);
  }

  # ↑↑↑↑ METHODS ↑↑↑↑

}
