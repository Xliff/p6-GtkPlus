use v6.c;

use NativeCall;

use GTK::Compat::Types;

unit package GIO::Raw::NetworkService;

sub g_network_service_get_domain (GNetworkService $srv)
  returns Str
  is native(gio)
  is export
{ * }

sub g_network_service_get_protocol (GNetworkService $srv)
  returns Str
  is native(gio)
  is export
{ * }

sub g_network_service_get_service (GNetworkService $srv)
  returns Str
  is native(gio)
  is export
{ * }

sub g_network_service_get_type ()
  returns GType
  is native(gio)
  is export
{ * }

sub g_network_service_new (Str $service, Str $protocol, Str $domain)
  returns GNetworkService
  is native(gio)
  is export
{ * }

sub g_network_service_get_scheme (GNetworkService $srv)
  returns Str
  is native(gio)
  is export
{ * }

sub g_network_service_set_scheme (GNetworkService $srv, Str $scheme)
  is native(gio)
  is export
{ * }
