use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::TargetList;
use GTK::Raw::Types;

use GTK::TargetEntry;

class GTK::TargetList {
  has GtkTargetList $!tl;

  submethod BUILD(:$targetlist) {
    $!tl = $targetlist
  }

  method new (@target_entries) {
    my CArray[GtkTargetEntry] $te_list = CArray[GtkTargetEntry].new;
    my $c = 0;
    for @target_entries.kv -> $i, $te {
      $c++;
      given $te {
        when GTK::TargetEntry {
          # Note: Eliminate the need for multi's. Have an Object to Type conversion
          #       method for EVERYTHING!
          $te_list[$c++] = $_.GtkTargetEntry;
        }
        when GtkTargetEntry   {
          $te_list[$c++] = $_;
        }
        default {
          warn "Ignored element #{ $i } of the target entries due to invalid type: { .^name }";
        }
      }
    }

    my guint $nt = $te_list.elems;
    my $targetlist = gtk_target_list_new($te_list, $nt);
    self.bless(:$targetlist);
  }

  method GTK::Raw::Types::GtkTargetList {
    $!tl;
  }

  # ↓↓↓↓ SIGNALS ↓↓↓↓
  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  method add (GdkAtom $target, Int() $flags, Int() $info) {
    my @u = ($flags, $info);
    my guint ($f, $i) = self.RESOLVE-UINT(@u);
    gtk_target_list_add($!tl, $target, $f, $i);
  }

  method add_image_targets (Int() $info, Int() $writeable) {
    my @u = ($info, $writeable);
    my guint ($i, $w) = self.RESOLVE-UINT(@u);
    gtk_target_list_add_image_targets($!tl, $i, $w);
  }

  method add_rich_text_targets (
    Int() $info,
    Int() $deserializable,
    GtkTextBuffer() $buffer
  ) {
    my guint $i = self.RESOLVE-UINT($info);
    my gboolean $d = self.RESOLVE-BOOL($deserializable);
    gtk_target_list_add_rich_text_targets($!tl, $i, $d, $buffer);
  }

  method add_table (GtkTargetEntry @targets) {
    my CArray[GtkTargetEntry] $t = CArray[GtkTargetEntry].new;
    $t[$++] = $_ for @targets;
    gtk_target_list_add_table($!tl, $t, $t.elems);
  }

  method add_text_targets (Int() $info) {
    my guint $i = self.RESOLVE-UINT($info);
    gtk_target_list_add_text_targets($!tl, $i);
  }

  method add_uri_targets (Int() $info) {
    my guint $i = self.RESOLVE-UINT($info);
    gtk_target_list_add_uri_targets($!tl, $i);
  }

  method find (GdkAtom $target, Int() $info) {
    my guint $i = self.RESOLVE-UINT($info);
    gtk_target_list_find($!tl, $target, $i);
  }

  method ref {
    gtk_target_list_ref($!tl);
  }

  method remove (GdkAtom $target) {
    gtk_target_list_remove($!tl, $target);
  }

  method unref {
    gtk_target_list_unref($!tl);
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
