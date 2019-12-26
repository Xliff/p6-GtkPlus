use v6.c;

use Method::Also;
use NativeCall;

use GTK::Compat::Types;
use GTK::Compat::FileTypes;
use GIO::Raw::Mount;

use GTK::Raw::Utils;

use GTK::Roles::Signals::Generic;
use GIO::Roles::GFile;
use GIO::Roles::Icon;
use GIO::Roles::Volume;
use GIO::Roles::Drive;

role GIO::Roles::Mount {
  has GMount $!m;

  submethod BUILD (:$mount) {
    $!m = $mount;
  }

  method roleInit-Mount is also<roleInit_Mount> {
    my \i = findProperImplementor(self.^attributes);

    $!m = cast(GMount, i.get_value(self) );
  }

  method GTK::Compat::Types::GMount
    is also<GMount>
  { $!m }

  method new-mount-obj ($mount) is also<new_mount_obj> {
    self.bless( :$mount );
  }

  # Is originally:
  # GMount, gpointer --> void
  method changed {
    self.connect($!m, 'changed');
  }

  # Is originally:
  # GMount, gpointer --> void
  method pre-unmount is also<pre_unmount> {
    self.connect($!m, 'pre-unmount');
  }

  # Is originally:
  # GMount, gpointer --> void
  method unmounted {
    self.connect($!m, 'unmounted');
  }

  method can_eject is also<can-eject> {
    so g_mount_can_eject($!m);
  }

  method can_unmount is also<can-unmount> {
    so g_mount_can_unmount($!m);
  }

  proto method eject_with_operation (|)
      is also<eject-with-operation>
  { * }

  multi method eject_with_operation (
    Int() $flags,
    Int() $mount_operation,
    GCancellable() $cancellable,
    GAsyncReadyCallback $callback,
    gpointer $user_data = gpointer
  ) {
    samewith($flags, $mount_operation, GCancellable, $callback, $user_data);
  }
  multi method eject_with_operation (
    Int() $flags,
    Int() $mount_operation,
    GCancellable() $cancellable,
    GAsyncReadyCallback $callback,
    gpointer $user_data = gpointer
  ) {
    my GMountUnmountFlags $f = $flags;
    my GMountOperation $m = $mount_operation;

    g_mount_eject_with_operation(
      $!m,
      $f,
      $m,
      $cancellable,
      $callback,
      $user_data
    );
  }

  method eject_with_operation_finish (
    GAsyncResult() $result,
    CArray[Pointer[GError]] $error
  )
    is also<eject-with-operation-finish>
  {
    clear_error;
    my $rv = so g_mount_eject_with_operation_finish($!m, $result, $error);
    set_error($error);
    $rv;
  }

  method get_default_location (:$raw = False) is also<get-default-location> {
    my $f = g_mount_get_default_location($!m);

    $f ??
      ( $raw ?? $f !! GIO::Roles::GFile.new-file-obj($f) )
      !!
      Nil;
  }

  method get_drive (:$raw = False) is also<get-drive> {
    my $d = g_mount_get_drive($!m);

    $d ??
      ( $raw ?? $d !! GIO::Roles::Drive.new-drive-obj($d) )
      !!
      Nil;
  }

  method get_icon (:$raw = False) is also<get-icon> {
    my $i = g_mount_get_icon($!m);

    $i ??
      ( $raw ?? $i !! GIO::Roles::Icon.new-icon-obj($i) )
      !!
      Nil;
  }

  method get_name is also<get-name> {
    g_mount_get_name($!m);
  }

  method get_root ($raw = False) is also<get-root> {
    my $f = g_mount_get_root($!m);

    $f ??
      ( $raw ?? $f !! GIO::Roles::GFile.new-file-obj($f) )
      !!
      Nil;
  }

  method get_sort_key is also<get-sort-key> {
    g_mount_get_sort_key($!m);
  }

  method get_symbolic_icon (:$raw = False) is also<get-symbolic-icon> {
    my $i = g_mount_get_symbolic_icon($!m);

    $i ??
      ( $raw ?? $i !! GIO::Roles::Icon.new-icon-obj($i) )
      !!
      Nil;
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &g_mount_get_type, $n, $t );
  }

  method get_uuid is also<get-uuid> {
    g_mount_get_uuid($!m);
  }

  method get_volume (:$raw = False) is also<get-volume> {
    my $v = g_mount_get_volume($!m);

    $v ??
      ( $raw ?? $v !! GIO::Roles::Volume.new-volume-obj($v) )
      !!
      Nil;
  }

  proto method guess_content_type (|)
      is also<guess-content-type>
  { * }

  multi method guess_content_type (
    Int() $force_rescan,
    GAsyncReadyCallback $callback,
    gpointer $user_data = gpointer
  ) {
    samewith($force_rescan, GCancellable, $callback, $user_data);
  }
  multi method guess_content_type (
    Int() $force_rescan,
    GCancellable() $cancellable,
    GAsyncReadyCallback $callback,
    gpointer $user_data = gpointer
  ) {
    my gboolean $f = $force_rescan;

    g_mount_guess_content_type($!m, $f, $cancellable, $callback, $user_data);
  }

  method guess_content_type_finish (
    GAsyncResult() $result,
    CArray[Pointer[GError]] $error = gerror
  )
    is also<guess-content-type-finish>
  {
    clear_error;
    my $sa = g_mount_guess_content_type_finish($!m, $result, $error);
    set_error($error);

    CStringArrayToArray($sa);
  }

  method guess_content_type_sync (
    Int() $force_rescan,
    GCancellable() $cancellable = GCancellable,
    CArray[Pointer[GError]] $error = gerror
  )
    is also<guess-content-type-sync>
  {
    my gboolean $f = $force_rescan;

    clear_error;
    my $sa = g_mount_guess_content_type_sync($!m, $f, $cancellable, $error);
    set_error($error);

    CStringArrayToArray($sa);
  }

  method is_shadowed is also<is-shadowed> {
    so g_mount_is_shadowed($!m);
  }

  multi method remount (
    Int() $flags,
    Int() $mount_operation,
    GAsyncReadyCallback $callback,
    gpointer $user_data = gpointer
  ) {
    samewith($flags, $mount_operation, GCancellable, $callback, $user_data);
  }
  method remount (
    Int() $flags,
    Int() $mount_operation,
    GCancellable() $cancellable,
    GAsyncReadyCallback $callback,
    gpointer $user_data = gpointer
  ) {
    my GMountUnmountFlags $f = $flags;
    my GMountOperation $m = $mount_operation;

    g_mount_remount($!m, $f, $m, $cancellable, $callback, $user_data);
  }

  method remount_finish (
    GAsyncResult() $result,
    CArray[Pointer[GError]] $error = gerror
  )
    is also<remount-finish>
  {
    clear_error;
    my $rv = so g_mount_remount_finish($!m, $result, $error);
    set_error($error);
    $rv;
  }

  method shadow {
    g_mount_shadow($!m);
  }

  proto method unmount_with_operation (|)
      is also<unmount-with-operation>
  { * }

  multi method unmount_with_operation (
    Int() $flags,
    Int() $mount_operation,
    GAsyncReadyCallback $callback,
    gpointer $user_data = gpointer
  ) {
    samewith($flags, $mount_operation, GCancellable, $callback, $user_data);
  }
  multi method unmount_with_operation (
    Int() $flags,
    Int() $mount_operation,
    GCancellable() $cancellable,
    GAsyncReadyCallback $callback,
    gpointer $user_data = gpointer
  ) {
    my GMountUnmountFlags $f = $flags;
    my GMountOperation $m = $mount_operation;

    g_mount_unmount_with_operation(
      $!m,
      $f,
      $m,
      $cancellable,
      $callback,
      $user_data
    );
  }

  method unmount_with_operation_finish (
    GAsyncResult() $result,
    CArray[Pointer[GError]] $error = gerror
  )
    is also<unmount-with-operation-finish>
  {
    clear_error;
    my $rv = so g_mount_unmount_with_operation_finish($!m, $result, $error);
    set_error($error);
    $rv;
  }

  method unshadow {
    g_mount_unshadow($!m);
  }

}
