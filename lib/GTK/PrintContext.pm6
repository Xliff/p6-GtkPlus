use v6.c;

use Cairo;
use Method::Also;
use NativeCall;

use Pango::FontMap;
use Pango::Layout;


use GTK::Raw::PrintContext;
use GTK::Raw::Types;

use GLib::Roles::Object;
use GTK::Roles::Types;

use GTK::PageSetup;

class GTK::PrintContext {
  also does GLib::Roles::Object;
  also does GTK::Roles::Types;

  has GtkPrintContext $!pc is implementor;

  submethod BUILD(:$context) {
    self!setObject($!pc = $context);
  }
  
  method GTK::Raw::Definitions::GtkPrintContext is also<PrintContext> { $!pc }

  method new (GtkPrintContext $context) {
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
    Cairo::Context.new( gtk_print_context_create_pango_context($!pc); )
  }

  method create_pango_layout is also<create-pango-layout> {
    Pango::Layout.new( gtk_print_context_create_pango_layout($!pc) );
  }

  method get_cairo_context is also<get-cairo-context> {
    Cairo::Context.new( gtk_print_context_get_cairo_context($!pc) );
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

  method get_height is also<get-height height> {
    gtk_print_context_get_height($!pc);
  }

  method get_page_setup is also<get-page-setup> {
    GTK::PageSetup.new( gtk_print_context_get_page_setup($!pc) );
  }

  method get_pango_fontmap is also<get-pango-fontmap> {
    Pango::FontMap.new( gtk_print_context_get_pango_fontmap($!pc) );
  }

  method get_type is also<get-type> {
    gtk_print_context_get_type();
  }

  method get_width is also<get-width width> {
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
