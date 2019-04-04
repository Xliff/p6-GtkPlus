use v6.c;

use Method::Also;
use NativeCall;

use GTK::Raw::Utils;

use GTK::Compat::Raw::GList;
use GTK::Compat::Types;

# See if this will work properly:
# - Move ALL data related routines to a ListData parameterized role.
# - Have raw_data method implemented in client classes that return the pointer 
#   attribute.

class GTK::Compat::GList {
  #also does Positional;
  #also does Iterator;

  has GTK::Compat::Types::GList $!list;
  has GTK::Compat::Types::GList $!cur;
  
  # Left active, but see NOTE.
  has $.dirty;

  submethod BUILD(:$list) {
    # die 'Must use a type object for $type when creating a GTK::Compat::GSList'
    #   if $type.defined;

    $!dirty = True;
    $!cur = $!list = $list;
    
    # No longer necessary due to GTK::Compat::Roles::ListData
    #$!type := $type;
    
    # See NOTE.
    #
    # while $!cur.defined {
    #   @!nat.push: self.data;
    #   $!cur .= next;
    # }
    # $!cur = $!list;
  }

  submethod DESTROY {
    #self.free;
  }

  multi method new (@list) {
    my $l = GTK::Compat::Types::GList.new;
    for @list {
      # What about prototype numeric data (ints, nums) and Str?
      $l.append( nativecast(Pointer, $_) );
    }
  }
  multi method new {
    my $list = g_list_alloc();
    die "Cannot allocate GList" unless $list;

    self.bless(:$list);
  }
  multi method new ($type, GTK::Compat::Types::GList $list) {
    self.bless(:$list);
  }

  method GTK::Compat::Types::GList is also<GList> { $!list }
  
  method current_node
    is also<
      current-node
      cur
      current
      node
    >
  { $!cur }

  method cleaned {
    $!dirty = False;
  }
  
  method !_data is rw {
    $!cur.data;
  }

  method data is rw {
    self!_data;
  }
  
  # Need a current pointer.
  method next {
    $!cur .= next;
  }

  method prev {
    $!cur .= prev;
  }

  # NOTE -- NOTE -- NOTE -- NOTE -- NOTE -- NOTE -- NOTE -- NOTE -- NOTE
  # Probably better to finish work on GTK::Compat::ListData role and move 
  # the Array backing to it. Until that decision has been made, this code
  # has been deactivated.
  #
  # has @!nat 
  #   handles
  #   «pull-one iterator elems AT-POS EXISTS-POS join :p6sort('sort')»;
  # 
  # method !rebuild {
  #   my GTK::Compat::Types::GList $l;
  # 
  #   @!nat = ();
  #   loop ($l = self.first; $l != GList; $l = $l.next) {
  #     @!nat.push: self.data($l);
  #   }
  #   @!nat;
  # }

  method append (Pointer $data) {
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
  multi method concat (GTK::Compat::Types::GList() $list2) {
    my $list = g_list_concat($!list, $list2);
    $!dirty = True;
    $!list = $list;
  }

  method copy {
    self.bless( 
      #type => $!type, 
      list => g_list_copy($!list) 
    );
  }

  method copy_deep (
    &func, 
    Pointer $user_data = Pointer
  ) 
    is also<copy-deep>
  {
    self.bless( 
      #type => $!type, 
      list => g_list_copy_deep($!list, &func, $user_data)
    );
  }

  method delete_link (GTK::Compat::Types::GList() $link) 
    is also<delete-link>
  {
    my $list = g_list_delete_link($!list, $link);
    $!dirty = True;
    $!list = $list;
  }

  method find (Pointer $data) {
    g_list_find($!list, $data);
  }

  method find_custom (Pointer $data, &func) 
    is also<find-custom>
  {
    g_list_find_custom($!list, $data, &func);
  }

  method first {
    #g_list_first($!list);
    $!cur = $!list;
  }

  method foreach (
    &func, 
    Pointer $user_data = Pointer
  ) {
    g_list_foreach($!list, &func, $user_data);
  }

  method free {
    g_list_free($!list);
  }

  # Aliases with numbers after the dash are still a Bad Idea
  method free_1 {
    g_list_free_1($!list);
  }

  method free_full ( 
    &free_func = -> { } 
  ) 
    is also<free-full> 
  {
    my &func := &free_func // &g_destroy_none;
    g_list_free_full($!list, &func);
  }

  method index (Pointer $data) {
    g_list_index($!list, $data);
  }

  method insert (Pointer $data, Int() $position) {
    my gint $p = resolve-int($position);
    my $list = g_list_insert($!list, $data, $position);
    $!dirty = True;
    $!list = $list;
  }

  method insert_before (GTK::Compat::Types::GList() $sibling, Pointer $data) 
    is also<insert-before>
  {
    my $list = g_list_insert_before($!list, $sibling, $data);
    $!dirty = True;
    $!list = $list;
  }

  method insert_sorted (Pointer $data, &func) 
    is also<insert-sorted>
  {
    my $list = g_list_insert_sorted($!list, $data, &func);
    $!dirty = True;
    $!list = $list;
  }

  method insert_sorted_with_data (
    Pointer $data,
    &func,
    Pointer $user_data = Pointer
  ) 
    is also<insert-sorted-with-data>
  {
    my $list = g_list_insert_sorted_with_data(
      $!list, $data, &func, $user_data
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

  method nth (Int() $n) {
    my guint $nn = resolve-uint($n);
    g_list_nth($!list, $n);
  }

  method nth_data (Int() $n) 
    is also<nth-data>
  {
    my guint $nn = resolve-uint($n);
    g_list_nth_data($!list, $nn);
  }

  method nth_prev (Int() $n) {
    my guint $nn = resolve-uint($n);
    g_list_nth_prev($!list, $nn);
  }

  method position (GTK::Compat::Types::GList() $llink) {
    g_list_position($!list, $llink);
  }

  method prepend (Pointer $data) {
    my $list = g_list_prepend($!list, $data);
    $!dirty = True;
    $!list = $list;
  }

  method remove (Pointer $data) {
    my $list = g_list_remove($!list, $data);
    $!dirty = True;
    $!list = $list;
  }

  method remove_all (Pointer $data) {
    g_list_remove_all($!list, $data);
    $!dirty = True;
    #!nat = ();
  }

  method remove_link (GTK::Compat::Types::GList() $llink) {
    my $list = g_list_remove_link($!list, $llink);
    $!dirty = True;
    $!list = $list;
  }

  method reverse {
    my $list = g_list_reverse($!list);
    $!dirty = True;
    $!list = $list;
  }

  method sort (&compare_func) {
    $!list = g_list_sort($!list, &compare_func);
    $!dirty = True;
  }

  method sort_with_data (&compare_func, Pointer $user_data = Pointer) {
    $!list = g_list_sort_with_data($!list, &compare_func, $user_data);
    $!dirty = True;
  }

}
