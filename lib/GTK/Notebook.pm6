use v6.c;

use Method::Also;

use GTK::Raw::Notebook:ver<3.0.1146>;
use GTK::Raw::Types:ver<3.0.1146>;

use GTK::Container:ver<3.0.1146>;
use GTK::Label:ver<3.0.1146>;

use GTK::Roles::Signals::Notebook:ver<3.0.1146>;

our subset GtkNotebookAncestry is export
  where GtkNotebook | ContainerAncestry;

class X::GTK::Notebook::InvalidPageParams is Exception {
  has $.child;
  has $.tab-label;

  submethod BUILD (:$child, :$tab-label) {
    $!child = $child;
    $!tab-label = $tab-label;
    say "X-GTK-Notebook-InvalidPageParams { $child }/{ $tab-label }";
  }

  method message {
    # ??! WTF !??
    # $.child and $.tab-label are Any after the constructor?
    #
    # qq:to/DIE/.chomp;
    #   \$child ({ $!child.^name }) and \$tab-label ({ $!tab-label.^name
    #   }) MUST be GTK::Widget compatible objects!
    #   DIE
    qq:to/DIE/.chomp;
      \$child and \$tab-label MUST be GTK::Widget compatible objects!
      DIE
  }
}

class GTK::Notebook:ver<3.0.1146> is GTK::Container {
  also does GTK::Roles::Signals::Notebook;

  has GtkNotebook $!n is implementor;
  has @!labels;

  method bless(*%attrinit) {
    my $o = self.CREATE.BUILDALL(Empty, %attrinit);
    $o.setType($o.^name);
    $o;
  }

  submethod BUILD (:$notebook) {
    self.setGtkNotebook($notebook) if $notebook;
  }

  method setGtkNotebook (GtkNotebookAncestry $_) {
    my $to-parent;

    $!n = do {
      when GtkNotebook {
        $to-parent = cast(GtkContainer, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GtkNotebook, $_);
      }
    }
    self.setGtkContainer($to-parent);
  }

  submethod DESTROY {
    self.disconnect-all($_) for %!signals-n;
  }

  method GTK::Raw::Definitions::GtkNotebook
    is also<
      Notebook
      GtkNotebook
    >
  { $!n }

  multi method new (GtkNotebookAncestry $notebook, :$ref = False) {
    return Nil unless $notebook;

    my $o = self.bless(:$notebook);
    $o.ref if $ref;
    $o;
  }
  multi method new {
    my $notebook = gtk_notebook_new();

    $notebook ?? self.bless(:$notebook) !! $notebook;
  }

  # ↓↓↓↓ SIGNALS ↓↓↓↓

  # Is originally:
  # GtkNotebook, gint, gpointer --> gboolean
  method change-current-page is also<change_current_page> {
    self.connect-int-ruint($!n, 'change-current-page');
  }

  # Is originally:
  # GtkNotebook, GtkWidget, gint, gint, gpointer --> GtkNotebook
  method create-window is also<create_window> {
    self.connect-create-window($!n);
  }

  # Is originally:
  # GtkNotebook, uint32 (GtkNotebookTab), gpointer --> gboolean
  method focus-tab is also<focus_tab> {
    self.connect-uint-ruint($!n, 'focus-tab');
  }

  # Is originally:
  # GtkNotebook, uint32 (GtkDirectionType), gpointer --> void
  method move-focus-out is also<move_focus_out> {
    self.connect-uint($!n, 'move-focus-out');
  }

  # Is originally:
  # GtkNotebook, GtkWidget, guint, gpointer --> void
  method page-added is also<page_added> {
    self.connect-notebook-widget($!n, 'page-added');
  }

  # Is originally:
  # GtkNotebook, GtkWidget, guint, gpointer --> void
  method page-removed is also<page_removed> {
    self.connect-notebook-widget($!n, 'page-removed');
  }

