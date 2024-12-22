use v6.c;

use Method::Also;
use NativeCall;

use GTK::Raw::Button:ver<3.0.1146>;
use GTK::Raw::Types:ver<3.0.1146>;

use GTK::Roles::Actionable:ver<3.0.1146>;

use GDK::Window;

use GTK::Bin:ver<3.0.1146>;
use GTK::Widget:ver<3.0.1146>;

our subset GtkButtonAncestry is export of Mu
  where GtkButton | BinAncestry;

constant ButtonAncestry is export = GtkButtonAncestry;

class GTK::Button:ver<3.0.1146> is GTK::Bin {
  also does GTK::Roles::Actionable;

  has GtkButton $!b is implementor;

  submethod BUILD( :$gtk-button) {
    self.setGtkButton($gtk-button) if $gtk-button;
  }

  method GTK::Raw::Definitions::GtkButton
    is also<
      Button
      GtkButton
    >
  { $!b }

  method setGtkButton (ButtonAncestry $_) is also<setButton> {
    my $to-parent;
    $!b = do {
      when GtkButton {
        $to-parent = cast(GtkBin, $_);
        $_;
      }

      when GtkActionable {
        $!action   = $_;
        $to-parent = cast(GtkBin, $_);
        cast(GtkButton, $_);
      }

      default {
        $to-parent = $_;
        cast(GtkButton, $_);
      }
    };
    self.setBin($to-parent);
    self.roleInit-GtkActionable;
  }

  proto method new (|)
  { * }

  multi method new(GtkButtonAncestry $gtk-button, :$ref = True) {
    return Nil unless $gtk-button;

    my $o = self.bless(:$gtk-button);
    $o.ref if $ref;
    $o;
  }
  multi method new {
    my $gtk-button = gtk_button_new();

    $gtk-button ?? self.bless( :$gtk-button ) !! Nil;
  }
  multi method new(|c) {
    die "No matching constructor for: ({ c.map( *.^name ).join(', ') })";
  }


  method new_with_mnemonic (GTK::Button:U: Str() $label)
    is also<new-with-mnemonic>
  {
    my $gtk-button = gtk_button_new_with_mnemonic($label);

    $gtk-button ?? self.bless(:$gtk-button) !! Nil;
  }

  method new_from_icon_name (
    GTK::Button:U: Str() $icon_name,
    GtkIconSize $size
  )
    is also<new-from-icon-name>
  {
    my GtkIconSize $s = $size;

    my $gtk-button = gtk_button_new_from_icon_name($icon_name, $s);

    $gtk-button ?? self.bless(:$gtk-button) !! Nil;
  }

  method new_from_stock (
    GTK::Button:U: Str() $stock_id
  )
    is also<new-from-stock>
  {
    my $gtk-button = gtk_button_new_from_stock($stock_id);

    $gtk-button ?? self.bless(:$gtk-button) !! Nil;
  }

  method new_with_label (
    GTK::Button:U: Str() $label
  )
    is also<new-with-label>
  {
    my $gtk-button = gtk_button_new_with_label($label);

    $gtk-button ?? self.bless(:$gtk-button) !! Nil;
  }

  method always_show_image is rw is also<always-show-image> {
    Proxy.new(
      FETCH => sub ($) {
        so gtk_button_get_always_show_image($!b);
      },
      STORE => sub ($, Int() $always_show is copy) {
        my gboolean $as = $always_show.so.Int;

        gtk_button_set_always_show_image($!b, $as);
      }
    );
  }

  method focus_on_click is rw is also<focus-on-click> {
    Proxy.new(
      FETCH => sub ($) {
        Bool( gtk_button_get_focus_on_click($!b) );
      },
      STORE => sub ($, Int() $focus_on_click is copy) {
        my gboolean $fc = $focus_on_click.so.Int;

        gtk_button_set_focus_on_click($!b, $fc);
      }
    );
  }

