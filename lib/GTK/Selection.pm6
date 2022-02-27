use v6.c;

use Method::Also;
use NativeCall;

use GTK::Raw::Types:ver<3.0.1146>;
use GTK::Raw::Selection:ver<3.0.1146>;

use GDK::Display;
use GDK::Pixbuf;

use GLib::Roles::Object;

class GTK::Selection:ver<3.0.1146> {
  also does GLib::Roles::Object;

  has GtkSelectionData $!s is implementor;

  submethod BUILD(:$selection) {
    $!s = $selection;

    self.roleInit-Object;
  }

  submethod DESTROY {
    self.free;
  }

  method GTK::Raw::Definitions::GtkSelectionData
    is also<
      SelectionData
      GtkSelectionData
    >
  { $!s }

  method new (GtkSelectionData $selection) {
    $selection ?? self.bless(:$selection) !! Nil;
  }

  # ↓↓↓↓ SIGNALS ↓↓↓↓
  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  method pixbuf (:$raw = False) is rw {
    Proxy.new(
      FETCH => sub ($) {
        my $p = gtk_selection_data_get_pixbuf($!s);

        $p ??
          ( $raw ?? $p !! GDK::Pixbuf.new($p) )
          !!
          Nil;
      },
      STORE => sub ($, GdkPixbuf() $pixbuf is copy) {
        gtk_selection_data_set_pixbuf($!s, $pixbuf);
      }
    );
  }

  method uris is rw {
    Proxy.new(
      FETCH => sub ($) {
        my $u = gtk_selection_data_get_uris($!s);

        CStringArrayToArray($u);
      },
      STORE => sub ($, *@uris is copy) {
        @uris .= map( *.Str );
        gtk_selection_data_set_uris( $!s, ArrayToCArray(Str, @uris) );
      }
    );
  }

  method text is rw {
    Proxy.new(
      FETCH => sub ($) {
        self.get_text;
      },
      STORE => -> $, Str() $val {
        self.set_text($val, -1);
      }
    );
  }
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ STATIC (non GtkSelectionData) METHODS ↓↓↓↓
  method add_target (
    GtkWidget() $widget,
    GdkAtom $selection,
    GdkAtom $target,
    Int() $info
  )
    is also<add-target>
  {
    my guint $i = $info;

    gtk_selection_add_target($widget, $selection, $target, $i);
  }

  method add_targets (
    GtkWidget() $widget,
    GdkAtom $selection,
    GtkTargetEntry() $targets,
    Int() $ntargets
  )
    is also<add-targets>
  {
    my guint $nt = $ntargets;

    gtk_selection_add_targets($widget, $selection, $targets, $nt);
  }

  method clear_targets (GtkWidget() $widget, GdkAtom $selection)
    is also<clear-targets>
  {
    gtk_selection_clear_targets($widget, $selection);
  }

  method convert (
    GtkWidget() $widget,
    GdkAtom $selection,
    GdkAtom $target,
    Int() $time
  ) {
    my guint32 $t = $time;

    gtk_selection_convert($widget, $selection, $target, $t);
  }

  method owner_set (GtkWidget() $widget, GdkAtom $selection, Int() $time)
    is also<owner-set>
  {
    my guint32 $t = $time;

    gtk_selection_owner_set($widget, $selection, $t);
  }

  multi method owner_set_for_display (
    GtkWidget() $widget,
    GdkAtom $selection,
    Int() $time
  )
    is also<owner-set-for-display>
  {
    my guint32 $t = $time;

    gtk_selection_owner_set_for_display($widget, $selection, $t);
  }

  method remove_all(GtkWidget() $widget) is also<remove-all> {
    gtk_selection_remove_all($widget);
  }
  # ↑↑↑↑ STATIC (non GtkSelectionData) METHODS ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  method copy {
    gtk_selection_data_copy($!s);
  }

  method free {
    gtk_selection_data_free($!s);
  }

  method get_data
    is also<
      get-data
      data
    >
  {
    gtk_selection_data_get_data($!s);
  }

  proto method get_data_with_length (|)
    is also<get-data-with-length>
  { * }

  multi method get_data_with_length {
    samewith($, :all);
  }
  multi method get_data_with_length ($length is rw, :$all = False)
  {
    my guint $l = 0;

    my $s = gtk_selection_data_get_data_with_length($!s, $l);
    $length = $l;

    $all.not ?? $s !! ($s, $length)
  }

  method get_data_type
    is also<
      get-data-type
      data-type
      data_type
    >
  {
    gtk_selection_data_get_data_type($!s);
  }

  method get_display (:$raw = False)
    is also<
      get-display
      display
    >
  {
    my $d = gtk_selection_data_get_display($!s);

    $d ??
      ( $raw ?? $d !! GDK::Display.new($d) )
      !!
      Nil;
  }

  method get_format
    is also<
      get-format
      format
    >
  {
    gtk_selection_data_get_format($!s);
  }

  method get_length
    is also<
      get-length
      length
    >
  {
    gtk_selection_data_get_length($!s);
  }

  method get_selection
    is also<
      get-selection
      selections
    >
  {
    gtk_selection_data_get_selection($!s);
  }

  method get_target
    is also<
      get-target
      target
    >
  {
    gtk_selection_data_get_target($!s);
  }

  proto method get_targets (|)
    is also<get-targets>
  { * }

  multi method get_targets (:$raw = False) is also<targets> {
    samewith($, $, :$raw);
  }
  multi method get_targets ($targets is rw, $n_atoms is rw, :$raw = False) {
    my $t = CArray[CArray[GdkAtom]].new;
    my gint $na = 0;

    $t[0] = CArray[GdkAtom];
    gtk_selection_data_get_targets($!s, $t, $na);
    $n_atoms = $na;

    return Nil unless $t[0];
    return $t[0] if $raw;

    CArrayToArray($t[0], $n_atoms);
  }

  method get_text is also<get-text> {
    gtk_selection_data_get_text($!s);
  }

  method set (GdkAtom $type, Int() $format, Str() $data, Int() $length) {
    my gint ($f, $l) = ($format, $length);

    gtk_selection_data_set($!s, $type, $format, $data, $length);
  }

  method set_text (Str() $str, Int() $len)
    is also<set-text>
  {
    my gint $l = $len;

    gtk_selection_data_set_text($!s, $str, $len);
  }

  method targets_include_image (Int() $writeable)
    is also<targets-include-image>
  {
    my gboolean $w = $writeable.so.Int;

    so gtk_selection_data_targets_include_image($!s, $w);
  }

  multi method targets_include_rich_text (GtkTextBuffer() $buffer)
    is also<targets-include-rich-text>
  {
    so gtk_selection_data_targets_include_rich_text($!s, $buffer);
  }

  method targets_include_text is also<targets-include-text> {
    so gtk_selection_data_targets_include_text($!s);
  }

  method targets_include_uri is also<targets-include-uri> {
    so gtk_selection_data_targets_include_uri($!s);
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