  # Is originally:
  # GtkNotebook, GtkWidget, guint, gpointer --> void
  method page-reordered is also<page_reordered> {
    self.connect-notebook-widget($!n, 'page-reordered');
  }

  # Is originally:
  # GtkNotebook, uint32 (GtkDirectionType), gboolean, gpointer --> gboolean
  method reorder-tab is also<reorder_tab> {
    self.connect-reorder-tab($!n);
  }

  # Is originally:
  # GtkNotebook, gboolean, gpointer --> gboolean
  method select-page is also<select_page> {
    self.connect-uint-ruint($!n, 'select-page');
  }

  # Is originally:
  # GtkNotebook, GtkWidget, guint, gpointer --> void
  method switch-page is also<switch_page> {
    self.connect-notebook-widget($!n, 'switch-page');
  }
  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  method current_page is rw is also<
    current-page
    page
  > {
    Proxy.new(
      FETCH => sub ($) {
        gtk_notebook_get_current_page($!n);
      },
      STORE => sub ($, Int() $page_num is copy) {
        my gint $pn = $page_num;

        gtk_notebook_set_current_page($!n, $pn);
      }
    );
  }

  method group_name is rw is also<group-name> {
    Proxy.new(
      FETCH => sub ($) {
        gtk_notebook_get_group_name($!n);
      },
      STORE => sub ($, Str() $group_name is copy) {
        gtk_notebook_set_group_name($!n, $group_name);
      }
    );
  }

  method scrollable is rw {
    Proxy.new(
      FETCH => sub ($) {
        so gtk_notebook_get_scrollable($!n);
      },
      STORE => sub ($, Int() $scrollable is copy) {
        my gboolean $s = $scrollable.so.Int;

        gtk_notebook_set_scrollable($!n, $s);
      }
    );
  }

  method show_border is rw is also<show-border> {
    Proxy.new(
      FETCH => sub ($) {
        so gtk_notebook_get_show_border($!n);
      },
      STORE => sub ($, Int() $show_border is copy) {
        my gboolean $sb = $show_border.so.Int;

        gtk_notebook_set_show_border($!n, $sb);
      }
    );
  }

  method show_tabs is rw is also<show-tabs> {
    Proxy.new(
      FETCH => sub ($) {
        so gtk_notebook_get_show_tabs($!n);
      },
      STORE => sub ($, $show_tabs is copy) {
        my gboolean $st = $show_tabs.so.Int;

        gtk_notebook_set_show_tabs($!n, $st);
      }
    );
  }

  method tab_pos is rw is also<tab-pos> {
    Proxy.new(
      FETCH => sub ($) {
        GtkPositionTypeEnum( gtk_notebook_get_tab_pos($!n) );
      },
      STORE => sub ($, Int() $pos is copy) {
        my uint32 $p = $pos;

        gtk_notebook_set_tab_pos($!n, $p);
      }
    );
  }
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  proto method append_page (|)
    is also<append-page>
  { * }

  multi method append_page ($child, Str $tab-label) {
    samewith($child, GTK::Label.new($tab-label) );
  }
  multi method append_page (
    $child     is copy,
    $tab-label is copy
  ) {
    X::GTK::Notebook::InvalidPageParams.new(:$child, :$tab-label).new.throw
      unless ($child, $tab-label).all ~~ (GTK::Widget, GtkWidget).any;

    self.push-start($child);
    @!labels.push($tab-label);
    $child     .= Widget if $child     ~~ GTK::Widget;
    $tab-label .= Widget if $tab-label ~~ GTK::Widget;
    gtk_notebook_append_page($!n, $child, $tab-label);
  }

  method append_page_menu (
    GtkWidget() $child,
    GtkWidget() $tab-label,
    GtkWidget() $menu_label
  )
    is also<append-page-menu>
  {
    gtk_notebook_append_page_menu($!n, $child, $tab-label, $menu_label);
  }

  method detach_tab (GtkWidget() $child) is also<detach-tab> {
    gtk_notebook_detach_tab($!n, $child);
  }

