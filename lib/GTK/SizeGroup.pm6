use v6.c;

use Method::Also;
use NativeCall;


use GTK::Raw::SizeGroup;
use GTK::Raw::Types;

use GTK::Raw::Utils;

use GLib::Roles::Object;

class GTK::SizeGroup {
  also does GLib::Roles::Object;

  has GtkSizeGroup $!sg is implementor;

  submethod BUILD(:$sizegroup) {
    self!setObject($!sg = $sizegroup);
  }

  method GTK::Raw::Types::GtkSizeGroup
    is also<
      GtkSizeGroup
      SizeGroup
    >
  { $!sg }

  multi method new (Int() $sizegroupmode) {
    my uint32 $s = resolve-uint($sizegroupmode);
    my $sizegroup = gtk_size_group_new($s);
    self.bless(:$sizegroup);
  }
  multi method new(GtkSizeGroup $sizegroup) {
    self.bless(:$sizegroup);
  }
  multi method new (:$horizontal, :$vertical) {
    die 'Please specify either :horizontal or :vertical in call to GTK::SizeGroup.new'
      unless $horizontal ^^ $vertical;
    my $m = do {
      when $horizontal { GTK_ORIENTATION_HORIZONTAL }
      when $vertical   { GTK_ORIENTATION_VERTICAL }
    };
    my $sizegroup = gtk_size_group_new($m);
    self.bless(:$sizegroup);
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
        my gboolean $i = resolve-bool($ignore_hidden);
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
        my uint32 $m = resolve-uint($mode);
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
    gtk_size_group_get_type();
  }

  method get_widgets is also<get-widgets> {
    gtk_size_group_get_widgets($!sg);
  }

  method remove_widget (GtkWidget() $widget) is also<remove-widget> {
    gtk_size_group_remove_widget($!sg, $widget);
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
