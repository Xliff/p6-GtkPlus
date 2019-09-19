use v6.c;

use NativeCall;

use GTK::Compat::Types;

unit package GIO::Raw::InetSocketAddress;

sub g_inet_socket_address_get_address (GInetSocketAddress $address)
  returns GInetAddress
  is native(gio)
  is export
{ * }

sub g_inet_socket_address_get_flowinfo (GInetSocketAddress $address)
  returns guint32
  is native(gio)
  is export
{ * }

sub g_inet_socket_address_get_port (GInetSocketAddress $address)
  returns guint16
  is native(gio)
  is export
{ * }

sub g_inet_socket_address_get_scope_id (GInetSocketAddress $address)
  returns guint32
  is native(gio)
  is export
{ * }

sub g_inet_socket_address_get_type ()
  returns GType
  is native(gio)
  is export
{ * }

sub g_inet_socket_address_new (GInetAddress $address, guint16 $port)
  returns GSocketAddress
  is native(gio)
  is export
{ * }

sub g_inet_socket_address_new_from_string (Str $address, guint $port)
  returns GSocketAddress
  is native(gio)
  is export
{ * }