  method get_action_widget (
    Int()  $pack_type,
          :$raw        = False,
          :$widget     = False
  )
    is also<get-action-widget>
  {
    my uint32 $pt = $pack_type;
    my $w = gtk_notebook_get_action_widget($!n, $pt);

    self.ReturnWidget($w, $raw, $widget);
  }

  method get_menu_label (GtkWidget() $child, :$raw = False, :$widget = False)
    is also<get-menu-label>
  {
    my $w = gtk_notebook_get_menu_label($!n, $child);

    self.ReturnWidget($w, $raw, $widget);
  }

  method get_menu_label_text (GtkWidget() $child)
    is also<get-menu-label-text>
  {
    gtk_notebook_get_menu_label_text($!n, $child);
  }

  method get_n_pages
    is also<
      get-n-pages
      n_pages
      n-pages
      elems
    >
  {
    gtk_notebook_get_n_pages($!n);
  }

  method get_nth_page (Int() $page_num, :$raw = False, :$widget = False)
    is also<get-nth-page>
  {
    my gint $pn = $page_num;
    my $w = gtk_notebook_get_nth_page($!n, $pn);

    self.ReturnWidget($w, $raw, $widget);
  }

  method get_tab_detachable (GtkWidget() $child)
    is also<get-tab-detachable>
  {
    so gtk_notebook_get_tab_detachable($!n, $child);
  }

  method get_tab_hborder is also<get-tab-hborder> {
    gtk_notebook_get_tab_hborder($!n);
  }

  method get_tab_label (GtkWidget() $child, :$raw = False, :$widget = False)
    is also<get-tab-label>
  {
    my $w = gtk_notebook_get_tab_label($!n, $child);

    self.ReturnWidget($w, $raw, $widget);
  }

  method get_tab_label_text (GtkWidget() $child)
    is also<get-tab-label-text>
  {
    gtk_notebook_get_tab_label_text($!n, $child);
  }

  multi method get_tab_reorderable (GtkWidget() $child)
    is also<get-tab-reorderable>
  {
    so gtk_notebook_get_tab_reorderable($!n, $child);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    GTK::Widget.unstable_get_type( &gtk_notebook_get_type, $n, $t );
  }

  proto method insert_page (|)
    is also<insert-page>
  { * }

  multi method insert_page ($child, Str() $tab-label, $position) {
    samewith($child, GTK::Label.new($tab-label), $position);
  }
  multi method insert_page (
    $child          is copy,
    $tab-label      is copy,
    Int() $position
  ) {
    X::GTK::Notebook::InvalidPageParams.new(:$child, :$tab-label).new.throw
      unless ($child, $tab-label).all ~~ (GTK::Widget, GtkWidget).any;

    my uint32 $p = $position;

    self.insert_start_at($child, $p);
    @!labels.splice($p, 0, $tab-label);
    $child     .= Widget if $child     ~~ GTK::Widget;
    $tab-label .= Widget if $tab-label ~~ GTK::Widget;
    gtk_notebook_insert_page($!n, $child, $tab-label, $p);
  }

  method insert_page_menu (
    GtkWidget() $child,
    GtkWidget() $tab-label,
    GtkWidget() $menu_label,
    Int()       $position               # gint $position
  )
    is also<insert-page-menu>
  {
    my uint32 $p = $position;

    gtk_notebook_insert_page_menu($!n, $child, $tab-label, $menu_label, $p);
  }

  method next_page is also<next-page> {
    gtk_notebook_next_page($!n);
  }

  method page_num (GtkWidget() $child) is also<page-num> {
    gtk_notebook_page_num($!n, $child);
  }

  method popup_disable is also<popup-disable> {
    gtk_notebook_popup_disable($!n);
  }

  method popup_enable is also<popup-enable> {
    gtk_notebook_popup_enable($!n);
  }

  proto method prepend_page (|)
    is also<prepend-page>
  { * }

