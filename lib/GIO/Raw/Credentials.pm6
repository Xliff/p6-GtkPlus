use v6.c;

use NativeCall;

use GLib::Raw::Types;

unit package GIO::Raw::Credentials;

sub g_credentials_get_native (
  GCredentials $credentials,
  GCredentialsType $native_type
)  
  returns Pointer
  is native(gio)
  is export
{ * }

sub g_credentials_get_type ()
  returns GType
  is native(gio)
  is export
{ * }

sub g_credentials_get_unix_pid (
  GCredentials $credentials,
  CArray[Pointer[GError]] $error
)
  returns pid_t
  is native(gio)
  is export
{ * }

sub g_credentials_get_unix_user (
  GCredentials $credentials,
  CArray[Pointer[GError]] $error
)
  returns uid_t
  is native(gio)
  is export
{ * }

sub g_credentials_is_same_user (
  GCredentials $credentials,
  GCredentials $other_credentials,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(gio)
  is export
{ * }

sub g_credentials_new ()
  returns GCredentials
  is native(gio)
  is export
{ * }

sub g_credentials_set_native (
  GCredentials $credentials,
  GCredentialsType $native_type,
  gpointer $native
)
  is native(gio)
  is export
{ * }

sub g_credentials_set_unix_user (
  GCredentials $credentials,
  uid_t $uid,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(gio)
  is export
{ * }

sub g_credentials_to_string (GCredentials $credentials)
  returns Str
  is native(gio)
  is export
{ * }
