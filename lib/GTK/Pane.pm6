use v6.c;

use Method::Also;

use GTK::Raw::Pane:ver<3.0.1146>;
use GTK::Raw::Types:ver<3.0.1146>;

use GTK::Container:ver<3.0.1146>;

use GTK::Roles::Orientable:ver<3.0.1146>;

our subset PaneAncestry is export
  where GtkPaned | GtkOrientable | ContainerAncestry;

constant GtkPaneAncestry  is export = PaneAncestry;
constant GtkPanedAncestry is export = PaneAncestry;

class GTK::Pane:ver<3.0.1146> is GTK::Container {
  also does GTK::Roles::Orientable;

  has GtkPaned $!p is implementor;

  has @!child1;
  has @!child2;

  method bless(*%attrinit) {
    my $o = self.CREATE.BUILDALL(Empty, %attrinit);
    $o.setType($o.^name);
    $o;
  }

  submethod BUILD(:$pane) {
    given $pane {
      when PaneAncestry { self.setPane($pane) }
      when GTK::Pane    { }
      default           { }
    }
  }

  method setPane (PaneAncestry $_) {
    my $to-parent;
    $!p = do {
      when GtkPaned {
        $to-parent = cast(GtkContainer, $_);
        $_;
      }
      when GtkOrientable {
        $!or = $_;                              # GTK::Roles::GtkOrientable
        $to-parent = cast(GtkContainer, $_);
        cast(GtkPaned, $_);
      }
      default {
        $to-parent = $_;
        cast(GtkPaned, $_);
      }
    }
    $!or //= cast(GtkOrientable, $_);     # GTK::Roles::Orientable
    self.setContainer($to-parent);
  }

  method GTK::Raw::Definitions::GtkPaned
    is also<
      Pane
      GtkPane
      GtkPaned
    >
  { $!p }

  multi method new (PaneAncestry $pane, :$ref = True) {
    return Nil unless $pane;

    my $o = self.bless(:$pane);
    $o.ref if $ref;
    $o;
  }
  multi method new (:h(:$horizontal) = False, :v(:$vertical) = False) {
    die "Must specify either :horizontal or :vertical when creating GTK::Pane"
      unless $horizontal ^^ $vertical;

    my $orientation = do {
      when $horizontal { GTK_ORIENTATION_HORIZONTAL.Int; }
      when $vertical   { GTK_ORIENTATION_HORIZONTAL.Int; }
    }

    samewith($orientation);
  }
  multi method new (Int() $orientation) {
    my uint32 $o = $orientation;

    my $pane = gtk_paned_new($orientation);

    $pane ?? self.bless(:$pane) !! Nil;
  }

  method new-hpane is also<new_hpane> {
    my $pane = gtk_paned_new(GTK_ORIENTATION_HORIZONTAL.Int);

    $pane ?? self.bless(:$pane) !! Nil;
  }

  method new-vpane is also<new_vpane> {
    my $pane = gtk_paned_new(GTK_ORIENTATION_VERTICAL.Int);

    $pane ?? self.bless(:$pane) !! Nil;
  }

  # ↓↓↓↓ SIGNALS ↓↓↓↓

  # Is originally:
  # GtkPaned, gpointer --> gboolean
  method accept-position is also<accept_position> {
    self.connect-rbool($!p, 'accept-position');
  }

  # Is originally:
  # GtkPaned, gpointer --> gboolean
  method cancel-position is also<cancel_position> {
    self.connect-rbool($!p, 'cancel-position');
  }

  # Is originally:
  # GtkPaned, gboolean, gpointer --> gboolean
  method cycle-child-focus is also<cycle_child_focus> {
    self.connect-uint-ruint($!p, 'cycle-child-focus');
  }

  # Is originally:
  # GtkPaned, gboolean, gpointer --> gboolean
  method cycle-handle-focus is also<cycle_handle_focus> {
    self.connect-uint-ruint($!p, 'cycle-handle-focus');
  }