  # This probably should be exported.
  my subset WidgetPointerOrObject of Mu where GTK::Widget | GtkWidget;

  multi method prepend_page ($child, Str() $tab-label) {
    samewith( $child, GTK::Label.new($tab-label) );
  }
  multi method prepend_page (
    WidgetPointerOrObject $child     is copy,
    WidgetPointerOrObject $tab-label is copy
  ) {
    X::GTK::Notebook::InvalidPageParams.new(:$child, :$tab-label).new.throw
      unless ($child, $tab-label).all ~~ (GTK::Widget, GtkWidget).any;

    self.unshift-start($child);
    @!labels.unshift($tab-label);
    $child     .= Widget if $child     ~~ GTK::Widget;
    $tab-label .= Widget if $tab-label ~~ GTK::Widget;
    gtk_notebook_prepend_page($!n, $child, $tab-label);
  }

  method prepend_page_menu (
    GtkWidget() $child,
    GtkWidget() $tab-label,
    GtkWidget() $menu_label
  )
    is also<prepend-page-menu>
  {
    gtk_notebook_prepend_page_menu($!n, $child, $tab-label, $menu_label);
  }

  method prev_page is also<prev-page> {
    gtk_notebook_prev_page($!n);
  }

  method remove_page (Int() $page_num) is also<remove-page> {
    my gint $pn = $page_num;

    gtk_notebook_remove_page($!n, $pn);
  }

  method reorder_child (GtkWidget() $child, Int() $position)
    is also<reorder-child>
  {
    my gint $p = $position;
    # YYY - Find child in @!start and move to new position?
    gtk_notebook_reorder_child($!n, $child, $p);
  }

  method set_action_widget (
    GtkWidget() $widget,
    Int()       $pack_type              # GtkPackType $pack_type)
  )
    is also<set-action-widget>
  {
    gtk_notebook_set_action_widget($!n, $widget, $pack_type);
  }

  method set_menu_label (
    GtkWidget() $child,
    GtkWidget() $menu_label
  )
    is also<set-menu-label>
  {
    gtk_notebook_set_menu_label($!n, $child, $menu_label);
  }

  method set_menu_label_text (GtkWidget() $child, Str() $menu_text)
    is also<set-menu-label-text>
  {
    gtk_notebook_set_menu_label_text($!n, $child, $menu_text);
  }

  method set_tab_detachable (
    GtkWidget() $child,
    Int()       $detachable             # gboolean $detachable
  )
    is also<set-tab-detachable>
  {
    my gboolean $d = $detachable.so.Int;

    gtk_notebook_set_tab_detachable($!n, $child, $d);
  }

  method set_tab_label (GtkWidget() $child, GtkWidget() $tab-label)
    is also<set-tab-label>
  {
    gtk_notebook_set_tab_label($!n, $child, $tab-label);
  }

  method set_tab_label_text (GtkWidget() $child, Str() $tab_text)
    is also<set-tab-label-text>
  {
    gtk_notebook_set_tab_label_text($!n, $child, $tab_text);
  }

  method set_tab_reorderable (
    GtkWidget() $child,
    Int() $reorderable            # gboolean $reorderable
  )
    is also<set-tab-reorderable>
  {
    my $r = $reorderable;

    gtk_notebook_set_tab_reorderable($!n, $child, $r);
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

  method child-set (GtkWidget() $c, *@propval) {
    my @notfound;
    @notfound = gather for @propval -> $p, $v {
      given $p {
        when 'detachable'  |
             'reorderable' |
             'tab-expand'  |
             'tab-fill'    { self.child-set-bool($c, $p, $v)   }

        when 'menu-label'  |
             'tab-label'   { self.child-set-string($c, $p, $v) }

        when 'position'    { self.child-set-int($c, $p, $v)    }

        default            { take $p; take $v;                 }
      }
    }
    nextwith($c, @notfound) if +@notfound;
  }
}
