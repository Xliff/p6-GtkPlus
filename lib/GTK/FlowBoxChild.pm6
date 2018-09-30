use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::FlowBox;
use GTK::Raw::Types;

use GTK::Bin;

# This is an interesting one as it is created by GTK::FlowBox automatically.
# It is practically an abstract class, but it is used as an individual object
# by GTK::FlowBox

# One could almost think this could just be a GTK::Bin. The jury is hung, at
# the moment.

class GTK::FlowBoxChild is GTK::Bin {
  has GtkFlowBoxChild $!fbc;

  method bless(*%attrinit) {
    use nqp;
    my $o = nqp::create(self).BUILDALL(Empty, %attrinit);
    $o.setType('GTK::FlowBoxChild');
    $o;
  }

  submethod BUILD(:$flowboxchild) {
    my $to-parent;
    given $flowboxchild {
      when GtkFlowBoxChild | GtkWidget {
        $!fbc = do {
          when GtkWidget  {
            $to-parent = $_;
            nativecast(GtkFlowBoxChild, $_);
          }
          when GtkFlowBoxChild {
            $to-parent = nativecast(GtkBin, $_);
            $_;
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

  multi method new {
    my $flowboxchild = gtk_flow_box_child_new();
    self.bless(:$flowboxchild);
  }
  multi method new (GtkWidget $flowboxchild) {
    self.bless(:$flowboxchild);
  }

  method GTK::Raw::Types::GtkFlowBoxChild {
    $!fbc
  }

  # ↓↓↓↓ SIGNALS ↓↓↓↓
  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  method changed {
    gtk_flow_box_child_changed($!fbc);
  }

  method get_index {
    gtk_flow_box_child_get_index($!fbc);
  }

  method is_selected {
    gtk_flow_box_child_is_selected($!fbc);
  }
  # ↑↑↑↑ METHODS ↑↑↑↑
}
