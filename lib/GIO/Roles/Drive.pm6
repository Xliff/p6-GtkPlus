use v6.c;

use Method::Also;

use NativeCall;

use GTK::Compat::Types;
use GTK::Compat::FileTypes;

use GTK::Raw::Utils;
use GIO::Raw::Drive;

use GIO::Roles::Icon;
use GTK::Roles::Signals::Generic;
use GIO::Roles::Volume;

role GIO::Roles::Drive {
  has GDrive $!d;

  submethod BUILD (:$drive) {
    $!d = $drive;
  }

  method roleInit-Drive is also<roleInit_Drive> {
    $!d = cast(
      GDrive,
      self.^attributes(:local)[0].get_value(self)
    );
  }

  method GTK::Compat::Types::GDrive
    is also<GDrive>
  { $!d }

  method new-drive-obj (GDrive $drive) is also<new_drive_obj> {
    self.bless( :$drive );
  }

  # Is originally:
  # GDrive, gpointer --> void
  method changed {
    self.connect($!d, 'changed');
  }

  # Is originally:
  # GDrive, gpointer --> void
  method disconnected {
    self.connect($!d, 'disconnected');
  }

  # Is originally:
  # GDrive, gpointer --> void
  method eject-button is also<eject_button> {
    self.connect($!d, 'eject-button');
  }

  # Is originally:
  # GDrive, gpointer --> void
  method stop-button is also<stop_button> {
    self.connect($!d, 'stop-button');
  }

  method can_eject is also<can-eject> {
    so g_drive_can_eject($!d);
  }

  method can_poll_for_media is also<can-poll-for-media> {
    so g_drive_can_poll_for_media($!d);
  }

  method can_start is also<can-start> {
    so g_drive_can_start($!d);
  }

  method can_start_degraded is also<can-start-degraded> {
    so g_drive_can_start_degraded($!d);
  }

  method can_stop is also<can-stop> {
    so g_drive_can_stop($!d);
  }

  proto method eject_with_operation (|)
      is also<eject-with-operation>
  { * }

  multi method eject_with_operation (
    Int() $flags,
    Int() $mount_operation,
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

    g_drive_eject_with_operation($!d, $flags, $mount_operation, $cancellable, $callback, $user_data);
  }

  method eject_with_operation_finish (
    GAsyncResult() $result,
    CArray[Pointer[GError]] $error = gerror
  )
    is also<eject-with-operation-finish>
  {
    clear_error;
    my $rv = so g_drive_eject_with_operation_finish($!d, $result, $error);
    set_error($error);
    $rv;
  }

  method enumerate_identifiers is also<enumerate-identifiers> {
    CStringArrayToArray( g_drive_enumerate_identifiers($!d) );
  }

  method get_icon (:$raw = False) is also<get-icon> {
    my $i = g_drive_get_icon($!d);

    $i ??
      ( $raw ?? $i !! GIO::Roles::Icon.new-icon-obj($i) )
      !!
      Nil;
  }

  method get_identifier (Str() $kind) is also<get-identifier> {
    g_drive_get_identifier($!d, $kind);
  }

  method get_name is also<get-name> {
    g_drive_get_name($!d);
  }

  method get_sort_key is also<get-sort-key> {
    g_drive_get_sort_key($!d);
  }

  method get_start_stop_type is also<get-start-stop-type> {
    GDriveStartStopTypeEnum( g_drive_get_start_stop_type($!d) );
  }

  method get_symbolic_icon (:$raw = False) is also<get-symbolic-icon> {
    my $i = g_drive_get_symbolic_icon($!d);

    $i ??
      ( $raw ?? $i !! GIO::Roles::Icon.new-icon-obj($i) )
      !!
      Nil;
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &g_drive_get_type, $n, $t );
  }

  method get_volumes (:$glist = False, :$raw = False) is also<get-volumes> {
    my $vl = g_drive_get_volumes($!d)
      but GTK::Compat::Roles::ListData[GVolume];

    return $vl if $glist;

    $vl ??
      ( $raw ??
        $vl.Array !!
        $vl.Array.map({ GIO::Roles::Volume.new-volume-obj($_) }) )
      !!
      Nil
  }

  method has_media is also<has-media> {
    so g_drive_has_media($!d);
  }

  method has_volumes is also<has-volumes> {
    so g_drive_has_volumes($!d);
  }

  method is_media_check_automatic is also<is-media-check-automatic> {
    so g_drive_is_media_check_automatic($!d);
  }

  method is_media_removable is also<is-media-removable> {
    so g_drive_is_media_removable($!d);
  }

  method is_removable is also<is-removable> {
    so g_drive_is_removable($!d);
  }

  proto method poll_for_media (|)
      is also<poll-for-media>
  { * }

  multi method poll_for_media (
    GAsyncReadyCallback $callback,
    gpointer $user_data = gpointer
  ) {
    samewith(GCancellable, $callback, $user_data);
  }
  multi method poll_for_media (
    GCancellable() $cancellable,
    GAsyncReadyCallback $callback,
    gpointer $user_data = gpointer
  ) {
    g_drive_poll_for_media($!d, $cancellable, $callback, $user_data);
  }

  method poll_for_media_finish (
    GAsyncResult() $result,
    CArray[Pointer[GError]] $error = gerror
  )
    is also<poll-for-media-finish>
  {
    clear_error;
    my $rv = so g_drive_poll_for_media_finish($!d, $result, $error);
    set_error($error);
    $rv;
  }

  multi method start (
    Int() $flags,
    Int() $mount_operation,
    GAsyncReadyCallback $callback,
    gpointer $user_data = gpointer
  ) {
    samewith($flags, $mount_operation, GCancellable, $callback, $user_data);
  }
  multi method start (
    Int() $flags,
    Int() $mount_operation,
    GCancellable() $cancellable,
    GAsyncReadyCallback $callback,
    gpointer $user_data = gpointer
  ) {
    my GDriveStartFlags $f = $flags;
    my GMountOperation $m = $mount_operation;

    g_drive_start($!d, $f, $m, $cancellable, $callback, $user_data);
  }

  method start_finish (
    GAsyncResult() $result,
    CArray[Pointer[GError]] $error = gerror
  )
    is also<start-finish>
  {
    clear_error;
    my $rv = so g_drive_start_finish($!d, $result, $error);
    set_error($error);
    $rv;
  }

  multi method stop (
    Int() $flags,
    Int() $mount_operation,
    GAsyncReadyCallback $callback,
    gpointer $user_data = gpointer
  ) {
    samewith($flags, $mount_operation, GCancellable, $callback, $user_data);
  }
  method stop (
    Int() $flags,
    Int() $mount_operation,
    GCancellable() $cancellable,
    GAsyncReadyCallback $callback,
    gpointer $user_data = gpointer
  ) {
    my GMountUnmountFlags $f = $flags;
    my GMountOperation $m = $mount_operation;

    g_drive_stop($!d, $f, $m, $cancellable, $callback, $user_data);
  }

  method stop_finish (
    GAsyncResult() $result,
    CArray[Pointer[GError]] $error = gerror
  )
    is also<stop-finish>
  {
    clear_error;
    my $rv = g_drive_stop_finish($!d, $result, $error);
    set_error($error);
    $rv;
  }

}
