use v6.c;

use NativeCall;

use GDK::Raw::Types;

unit package GDK::Raw::DragContext;

sub gdk_drag_abort (GdkDragContext $context, guint32 $time_)
  is native(gdk)
  is export
  { * }

sub gdk_drag_begin (GdkWindow $window, GList $targets)
  returns GdkDragContext
  is native(gdk)
  is export
  { * }

sub gdk_drag_begin_for_device (
  GdkWindow $window,
  GdkDevice $device,
  GList $targets
)
  returns GdkDragContext
  is native(gdk)
  is export
  { * }

sub gdk_drag_begin_from_point (
  GdkWindow $window,
  GdkDevice $device,
  GList $targets,
  gint $x_root,
  gint $y_root
)
  returns GdkDragContext
  is native(gdk)
  is export
  { * }

sub gdk_drag_context_get_actions (GdkDragContext $context)
  returns uint32 # GdkDragAction
  is native(gdk)
  is export
  { * }

sub gdk_drag_context_get_dest_window (GdkDragContext $context)
  returns GdkWindow
  is native(gdk)
  is export
  { * }

sub gdk_drag_context_get_drag_window (GdkDragContext $context)
  returns GdkWindow
  is native(gdk)
  is export
  { * }

sub gdk_drag_context_get_protocol (GdkDragContext $context)
  returns uint32 # GdkDragProtocol
  is native(gdk)
  is export
  { * }

sub gdk_drag_context_get_selected_action (GdkDragContext $context)
  returns uint32 # GdkDragAction
  is native(gdk)
  is export
  { * }

sub gdk_drag_context_get_source_window (GdkDragContext $context)
  returns GdkWindow
  is native(gdk)
  is export
  { * }

sub gdk_drag_context_get_suggested_action (GdkDragContext $context)
  returns uint32 # GdkDragAction
  is native(gdk)
  is export
  { * }

sub gdk_drag_context_get_type ()
  returns GType
  is native(gdk)
  is export
  { * }

sub gdk_drag_context_list_targets (GdkDragContext $context)
  returns GList
  is native(gdk)
  is export
  { * }

sub gdk_drag_context_manage_dnd (
  GdkDragContext $context,
  GdkWindow $ipc_window,
  guint $actions                        # GdkDragAction $actions
)
  returns uint32
  is native(gdk)
  is export
  { * }

sub gdk_drag_context_set_hotspot (
  GdkDragContext $context,
  gint $hot_x,
  gint $hot_y
)
  is native(gdk)
  is export
  { * }

sub gdk_drag_drop (GdkDragContext $context, guint32 $time_)
  is native(gdk)
  is export
  { * }

sub gdk_drag_drop_done (GdkDragContext $context, gboolean $success)
  is native(gdk)
  is export
  { * }

sub gdk_drag_drop_succeeded (GdkDragContext $context)
  returns uint32
  is native(gdk)
  is export
  { * }

sub gdk_drag_find_window_for_screen (
  GdkDragContext $context,
  GdkWindow $drag_window,
  GdkScreen $screen,
  gint $x_root,
  gint $y_root,
  GdkWindow $dest_window,
  guint $protocol                       # GdkDragProtocol $protocol
)
  is native(gdk)
  is export
  { * }

sub gdk_drop_finish (
  GdkDragContext $context,
  gboolean $success,
  guint32 $time
)
  is native(gdk)
  is export
  { * }

sub gdk_drop_reply (
  GdkDragContext $context,
  gboolean $accepted,
  guint32 $time
)
  is native(gdk)
  is export
  { * }

sub gdk_drag_get_selection (GdkDragContext $context)
  returns GdkAtom
  is native(gdk)
  is export
  { * }

sub gdk_drag_motion (
  GdkDragContext $context,
  GdkWindow $dest_window,
  guint $protocol,                       # GdkDragProtocol $protocol,
  gint $x_root,
  gint $y_root,
  guint $suggested,                     # GdkDragAction $suggested_action,
  guint $possible,                      # GdkDragAction $possible_actions,
  guint32 $time
)
  returns uint32
  is native(gdk)
  is export
  { * }

sub gdk_drag_status (
  GdkDragContext $context,
  guint $action,                        # GdkDragAction $action,
  guint32 $time
)
  is native(gdk)
  is export
  { * }

sub gdk_drag_context_get_device (GdkDragContext $context)
  returns GdkDevice
  is native(gdk)
  is export
  { * }

sub gdk_drag_context_set_device (
  GdkDragContext $context,
  GdkDevice $device
)
  is native(gdk)
  is export
  { * }
