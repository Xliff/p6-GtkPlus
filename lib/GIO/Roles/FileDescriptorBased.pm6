use v6.c;

use Method::Also;

use NativeCall;

use GLib::Raw::Types;

role GIO::Roles::FileDescriptorBased {
  has GFileDescriptorBased $!fdb;

  method GLib::Raw::Types::GFileDescriptorBased
    is also<GFileDescriptorBased>
  { $!fdb }

  method roleInit-FileDescriptorBased is also<roleInit_FileDescriptorBased> {
    my \i = findProperImplementor(self.^attributes);

    $!fdb = cast( GFileDescriptorBased, i.get_value(self) );
  }

  method role_get_fd is also<role-get-fd> {
    g_file_descriptor_based_get_fd($!fdb);
  }

  method filedescriptorbased_get_type is also<filedescriptorbased-get-type> {
    g_file_descriptor_based_get_type();
  }

}

sub g_file_descriptor_based_get_fd (GFileDescriptorBased $fd_based)
  returns gint
  is native(gio)
  is export
{ * }

sub g_file_descriptor_based_get_type ()
  returns GType
  is native(gio)
  is export
{ * }
