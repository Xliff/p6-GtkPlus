use v6.c;

use Method::Also;
use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::TargetEntry;
use GTK::Raw::Types;

class GTK::TargetEntry {
  has GtkTargetEntry $!te;

  submethod BUILD(:$entry) {
    $!te = $entry;
  }

  multi method new {
    my $entry = GtkTargetEntry.new;
    self.bless($entry);
  }
  multi method new (GtkTargetEntry $entry) {
    self.bless(:$entry);
  }
  multi method new (gchar $target, Int() $flags, Int() $info) {
    my @u = ($flags, $info);
    my guint ($f, $i) = self.RESOLVE-UINT(@u);
    my $entry = gtk_target_entry_new($target, $f, $i);
    self.bless(:$entry);
  }

  method GTK::Raw::Types::GtkTargetEntry {
    $!te;
  }

  # ↓↓↓↓ SIGNALS ↓↓↓↓
  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  method copy {
    GTK::TargetEntry.new( gtk_target_entry_copy($!te) );
  }

  method free {
    gtk_target_entry_free($!te);
  }

  method get_type is also<get-type> {
    gtk_target_entry_get_type();
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}

