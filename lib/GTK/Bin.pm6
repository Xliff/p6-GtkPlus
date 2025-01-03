use v6.c;

use Method::Also;
use NativeCall;

use GTK::Raw::Bin:ver<3.0.1146>;
use GTK::Raw::Types:ver<3.0.1146>;

use GTK::Container;
use GTK::Widget;

our subset GtkBinAncestry is export of Mu
  where GtkBin | ContainerAncestry;

constant BinAncestry is export := GtkBinAncestry;

class GTK::Bin is GTK::Container {
  has GtkBin $!bin is implementor;

  # method bless(*%attrinit) {
  #   my $o = self.CREATE.BUILDALL(Empty, %attrinit);
  #   $o.setType($o.^name);
  #   $o;
  # }

  submethod BUILD(:$bin) {
    self.setBin($bin) if $bin;
  }

  method GTK::Raw::Definitions::GtkBin
    is also<
      GtkBin
      Bin
    >
  { $!bin }

  method setGtkBin (GtkBinAncestry $_) is also<setBin> {
    return unless $_;

    my $to-parent;
    $!bin = do {
      when GtkBin {
        $to-parent = cast(GtkContainer, $_);
        $_;
      }

      when ContainerAncestry {
        $to-parent = $_;
        cast(GtkBin, $_);
      }
    }

    say "BIN: { $!bin // 'NIL' }";
    say "BIN-TP: { $to-parent // 'NIL' }";
    self.setGtkContainer($to-parent);
  }

  method new (GtkBinAncestry $bin, :$ref = True) {
    return unless $bin;

    my $o = self.bless(:$bin);
    $o.ref if $ref;
    $o;
  }

  multi method add (GTK::Widget $widget) {
    self.set_end($widget);
    self.SET-LATCH;
    samewith($widget.Widget);
  }
  multi method add (GtkWidget $widget) {
    self.set_end($widget) unless self.IS-LATCHED;
    self.SET-LATCH;
    nextwith($widget);
  }

  multi method remove(GtkWidget() $widget) {
    self.clear_end if self.end[0].p != +$widget.p;
    nextwith($widget);
  }

  method get_child
    is also<
      get-child
      child
    >
  {
    self.end[0] ~~ GTK::Widget ??
      self.end[0] !! gtk_bin_get_child($!bin);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    GTK::Widget.unstable_get_type( &gtk_bin_get_type, $n, $t );
  }

  # XXX - Override add to take only one child?

}
