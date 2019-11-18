use v6.c;

use Method::Also;
use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::TargetList;
use GTK::Raw::Types;

use GTK::TargetEntry;

use GTK::Compat::Roles::Object;

class GTK::TargetList {
  also does GTK::Compat::Roles::Object;
  
  has GtkTargetList $!tl is implementor;

  submethod BUILD(:$targetlist) {
    self!setObject($!tl = $targetlist)
  }
  
  method GTK::Raw::Types::GtkTargetList
    is also<TargetList>
    { $!tl }

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
          warn qq:to/WARN/;
            Ignored element #{ $i } of the target entries due to invalid{
            } type: { .^name }
            WARN
        }
      }
    }

    my guint $nt = $te_list.elems;
    my $targetlist = gtk_target_list_new($te_list, $nt);
    self.bless(:$targetlist);
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

  method add_image_targets (Int() $info, Int() $writeable) 
    is also<add-image-targets> 
  {
    my @u = ($info, $writeable);
    my guint ($i, $w) = self.RESOLVE-UINT(@u);
    gtk_target_list_add_image_targets($!tl, $i, $w);
  }

  method add_rich_text_targets (
    Int() $info,
    Int() $deserializable,
    GtkTextBuffer() $buffer
  ) 
    is also<add-rich-text-targets> 
  {
    my guint $i = self.RESOLVE-UINT($info);
    my gboolean $d = self.RESOLVE-BOOL($deserializable);
    gtk_target_list_add_rich_text_targets($!tl, $i, $d, $buffer);
  }

  method add_table (GtkTargetEntry @targets) is also<add-table> {
    my CArray[GtkTargetEntry] $t = CArray[GtkTargetEntry].new;
    my $i = 0;
    $t[$i++] = $_ for @targets;
    gtk_target_list_add_table($!tl, $t, $t.elems);
  }

  method add_text_targets (Int() $info) is also<add-text-targets> {
    my guint $i = self.RESOLVE-UINT($info);
    gtk_target_list_add_text_targets($!tl, $i);
  }

  method add_uri_targets (Int() $info) is also<add-uri-targets> {
    my guint $i = self.RESOLVE-UINT($info);
    gtk_target_list_add_uri_targets($!tl, $i);
  }

  method find (GdkAtom $target, Int() $info) {
    my guint $i = self.RESOLVE-UINT($info);
    gtk_target_list_find($!tl, $target, $i);
  }

  method get_type is also<get-type> {
    gtk_target_list_get_type();
  }

  method ref is also<upref> {
    gtk_target_list_ref($!tl);
  }

  method remove (GdkAtom $target) {
    gtk_target_list_remove($!tl, $target);
  }

  method unref is also<downref> {
    gtk_target_list_unref($!tl);
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
