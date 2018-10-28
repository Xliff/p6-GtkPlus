use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::Types;

unit package GTK::Raw::TargetList;

sub gtk_target_list_add (
  GtkTargetList $list,
  GdkAtom $target,
  guint $flags,
  guint $info
)
  is native($LIBGTK)
  is export
  { * }

sub gtk_target_list_add_image_targets (
  GtkTargetList $list,
  guint $info,
  gboolean $writable
)
  is native($LIBGTK)
  is export
  { * }

sub gtk_target_list_add_rich_text_targets (
  GtkTargetList $list,
  guint $info,
  gboolean $deserializable,
  GtkTextBuffer $buffer
)
  is native($LIBGTK)
  is export
  { * }

sub gtk_target_list_add_table (
  GtkTargetList $list,
  GtkTargetEntry $targets,
  guint $ntargets
)
  is native($LIBGTK)
  is export
  { * }

sub gtk_target_list_add_text_targets (GtkTargetList $list, guint $info)
  is native($LIBGTK)
  is export
  { * }

sub gtk_target_list_add_uri_targets (GtkTargetList $list, guint $info)
  is native($LIBGTK)
  is export
  { * }

sub gtk_target_list_find (GtkTargetList $list, GdkAtom $target, guint $info)
  returns uint32
  is native($LIBGTK)
  is export
  { * }

sub gtk_target_list_get_type ()
  returns GType
  is native($LIBGTK)
  is export
  { * }

sub gtk_target_list_new (
  CArray[GtkTargetEntry] $targets,
  guint $ntargets
)
  returns GtkTargetList
  is native($LIBGTK)
  is export
  { * }

sub gtk_target_list_ref (GtkTargetList $list)
  returns GtkTargetList
  is native($LIBGTK)
  is export
  { * }

sub gtk_target_list_remove (GtkTargetList $list, GdkAtom $target)
  is native($LIBGTK)
  is export
  { * }

sub gtk_target_list_unref (GtkTargetList $list)
  is native($LIBGTK)
  is export
  { * }