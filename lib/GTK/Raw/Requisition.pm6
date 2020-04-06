use v6.c;

use NativeCall;

use MONKEY-TYPING;

use GLib::Raw::Definitions;
use GLib::Raw::Subs;
use GTK::Raw::Definitions;
use GTK::Raw::Structs;
use GTK::Raw::Subs;

unit package GTK::Raw::Requisition;

augment class GtkRequisition {

  method new {
    # Will return the eventual "self" since it returns a struct!
    gtk_requisition_new();
  }

  method get-type {
    self.get_type;
  }
  method get_type {
    state ($n, $t);

    unstable_get_type( self.^name, &gtk_requisition_get_type, $n, $t );
  }

  method copy {
    gtk_requisition_copy(self);
  }

  sub gtk_requisition_free (GtkRequisition $requisition)
    is native(gtk)
  { * }

  sub gtk_requisition_get_type ()
    returns GType
    is native(gtk)
  { * }

  sub gtk_requisition_copy (GtkRequisition $requisition)
    returns GtkRequisition
    is native(gtk)
  { * }

  sub gtk_requisition_new ()
    returns GtkRequisition
    is native(gtk)
  { * }

}

BEGIN { GtkRequisition.^compose }
