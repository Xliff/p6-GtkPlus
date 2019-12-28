use v6.c;

use Method::Also;

use GTK::Compat::Types;
use GIO::Raw::VolumeMonitor;

use GLib::Roles::Object;
use GIO::Roles::Signals::VolumeMonitor;

use GIO::Roles::Drive;
use GIO::Roles::Mount;
use GIO::Roles::Volume;

class GIO::VolumeMonitor {
  also does GLib::Roles::Object;
  also does GIO::Roles::Signals::VolumeMonitor;

  has GVolumeMonitor $!vm is implementor;

  submethod BUILD (:$monitor) {
    $!vm = $monitor;

    self.roleInit-Object;
  }

  method GTK::Compat::Types::GVolumeMonitor
    is also<GVolumeMonitor>
  { $!vm }

  method new (GVolumeMonitor $monitor) {
    self.bless( :$monitor );
  }

  # Is originally:
  # GVolumeMonitor, GDrive, gpointer --> void
  method drive-changed is also<drive_changed> {
    self.connect-drive($!vm, 'drive-changed');
  }

  # Is originally:
  # GVolumeMonitor, GDrive, gpointer --> void
  method drive-connected is also<drive_connected> {
    self.connect-drive($!vm, 'drive-connected');
  }

  # Is originally:
  # GVolumeMonitor, GDrive, gpointer --> void
  method drive-disconnected is also<drive_disconnected> {
    self.connect-drive($!vm, 'drive-disconnected');
  }

  # Is originally:
  # GVolumeMonitor, GDrive, gpointer --> void
  method drive-eject-button is also<drive_eject_button> {
    self.connect-drive($!vm, 'drive-eject-button');
  }

  # Is originally:
  # GVolumeMonitor, GDrive, gpointer --> void
  method drive-stop-button is also<drive_stop_button> {
    self.connect-drive($!vm, 'drive-stop-button');
  }

  # Is originally:
  # GVolumeMonitor, GMount, gpointer --> void
  method mount-added is also<mount_added> {
    self.connect-mount($!vm, 'mount-added');
  }

  # Is originally:
  # GVolumeMonitor, GMount, gpointer --> void
  method mount-changed is also<mount_changed> {
    self.connect-mount($!vm, 'mount-changed');
  }

  # Is originally:
  # GVolumeMonitor, GMount, gpointer --> void
  method mount-pre-unmount is also<mount_pre_unmount> {
    self.connect-mount($!vm, 'mount-pre-unmount');
  }

  # Is originally:
  # GVolumeMonitor, GMount, gpointer --> void
  method mount-removed is also<mount_removed> {
    self.connect-mount($!vm, 'mount-remove;');
  }

  # Is originally:
  # GVolumeMonitor, GVolume, gpointer --> void
  method volume-added is also<volume_added> {
    self.connect-volume($!vm, 'volume-added');
  }

  # Is originally:
  # GVolumeMonitor, GVolume, gpointer --> void
  method volume-changed is also<volume_changed> {
    self.connect-volume($!vm, 'volume-changed');
  }

  # Is originally:
  # GVolumeMonitor, GVolume, gpointer --> void
  method volume-removed is also<volume_removed> {
    self.connect-volume($!vm, 'volume-removed');
  }

  method get (:$raw = False) {
    my $v = g_volume_monitor_get();

    $v ??
      ( $raw ?? $v !! GIO::VolumeMonitor.new($v) )
      !!
      Nil;
  }

  method adopt_orphan_mount (GMount() $mount, :$raw = False)
    is DEPRECATED<the shadow mounts routines in GIO::Mount>
    is       also<adopt-orphan-mount>
  {
    my $v = g_volume_monitor_adopt_orphan_mount($mount);

    $v ??
      ( $raw ?? $v !! GIO::Roles::Volume.new-volume-obj($v) )
      !!
      Nil;
  }

  method get_connected_drives (:$raw = False) is also<get-connected-drives> {
    my $dl = g_volume_monitor_get_connected_drives($!vm)
      but GLib::Roles::ListData[GDrive];

    $dl ??
      ( $raw ??
        $dl.Array !!
        $dl.Array.map({ GIO::Roles::Drive.new-drive-obj($_) })
      )
      !!
      Nil;
  }

  method get_mount_for_uuid (Str() $uuid, :$raw = False)
    is also<get-mount-for-uuid>
  {
    my $m = g_volume_monitor_get_mount_for_uuid($!vm, $uuid);

    $m ??
      ( $raw ?? $m !! GIO::Roles::Mount.new-mount-obj($m) )
      !!
      Nil;
  }

  method get_mounts (:$raw = False) is also<get-mounts> {
    my $ml = g_volume_monitor_get_mounts($!vm)
      but GLib::Roles::ListData[GMount];

    $ml ??
      ( $raw ??
        $ml.Array !!
        $ml.Array.map({ GIO::Roles::Mount.new-mount-obj($_) })
      )
      !!
      Nil;
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &g_volume_monitor_get_type, $n, $t );
  }

  method get_volume_for_uuid (Str() $uuid, :$raw = False)
    is also<get-volume-for-uuid>
  {
    my $v = g_volume_monitor_get_volume_for_uuid($!vm, $uuid);

    $v ??
      ( $raw ?? $v !! GIO::Roles::Volume.new-volume-obj($v) )
      !!
      Nil;
  }

  method get_volumes (:$raw = False) is also<get-volumes> {
    my $vl = g_volume_monitor_get_volumes($!vm);

    $vl ??
      ( $raw ??
        $vl.Array !!
        $vl.Array.map({ GIO::Roles::Volume.new-volume-obj($_) })
      )
      !!
      Nil
  }

}