  method image (:$raw = False) is rw {
    Proxy.new(
      FETCH => sub ($) {
        # Return a GTK::Widget at this stage and
        # let the caller worry about the details!
        my $i = gtk_button_get_image($!b);

        $i ??
          ( $raw ?? $i !! GTK::Widget.new($i) )
          !!
          Nil;
      },
      STORE => sub ($, GtkWidget() $image is copy) {
        gtk_button_set_image($!b, $image);
      }
    );
  }

  method image_position is rw is also<image-position> {
    Proxy.new(
      FETCH => sub ($) {
        GtkPositionTypeEnum( gtk_button_get_image_position($!b) );
      },
      STORE => sub ($, Int() $position is copy) {
        my uint32 $p = $position;

        gtk_button_set_image_position($!b, $p);
      }
    );
  }

  method label is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_button_get_label($!b);
      },
      STORE => sub ($, Str() $label is copy) {
        gtk_button_set_label($!b, $label);
      }
    );
  }

  method relief is rw {
    Proxy.new(
      FETCH => sub ($) {
        GtkReliefStyleEnum( gtk_button_get_relief($!b) );
      },
      STORE => sub ($, Int() $relief is copy) {
        my uint32 $r = $relief;

        gtk_button_set_relief($!b, $r);
      }
    );
  }

  method use_stock is rw is also<use-stock> {
    Proxy.new(
      FETCH => sub ($) {
        so gtk_button_get_use_stock($!b);
      },
      STORE => sub ($, Int() $use_stock is copy) {
        my gboolean $us = $use_stock.so.Int;

        gtk_button_set_use_stock($!b, $us);
      }
    );
  }

  method use_underline is rw is also<use-underline> {
    Proxy.new(
      FETCH => sub ($) {
        so gtk_button_get_use_underline($!b);
      },
      STORE => sub ($, $use_underline is copy) {
        my gboolean $uu = $use_underline.so.Int;

        gtk_button_set_use_underline($!b, $use_underline);
      }
    );
  }

  # Is originally:
  # GtkButton, gpointer --> void
  method activate {
    self.connect($!b, 'activate');
  }

  # Is originally:
  # GtkButton, gpointer --> void
  method clicked {
    self.connect($!b, 'clicked');
  }

  # Is originally:
  # GtkButton, gpointer --> void
  method enter {
    self.connect($!b, 'enter');
  }

  # Is originally:
  # GtkButton, gpointer --> void
  method leave {
    self.connect($!b, 'leave');
  }

  # Is originally:
  # GtkButton, gpointer --> void
  method pressed {
    self.connect($!b, 'pressed');
  }

  # Is originally:
  # GtkButton, gpointer --> void
  method released {
    self.connect($!b, 'released');
  }

  # Renamed from "clicked" due to conflict with the signal.
  method emit-clicked is also<emit_clicked> {
    gtk_button_clicked($!b);
  }

  multi method get-alignment (Num() $xalign is rw, Num() $yalign is rw)
    is DEPRECATED
  {
    self.get_alignment($xalign, $yalign);
  }
  multi method get_alignment (Num() $xalign is rw, Num() $yalign is rw)
    is DEPRECATED
  {
    my gfloat ($xa, $ya) = ($xalign, $yalign);
    my $rc = gtk_button_get_alignment($!b, $xa, $ya);

    ($xalign, $yalign) = ($xa, $ya);
    $rc;
  }
  multi method get-alignment is DEPRECATED {
    self.get_alignment;
  }
  multi method get_alignment is DEPRECATED {
    my ($x, $y);
    samewith($x, $y);
    ($x, $y);
  }

  method get_event_window (:$raw = False) is also<get-event-window> {
    my $w = gtk_button_get_event_window($!b);

    $w ??
      ( $raw ?? $w !! GDK::Window.new($w) )
      !!
      Nil;
  }

  # Used for type checking at the C level.
  method get_type {
    state ($n, $t);

    self.unstable_get_type( &gtk_button_get_type, $n, $t )
  }

  method set_alignment (Num() $xalign, Num() $yalign)
    is also<set-alignment>
  {
    my gfloat ($xa, $ya) = ($xalign, $yalign);

    gtk_button_set_alignment($!b, $xalign, $yalign);
  }

}
