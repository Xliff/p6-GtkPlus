use v6.c;

use NativeCall;

use Method::Also;
use GTK::Roles::Protection:ver<3.0.1146>;

# With reservations.... but...
use GTK::Raw::Types:ver<3.0.1146>;
use GTK::Widget:ver<3.0.1146>;

role GTK::Roles::LatchedContents:ver<3.0.1146> {
  # This is for GTK:: objects ONLY!
  also does GTK::Roles::Protection;

  has $!add-latch;
  has @!start;
  has @!end;

  method SET-LATCH is also<SET_LATCH> {
    #self.IS-PROTECTED;
    $!add-latch = True;
  }

  method UNSET-LATCH is also<UNSET_LATCH> {
    #self.IS-PROTECTED;
    $!add-latch = False;
  }

  method IS-LATCHED is also<IS_LATCHED> {
    #self.IS-PROTECTED;
    $!add-latch;
  }

  method push-start($c) is also<push_start> {
    # Write @!start.elems to GtkWidget under key GTKPlus-ContainerStart
    #self.IS-PROTECTED;
    @!start.push: $c;
  }

  method unshift-start($c) is also<unshift_start> {
    #self.IS-PROTECTED;
    @!start.unshift: $c;
  }

  method unshift-end($c) is also<unshift_end> {
    # Write @!end.elems to GtkWidget under key GTKPlus-ContainerEnd
    #self.IS-PROTECTED;
    @!end.unshift: $c;
  }

  method push_end($c) is also<push-end> {
    #self.IS-PROTECTED;
    @!end.push: $c;
  }

  method set_end($c) is also<set-end> {
    #self.IS-PROTECTED;
    @!end = ($c);
  }

  method clear_end is also<clear-end> {
    @!end = ();
  }

  my sub checkp($o) {
    do given $o {
      when GTK::Widget { .Widget.p }
      when GtkWidget   { .p        }
      when Pointer     { $_        }

      default {
        warn qq:to/W/.chomp;
GTK::Roles::LatchedContents.checkp detected unexpected type { .^name }
W

      }
    }
  }

  method remove_from_end($c) is also<remove-from-end> {
    #self.IS-PROTECTED;
    my $cw = +checkp($c);
    @!end .= grep({ $cw != +checkp($_) });
  }

  method remove_from_start($c) is also<remove-from-start> {
    #self.IS-PROTECTED;
    my $cw = +checkp($c);
    @!start .= grep({ $cw != +checkp($_) });
  }

  method insert_start_at($c, $p) is also<insert-start-at> {
    #self.IS-PROTECTED;
    @!start.splice($p, 0, $c);
  }

  method insert_end_at($c, $p) is also<insert-end-at> {
    #self.IS-PROTECTED;
    @!end.splice($p, 0, $c);
  }

  method start {
    #self.IS-PROTECTED;
    @!start.clone;
  }

  method end {
    #self.IS-PROTECTED;
    @!end.clone;
  }

  method children {
    |@!start, |@!end;
  }

}
