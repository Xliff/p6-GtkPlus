use v6.c;

use NativeCall;

use GLib::Raw::Types;

unit package GIO::Raw::DatagramBased;

sub g_datagram_based_condition_check (
  GDatagramBased $datagram_based,
  GIOCondition $condition
)
  returns GIOCondition
  is native(glib)
  is export
{ * }

sub g_datagram_based_condition_wait (
  GDatagramBased $datagram_based,
  GIOCondition $condition,
  gint64 $timeout,
  GCancellable $cancellable,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(glib)
  is export
{ * }

sub g_datagram_based_create_source (
  GDatagramBased $datagram_based,
  GIOCondition $condition,
  GCancellable $cancellable
)
  returns GSource
  is native(glib)
  is export
{ * }

sub g_datagram_based_get_type ()
  returns GType
  is native(glib)
  is export
{ * }

sub g_datagram_based_receive_messages (
  GDatagramBased $datagram_based,
  GInputMessage $messages,
  guint $num_messages,
  gint $flags,
  gint64 $timeout,
  GCancellable $cancellable,
  CArray[Pointer[GError]] $error
)
  returns gint
  is native(glib)
  is export
{ * }

sub g_datagram_based_send_messages (
  GDatagramBased $datagram_based,
  GOutputMessage $messages,
  guint $num_messages,
  gint $flags,
  gint64 $timeout,
  GCancellable $cancellable,
  CArray[Pointer[GError]] $error
)
  returns gint
  is native(glib)
  is export
{ * }
