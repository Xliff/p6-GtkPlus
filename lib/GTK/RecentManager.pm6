use v6.c;

use Method::Also;
use NativeCall;

use GTK::Raw::Types;

use GTK::Raw::RecentInfo;   # Contains Raw calls for ::RecentManager

use GLib::GList;
use GLib::Value;
use GTK::RecentInfo;

use GLib::Roles::ListData;
use GLib::Roles::Properties;
use GTK::Roles::Signals::Generic;

class GTK::RecentManager {
  also does GLib::Roles::Properties;
  also does GTK::Roles::Signals::Generic;

  has GtkRecentManager $!rm is implementor;

  submethod BUILD (:$manager) {
    self!setObject($!rm = $manager);
  };

  method GTK::Raw::Definitions::GtkRecentManager
    is also<
      RecentManager
      GtkRecentManagers
    >
  { * }

  multi method new (GtkRecentManager $manager) {
    $manager ?? self.bless( :$manager ) !! Nil;
  }
  multi method new {
    my $manager = gtk_recent_manager_new();

    $manager ?? self.bless( :$manager ) !! Nil;
  }

  method get_default {
    my $manager = gtk_recent_manager_get_default();

    $manager ?? self.bless( :$manager ) !! Nil;
  }

  # Type: gint
  method size is rw  {
    my GLib::Value $gv .= new( G_TYPE_INT );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('size', $gv)
        );
        $gv.int;
      },
      STORE => -> $, Int() $val is copy {
        warn "{ self.^name }.size does not allow writing"
      }
    );
  }


  # Is originally:
  # GtkRecentManager, gpointer --> void
  method changed {
    self.connect($!rm, 'changed');
  }

  method add_full (Str() $uri, GtkRecentData $recent_data) {
    so gtk_recent_manager_add_full($!rm, $uri, $recent_data);
  }

  method add_item (Str() $uri) {
    so gtk_recent_manager_add_item($!rm, $uri);
  }

  method error_quark {
    gtk_recent_manager_error_quark();
  }

  method get_items (:$glist = False, :$raw = False) {
    my $il = gtk_recent_manager_get_items($!rm);

    return Nil unless $il;
    return $il if $glist;

    $il = GLib::GList.new($il) but GLib::Roles::ListData[GtkRecentInfo];
    $raw ?? $il.Array !! $il.Array.map({ GTK::RecentInfo.new($_) });
  }

  method get_type {
    state ($n, $t);
    unstable_get_type( self.^name, &gtk_recent_manager_get_type, $n, $t );
  }

  method has_item (Str() $uri) {
    so gtk_recent_manager_has_item($!rm, $uri);
  }

  method lookup_item (
    Str() $uri,
    CArray[Pointer[GError]] $error = gerror(),
    :$raw = False
  ) {
    clear_error
    my $rc = gtk_recent_manager_lookup_item($!rm, $uri, $error);
    set_error($error);

    $rc ??
      ( $raw ?? $rc !! GTK::RecentInfo.new($rc) )
      !!
      Nil;
  }

  method move_item (
    Str() $uri,
    Str() $new_uri,
    CArray[Pointer[GError]] $error = gerror()
  ) {
    clear_error;
    my $rc = so gtk_recent_manager_move_item($!rm, $uri, $new_uri, $error);
    set_error($error);
    $rc;
  }

  method purge_items (
    CArray[Pointer[GError]] $error = gerror()
  ) {
    clear_error;
    my $rc = gtk_recent_manager_purge_items($!rm, $error);
    set_error($error);
    $rc;
  }

  method remove_item (
    Str() $uri,
    CArray[Pointer[GError]] $error = gerror()
  ) {
    clear_error;
    my $rc = so gtk_recent_manager_remove_item($!rm, $uri, $error);
    set_error($error);
    $rc;
  }

}
