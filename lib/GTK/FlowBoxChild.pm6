use v6.c;

use Method::Also;

use GTK::Raw::FlowBox:ver<3.0.1146>;
use GTK::Raw::Types:ver<3.0.1146>;

use GTK::Bin:ver<3.0.1146>;

our subset FlowBoxChildAncestry is export of Mu
  where GtkFlowBoxChild | BinAncestry;

class GTK::FlowBoxChild:ver<3.0.1146> is GTK::Bin {
  has GtkFlowBoxChild $!fbc is implementor;

  method bless(*%attrinit) {
    my $o = self.CREATE.BUILDALL(Empty, %attrinit);
    $o.setType($o.^name);
    $o;
  }

  submethod BUILD(:$flowboxchild) {
    my $to-parent;
    given $flowboxchild {
      when FlowBoxChildAncestry {
        $!fbc = do {
          when GtkFlowBoxChild {
            $to-parent = cast(GtkBin, $_);
            $_;
          }

          default {
            $to-parent = $_;
            cast(GtkFlowBoxChild, $_);
          }
        };
        self.setBin($to-parent);
      }

      when GTK::FlowBoxChild {
      }

      default {
      }
    }
  }

  multi method new (FlowBoxChildAncestry $flowboxchild, :$ref = True) {
    return Nil unless $flowboxchild;

    my $o = self.bless(:$flowboxchild);
    $o.ref if $ref;
    $o;
  }
  multi method new {
    my $flowboxchild = gtk_flow_box_child_new();

    $flowboxchild ?? self.bless(:$flowboxchild) !! Nil;
  }

  method GTK::Raw::Definitions::GtkFlowBoxChild
    is also<
      GtkFlowBoxChild
      FlowBoxChild
    >
  { $!fbc }

  # ↓↓↓↓ SIGNALS ↓↓↓↓
  method activate {
    self.connect($!fbc, 'activate');
  }
  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  method changed {
    so gtk_flow_box_child_changed($!fbc);
  }

  method get_index is also<get-index> {
    gtk_flow_box_child_get_index($!fbc);
  }

  method is_selected is also<is-selected> {
    so gtk_flow_box_child_is_selected($!fbc);
  }
  # ↑↑↑↑ METHODS ↑↑↑↑
}
