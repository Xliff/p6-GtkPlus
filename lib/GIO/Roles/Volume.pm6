use v6.c;

use Method::Also;

use NativeCall;

use GTK::Compat::Types;
use GTK::Compat::FileTypes;
use GIO::Raw::Volume;

use GTK::Raw::Utils;

use GTK::Compat::Roles::Icon;
use GTK::Compat::Roles::GFile;

use GTK::Roles::Signals::Generic;

role GIO::Roles::Volume {
  also does GTK::Roles::Signals::Generic;

  has GVolume $!v;

  submethod BUILD (:$volume) {
    $!v = $volume;
  }

  method roleInit-Volume is also<roleInit_Volume> {
    $!v = cast(
      GVolume,
      self.^attributes(:local)[0].get_value(self)
    );
  }

  method GTK::Compat::Types::GVolume
  { $!v }

  method new-volume-obj (GVolume :$volume) is also<new_volume_obj> {
    self.bless( :$volume );
  }

  # Is originally:
  # GVolume, gpointer --> void
  method changed {
    self.connect($!v, 'changed');
  }

  # Is originally:
  # GVolume, gpointer --> void
  method removed {
    self.connect($!v, 'removed');
  }

  method can_eject is also<can-eject> {
    so g_volume_can_eject($!v);
  }

  method can_mount is also<can-mount> {
    so g_volume_can_mount($!v);
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

    g_volume_eject_with_operation(
      $!v,
      $f,
      $m,
      $cancellable,
      $callback,
      $user_data
    );
  }

  method eject_with_operation_finish (
    GAsyncResult() $result,
    CArray[Pointer[GError]] $error = gerror
  )
    is also<eject-with-operation-finish>
  {
    clear_error;
    my $rv = so g_volume_eject_with_operation_finish($!v, $result, $error);
    set_error($error);
    $rv;
  }

  method enumerate_identifiers is also<enumerate-identifiers> {
    CStringArrayToArray( g_volume_enumerate_identifiers($!v) );
  }

  method get_activation_root (:$raw = False) is also<get-activation-root> {
    my $f = g_volume_get_activation_root($!v);

    $f ??
      ( $raw ?? $f !! GTK::Compat::Roles::File.new-file-obj($f) )
      !!
      Nil;
  }

  method get_drive (:$raw = False) is also<get-drive> {
    my $d = g_volume_get_drive($!v);

    $d ??
      ( $raw ?? $d !! ::('GIO::Roles::Drive').new-drive-obj($d) )
      !!
      Nil;
  }

  method get_icon (:$raw = False) is also<get-icon> {
    my $i = g_volume_get_icon($!v);

    $i ??
      ( $raw ?? $i !! GTK::Compat::Roles::Icon.new-icon-obj($i) )
      !!
      Nil;
  }

  method get_identifier (Str() $kind) is also<get-identifier> {
    g_volume_get_identifier($!v, $kind);
  }

  method get_mount (:$raw = False) is also<get-mount> {
    my $m = g_volume_get_mount($!v);

    $m ??
      ( $raw ?? $m !! ::('GIO::Roles::Mount').new-mount-obj($m) )
      !!
      Nil;
  }

  method get_name is also<get-name> {
    g_volume_get_name($!v);
  }

  method get_sort_key is also<get-sort-key> {
    g_volume_get_sort_key($!v);
  }

  method get_symbolic_icon (:$raw = False) is also<get-symbolic-icon> {
    my $i = g_volume_get_symbolic_icon($!v);

    $i ??
      ( $raw ?? $i !! GTK::Compat::Roles::Icon.new-icon-obj($i) )
      !!
      Nil;
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &g_volume_get_type, $n, $t );
  }

  method get_uuid is also<get-uuid> {
    g_volume_get_uuid($!v);
  }

  multi method mount (
    Int() $flags,
    Int() $mount_operation,
    GAsyncReadyCallback $callback,
    gpointer $user_data = gpointer
  ) {
    samewith($flags, $mount_operation, GCancellable, $callback, $user_data);
  }
  multi method mount (
    Int() $flags,
    Int() $mount_operation,
    GCancellable() $cancellable,
    GAsyncReadyCallback $callback,
    gpointer $user_data = gpointer
  ) {
    my GMountUnmountFlags $f = $flags;
    my GMountOperation $m = $mount_operation;

    g_volume_mount(
      $!v,
      $flags,
      $mount_operation,
      $cancellable,
      $callback,
      $user_data
    );
  }

  method mount_finish (
    GAsyncResult() $result,
    CArray[Pointer[GError]] $error = gerror
  )
    is also<mount-finish>
  {
    clear_error;
    my $rv = so g_volume_mount_finish($!v, $result, $error);
    set_error($error);
    $rv;
  }

  method should_automount is also<should-automount> {
    so g_volume_should_automount($!v);
  }

}
