use v6.c;

use Method::Also;

use GTK::Compat::Types;

use GLib::Raw::GSList;

class GLib::GSList {
  has GSList $!list;
  has GSList $!cur;

  has @!nat;

  # Left active, but see NOTE in GLib::GList
  has $.dirty = False;

  # CLASS HAS NOT PROPERLY BEEN OPTIMIZED FOR PERL6.
  #
  # At best, this will serve to perform basic operations for any widgets
  # that use it.
  #
  # Memory management is a SPECIFIC concern.

  submethod BUILD(:$list) {
    $!dirty = True;
    $!cur   = $!list = $list;
  }

  # May need to write something to free every element in the list.
  submethod DESTROY {
    self.free;
  }

  # XXX - THIS DOES NOT CURRENTLY WORK WITHOUT A WAY TO SET DATA! - XXX
  # Not liking this. See if it can be improved.
  multi method new (@list) {
    my $list;
    for @list {
      my $l = GLib::GSList.alloc();
      $l.data = $_;
      with $list  {
        $list.append($l);
      } else {
        $list = self.bless(list => $l);
      }
    }
    $list;
  }
  multi method new (GSList $list?) {
    with $list {
      self.bless(:$list);
    } else {
      my $list = GLib::GSList.alloc();
      self.bless(:$list)
    }
  }

  method GTK::Compat::Types::GSList
    is also<GSList>
  { $!list }

  method !_data is rw {
    $!cur.data;
  }

  method cleaned {
    $!dirty = False;
  }

  method current_node
    is also<
      current-node
      cur
      current
      node
    >
  { $!cur }

  method data is rw {
    self!_data;
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

  method copy_deep (GCopyFunc $func, gpointer $user_data) is also<copy-deep> {
    g_slist_copy_deep($!list, $func, $user_data);
  }

  method delete_link (GSList $link) is also<delete-link> {
    g_slist_delete_link($!list, $link);
  }

  method find (gpointer $data) {
    g_slist_find($!list, $data);
  }

  method find_custom (gpointer $data, GCompareFunc $func)
    is also<find-custom>
  {
    g_slist_find_custom($!list, $data, $func);
  }

  method foreach (GFunc $func, gpointer $user_data) {
    g_slist_foreach($!list, $func, $user_data);
  }

  method free {
    g_slist_free($!list);
  }

  method free_1 is also<free1> {
    g_slist_free_1($!list);
  }

  method free_full (GDestroyNotify $free_func) is also<free-full> {
    g_slist_free_full($!list, $free_func);
  }

  method index (gpointer $data) {
    g_slist_index($!list, $data);
  }

  method insert (gpointer $data, Int() $position) {
    my gint $p = $position;

    g_slist_insert($!list, $data, $p);
  }

  method insert_before (GSList $sibling, gpointer $data)
    is also<insert-before>
  {
    g_slist_insert_before($!list, $sibling, $data);
  }

  method insert_sorted (gpointer $data, GCompareFunc $func)
    is also<insert-sorted>
  {
    g_slist_insert_sorted($!list, $data, $func);
  }

  method insert_sorted_with_data (
    gpointer $data,
    GCompareDataFunc $func,
    gpointer $user_data
  )
    is also<insert-sorted-with-data>
  {
    g_slist_insert_sorted_with_data($!list, $data, $func, $user_data);
  }

  method last {
    g_slist_last($!list);
  }

  method length {
    g_slist_length($!list);
  }

  method next {
    $!cur .= next;
  }

  method nth (Int() $n) {
    my guint $nn = $n;

    g_slist_nth($!list, $nn);
  }

  method nth_data (Int() $n) is also<nth-data> {
    my guint $nn = $n;

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

  method remove_all (gpointer $data) is also<remove-all> {
    g_slist_remove_all($!list, $data);
  }

  method remove_link (GSList $link) is also<remove-link> {
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
  )
    is also<sort-with-data>
  {
    g_slist_sort_with_data($!list, $compare_func, $user_data);
  }

}
