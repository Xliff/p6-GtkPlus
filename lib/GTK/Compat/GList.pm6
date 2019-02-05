use v6.c;

use Method::Also;
use NativeCall;

use GTK::Compat::Raw::GList;
use GTK::Compat::Types;

class GTK::Compat::GList {
  also does Positional;
  also does Iterator;

  has GTK::Compat::Types::GList $!list;
  has GTK::Compat::Types::GList $!cur;
  has @!nat handles
    «pull-one iterator elems AT-POS EXISTS-POS join :p6sort('sort')»;
  has $!dirty = False;
  has $!type;

  submethod BUILD(:$type, :$list) {
    die 'Must use a type object for $type when creating a GTK::Compat::GSList'
      if $type.defined;

    $!cur = $!list = $list;
    $!type := $type;
    while $!cur.defined {
      @!nat.push: self.data;
      $!cur .= next;
    }
    $!cur = $!list;
  }

  submethod DESTROY {
    #self.free;
  }

  multi method new($type) {
    my $list = g_list_alloc();
    die "Cannot allocate GList" unless $list;

    self.bless(:$type, :$list);
  }
  multi method new($type, GTK::Compat::Types::GList $list) {
    self.bless(:$type, :$list);
  }

  method GTK::Compat::Types::GList is also<glist> {
    $!list;
  }

  method List {
    @!nat.clone;
  }

  method data {
    self!_data($!cur);
  }

  method !_data(GTK::Compat::Types::GList $n) {
    given $!type {
      when  uint64 | uint32 | uint16 | uint8 |
             int64 |  int32 |  int16 |  int8 |
             num64 |  num32
      {
        $n.data.deref;
      }

      when Str {
        nativecast($_, $n.data);
      }

      when .REPR eq <CPointer CStruct>.any {
        nativecast($_, $n.data);
      }

      default {
        die "Unknown type '{ .^name }' passed to GTK::Compat::List.new()";
      }
    }
  }

  # Need a current pointer.
  method next {
    $!cur .= next;
  }

  method prev {
    $!cur .= prev;
  }

  method !rebuild {
    my GTK::Compat::Types::GList $l;

    @!nat = ();
    loop ($l = self.first; $l != GList; $l = $l.next) {
      @!nat.push: self.data($l);
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

  multi method concat (
    GTK::Compat::GList:U:
    GTK::Compat::Types::GList $list1,
    GTK::Compat::Types::GList $list2
  ) {
    g_list_concat($list1, $list2);
  }
  multi method concat (GTK::Compat::Types::GList $list2) {
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

  method delete_link (GTK::Compat::Types::GList $link) {
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
    $!cur = $!list;
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

  method free_full(&free_func?) {
    my &func := &free_func // &g_destroy_none;
    g_list_free_full($!list, &func);
  }

  method index (gconstpointer $data) {
    g_list_index($!list, $data);
  }

  method insert (gpointer $data, gint $position) {
    my $list = g_list_insert($!list, $data, $position);
    $!dirty = True;
    $!list = $list;
  }

  method insert_before (GTK::Compat::Types::GList $sibling, gpointer $data) {
    my $list = g_list_insert_before($!list, $sibling, $data);
    $!dirty = True;
    $!list = $list;
  }

  method insert_sorted (gpointer $data, GCompareFunc $func) {
    my $list = g_list_insert_sorted($!list, $data, $func);
    $!dirty = True;
    $!list = $list;
  }

  method insert_sorted_with_data (
    gpointer $data,
    GCompareDataFunc $func,
    gpointer $user_data
  ) {
    my $list = g_list_insert_sorted_with_data(
      $!list, $data, $func, $user_data
    );
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

  method position (GTK::Compat::Types::GList $llink) {
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

  method remove_link (GTK::Compat::Types::GList $llink) {
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
