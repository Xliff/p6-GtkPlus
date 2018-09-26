use v6.c;

use GTK::Compat::Raw::GSList;

use GTK::Compat::Types;

class GTK::Compat::GSList {
  has GSList $!list;
  has @!nat;
  has $!dirty = False;

  # CLASS HAS NOT PROPERLY BEEN OPTIMIZED FOR PERL6.
  #
  # At best, this will serve to perform basic operations for any widgets
  # that use it.
  #
  # Memory management is a SPECIFIC concern.

  submethod BUILD(:$!list) { }


  submethod DESTROY {
    self.free;
  }

  method new(:$list) {
    with $list {
      self.bless(:$list);
    } else {
      my $list = GTK::Compat::GSList.alloc();
      self.bless(:$list)
    }
  }

  method GTK::Compat::Types::GSList {
    $!list;
  }

  # Import methods from
  # https://developer.gnome.org/glib/stable/glib-Singly-Linked-Lists.html

  method alloc {
    g_slist_alloc();
  }

  method append (gpointer $data) {
    g_slist_append($!list, $data);
  }

  method concat (GSList $list2) {
    g_slist_concat($!list, $list2);
  }

  method copy {
    g_slist_copy($!list);
  }

  method copy_deep (GCopyFunc $func, gpointer $user_data) {
    g_slist_copy_deep($!list, $func, $user_data);
  }

  method delete_link (GSList $link_) {
    g_slist_delete_link($!list, $link_);
  }

  method find (gpointer $data) {
    g_slist_find($!list, $data);
  }

  method find_custom (gpointer $data, GCompareFunc $func) {
    g_slist_find_custom($!list, $data, $func);
  }

  method foreach (GFunc $func, gpointer $user_data) {
    g_slist_foreach($!list, $func, $user_data);
  }

  method free {
    g_slist_free($!list);
  }

  method free_1 {
    g_slist_free_1($!list);
  }

  method free_full (GDestroyNotify $free_func) {
    g_slist_free_full($!list, $free_func);
  }

  method index (gpointer $data) {
    g_slist_index($!list, $data);
  }

  method insert (gpointer $data, Int() $position) {
    my gint $p = $position +& 0xffff;
    g_slist_insert($!list, $data, $p);
  }

  method insert_before (GSList $sibling, gpointer $data) {
    g_slist_insert_before($!list, $sibling, $data);
  }

  method insert_sorted (gpointer $data, GCompareFunc $func) {
    g_slist_insert_sorted($!list, $data, $func);
  }

  method insert_sorted_with_data (
    gpointer $data,
    GCompareDataFunc $func,
    gpointer $user_data
  ) {
    g_slist_insert_sorted_with_data($!list, $data, $func, $user_data);
  }

  method last {
    g_slist_last($!list);
  }

  method length {
    g_slist_length($!list);
  }

  method nth (Int() $n) {
    my guint $nn = $n +& 0xffff;
    g_slist_nth($!list, $nn);
  }

  method nth_data (Int() $n) {
    my guint $nn = $n +& 0xffff;
    g_slist_nth_data($!list, $nn);
  }

  method position (GSList $llink) {
    g_slist_position($!list, $llink);
  }

  method prepend (gpointer $data) {
    g_slist_prepend($!list, $data);
  }

  method remove (gpointer $data) {
    g_slist_remove($!list, $data);
  }

  method remove_all (gpointer $data) {
    g_slist_remove_all($!list, $data);
  }

  method remove_link (GSList $link) {
    g_slist_remove_link($!list, $link);
  }

  method reverse {
    g_slist_reverse($!list);
  }

  method sort (GCompareFunc $compare_func) {
    g_slist_sort($!list, $compare_func);
  }

  method sort_with_data (
    GCompareDataFunc $compare_func,
    gpointer $user_data
  ) {
    g_slist_sort_with_data($!list, $compare_func, $user_data);
  }

}
