use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::TargetEntry;
use GTK::Raw::Types;

class GTK::TargetEntry {
  has GtkTargetEntry $!te;

  method bless(*%attrinit) {
    use nqp;
    my $o = nqp::create(self).BUILDALL(Empty, %attrinit);
    self.setType('GTK::Entry');
    $o;
  }

  submethod BUILD(:$entry) {
    $!te = $entry;
  }

  multi method new (gchar $target, guint $flags, guint $info) {
    my guint ($f, $i) = ($flags, $info) >>+&<< (0xffff x 2);
    my $entry = gtk_target_entry_new($target, $f, $i);
    self.bless(:$entry);
  }
  multi method new (GtkTargetEntry $entry) {
    self.bless(:$entry);
  }

  method GtkTargetEntry {
    $!te;
  }

  # ↓↓↓↓ SIGNALS ↓↓↓↓
  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  method copy {
    GTK::TargetEntry.new( gtk_target_entry_copy($!tl) );
  }

  method free {
    gtk_target_entry_free($!tl);
  }

  method get_type {
    gtk_target_entry_get_type();
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
