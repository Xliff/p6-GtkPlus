use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::TargetList;
use GTK::Raw::Types;

class GTK::TargetList {
  has GtkTargetList $!tl;

  method bless(*%attrinit) {
    use nqp;
    my $o = nqp::create(self).BUILDALL(Empty, %attrinit);
    self.setType('GTK::TargetList');
    $o;
  }

  submethod BUILD(:$targetlist) {
    $!tl = $targetlist
  }

  method new (@target_entries) {
    my CArray[GtkTargetEntry] $te_list = CArray[GtkTargetEntry].new;
    my $c = 0;
    $te = 0;
    for @target_entries -> $te {
      $c++;
      given $te {
        when GTK::TargetEntry {
          # Note: Eliminate the need for multi's. Have an Object to Type conversion
          #       method for EVERYTHING!
          $te_list[$te++] = $_.GtkTargetEntry;
        }
        when GtkTargetEntry   {
          $te_list[$te++] = $_;
        }
        default {
          warn "Ignored element #{ $c } of the target entries due to invalid type: { .^name }";
        }
      }
    }

    my guint $nt = $te_list.elems
    my $targetlist = gtk_target_list_new($te_list, $nt);
    self.bless(:$target_list);
  }

  method GtkTargetList {
    $!tl;
  }

  # ↓↓↓↓ SIGNALS ↓↓↓↓
  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  method add (GdkAtom $target, guint $flags, guint $info) {
    gtk_target_list_add($!tl, $target, $flags, $info);
  }

  method add_image_targets (guint $info, gboolean $writable) {
    gtk_target_list_add_image_targets($!tl, $info, $writable);
  }

  method add_rich_text_targets (
    guint $info,
    gboolean $deserializable,
    GtkTextBuffer() $buffer
  ) {
    gtk_target_list_add_rich_text_targets($!tl, $info, $deserializable, $buffer);
  }

  method add_table (GtkTargetEntry() $targets, guint $ntargets) {
    gtk_target_list_add_table($!tl, $targets, $ntargets);
  }

  method add_text_targets (guint $info) {
    gtk_target_list_add_text_targets($!tl, $info);
  }

  method add_uri_targets (guint $info) {
    gtk_target_list_add_uri_targets($!tl, $info);
  }

  method find (GdkAtom $target, guint $info) {
    gtk_target_list_find($!tl, $target, $info);
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
