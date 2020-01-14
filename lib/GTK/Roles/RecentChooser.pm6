use v6.c;

use Method::Also;
use NativeCall;

use GTK::Raw::Types;

use GTK::Raw::RecentChooser;

use GTK::RecentFilter;
use GTK::RecentInfo;

use GTK::Roles::Signals::Generic;

role GTK::Roles::RecentChooser {
  also does GTK::Roles::Signals::Generic;

  has GtkRecentChooser $!rc;

  method roleInit-RecentChooser {
    my \i = findProperImplementor(self.^attributes);

    $!rc = cast( GtkRecentChooser, i.get_value(self) );
  }

  method filter is rw {
    Proxy.new(
      FETCH => sub ($) {
        GTK::RecentFilter.new( gtk_recent_chooser_get_filter($!rc) );
      },
      STORE => sub ($, GtkRecentFilter() $filter is copy) {
        gtk_recent_chooser_set_filter($!rc, $filter);
      }
    );
  }

  method limit is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_recent_chooser_get_limit($!rc);
      },
      STORE => sub ($, Int() $limit is copy) {
        my gint $l = $limit;

        gtk_recent_chooser_set_limit($!rc, $l);
      }
    );
  }

  method local_only is rw is also<local-only> {
    Proxy.new(
      FETCH => sub ($) {
        so gtk_recent_chooser_get_local_only($!rc);
      },
      STORE => sub ($, Int() $local_only is copy) {
        my gboolean $l = $local_only.so.Int;

        gtk_recent_chooser_set_local_only($!rc, $local_only);
      }
    );
  }

  method select_multiple is rw is also<select-multiple> {
    Proxy.new(
      FETCH => sub ($) {
        so gtk_recent_chooser_get_select_multiple($!rc);
      },
      STORE => sub ($, $select_multiple is copy) {
        my gboolean $s = $select_multiple.so.Int;

        gtk_recent_chooser_set_select_multiple($!rc, $s);
      }
    );
  }

  method show_icons is rw is also<show-icons> {
    Proxy.new(
      FETCH => sub ($) {
        so gtk_recent_chooser_get_show_icons($!rc);
      },
      STORE => sub ($, Int() $show_icons is copy) {
        my gboolean $s = $show_icons.so.Int;

        gtk_recent_chooser_set_show_icons($!rc, $s);
      }
    );
  }

  method show_not_found is rw is also<show-not-found> {
    Proxy.new(
      FETCH => sub ($) {
        so gtk_recent_chooser_get_show_not_found($!rc);
      },
      STORE => sub ($, Int() $show_not_found is copy) {
        my gboolean $s = $show_not_found.so.Int;

        gtk_recent_chooser_set_show_not_found($!rc, $s);
      }
    );
  }

  method show_private is rw is also<show-private> {
    Proxy.new(
      FETCH => sub ($) {
        so gtk_recent_chooser_get_show_private($!rc);
      },
      STORE => sub ($, Int() $show_private is copy) {
        my gboolean $s = $show_private.so.Int;

        gtk_recent_chooser_set_show_private($!rc, $s);
      }
    );
  }

  method show_tips is rw is also<show-tips> {
    Proxy.new(
      FETCH => sub ($) {
        so gtk_recent_chooser_get_show_tips($!rc);
      },
      STORE => sub ($, Int() $show_tips is copy) {
        my gboolean $s = $show_tips.so.Int;

        gtk_recent_chooser_set_show_tips($!rc, $s);
      }
    );
  }

  method sort_type is rw is also<sort-type> {
    Proxy.new(
      FETCH => sub ($) {
        GtkRecentSortTypeEnum( gtk_recent_chooser_get_sort_type($!rc) );
      },
      STORE => sub ($, Int() $sort_type is copy) {
        my gint $s = $sort_type;

        gtk_recent_chooser_set_sort_type($!rc, $s);
      }
    );
  }

  # Is originally:
  # GtkRecentChooser, gpointer --> void
  method item-activated is also<item_activated> {
    self.connect($!rc, 'item-activated');
  }

  # Is originally:
  # GtkRecentChooser, gpointer --> void
  method selection-changed is also<selection_changed> {
    self.connect($!rc, 'selection-changed');
  }

  method add_filter (GtkRecentFilter() $filter) is also<add-filter> {
    gtk_recent_chooser_add_filter($!rc, $filter);
  }

  method error_quark is also<error-quark> {
    gtk_recent_chooser_error_quark();
  }

  method get_current_item (:$raw = False)
    is also<
      get-current-item
      current_item
      current-item
    >
  {
    my $info = gtk_recent_chooser_get_current_item($!rc);

    $info ??
      ( $raw ?? $info !! GTK::RecentInfo.new($info) )
      !!
      Nil;
  }

  method get_current_uri
    is also<
      get-current-uri
      current_uri
      current-uri
    >
  {
    gtk_recent_chooser_get_current_uri($!rc);
  }

  method get_items (:$glist = False, :$raw = False)
    is also<
      get-items
      items
    >
  {
    my $i = gtk_recent_chooser_get_items($!rc);

    return Nil unless $i;
    return $i if $glist;

    $i = GLib::List.new($i) but GLib::Roles::ListData[GtkRecentInfo];
    $raw ?? $i.Array !! $i.Array.map({ GTK::RecentInfo.new($_) });
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gtk_recent_chooser_get_type, $n, $t);
  }

  method get_uris ($length is rw) is also<get-uris> {
    my gint $l = 0;
    my CArray[Str] $u = gtk_recent_chooser_get_uris($!rc, $l);
    $length = $l;

    CStringArrayToArray($u, $l);
  }

  method list_filters (:$glist = False, :$raw = False) is also<list-filters> {
    my $fl = gtk_recent_chooser_list_filters($!rc);

    return Nil unless $fl;
    return $fl if $glist;

    $fl = GDK::GList.new($fl) but GLib::Roles::ListData[GtkRecentFilter];
    $raw ?? $fl.Array !! $fl.Array.map({ GTK::RecentFilter.new($_) });
  }

  method remove_filter (GtkRecentFilter() $filter) is also<remove-filter> {
    gtk_recent_chooser_remove_filter($!rc, $filter);
  }

  method select_all is also<select-all> {
    gtk_recent_chooser_select_all($!rc);
  }

  method select_uri (
    Str() $uri,
    CArray[Pointer[GError]] $error = gerror()
  )
    is also<select-uri>
  {
    clear_error;
    my $rc = gtk_recent_chooser_select_uri($!rc, $uri, $error);
    set_error($error);
    $rc;
  }

  method set_current_uri (
    Str() $uri,
    CArray[Pointer[GError]] $error = gerror()
  )
    is also<set-current-uri>
  {
    clear_error;
    my $rc = gtk_recent_chooser_set_current_uri($!rc, $uri, $error);
    set_error($error);
    $rc;
  }

  method set_sort_func (
    GtkRecentSortFunc $sort_func,
    gpointer $sort_data          = Pointer,
    GDestroyNotify $data_destroy = Pointer
  )
    is also<set-sort-func>
  {
    gtk_recent_chooser_set_sort_func(
      $!rc,
      $sort_func,
      $sort_data,
      $data_destroy
    );
  }

  method unselect_all is also<unselect-all> {
    gtk_recent_chooser_unselect_all($!rc);
  }

  method unselect_uri (Str() $uri) is also<unselect-uri> {
    gtk_recent_chooser_unselect_uri($!rc, $uri);
  }

}
