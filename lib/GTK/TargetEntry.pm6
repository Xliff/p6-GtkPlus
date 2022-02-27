use v6.c;

use Method::Also;

use GTK::Raw::TargetEntry:ver<3.0.1146>;
use GTK::Raw::Types:ver<3.0.1146>;

class GTK::TargetEntry:ver<3.0.1146> {
  has GtkTargetEntry $!te is implementor;

  submethod BUILD(:$entry) {
    $!te = $entry;
  }

  method GTK::Raw::Definitions::GtkTargetEntry
    is also<
      TargetEntry
      GtkTargetEntry
    >
  { $!te }

  multi method new {
    my $entry = GtkTargetEntry.new;

     die 'Could not create a GtkTargetEntry structure!' unless $entry;

    self.bless($entry);
  }
  multi method new (GtkTargetEntry $entry) {
    $entry ?? self.bless(:$entry) !! Nil;
  }
  multi method new (gchar $target, Int() $flags, Int() $info) {
    my guint ($f, $i) = ($flags, $info);
    my $entry = gtk_target_entry_new($target, $f, $i);

    $entry ?? self.bless(:$entry) !! Nil;
  }

  # ↓↓↓↓ SIGNALS ↓↓↓↓
  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  method copy (:$raw = False) {
    my $te = gtk_target_entry_copy($!te);

    $te ??
      ( $raw ?? $te !! GTK::TargetEntry.new($te) )
      !!
      Nil;
  }

  method free {
    gtk_target_entry_free($!te);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gtk_target_entry_get_type, $n, $t );
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
