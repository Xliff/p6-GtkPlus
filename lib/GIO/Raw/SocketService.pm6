use v6.c;

use NativeCall;

use GTK::Compat::Types;

unit package GIO::Raw::SocketService;

sub g_socket_service_get_type ()
  returns GType
  is native(gio)
  is export
{ * }

sub g_socket_service_is_active (GSocketService $service)
  returns uint32
  is native(gio)
  is export
{ * }

sub g_socket_service_new ()
  returns GSocketService
  is native(gio)
  is export
{ * }

sub g_socket_service_start (GSocketService $service)
  is native(gio)
  is export
{ * }

sub g_socket_service_stop (GSocketService $service)
  is native(gio)
  is export
{ * }
