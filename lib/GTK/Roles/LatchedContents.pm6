use v6.c;

use NativeCall;

use Method::Also;
use GTK::Roles::Protection:ver<3.0.1146>;

# With reservations.... but...
use GTK::Raw::Types:ver<3.0.1146>;
use GTK::Widget:ver<3.0.1146>;

role GTK::Roles::LatchedContents:ver<3.0.1146> {
  has $!add-latch;
  has @!start;
  has @!end;

  method SET-LATCH is also<SET_LATCH> {
    $!add-latch = True;
  }

  method UNSET-LATCH is also<UNSET_LATCH> {
    $!add-latch = False;
  }

  method IS-LATCHED is also<IS_LATCHED> {
    $!add-latch;
  }

  method push-start($c) is also<push_start> {
    # Write @!start.elems to GtkWidget under key GTKPlus-ContainerStart
    @!start.push: $c;
  }

  method unshift-start($c) is also<unshift_start> {
    @!start.unshift: $c;
  }

  method unshift-end($c) is also<unshift_end> {
    # Write @!end.elems to GtkWidget under key GTKPlus-ContainerEnd
    @!end.unshift: $c;
  }

  method push_end($c) is also<push-end> {
    @!end.push: $c;
  }

  method set_end($c) is also<set-end> {
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
    my $cw = +checkp($c);
    @!end .= grep({ $cw != +checkp($_) });
  }

  method remove_from_start($c) is also<remove-from-start> {
    my $cw = +checkp($c);
    @!start .= grep({ $cw != +checkp($_) });
  }

  method insert_start_at($c, $p) is also<insert-start-at> {
    @!start.splice($p, 0, $c);
  }

  method insert_end_at($c, $p) is also<insert-end-at> {
    @!end.splice($p, 0, $c);
  }

  method start {
    @!start.clone;
  }

  method end {
    @!end.clone;
  }

  method children {
    |@!start, |@!end;
  }

}
