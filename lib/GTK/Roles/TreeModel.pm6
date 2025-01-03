use v6.c;

use Method::Also;
use NativeCall;

use GTK::Raw::TreeModel:ver<3.0.1146>;
use GTK::Raw::Types:ver<3.0.1146>;

use GLib::Value;
use GTK::TreeIter:ver<3.0.1146>;
use GTK::TreePath:ver<3.0.1146>;

my %typeData;

role GTK::Roles::TreeModel:ver<3.0.1146> {
  has GtkTreeModel $!tm;

  method roleInit-GtkTreeModel {
    return if $!tm;

    my \i = findProperImplementor(self.^attributes);
    $!tm  = cast( GtkTreeModel, i.get_value(self) );
  }

  method GTK::Raw::Definitions::GtkTreeModel
    is also<
      GtkTreeModel
      TreeModel
    >
  { $!tm }

  method setTypeData (@types) {
    %typeData{ +$!tm.p } = @types;
  }

  method getTypeData {
    %typeData{ +$!tm.p };
  }

  # ↓↓↓↓ SIGNALS ↓↓↓↓

  # Is originally:
  # GtkTreeModel, GtkTreePath, GtkTreeIter, gpointer --> void
  method row-changed is also<row_changed> {
    self.connect($!tm, 'row-changed');
  }

  # Is originally:
  # GtkTreeModel, GtkTreePath, gpointer --> void
  method row-deleted is also<row_deleted> {
    self.connect($!tm, 'row-deleted');
  }

  # Is originally:
  # GtkTreeModel, GtkTreePath, GtkTreeIter, gpointer --> void
  method row-has-child-toggled is also<row_has_child_toggled> {
    self.connect($!tm, 'row-has-child-toggled');
  }

  # Is originally:
  # GtkTreeModel, GtkTreePath, GtkTreeIter, gpointer --> void
  method row-inserted is also<row_inserted> {
    self.connect($!tm, 'row-inserted');
  }

  # Is originally:
  # GtkTreeModel, GtkTreePath, GtkTreeIter, gpointer, gpointer --> void
  method rows-reordered is also<rows_reordered> {
    self.connect($!tm, 'rows-reordered');
  }

  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  method foreach (
             &func,
    gpointer $user_data = gpointer
  ) {
    gtk_tree_model_foreach($!tm, &func, $user_data);
  }

  multi method get (GtkTreeIter() $iter, @types, @cols) {
    samewith($iter, @types, |@cols);
  }
  multi method get (GtkTreeIter() $iter, *@cols) {
    my @r;
    my $t = 0;
    @r.push(
      do {
        my ($v, $c) = (GValue.new, .Int);
        self.get_value($iter, $c, $v);

        say "Get-T: { self.getTypeData.gist }";
        say "Get-C: { $c }";

        GLib::Value.new($v).valueFromGType( self.getTypeData[$c] );
      }
    ) for @cols;

    @r.elems > 1 ?? @r !! @r[0];
  }

  method get_column_type (Int() $index) is also<get-column-type> {
    my gint $i = $index;

    gtk_tree_model_get_column_type($!tm, $i);
  }

  method get_flags is also<get-flags> {
    gtk_tree_model_get_flags($!tm);
  }

  proto method get_iter (|)
    is also<get-iter>
  { * }

  multi method get_iter (GtkTreePath() $path, :$raw = False) {
    my @r = samewith($, $path, :all, :$raw);

    @r[0] ?? @r[1] !! Nil;
  }
  multi method get_iter (
                  $iter is rw,
    GtkTreePath() $path,
                  :$all = False,
                  :$raw = False
  ) {
    $iter = GtkTreeIter.new;

    die 'Could not allocate GtkTreeIter!' unless $iter;

    my $rv = so gtk_tree_model_get_iter($!tm, $iter, $path);

    $iter = $raw ?? $iter !! GTK::TreeIter.new($iter);
    $all.not ?? $rv !! ($rv, $iter);
  }

  proto method get_iter_first(|)
    is also<get-iter-first>
  { * }

  multi method get_iter_first (:$raw = False) {
    samewith($, :all, :$raw)
  }
  multi method get_iter_first ($iter is rw, :$all = False, :$raw = False) {
    $iter = GtkTreeIter.new;

    die 'Could not allocate GtkTreeIter!' unless $iter;

    my $rv = so gtk_tree_model_get_iter_first($!tm, $iter);

    $iter = $raw ?? $iter !! GTK::TreeIter.new($iter);
    $all.not ?? $rv !! ($rv, $iter);
  }

  proto method get_iter_from_string(|)
    is also<get-iter-from-string>
  { * }

  multi method get_iter_from_string (Str() $path_string, :$raw = False) {
    samewith($, $path_string, :all, :$raw);
  }
  multi method get_iter_from_string (
          $iter        is rw,
    Str() $path_string,
          :$all        = False,
          :$raw        = False
  ) {
    $iter = GtkTreeIter.new;

    die 'Could not allocate GtkTreeIter!' unless $iter;

    my $rv = so gtk_tree_model_get_iter_from_string($!tm, $iter, $path_string);

    $iter = $raw ?? $iter !! GTK::TreeIter.new($iter);
    $all.not ?? $rv !! ($rv, $iter);
  }

  method get_n_columns is also<get-n-columns> {
    gtk_tree_model_get_n_columns($!tm);
  }

  method get_path (GtkTreeIter() $iter, :$raw = False) is also<get-path> {
    my $tp = gtk_tree_model_get_path($!tm, $iter);

    $tp ??
      ( $raw ?? $tp !! GTK::TreePath.new($tp) )
      !!
      Nil;
  }

  method get_string_from_iter (GtkTreeIter() $iter)
    is also<get-string-from-iter>
  {
    gtk_tree_model_get_string_from_iter($!tm, $iter);
  }

  method gtktreemodel_get_type is also<gtktreemodel-get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gtk_tree_model_get_type, $n, $t );
  }

  # method get_valist (GtkTreeIter $iter, va_list $var_args) {
  #   gtk_tree_model_get_valist($!tm, $iter, $var_args);
  # }

  proto method get_value (|)
    is also<get-value>
  { * }

  multi method get_value (GtkTreeIter() $iter, Int() $column, :$raw = False) {
    my gint $c     = $column;
    my      $value = GValue.new;

    #say "Iter: $iter";
    #say "Column: $column";

    gtk_tree_model_get_value($!tm, $iter, $c, $value);

    $value ??
      ( $raw ?? $value !! GLib::Value.new($value) )
      !!
      Nil;
  }
  multi method get_value (
    GtkTreeIter() $iter,
    Int()         $column,
    GValue()      $value
  )  {
    # TODO: Check iter for path.
    my gint $c = $column;

    gtk_tree_model_get_value($!tm, $iter, $c, $value);
  }

  method iter_children (GtkTreeIter() $iter, GtkTreeIter() $parent)
    is also<iter-children>
  {
    so gtk_tree_model_iter_children($!tm, $iter, $parent);
  }

  method iter_has_child (GtkTreeIter() $iter) is also<iter-has-child> {
    so gtk_tree_model_iter_has_child($!tm, $iter);
  }

  method iter_n_children (GtkTreeIter() $iter) is also<iter-n-children> {
    gtk_tree_model_iter_n_children($!tm, $iter);
  }

  method iter_next (GtkTreeIter() $iter) is also<iter-next> {
    so gtk_tree_model_iter_next($!tm, $iter);
  }

  method iter_nth_child (
    GtkTreeIter() $iter,
    GtkTreeIter() $parent,
    Int()         $n
  )
    is also<iter-nth-child>
  {
    my gint $nn = $n;
    so gtk_tree_model_iter_nth_child($!tm, $iter, $parent, $nn);
  }

  method iter_parent (GtkTreeIter() $iter, GtkTreeIter() $child)
    is also<iter-parent>
  {
    so gtk_tree_model_iter_parent($!tm, $iter, $child);
  }

  method iter_previous (GtkTreeIter() $iter) is also<iter-previous> {
    so gtk_tree_model_iter_previous($!tm, $iter);
  }

  method ref_node (GtkTreeIter() $iter) is also<ref-node> {
    gtk_tree_model_ref_node($!tm, $iter);
  }

  method emit_row_changed (GtkTreePath() $path, GtkTreeIter() $iter)
    is also<emit-row-changed>
  {
    gtk_tree_model_row_changed($!tm, $path, $iter);
  }

  method emit_row_deleted (GtkTreePath() $path) is also<emit-row-deleted> {
    gtk_tree_model_row_deleted($!tm, $path);
  }

  method emit_row_has_child_toggled (GtkTreePath() $path, GtkTreeIter() $iter)
    is also<emit-row-has-child-toggled>
  {
    gtk_tree_model_row_has_child_toggled($!tm, $path, $iter);
  }

  method emit_row_inserted (GtkTreePath() $path, GtkTreeIter() $iter)
    is also<emit-row-inserted>
  {
    gtk_tree_model_row_inserted($!tm, $path, $iter);
  }

  method emit_rows_reordered (
    GtkTreePath() $path,
    GtkTreeIter() $iter,
    Int()         $new_order
  )
    is also<emit-rows-reordered>
  {
    my gint $no = $new_order;

    gtk_tree_model_rows_reordered($!tm, $path, $iter, $no);
  }

  method emit_rows_reordered_with_length (
    GtkTreePath() $path,
    GtkTreeIter() $iter,
    Int()         $new_order,
    Int()         $length
  )
    is also<emit-rows-reordered-with-length>
  {
    my gint ($no, $l) = ($new_order, $length);

    gtk_tree_model_rows_reordered_with_length($!tm, $path, $iter, $no, $l);
  }

  method unref_node (GtkTreeIter() $iter) is also<unref-node> {
    gtk_tree_model_unref_node($!tm, $iter);
  }

  # ↑↑↑↑ METHODS ↑↑↑↑

}

use GLib::Roles::Object;

our subset GtkTreeModelAncestry is export of Mu
  where GtkTreeModel | GObject;

class GTK::TreeModel:ver<3.0.1146> {
  also does GLib::Roles::Object;
  also does GTK::Roles::TreeModel;

  submethod BUILD(:$tree) {
    self.setGtkTreeModel($tree) if $tree;
  }

  method setGtkTreeModel (GtkTreeModelAncestry $_) {
    my $to-parent;

    $!tm = do {
      when GtkTreeModel {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GtkTreeModel, $_);
      }
    }
    self!setObject($to-parent);
  }

  method new (GtkTreeModelAncestry $tree, :$ref = True) {
    return Nil unless $tree;

    my $o = self.bless( :$tree );
    $o.ref if $ref;
    $o;
  }

  method get_type {
    self.gtktreemodel_get_type;
  }

}
