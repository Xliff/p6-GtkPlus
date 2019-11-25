use v6.c;

use NativeCall;

use GTK::Raw::Utils;

use GTK::Compat::Types;

use GLib::Raw::Log;

use GLib::Roles::StaticClass;

class GLib::Log {
  also does GLib::Roles::StaticClass;

  method log (Str() $log_domain, Int() $log_level, Str() $format) {
    my guint $ll = $log_level;

    g_log($log_domain, $ll, $format);
  }

  method message (Str() $format) {
    GLib::Log.log('GTK::Compat', G_LOG_LEVEL_MESSAGE,  $format);
  }

  method critical (Str() $format) {
    GLib::Log.log('GTK::Compat', G_LOG_LEVEL_CRITICAL, $format);
  }

  method error (Str() $format) {
    GLib::Log.log('GTK::Compat', G_LOG_LEVEL_ERROR,    $format);
  }

  method warn (Str() $format) {
    GLib::Log.log('GTK::Compat', G_LOG_LEVEL_WARNING,  $format);
  }

  method info (Str() $format) {
    GLib::Log.log('GTK::Compat', G_LOG_LEVEL_INFO,     $format);
  }

  method debug (Str() $format) {
    GLib::Log.log('GTK::Compat', G_LOG_LEVEL_DEBUG,    $format);
  }

  method default_handler (
    Str() $log_domain,
    Int() $log_level,
    Str() $message,
    gpointer $unused_data = Pointer
  ) {
    g_log_default_handler($log_domain, $log_level, $message, $unused_data);
  }

  # method logv (Str() $log_domain, Int() $log_level, Str() $format, va_list $args) {
  #   g_logv($log_domain, $log_level, $format, $args);
  # }
  #
  # method printf_string_upper_bound (Str() $format, va_list $args) {
  #   g_printf_string_upper_bound($format, $args);
  # }

  method return_if_fail_warning (
    Str() $log_domain,
    Str() $pretty_function,
    Str() $expression
  ) {
    g_return_if_fail_warning($log_domain, $pretty_function, $expression);
  }

  method set_print_handler (GPrintFunc $func) {
    g_set_print_handler($func);
  }

  method set_printerr_handler (GPrintFunc $func) {
    g_set_printerr_handler($func);
  }

  method warn_message (
    Str() $domain,
    Str() $file,
    Int() $line,
    Str() $func,
    Str() $warnexpr
  ) {
    my gint $l = $line;

    g_warn_message($domain, $file, $l, $func, $warnexpr);
  }

  method remove_handler (Str() $log_domain, Int() $handler_id) {
    my guint $hid = $handler_id;

    g_log_remove_handler($log_domain, $hid);
  }

  method set_always_fatal (Int() $fatal_mask) {
    g_log_set_always_fatal($fatal_mask);
  }

  method set_default_handler (
    GLogFunc $log_func,
    gpointer $user_data = Pointer
  ) {
    g_log_set_default_handler($log_func, $user_data);
  }

  method set_fatal_mask (Str() $log_domain, Int() $fatal_mask) {
    my guint $fm = $fatal_mask;

    g_log_set_fatal_mask($log_domain, $fm);
  }

  method set_handler (
    Str() $log_domain,
    Int() $log_levels,
    GLogFunc $log_func,
    gpointer $user_data = Pointer
  ) {
    my guint $ll = $log_levels;

    g_log_set_handler($log_domain, $ll, $log_func, $user_data);
  }

  method set_handler_full (
    Str() $log_domain,
    Int() $log_levels,
    GLogFunc $log_func,
    gpointer $user_data     = Pointer,
    GDestroyNotify $destroy = Pointer
  ) {
    my guint $ll = $log_levels;

    g_log_set_handler_full($log_domain, $ll, $log_func, $user_data, $destroy);
  }

  method set_writer_func (
    GLogWriterFunc $func,
    gpointer $user_data            = Pointer,
    GDestroyNotify $user_data_free = Pointer
  ) {
    g_log_set_writer_func($func, $user_data, $user_data_free);
  }

  method log_structured_array (
    Int() $log_level,
    GLogField $fields,
    Int() $n_fields
  ) {
    my guint $ll = $log_level;
    my uint64 $nf = $n_fields;

    g_log_structured_array($ll, $fields, $nf);
  }

  method variant (Str() $log_domain, Int() $log_level, GVariant() $fields) {
    my guint $ll = $log_level;

    g_log_variant($log_domain, $log_level, $fields);
  }

  method writer_default (
    Int() $log_level,
    GLogField $fields,
    Int() $n_fields,
    gpointer $user_data = Pointer
  ) {
    my guint $ll = $log_level;
    my uint64 $nf = $n_fields;

    g_log_writer_default($ll, $fields, $nf, $user_data);
  }

  method writer_format_fields (
    Int() $log_level,
    GLogField $fields,
    Int() $n_fields,
    Int() $use_color
  ) {
    my guint $ll = $log_level;
    my uint64 $nf = $n_fields;
    my gboolean $uc = so $use_color;

    g_log_writer_format_fields($ll, $fields, $nf, $uc);
  }

  # Handle IO::Handle, too?
  method writer_is_journald (Int() $output_fd) {
    my guint $of = $output_fd;

    g_log_writer_is_journald($of);
  }

  method writer_journald (
    Int() $log_level,
    GLogField $fields,
    Int() $n_fields,
    Int() $user_data = Pointer
  ) {
    my guint $ll = $log_level;
    my uint64 $nf = $n_fields;

    g_log_writer_journald($ll, $fields, $nf, $user_data);
  }

  method writer_standard_streams (
    Int() $log_level,
    GLogField $fields,
    Int() $n_fields,
    Int() $user_data = Pointer
  ) {
    my guint $ll = $log_level;
    my uint64 $nf = $n_fields;

    g_log_writer_standard_streams($ll, $fields, $nf, $user_data);
  }

  # Handle IO::Handle, too?
  method writer_supports_color (Int() $output_fd) {
    my guint $of = $output_fd;

    g_log_writer_supports_color($of);
  }

}
