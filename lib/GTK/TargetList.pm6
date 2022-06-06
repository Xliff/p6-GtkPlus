use v6.c;

use Method::Also;
use NativeCall;

use GTK::Raw::TargetList:ver<3.0.1146>;
use GTK::Raw::Types:ver<3.0.1146>;

use GTK::TargetEntry:ver<3.0.1146>;

use GLib::Roles::Object;

our subset GtkTargetListAncestry is export of Mu
  where GtkTargetList | GObject;

class GTK::TargetList:ver<3.0.1146> {
  also does GLib::Roles::Object;

  has GtkTargetList $!tl is implementor;

  submethod BUILD( :$targetlist ) {
    self.setGtkTargetList($targetlist) if $targetlist;

  }

  method setGtkTargetEntry (GtkTargetListAncestry $_) {
    my $to-parent;

    $!tl = do {
      when GtkTargetList {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GtkTargetList, $_)
      }
    }
    self!setObject($to-parent)
  }

  method GTK::Raw::Definitions::GtkTargetList
    is also<
      TargetList
      GtkTargetList
    >
  { $!tl }

  method new (@target_entries) {
    my $te_list = CArray[GtkTargetEntry].new;
    for @target_entries.kv -> $i, $te {
      given $te {
        when GTK::TargetEntry {
          $te_list[$i] = .GtkTargetEntry;
        }

        when GtkTargetEntry   {
          $te_list[$i] = $_;
        }

        default {
          warn qq:to/WARN/
            Ignored element #{ $i } of the target entries due to invalid{
            } type: { .^name }
            WARN
        }
      }
    }

    my $targetlist = gtk_target_list_new($te_list, $te_list.elems);

    $targetlist ?? self.bless(:$targetlist) !! Nil;
  }

  # ↓↓↓↓ SIGNALS ↓↓↓↓
  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  method add (GdkAtom $target, Int() $flags, Int() $info) {
    my guint ($f, $i) = ($flags, $info);

    gtk_target_list_add($!tl, $target, $f, $i);
  }

  method add_image_targets (Int() $info, Int() $writeable)
    is also<add-image-targets>
  {
    my guint ($i, $w) = ($info, $writeable);

    gtk_target_list_add_image_targets($!tl, $i, $w);
  }

  method add_rich_text_targets (
    Int() $info,
    Int() $deserializable,
    GtkTextBuffer() $buffer
  )
    is also<add-rich-text-targets>
  {
    my guint $i = $info;
    my gboolean $d = $deserializable.so.Int;

    gtk_target_list_add_rich_text_targets($!tl, $i, $d, $buffer);
  }

  method add_table (GtkTargetEntry @targets) is also<add-table> {
    gtk_target_list_add_table(
      $!tl,
      ArrayToCArray(GtkTargetEntry, @targets);
      @targets.elems
    );
  }

  method add_text_targets (Int() $info) is also<add-text-targets> {
    my guint $i = $info;

    gtk_target_list_add_text_targets($!tl, $i);
  }

  method add_uri_targets (Int() $info) is also<add-uri-targets> {
    my guint $i = $info;

    gtk_target_list_add_uri_targets($!tl, $i);
  }

  method find (GdkAtom $target, Int() $info) {
    my guint $i = $info;

    gtk_target_list_find($!tl, $target, $i);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gtk_target_list_get_type, $n, $t );
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
