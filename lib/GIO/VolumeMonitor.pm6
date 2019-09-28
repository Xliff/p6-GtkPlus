use v6.c;

use GTK::Compat::Types;
use GIO::Raw::VolumeMonitor;

use GTK::Compat::Roles::Object;
use GIO::Roles::Signals::VolumeMonitor;

class GIO::VolumeMonitor {
  also does GTK::Compat::Roles::Object;
  also does GIO::Roles::Signals::VolumeMonitor;

  has GVolumeMonitor $!vm;

  submethod BUILD (:$monitor) {
    $!vm = $monitor;

    self.roleInit-Object;
  }

  method GTK::Compat::Types::GVolumeMonitor
  { $!vm }

  method new (GVolumeMonitor $monitor) {
    self.bless( :$monitor );
  }

  # Is originally:
  # GVolumeMonitor, GDrive, gpointer --> void
  method drive-changed {
    self.connect-drive($!vm, 'drive-changed');
  }

  # Is originally:
  # GVolumeMonitor, GDrive, gpointer --> void
  method drive-connected {
    self.connect-drive($!vm, 'drive-connected');
  }

  # Is originally:
  # GVolumeMonitor, GDrive, gpointer --> void
  method drive-disconnected {
    self.connect-drive($!vm, 'drive-disconnected');
  }

  # Is originally:
  # GVolumeMonitor, GDrive, gpointer --> void
  method drive-eject-button {
    self.connect-drive($!vm, 'drive-eject-button');
  }

  # Is originally:
  # GVolumeMonitor, GDrive, gpointer --> void
  method drive-stop-button {
    self.connect-drive($!vm, 'drive-stop-button');
  }

  # Is originally:
  # GVolumeMonitor, GMount, gpointer --> void
  method mount-added {
    self.connect-mount($!vm, 'mount-added');
  }

  # Is originally:
  # GVolumeMonitor, GMount, gpointer --> void
  method mount-changed {
    self.connect-mount($!vm, 'mount-changed');
  }

  # Is originally:
  # GVolumeMonitor, GMount, gpointer --> void
  method mount-pre-unmount {
    self.connect-mount($!vm, 'mount-pre-unmount');
  }

  # Is originally:
  # GVolumeMonitor, GMount, gpointer --> void
  method mount-removed {
    self.connect-mount($!vm, 'mount-remove;');
  }

  # Is originally:
  # GVolumeMonitor, GVolume, gpointer --> void
  method volume-added {
    self.connect-volume($!vm, 'volume-added');
  }

  # Is originally:
  # GVolumeMonitor, GVolume, gpointer --> void
  method volume-changed {
    self.connect-volume($!vm, 'volume-changed');
  }

  # Is originally:
  # GVolumeMonitor, GVolume, gpointer --> void
  method volume-removed {
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
  {
    my $v = g_volume_monitor_adopt_orphan_mount($mount);

    $v ??
      ( $raw ?? $v !! GIO::Volume.new($v) )
      !!
      Nil;
  }

  method get_connected_drives (:$raw = False) {
    my $dl = g_volume_monitor_get_connected_drives($!vm)
      but GTK::Compat::Roles::ListData[GDrive];

    $dl ??
      ( $raw ?? $dl.Array !! $dl.Array.map({ GIO::Drive.new($_) }) )
      !!
      Nil;
  }

  method get_mount_for_uuid (Str() $uuid, :$raw = False) {
    my $m = g_volume_monitor_get_mount_for_uuid($!vm, $uuid);

    $m ??
      ( $raw ?? $m !! GIO::Mount.new($m) )
      !!
      Nil;
  }

  method get_mounts (:$raw = False) {
    my $ml = g_volume_monitor_get_mounts($!vm)
      but GTK::Compat::Roles::ListData[GMount];

    $ml ??
      ( $raw ?? $ml.Array !! $ml.Array.map({ GIO::Mount.new($_) }) )
      !!
      Nil;
  }

  method get_type {
    state ($n, $t);

    unstable_get_type( self.^name, &g_volume_monitor_get_type, $n, $t );
  }

  method get_volume_for_uuid (Str() $uuid, :$raw = False) {
    my $v = g_volume_monitor_get_volume_for_uuid($!vm, $uuid);

    $v ??
      ( $raw ?? $v !! GIO::Volume.new($v) )
      !!
      Nil;
  }

  method get_volumes (:$raw = False) {
    my $vl = g_volume_monitor_get_volumes($!vm);

    $vl ??
      ( $raw ?? $vl.Array !! $vl.Array.map({ GIO::Volume.new($_) }) )
      !!
      Nil
  }

}