  # Is originally:
  # GtkPaned, GtkScrollType, gpointer --> gboolean
  method move-handle is also<move_handle> {
    self.connect-uint-ruint($!p, 'move-handle');
  }

  # Is originally:
  # GtkPaned, gpointer --> gboolean
  method toggle-handle-focus is also<toggle_handle_focus> {
    self.connect-rbool($!p, 'toggle-handle-focus');
  }

  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  method position is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_paned_get_position($!p);
      },
      STORE => sub ($, Int() $position is copy) {
        my gint $p = $position;

        gtk_paned_set_position($!p, $p);
      }
    );
  }

  method wide_handle is rw is also<wide-handle> {
    Proxy.new(
      FETCH => sub ($) {
        so gtk_paned_get_wide_handle($!p);
      },
      STORE => sub ($, Int() $wide is copy) {
        my gboolean $w = $wide.so.Int;

        gtk_paned_set_wide_handle($!p, $w);
      }
    );
  }
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  multi method add1 (GtkWidget $child) {
    @!child1.push: $child unless self.IS-LATCHED;
    self.UNSET-LATCH;
    gtk_paned_add1($!p, $child);
  }
  multi method add1 (GTK::Widget $child)  {
    @!child1.push: $child;
    self.SET-LATCH;
    samewith($child.Widget);
  }

  multi method add2 (GtkWidget $child) {
    @!child2.push($child) unless self.IS-LATCHED;
    self.UNSET-LATCH;
    gtk_paned_add2($!p, $child);
  }
  multi method add2 (GTK::Widget $child)  {
    @!child2.push: $child;
    self.SET-LATCH;
    samewith($child.Widget);
  }

  # Use the attribute only if it's a GtkPlus object.
  method get_child1 is also<get-child1 child1> {
    @!child1[0] ~~ GTK::Widget ?? @!child1[0] !! gtk_paned_get_child1($!p);
  }

  # Use the  attribute only if it's a GtkPlus object.
  method get_child2 is also<get-child2 child2> {
    @!child2[0] ~~ GTK::Widget ?? @!child2[0] !! gtk_paned_get_child2($!p);
  }

  method get_children is also<children> {
    (self.get_child1, self.get_child2);
  }

  method get_handle_window is also<get-handle-window> {
    gtk_paned_get_handle_window($!p);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    GTK::Widget.unstable_get_type( &gtk_paned_get_type, $n, $t );
  }

  multi method pack1 (
    GtkWidget $child,
    Int()     $resize = False,                # gboolean $resize,
    Int()     $shrink = False                 # gboolean $shrink
  ) {
    my gboolean ($r, $s) = ($resize, $shrink).map( *.so.Int );
    @!child1.push($child) unless self.IS-LATCHED;
    self.UNSET-LATCH;
    gtk_paned_pack1($!p, $child, $r, $s);
  }
  multi method pack1 (
    GTK::Widget $child,
    Int()       $resize = False,
    Int()       $shrink = False
  )  {
    @!child1.push($child);
    self.SET-LATCH;
    samewith($child.Widget, $resize, $shrink);
  }

  multi method pack2 (
    GtkWidget $child,
    Int()     $resize = False,
    Int()     $shrink = False
  ) {
    my gboolean ($r, $s) = ($resize, $shrink).map( *.so.Int );
    @!child2.push($child) unless self.IS-LATCHED;
    self.UNSET-LATCH;
    gtk_paned_pack2($!p, $child, $r, $s);
  }
  multi method pack2 (
    GTK::Widget $child,
    Int()       $resize = False,
    Int()       $shrink = False
  )  {
    @!child2.push($child);
    self.SET-LATCH;
    samewith($child.Widget, $resize, $shrink);
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

  method child-set(GtkWidget() $c, *@propval) {
    my @notfound;
    @notfound = gather for @propval -> $p, $v {
      given $p {
        when 'resize'    |
             'shrink'    { self.child-set-uint($c, $p, $v) }

        default          { take $p; take $v;               }
      }
    }
    nextwith($c, @notfound) if +@notfound;
  }
}
