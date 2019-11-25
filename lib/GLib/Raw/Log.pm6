use v6.c;

use NativeCall;

use GTK::Compat::Types;

unit package GLib::Raw::Log;

sub g_log_default_handler (
  Str $log_domain,
  guint $log_level,
  Str $message,
  gpointer $unused_data
)
  is native(glib)
  is export
{ * }

# sub g_logv (Str $log_domain, guint $log_level, Str $format, va_list $args)
#   is native(glib)
#   is export
# { * }

# sub g_printf_string_upper_bound (Str $format, va_list $args)
#   returns gsize
#   is native(glib)
#   is export
# { * }

sub g_return_if_fail_warning (
  Str $log_domain,
  Str $pretty_function,
  Str $expression
)
  is native(glib)
  is export
{ * }

sub g_set_print_handler (GPrintFunc $func)
  returns GPrintFunc
  is native(glib)
  is export
{ * }

sub g_set_printerr_handler (GPrintFunc $func)
  returns GPrintFunc
  is native(glib)
  is export
{ * }

sub g_warn_message (
  Str $domain,
  Str $file,
  gint $line,
  Str $func,
  Str $warnexpr
)
  is native(glib)
  is export
{ * }

sub g_log_remove_handler (Str $log_domain, guint $handler_id)
  is native(glib)
  is export
{ * }

sub g_log_set_always_fatal (guint $fatal_mask)
  returns guint
  is native(glib)
  is export
{ * }

sub g_log_set_default_handler (GLogFunc $log_func, gpointer $user_data)
  returns GLogFunc
  is native(glib)
  is export
{ * }

sub g_log_set_fatal_mask (Str $log_domain, guint $fatal_mask)
  returns guint
  is native(glib)
  is export
{ * }

sub g_log_set_handler (
  Str $log_domain,
  guint $log_levels,
  GLogFunc $log_func,
  gpointer $user_data
)
  returns guint
  is native(glib)
  is export
{ * }

sub g_log_set_handler_full (
  Str $log_domain,
  guint $log_levels,
  GLogFunc $log_func,
  gpointer $user_data,
  GDestroyNotify $destroy
)
  returns guint
  is native(glib)
  is export
{ * }

sub g_log_set_writer_func (
  GLogWriterFunc $func,
  gpointer $user_data,
  GDestroyNotify $user_data_free
)
  is native(glib)
  is export
{ * }

sub g_log_structured_array (
  guint $log_level,
  GLogField $fields,
  gsize $n_fields
)
  is native(glib)
  is export
{ * }

sub g_log_variant (
  Str $log_domain,
  guint $log_level,
  GVariant $fields
)
  is native(glib)
  is export
{ * }

sub g_log_writer_default (
  guint $log_level,
  GLogField $fields,
  gsize $n_fields,
  gpointer $user_data
)
  returns uint32 # GLogWriterOutput
  is native(glib)
  is export
{ * }

sub g_log_writer_format_fields (
  guint $log_level,
  GLogField $fields,
  gsize $n_fields,
  gboolean $use_color
)
  returns Str
  is native(glib)
  is export
{ * }

sub g_log_writer_is_journald (gint $output_fd)
  returns uint32
  is native(glib)
  is export
{ * }

sub g_log_writer_journald (
  guint $log_level,
  GLogField $fields,
  gsize $n_fields,
  gpointer $user_data
)
  returns uint32 # GLogWriterOutput
  is native(glib)
  is export
{ * }

sub g_log_writer_standard_streams (
  guint $log_level,
  GLogField $fields,
  gsize $n_fields,
  gpointer $user_data
)
  returns uint32 # GLogWriterOutput
  is native(glib)
  is export
{ * }

sub g_log_writer_supports_color (gint $output_fd)
  returns uint32
  is native(glib)
  is export
{ * }

# Converted '...' definitions
sub g_log (
  Str $log_domain,
  uint32 $log_level,
  Str $format
)
  is native(glib)
  is export
{ * }
