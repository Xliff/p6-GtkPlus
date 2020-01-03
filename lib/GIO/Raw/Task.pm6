use v6.c;

use NativeCall;

use GLib::Raw::Types;

unit package GIO::Raw::Task;

sub g_task_attach_source (
  GTask $task,
  GSource $source,
  &callback (gpointer --> gboolean)
)
  is native(gio)
  is export
{ * }

sub g_task_get_cancellable (GTask $task)
  returns GCancellable
  is native(gio)
  is export
{ * }

sub g_task_get_completed (GTask $task)
  returns uint32
  is native(gio)
  is export
{ * }

sub g_task_get_context (GTask $task)
  returns GMainContext
  is native(gio)
  is export
{ * }

sub g_task_get_source_object (GTask $task)
  returns Pointer
  is native(gio)
  is export
{ * }

sub g_task_get_task_data (GTask $task)
  returns Pointer
  is native(gio)
  is export
{ * }

sub g_task_get_type ()
  returns GType
  is native(gio)
  is export
{ * }

sub g_task_had_error (GTask $task)
  returns uint32
  is native(gio)
  is export
{ * }

sub g_task_is_valid (gpointer $result, gpointer $source_object)
  returns uint32
  is native(gio)
  is export
{ * }

sub g_task_new (
  gpointer $source_object,
  GCancellable $cancellable,
  &callback (GObject, GAsyncResult, gpointer),
  gpointer $callback_data
)
  returns GTask
  is native(gio)
  is export
{ * }

sub g_task_propagate_boolean (GTask $task, CArray[Pointer[GError]] $error)
  returns uint32
  is native(gio)
  is export
{ * }

sub g_task_propagate_int (GTask $task, CArray[Pointer[GError]] $error)
  returns gssize
  is native(gio)
  is export
{ * }

sub g_task_propagate_pointer (GTask $task, CArray[Pointer[GError]] $error)
  returns Pointer
  is native(gio)
  is export
{ * }

sub g_task_report_error (
  gpointer $source_object,
  &callback (GObject, GAsyncResult, gpointer),
  gpointer $callback_data,
  gpointer $source_tag,
  CArray[Pointer[GError]] $error
)
  is native(gio)
  is export
{ * }

sub g_task_return_boolean (GTask $task, gboolean $result)
  is native(gio)
  is export
{ * }

sub g_task_return_error (GTask $task, CArray[Pointer[GError]] $error)
  is native(gio)
  is export
{ * }

sub g_task_return_error_if_cancelled (GTask $task)
  returns uint32
  is native(gio)
  is export
{ * }

sub g_task_return_int (GTask $task, gssize $result)
  is native(gio)
  is export
{ * }

sub g_task_return_pointer (
  GTask $task,
  gpointer $result,
  GDestroyNotify $result_destroy
)
  is native(gio)
  is export
{ * }

sub g_task_run_in_thread (
  GTask $task,
  &task_func (gpointer --> gpointer)
)
  is native(gio)
  is export
{ * }

sub g_task_run_in_thread_sync (
  GTask $task,
  &task_func (gpointer --> gpointer)
  )
  is native(gio)
  is export
{ * }

sub g_task_set_task_data (
  GTask $task,
  gpointer $task_data,
  GDestroyNotify $task_data_destroy
)
  is native(gio)
  is export
{ * }

sub g_task_get_check_cancellable (GTask $task)
  returns uint32
  is native(gio)
  is export
{ * }

sub g_task_get_name (GTask $task)
  returns Str
  is native(gio)
  is export
{ * }

sub g_task_get_priority (GTask $task)
  returns gint
  is native(gio)
  is export
{ * }

sub g_task_get_return_on_cancel (GTask $task)
  returns uint32
  is native(gio)
  is export
{ * }

sub g_task_get_source_tag (GTask $task)
  returns Pointer
  is native(gio)
  is export
{ * }

sub g_task_set_check_cancellable (GTask $task, gboolean $check_cancellable)
  is native(gio)
  is export
{ * }

sub g_task_set_name (GTask $task, Str $name)
  is native(gio)
  is export
{ * }

sub g_task_set_priority (GTask $task, gint $priority)
  is native(gio)
  is export
{ * }

sub g_task_set_return_on_cancel (GTask $task, gboolean $return_on_cancel)
  returns uint32
  is native(gio)
  is export
{ * }

sub g_task_set_source_tag (GTask $task, gpointer $source_tag)
  is native(gio)
  is export
{ * }

sub g_task_report_new_error (
  gpointer            $source_object,
  &callback (GObject, GAsyncResult, gpointer),
  gpointer            $callback_data,
  gpointer            $source_tag,
  GQuark              $domain,
  gint                $code,
  Str                 $format,
  Str
)
  is native(gio)
  is export
{ * }

sub g_task_return_new_error (
  GTask  $task,
  GQuark $domain,
  gint   $code,
  Str    $format,
  Str
)
  is native(gio)
  is export
{ * }
