use v6.c;

use Cairo;
use Method::Also;

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

  method GTK::Raw::Definitions::GtkPrintContext
    is also<
      PrintContext
      GtkPrintContext
    >
  { $!pc }

  method new (GtkPrintContext $context) {
    $context ?? self.bless(:$context) !! Nil;
  }

  # ↓↓↓↓ SIGNALS ↓↓↓↓
  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ PROPERTIES ↓↓↓↓
  # ↑↑↑↑ PROPERTIES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  method create_pango_context (:$raw = False) is also<create-pango-context> {
    my $cc = gtk_print_context_create_pango_context($!pc);

    $cc ??
      ( $raw ?? $cc !! Cairo::Context.new($cc) )
      !!
      Nil;
  }

  method create_pango_layout (:$raw = False)
    is also<create-pango-layout>
  {
    my $pl = gtk_print_context_create_pango_layout($!pc);

    $pl ??
      ( $raw ?? $pl !! Pango::Layout.new($pl) )
      !!
      Nil;
  }

  method get_cairo_context (:$raw = False)
    is also<
      get-cairo-context
      cairo_context
      cairo-context
    >
  {
    my $cc = gtk_print_context_get_cairo_context($!pc);

    $cc ??
      ( $raw ?? $cc !! Cairo::Context.new($cc) )
      !!
      Nil;
  }

  method get_dpi_x
    is also<
      get-dpi-x
      dpi-x
      dpi_x
    >
  {
    gtk_print_context_get_dpi_x($!pc);
  }

  method get_dpi_y
    is also<
      get-dpi-y
      dpi-y
      dpi_y
    >
  {
    gtk_print_context_get_dpi_y($!pc);
  }

  proto method get_hard_margins (|)
    is also<get-hard-margins>
  { * }

  multi method get_hard_margins
    is also<
      hard-margins
      hard_margins
    >
  {
    samewith($, $, $, $);
  }
  multi method get_hard_margins (
    $top    is rw,
    $bottom is rw,
    $left   is rw,
    $right  is rw
  ) {
    my gdouble ($t, $b, $l, $r) = 0e0 xx 4;

    gtk_print_context_get_hard_margins($!pc, $t, $b, $l, $r);
    ($top, $bottom, $left, $right) = ($t, $b, $l, $r);
  }

  method get_height
    is also<
      get-height
      height
    >
  {
    gtk_print_context_get_height($!pc);
  }

  method get_page_setup (:$raw = False) is also<get-page-setup> {
    my $ps = gtk_print_context_get_page_setup($!pc);

    $ps ??
      ( $raw ?? $ps !! GTK::PageSetup.new($ps) )
      !!
      Nil;
  }

  method get_pango_fontmap (:$raw = False) is also<get-pango-fontmap> {
    my $ps = gtk_print_context_get_pango_fontmap($!pc);

    $ps ??
      ( $raw ?? $ps !! Pango::FontMap.new($ps) )
      !!
      Nil;
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gtk_print_context_get_type, $n, $t );
  }

  method get_width
    is also<
      get-width
      width
    >
  {
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
