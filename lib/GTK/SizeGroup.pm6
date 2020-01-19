use v6.c;

use Method::Also;
use NativeCall;

use GTK::Raw::SizeGroup;
use GTK::Raw::Types;

use GLib::GList;

use GLib::Roles::Object;
use GLib::Roles::ListData;

class GTK::SizeGroup {
  also does GLib::Roles::Object;

  has GtkSizeGroup $!sg is implementor;

  submethod BUILD(:$sizegroup) {
    self!setObject($!sg = $sizegroup);
  }

  method GTK::Raw::Definitions::GtkSizeGroup
    is also<
      SizeGroup
      GtkSizeGroup
    >
  { $!sg }

  multi method new (
    :h(:$horizontal),
    :v(:$vertical)
  ) {
    die 'Please specify either :horizontal or :vertical in call to GTK::SizeGroup.new'
      unless $horizontal ^^ $vertical;
    my $m = do {
      when $horizontal.so { GTK_ORIENTATION_HORIZONTAL }
      when $vertical.so   { GTK_ORIENTATION_VERTICAL   }
    };
    samewith($m);
  }
  multi method new (Int() $sizegroupmode) {
    my uint32 $s = $sizegroupmode;

    my $sizegroup = gtk_size_group_new($s);

    $sizegroup ?? self.bless(:$sizegroup) !! Nil;
  }
  multi method new(GtkSizeGroup $sizegroup) {
    $sizegroup ?? self.bless(:$sizegroup) !! Nil;
  }

  # ↓↓↓↓ SIGNALS ↓↓↓↓
  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  method ignore_hidden is rw is also<ignore-hidden> {
    Proxy.new(
      FETCH => sub ($) {
        Bool( gtk_size_group_get_ignore_hidden($!sg) );
      },
      STORE => sub ($, Int() $ignore_hidden is copy) {
        my gboolean $i = $ignore_hidden.so.Int;

        gtk_size_group_set_ignore_hidden($!sg, $ignore_hidden);
      }
    );
  }

  method mode is rw {
    Proxy.new(
      FETCH => sub ($) {
        GtkSizeGroupModeEnum( gtk_size_group_get_mode($!sg) );
      },
      STORE => sub ($, Int() $mode is copy) {
        my uint32 $m = $mode;

        gtk_size_group_set_mode($!sg, $m);
      }
    );
  }
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  method add_widget (GtkWidget() $widget) is also<add-widget> {
    gtk_size_group_add_widget($!sg, $widget);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gtk_size_group_get_type, $n, $t );
  }

  # Should this attempt to use GTK::Widget.CreateObject?
  method get_widgets (:$glist = False, :$raw = False) is also<get-widgets> {
    my $wl = gtk_size_group_get_widgets($!sg);

    return Nil unless $wl;
    return $wl if $glist;

    $wl = GLib::GList.new($wl) but GLib::Roles::ListData[GtkWidget];
    $raw ?? $wl.Array !! $wl.Array.map({ GTK::Widget.new($_) });
  }

  method remove_widget (GtkWidget() $widget) is also<remove-widget> {
    gtk_size_group_remove_widget($!sg, $widget);
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
