use v6.c;

use NativeCall;

use GTK::Compat::Types;

unit package GLib::Raw::BookmarkFile;

sub g_bookmark_file_add_application (
  GBookmarkFile $bookmark,
  Str $uri,
  Str $name,
  Str $exec
)
  is native(glib)
  is export
{ * }

sub g_bookmark_file_add_group (
  GBookmarkFile $bookmark,
  Str $uri,
  Str $group
)
  is native(glib)
  is export
{ * }

sub g_bookmark_file_error_quark ()
  returns GQuark
  is native(glib)
  is export
{ * }

sub g_bookmark_file_free (GBookmarkFile $bookmark)
  is native(glib)
  is export
{ * }

sub g_bookmark_file_get_added (
  GBookmarkFile $bookmark,
  Str $uri,
  CArray[Pointer[GError]] $error
)
  returns time_t
  is native(glib)
  is export
{ * }

sub g_bookmark_file_get_app_info (
  GBookmarkFile $bookmark,
  Str $uri,
  Str $name,
  Str $exec,
  guint $count,
  time_t $stamp,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(glib)
  is export
{ * }

sub g_bookmark_file_get_applications (
  GBookmarkFile $bookmark,
  Str $uri,
  gsize $length is rw,
  CArray[Pointer[GError]] $error
)
  returns CArray[Str]
  is native(glib)
  is export
{ * }

sub g_bookmark_file_get_description (
  GBookmarkFile $bookmark,
  Str $uri,
  CArray[Pointer[GError]] $error
)
  returns Str
  is native(glib)
  is export
{ * }

sub g_bookmark_file_get_groups (
  GBookmarkFile $bookmark,
  Str $uri,
  gsize $length is rw,
  CArray[Pointer[GError]] $error
)
  returns CArray[Str]
  is native(glib)
  is export
{ * }

sub g_bookmark_file_get_icon (
  GBookmarkFile $bookmark,
  Str $uri,
  Str $href,
  Str $mime_type,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(glib)
  is export
{ * }

sub g_bookmark_file_get_is_private (
  GBookmarkFile $bookmark,
  Str $uri,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(glib)
  is export
{ * }

sub g_bookmark_file_get_mime_type (
  GBookmarkFile $bookmark,
  Str $uri,
  CArray[Pointer[GError]] $error
)
  returns Str
  is native(glib)
  is export
{ * }

sub g_bookmark_file_get_modified (
  GBookmarkFile $bookmark,
  Str $uri,
  CArray[Pointer[GError]] $error
)
  returns time_t
  is native(glib)
  is export
{ * }

sub g_bookmark_file_get_size (GBookmarkFile $bookmark)
  returns gint
  is native(glib)
  is export
{ * }

sub g_bookmark_file_get_title (
  GBookmarkFile $bookmark,
  Str $uri,
  CArray[Pointer[GError]] $error
)
  returns Str
  is native(glib)
  is export
{ * }

sub g_bookmark_file_get_uris (GBookmarkFile $bookmark, gsize $length is rw)
  returns CArray[Str]
  is native(glib)
  is export
{ * }

sub g_bookmark_file_get_visited (
  GBookmarkFile $bookmark,
  Str $uri,
  CArray[Pointer[GError]] $error
)
  returns time_t
  is native(glib)
  is export
{ * }

sub g_bookmark_file_has_application (
  GBookmarkFile $bookmark,
  Str $uri,
  Str $name,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(glib)
  is export
{ * }

sub g_bookmark_file_has_group (
  GBookmarkFile $bookmark,
  Str $uri,
  Str $group,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(glib)
  is export
{ * }

sub g_bookmark_file_has_item (GBookmarkFile $bookmark, Str $uri)
  returns uint32
  is native(glib)
  is export
{ * }

sub g_bookmark_file_load_from_data (
  GBookmarkFile $bookmark,
  Str $data,
  gsize $length,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(glib)
  is export
{ * }

sub g_bookmark_file_load_from_data_dirs (
  GBookmarkFile $bookmark,
  Str $file,
  Str $full_path,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(glib)
  is export
{ * }

sub g_bookmark_file_load_from_file (
  GBookmarkFile $bookmark,
  Str $filename,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(glib)
  is export
{ * }

sub g_bookmark_file_move_item (
  GBookmarkFile $bookmark,
  Str $old_uri,
  Str $new_uri,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(glib)
  is export
{ * }

sub g_bookmark_file_new ()
  returns GBookmarkFile
  is native(glib)
  is export
{ * }

sub g_bookmark_file_remove_application (
  GBookmarkFile $bookmark,
  Str $uri,
  Str $name,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(glib)
  is export
{ * }

sub g_bookmark_file_remove_group (
  GBookmarkFile $bookmark,
  Str $uri,
  Str $group,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(glib)
  is export
{ * }

sub g_bookmark_file_remove_item (
  GBookmarkFile $bookmark,
  Str $uri,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(glib)
  is export
{ * }

sub g_bookmark_file_set_added (
  GBookmarkFile $bookmark,
  Str $uri,
  time_t $added
)
  is native(glib)
  is export
{ * }

sub g_bookmark_file_set_app_info (
  GBookmarkFile $bookmark,
  Str $uri,
  Str $name,
  Str $exec,
  gint $count,
  time_t $stamp,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(glib)
  is export
{ * }

sub g_bookmark_file_set_description (
  GBookmarkFile $bookmark,
  Str $uri,
  Str $description
)
  is native(glib)
  is export
{ * }

sub g_bookmark_file_set_groups (
  GBookmarkFile $bookmark,
  Str $uri,
  Str $groups,
  gsize $length
)
  is native(glib)
  is export
{ * }

sub g_bookmark_file_set_icon (
  GBookmarkFile $bookmark,
  Str $uri,
  Str $href,
  Str $mime_type
)
  is native(glib)
  is export
{ * }

sub g_bookmark_file_set_is_private (
  GBookmarkFile $bookmark,
  Str $uri,
  gboolean $is_private
)
  is native(glib)
  is export
{ * }

sub g_bookmark_file_set_mime_type (
  GBookmarkFile $bookmark,
  Str $uri,
  Str $mime_type
)
  is native(glib)
  is export
{ * }

sub g_bookmark_file_set_modified (
  GBookmarkFile $bookmark,
  Str $uri,
  time_t $modified
)
  is native(glib)
  is export
{ * }

sub g_bookmark_file_set_title (GBookmarkFile $bookmark, Str $uri, Str $title)
  is native(glib)
  is export
{ * }

sub g_bookmark_file_set_visited (
  GBookmarkFile $bookmark,
  Str $uri,
  time_t $visited
)
  is native(glib)
  is export
{ * }

sub g_bookmark_file_to_data (
  GBookmarkFile $bookmark,
  gsize $length,
  CArray[Pointer[GError]] $error
)
  returns Str
  is native(glib)
  is export
{ * }

sub g_bookmark_file_to_file (
  GBookmarkFile $bookmark,
  Str $filename,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(glib)
  is export
{ * }
