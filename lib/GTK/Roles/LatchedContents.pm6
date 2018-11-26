use v6.c;

use Method::Also;
use GTK::Roles::Protection;

role GTK::Roles::LatchedContents {
  also does GTK::Roles::Protection;

  has $!add-latch;
  has @!start;
  has @!end;

  method SET-LATCH is also<SET_LATCH> {
    self.IS-PROTECTED;
    $!add-latch = True;
  }

  method UNSET-LATCH is also<UNSET_LATCH> {
    self.IS-PROTECTED;
    $!add-latch = False;
  }

  method IS-LATCHED is also<IS_LATCHED> {
    self.IS-PROTECTED;
    $!add-latch;
  }

  method push-start($c) is also<push_start> {
    # Write @!start.elems to GtkWidget under key GTKPlus-ContainerStart
    @!start.push: $c;
  }

  method unshift-end($c) is also<unshift_end> {
    # Write @!end.elems to GtkWidget under key GTKPlus-ContainerEnd
    @!end.unshift: $c;
  }

}
