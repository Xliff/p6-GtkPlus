use v6.c;

use Method::Also;
use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::FlowBox;
use GTK::Raw::Types;

use GTK::Bin;

our subset FlowBoxChildAncestry is export of Mu
  where GtkFlowBoxChild | BinAncestry;

class GTK::FlowBoxChild is GTK::Bin {
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
            $to-parent = nativecast(GtkBin, $_);
            $_;
          }

          default {
            $to-parent = $_;
            nativecast(GtkFlowBoxChild, $_);
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

  multi method new (FlowBoxChildAncestry $flowboxchild) {
    my $o = self.bless(:$flowboxchild);
    $o.upref;
    $o;
  }
  multi method new {
    my $flowboxchild = gtk_flow_box_child_new();
    self.bless(:$flowboxchild);
  }

  method GTK::Raw::Types::GtkFlowBoxChild
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
    gtk_flow_box_child_changed($!fbc);
  }

  method get_index is also<get-index> {
    gtk_flow_box_child_get_index($!fbc);
  }

  method is_selected is also<is-selected> {
    so gtk_flow_box_child_is_selected($!fbc);
  }
  # ↑↑↑↑ METHODS ↑↑↑↑
}
