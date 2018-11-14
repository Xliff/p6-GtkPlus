use v6.c;

use Method::Also;
use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::Pane;
use GTK::Raw::Types;

use GTK::Container;

use GTK::Roles::Orientable;
use GTK::Roles::Signals::Generic;

class GTK::Pane is GTK::Container {
  also does GTK::Roles::Orientable;
  also does GTK::Roles::Signals::Generic;

  has GtkPaned $!p;

  has @!child1;
  has @!child2;

  method bless(*%attrinit) {
    my $o = self.CREATE.BUILDALL(Empty, %attrinit);
    $o.setType('GTK::Pane');
    $o;
  }

  submethod BUILD(:$pane) {
    my $to-parent;
    given $pane {
      when GtkPaned | GtkWidget {
        $!p = do {
          when GtkWidget {
            $to-parent = $_;
            nativecast(GtkPaned, $pane);
          }
          when GtkPaned {
            $to-parent = nativecast(GtkContainer, $_);
            $pane;
          }
        };
        self.setContainer($to-parent);
      }
      when GTK::Pane {
      }
      default {
      }
    }
    # For GTK::Roles::GtkOrientable
    $!or = nativecast(GtkOrientable, $!p);
  }

  submethod DESTROY {
    self.disconnect-all($_) for %!signals;
  }

  multi method new (GtkWidget $pane) {
    self.bless(:$pane);
  }
  multi method new (Int() $orientation) {
    my uint32 $o = self.RESOLVE-UINT($orientation);
    my $pane = gtk_paned_new($orientation);
    self.bless(:$pane);
  }
  multi method new (:$horizontal = False, :$vertical = False) {
    die "Must specify either :horizontal or :vertical when creating GTK::Pane"
      unless $horizontal ^^ $vertical;

    my $orientation = do {
      when $horizontal { GTK_ORIENTATION_HORIZONTAL.Int; }
      when $vertical   { GTK_ORIENTATION_HORIZONTAL.Int; }
    }

    samewith($orientation);
  }

  method new-hpane is also<new_hpane> {
    my $pane = gtk_paned_new(GTK_ORIENTATION_HORIZONTAL.Int);
    self.bless(:$pane);
  }

  method new-vpane is also<new_vpane> {
    my $pane = gtk_paned_new(GTK_ORIENTATION_VERTICAL.Int);
    self.bless(:$pane);
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
        my gint $p = self.RESOLVE-UINT($position);
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
        my gboolean $w = self.RESOLVE-BOOL($wide);
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
    samewith($child.widget);
  }

  multi method add2 (GtkWidget $child) {
    @!child2.push($child) unless self.IS-LATCHED;
    self.UNSET-LATCH;
    gtk_paned_add2($!p, $child);
  }
  multi method add2 (GTK::Widget $child)  {
    @!child2.push: $child;
    self.SET-LATCH;
    samewith($child.widget);
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
    gtk_paned_get_type();
  }

  multi method pack1 (
    GtkWidget $child,
    Int() $resize,                # gboolean $resize,
    Int() $shrink                 # gboolean $shrink
  ) {
    my @b = ($resize, $shrink);
    my gboolean ($r, $s) = self.RESOLVE-BOOL(@b);
    @!child1.push($child) unless self.IS-LATCHED;
    self.UNSET-LATCH;
    gtk_paned_pack1($!p, $child, $r, $s);
  }
  multi method pack1 (
    GTK::Widget $child,
    Int() $resize,
    Int() $shrink
  )  {
    @!child1.push($child);
    self.SET-LATCH;
    samewith($child.widget, $resize, $shrink);
  }

  multi method pack2 (
    GtkWidget $child,
    Int() $resize,
    Int() $shrink
  ) {
    my @b = ($resize, $shrink);
    my gboolean ($r, $s) = self.RESOLVE-BOOL(@b);
    @!child2.push($child) unless self.IS-LATCHED;
    self.UNSET-LATCH;
    gtk_paned_pack2($!p, $child, $r, $s);
  }
  multi method pack2 (
    GTK::Widget $child,
    Int() $resize,
    Int() $shrink
  )  {
    @!child2.push($child);
    self.SET-LATCH;
    samewith($child.widget, $resize, $shrink);
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
