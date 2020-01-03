use v6.c;

use NativeCall;

use GLib::Raw::Types;

unit package GIO::MountOperation;

sub g_mount_operation_get_type ()
  returns GType
  is native(gio)
  is export
{ * }

sub g_mount_operation_new ()
  returns GMountOperation
  is native(gio)
  is export
{ * }

sub g_mount_operation_reply (
  GMountOperation $op,
  GMountOperationResult $result
)
  is native(gio)
  is export
{ * }

sub g_mount_operation_get_anonymous (GMountOperation $op)
  returns uint32
  is native(gio)
  is export
{ * }

sub g_mount_operation_get_choice (GMountOperation $op)
  returns gint
  is native(gio)
  is export
{ * }

sub g_mount_operation_get_domain (GMountOperation $op)
  returns Str
  is native(gio)
  is export
{ * }

sub g_mount_operation_get_is_tcrypt_hidden_volume (GMountOperation $op)
  returns uint32
  is native(gio)
  is export
{ * }

sub g_mount_operation_get_is_tcrypt_system_volume (GMountOperation $op)
  returns uint32
  is native(gio)
  is export
{ * }

sub g_mount_operation_get_password (GMountOperation $op)
  returns Str
  is native(gio)
  is export
{ * }

sub g_mount_operation_get_password_save (GMountOperation $op)
  returns GPasswordSave
  is native(gio)
  is export
{ * }

sub g_mount_operation_get_pim (GMountOperation $op)
  returns guint
  is native(gio)
  is export
{ * }

sub g_mount_operation_get_username (GMountOperation $op)
  returns Str
  is native(gio)
  is export
{ * }

sub g_mount_operation_set_anonymous (GMountOperation $op, gboolean $anonymous)
  is native(gio)
  is export
{ * }

sub g_mount_operation_set_choice (GMountOperation $op, gint $choice)
  is native(gio)
  is export
{ * }

sub g_mount_operation_set_domain (GMountOperation $op, Str $domain)
  is native(gio)
  is export
{ * }

sub g_mount_operation_set_is_tcrypt_hidden_volume (
  GMountOperation $op,
  gboolean $hidden_volume
)
  is native(gio)
  is export
{ * }

sub g_mount_operation_set_is_tcrypt_system_volume (
  GMountOperation $op,
  gboolean $system_volume
)
  is native(gio)
  is export
{ * }

sub g_mount_operation_set_password (GMountOperation $op, Str $password)
  is native(gio)
  is export
{ * }

sub g_mount_operation_set_password_save (
  GMountOperation $op,
  GPasswordSave $save
)
  is native(gio)
  is export
{ * }

sub g_mount_operation_set_pim (GMountOperation $op, guint $pim)
  is native(gio)
  is export
{ * }

sub g_mount_operation_set_username (GMountOperation $op, Str $username)
  is native(gio)
  is export
{ * }
