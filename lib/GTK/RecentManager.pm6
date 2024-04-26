use v6.c;

use Method::Also;
use NativeCall;

use GTK::Raw::Types:ver<3.0.1146>;

use GTK::Raw::RecentInfo:ver<3.0.1146>;   # Contains Raw calls for ::RecentManager

use GLib::GList;
use GLib::Value;
use GTK::RecentInfo:ver<3.0.1146>;

use GLib::Roles::ListData;
use GLib::Roles::Object;

our subset GtkRecentManagerAncestry is export of Mu
  where GtkRecentManager | GObject;

class GTK::RecentManager:ver<3.0.1146> {
  also does GLib::Roles::Object;

  has GtkRecentManager $!rm is implementor;

  submethod BUILD ( :$gtk-recent-mgr ) {
    self.setGtkRecentManager($gtk-recent-mgr) if $gtk-recent-mgr
  }

  method setGtkRecentManager (GtkRecentManagerAncestry $_) {
    my $to-parent;

    $!rm = do {
      when GtkRecentManager {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GtkRecentManager, $_);
      }
    }
    self!setObject($to-parent);
  }

  method GTK::Raw::Definitions::GtkRecentManager
    is also<
      RecentManager
      GtkRecentManagers
    >
  { $!rm }

  multi method new (
    $gtk-recent-mgr where * ~~ GtkRecentManagerAncestry,

    :$ref = True
  ) {
    return unless $gtk-recent-mgr;

    my $o = self.bless( :$gtk-recent-mgr );
    $o.ref if $ref;
    $o;
  }
  multi method new {
    my $gtk-recent-mgr = gtk_recent_manager_new();

    $gtk-recent-mgr ?? self.bless( :$gtk-recent-mgr ) !! Nil;
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
    returnGList(
      gtk_recent_manager_get_items($!rm),
      $raw,
      $glist,
      |GTK::RecentInfo.getTypePair
    )
  }

  method get_type {
    state ($n, $t);

    unstable_get_type( self.^name, &gtk_recent_manager_get_type, $n, $t );
  }

  method has_item (Str() $uri) {
    so gtk_recent_manager_has_item($!rm, $uri);
  }

  method lookup_item (
    Str()                    $uri,
    CArray[Pointer[GError]]  $error = gerror(),
                            :$raw   = False
  ) {
    clear_error
    my $rc = gtk_recent_manager_lookup_item($!rm, $uri, $error);
    set_error($error);

    propReturnObject($rc, $raw, |GTK::RecentInfo.getTypePair)
  }

  method move_item (
    Str()                   $uri,
    Str()                   $new_uri,
    CArray[Pointer[GError]] $error    = gerror()
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
    Str()                   $uri,
    CArray[Pointer[GError]] $error = gerror()
  ) {
    clear_error;
    my $rc = so gtk_recent_manager_remove_item($!rm, $uri, $error);
    set_error($error);
    $rc;
  }

}
