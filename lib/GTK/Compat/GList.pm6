use v6.c;

use GTK::Compat::Raw::GList;

use GTK::Compat::Types;

class GTK::Compat::GList {
  has GList $!list;
  has @!nat;
  has $!dirty = False;

  submethod BUILD(:$!list) { say $!list; }

  submethod DESTROY {
    self.free;
  }

  multi method new {
    my $list = g_list_alloc();
    die "Cannot allocate GList" unless $list;

    self.bless(:$list);
  }
  multi method new($list) {
    self.bless(:$list);
  }

  method GTK::Compat::Types::GList {
    $!list;
  }

  method data {
    $!list.data;
  }

  method next {
    $!list.next;
  }

  method prev {
    $!list.prev;
  }

  method !rebuild {
    my GList $l;

    say $!list.data;
    say $!list.prev;
    say $!list.next;

    @!nat = ();
    loop ($l = self.first; $l != GList; $l = $l.next) {
      @!nat.push: $l;
    }
    @!nat;
  }

  method Array {
    self!rebuild if $!dirty;
    $!dirty = False;
    @!nat;
  }

  method append (gpointer $data) {
    my $list = g_list_append($!list, $data);
    $!dirty = True;
    $!list = $list;
  }

  multi method concat (GTK::Compat::GList:U: GList $list1, GList $list2) {
    g_list_concat($list1, $list2);
  }
  multi method concat (GList $list2) {
    my $list = g_list_concat($!list, $list2);
    $!dirty = True;
    $!list = $list;
  }

  method copy {
    g_list_copy($!list);
  }

  method copy_deep (GCopyFunc $func, gpointer $user_data) {
    g_list_copy_deep($!list, $func, $user_data);
  }

  method delete_link (GList $link) {
    my $list = g_list_delete_link($!list, $link);
    $!dirty = True;
    $!list = $list;
  }

  method find (gconstpointer $data) {
    g_list_find($!list, $data);
  }

  method find_custom (gconstpointer $data, GCompareFunc $func) {
    g_list_find_custom($!list, $data, $func);
  }

  method first {
    #g_list_first($!list);
    $!list;
  }

  method foreach (GFunc $func, gpointer $user_data) {
    g_list_foreach($!list, $func, $user_data);
  }

  method free {
    g_list_free($!list);
  }

  method free_1 {
    g_list_free_1($!list);
  }

  method free_full (GDestroyNotify $free_func) {
    g_list_free_full($!list, $free_func);
  }

  method index (gconstpointer $data) {
    g_list_index($!list, $data);
  }

  method insert (gpointer $data, gint $position) {
    my $list = g_list_insert($!list, $data, $position);
    $!dirty = True;
    $!list = $list;
  }

  method insert_before (GList $sibling, gpointer $data) {
    my $list = g_list_insert_before($!list, $sibling, $data);
    $!dirty = True;
    $!list = $list;
  }

  method insert_sorted (gpointer $data, GCompareFunc $func) {
    my $list = g_list_insert_sorted($!list, $data, $func);
    $!dirty = True;
    $!list = $list;
  }

  method insert_sorted_with_data (gpointer $data, GCompareDataFunc $func, gpointer $user_data) {
    my $list = g_list_insert_sorted_with_data($!list, $data, $func, $user_data);
    $!dirty = True;
    $!list = $list;
  }

  method last {
    g_list_last($!list);
  }

  method length {
    g_list_length($!list);
  }

  method nth (guint $n) {
    g_list_nth($!list, $n);
  }

  method nth_data (guint $n) {
    g_list_nth_data($!list, $n);
  }

  method nth_prev (guint $n) {
    g_list_nth_prev($!list, $n);
  }

  method position (GList $llink) {
    g_list_position($!list, $llink);
  }

  method prepend (gpointer $data) {
    my $list = g_list_prepend($!list, $data);
    $!dirty = True;
    $!list = $list;
  }

  method remove (gconstpointer $data) {
    my $list = g_list_remove($!list, $data);
    $!dirty = True;
    $!list = $list;
  }

  method remove_all (gconstpointer $data) {
    g_list_remove_all($!list, $data);
    @!nat = ();
  }

  method remove_link (GList $llink) {
    my $list = g_list_remove_link($!list, $llink);
    $!dirty = True;
    $!list = $list;
  }

  method reverse {
    my $list = g_list_reverse($!list);
    self!rebuild if $!dirty;
    @!nat = @!nat.reverse;
    $!list = $list;
  }

  method sort (GCompareFunc $compare_func) {
    $!list = g_list_sort($!list, $compare_func);
  }

  method sort_with_data (GCompareDataFunc $compare_func, gpointer $user_data) {
    $!list = g_list_sort_with_data($!list, $compare_func, $user_data);
  }

}
