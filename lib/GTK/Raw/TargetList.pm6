use v6.c;

use NativeCall;


use GTK::Raw::Types:ver<3.0.1146>;

unit package GTK::Raw::TargetList:ver<3.0.1146>;

sub gtk_target_list_add (
  GtkTargetList $list,
  GdkAtom $target,
  guint $flags,
  guint $info
)
  is native(gtk)
  is export
  { * }

sub gtk_target_list_add_image_targets (
  GtkTargetList $list,
  guint $info,
  gboolean $writable
)
  is native(gtk)
  is export
  { * }

sub gtk_target_list_add_rich_text_targets (
  GtkTargetList $list,
  guint $info,
  gboolean $deserializable,
  GtkTextBuffer $buffer
)
  is native(gtk)
  is export
  { * }

sub gtk_target_list_add_table (
  GtkTargetList $list,
  GtkTargetEntry $targets,
  guint $ntargets
)
  is native(gtk)
  is export
  { * }

sub gtk_target_list_add_text_targets (GtkTargetList $list, guint $info)
  is native(gtk)
  is export
  { * }

sub gtk_target_list_add_uri_targets (GtkTargetList $list, guint $info)
  is native(gtk)
  is export
  { * }

sub gtk_target_list_find (GtkTargetList $list, GdkAtom $target, guint $info)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_target_list_get_type ()
  returns GType
  is native(gtk)
  is export
  { * }

sub gtk_target_list_new (
  CArray[GtkTargetEntry] $targets,
  guint $ntargets
)
  returns GtkTargetList
  is native(gtk)
  is export
  { * }

sub gtk_target_list_ref (GtkTargetList $list)
  returns GtkTargetList
  is native(gtk)
  is export
  { * }

sub gtk_target_list_remove (GtkTargetList $list, GdkAtom $target)
  is native(gtk)
  is export
  { * }

sub gtk_target_list_unref (GtkTargetList $list)
  is native(gtk)
  is export
  { * }