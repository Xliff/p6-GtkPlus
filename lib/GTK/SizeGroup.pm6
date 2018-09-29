use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::SizeGroup;
use GTK::Raw::Types;

class GTK::SizeGroup {
  has GtkSizeGroup $!sg;

  submethod BUILD(:$sizegroup) {
    $!sg = $sizegroup
  }

  multi method new (Int() $sizegroupmode) {
    my uint32 $s = self.RESOLVE-UINT($sizegroupmode);
    my $sizegroup = gtk_size_group_new($s);
    self.bless(:$sizegroup);
  }
  multi method new(GtkSizeGroup $sizegroup) {
    self.bless(:$sizegroup);
  }

  method GTK::Raw::Types::GtkSizeGroup {
    $!sg;
  }

  # ↓↓↓↓ SIGNALS ↓↓↓↓
  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  method ignore_hidden is rw {
    Proxy.new(
      FETCH => sub ($) {
        Bool( gtk_size_group_get_ignore_hidden($!sg) );
      },
      STORE => sub ($, Int() $ignore_hidden is copy) {
        my gboolean $i = self.RESOLVE-BOOL($ignore_hidden);
        gtk_size_group_set_ignore_hidden($!sg, $ignore_hidden);
      }
    );
  }

  method mode is rw {
    Proxy.new(
      FETCH => sub ($) {
        GtkSizeGroupMode( gtk_size_group_get_mode($!sg) );
      },
      STORE => sub ($, Int() $mode is copy) {
        my uint32 $m = self.RgESOLVE-UINT($mode);
        gtk_size_group_set_mode($!sg, $m);
      }
    );
  }
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  method add_widget (GtkWidget() $widget) {
    gtk_size_group_add_widget($!sg, $widget);
  }

  method get_type {
    gtk_size_group_get_type();
  }

  method get_widgets {
    gtk_size_group_get_widgets($!sg);
  }

  method remove_widget (GtkWidget() $widget) {
    gtk_size_group_remove_widget($!sg, $widget);
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
