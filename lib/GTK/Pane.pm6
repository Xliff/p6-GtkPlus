use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::Pane;
use GTK::Raw::Types;

use GTK::Container;

class GTK::Pane is GTK::Container {
  has GtkPane $!p;

  has @!child1;
  has @!child2;
  has $!add-latch;

  submethod BUILD(:$pane) {
    given $pane {
      when GtkPane | GtkWidget {
        $!p = nativecast(GtkPane, $pane);
        self.setContainer($pane);
      }
      when GTK::Pane {
      }
      default {
      }
    }
  }

  multi method new(GtkOrientation $orientation) {
    my $pane = gtk_paned_new($orientation);
    self.bless(:$pane);
  }
  multi method new(:$horizontal = False, :$vertical = False) {
    die "Must specify either :horizontal or :vertical when creating GTK::Pane";
      unless $horizontal ^^ $vertical;

    my $orientation = do {
      when $horizontal { GTK_ORIENTATION_HORIZONTAL; }
      when $vertical   { GTK_ORIENTATION_HORIZONTAL; }
    }

    samewith($orientation);
  }

  method new-hpane {
    my $pane = gtk_paned_new(GTK_ORIENTATION_HORIZONTAL);
    self.bless(:$pane);
  }

  method new-vpane {
    my $pane = gtk_paned_new(GTK_ORIENTATION_VERTICAL);
    self.bless(:$pane);
  }

  # ↓↓↓↓ SIGNALS ↓↓↓↓
  method accept-position {
    self.connect($!p, 'accept-position');
  }

  method cancel-position {
    self.connect($!p, 'cancel-position');
  }

  # Should be:
  # (GtkPaned *widget,
  #  gboolean  reversed,
  #  gpointer  user_data)
  method cycle-child-focus {
    self.connect($!p, 'cycle-child-focus');
  }

  # Should be:
  # (GtkPaned     *widget,
  #  GtkScrollType scroll_type,
  #  gpointer      user_data)
  method move-handle {
    self.connect($!p, 'move-handle');
  }

  method toggle-handle-focus {
    self.connect($!p, 'toggle-handle-focus');
  }
  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  method position is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_paned_get_position($!p);
      },
      STORE => sub ($, $position is copy) {
        gtk_paned_set_position($!p, $position);
      }
    );
  }

  method wide_handle is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_paned_get_wide_handle($!p);
      },
      STORE => sub ($, $wide is copy) {
        gtk_paned_set_wide_handle($!p, $wide);
      }
    );
  }
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  multi method add1 (GtkWidget $child) {
    @!child1.push: $child unless $!add-latch;
    $!add-latch = False;
    gtk_paned_add1($!p, $child);
  }
  multi method add1 (GTK::Widget $child)  {
    @!child1.push: $child;
    $!add-latch = True;
    samewith($child.widget);
  }

  multi method add2 (GtkWidget $child) {
    @!child2.push($child) unless $!add-latch;
    $!add-latch = False;
    gtk_paned_add2($!p, $child);
  }
  multi method add2 (GTK::Widget $child)  {
    @!child2.push: $child;
    $!add-latch = True;
    samewith($child.widget);
  }

  method get_child1 {
    @!child1 ~~ GTK::Widget ?? @!child1[0] !! gtk_paned_get_child1($!p);
  }

  method get_child2 {
    @!child2 ~~ GTK::Widget ?? @!child2[0] !! gtk_paned_get_child2($!p);
  }

  method get_handle_window {
    gtk_paned_get_handle_window($!p);
  }

  method get_type {
    gtk_paned_get_type();
  }

  multi method pack1 (GtkWidget $child, gboolean $resize, gboolean $shrink) {
    @!child1.push($child) unless $!add-latch;
    $!add-latch = False;
    gtk_paned_pack1($!p, $child, $resize, $shrink);
  }
  multi method pack1 (GTK::Widget $child, gboolean $resize, gboolean $shrink)  {
    @!child1.push($child)
    $!add-latch = True;
    samewith($child.widget, $resize, $shrink);
  }

  multi method pack2 (GtkWidget $child, gboolean $resize, gboolean $shrink) {
    @!child2.push($child) unless $!add-latch;
    $!add-latch = False;
    gtk_paned_pack2($!p, $child, $resize, $shrink);
  }
  multi method pack2 (GTK::Widget $child, gboolean $resize, gboolean $shrink)  {
    @!child2.push($child);
    $!add-latch = True;
    samewith($child.widget, $resize, $shrink);
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
