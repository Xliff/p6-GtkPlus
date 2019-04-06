use v6.c;

use NativeCall;

use GTK::Compat::Types;

unit package GTK::Compat::Raw::Signal;

sub g_signal_accumulator_first_wins (
  GSignalInvocationHint $ihint, 
  GValue $return_accu, 
  GValue $handler_return, 
  gpointer $dummy
)
  returns uint32
  is native(gobject)
  is export
  { * }

sub g_signal_accumulator_true_handled (
  GSignalInvocationHint $ihint, 
  GValue $return_accu, 
  GValue $handler_return, 
  gpointer $dummy
)
  returns uint32
  is native(gobject)
  is export
  { * }

sub g_signal_add_emission_hook (
  guint $signal_id, 
  GQuark $detail, 
  GSignalEmissionHook $hook_func, 
  gpointer $hook_data, 
  GDestroyNotify $data_destroy
)
  returns gulong
  is native(gobject)
  is export
  { * }

sub g_signal_chain_from_overridden (
  GValue $instance_and_params, 
  GValue $return_value
)
  is native(gobject)
  is export
  { * }

sub g_signal_connect_closure (
  GObject $instance,
  Str $detailed_signal, 
  GClosure $closure, 
  gboolean $after
)
  returns gulong
  is native(gobject)
  is export
  { * }

sub g_signal_connect_closure_by_id (
  GObject $instance, 
  guint $signal_id, 
  GQuark $detail, 
  GClosure $closure, 
  gboolean $after
)
  returns gulong
  is native(gobject)
  is export
  { * }

sub g_signal_connect_data (
  GObject $instance, 
  Str $detailed_signal, 
  GCallback $c_handler, 
  gpointer $data, 
  GClosureNotify $destroy_data, 
  uint32 $connect_flags             # GConnectFlags
)
  returns gulong
  is native(gobject)
  is export
  { * }

# sub g_signal_emit_valist (GObject $instance guint $signal_id, GQuark $detail, va_list $var_args)
#   is native(gobject)
#   is export
#   { * }

sub g_signal_emitv (
  GValue $instance_and_params, # Needs to be an array. Use ctilmes' solution!
  guint $signal_id, 
  GQuark $detail, 
  GValue $return_value
)
  is native(gobject)
  is export
  { * }

sub g_signal_get_invocation_hint (GObject $instance)
  returns GSignalInvocationHint
  is native(gobject)
  is export
  { * }

sub g_signal_handler_block (GObject $instance, gulong $handler_id)
  is native(gobject)
  is export
  { * }

sub g_signal_handler_disconnect (GObject $instance, gulong $handler_id)
  is native(gobject)
  is export
  { * }

sub g_signal_handler_find (
  GObject $instance, 
  guint32 $mask,                # GSignalMatchType
  guint $signal_id, 
  GQuark $detail, 
  GClosure $closure, 
  gpointer $func, 
  gpointer $data
)
  returns gulong
  is native(gobject)
  is export
  { * }

sub g_signal_handler_is_connected (GObject $instance, gulong $handler_id)
  returns uint32
  is native(gobject)
  is export
  { * }

sub g_signal_handler_unblock (GObject $instance, gulong $handler_id)
  is native(gobject)
  is export
  { * }

sub g_signal_handlers_block_matched (
  GObject $instance, 
  guint $mask,            # GSignalMatchType
  guint $signal_id, 
  GQuark $detail, 
  GClosure $closure, 
  gpointer $func, 
  gpointer $data
)
  returns guint
  is native(gobject)
  is export
  { * }

sub g_signal_handlers_destroy (GObject $instance)
  is native(gobject)
  is export
  { * }

sub g_signal_handlers_disconnect_matched (
  GObject $instance, 
  guint $mask,            # GSignalMatchType
  guint $signal_id, 
  GQuark $detail, 
  GClosure $closure, 
  gpointer $func, 
  gpointer $data
)
  returns guint
  is native(gobject)
  is export
  { * }

sub g_signal_handlers_unblock_matched (
  GObject $instance, 
  guint $mask,            # GSignalMatchType
  guint $signal_id, 
  GQuark $detail, 
  GClosure $closure, 
  gpointer $func, 
  gpointer $data
)
  returns guint
  is native(gobject)
  is export
  { * }

sub g_signal_has_handler_pending (
  GObject $instance,
  guint $signal_id, 
  GQuark $detail, 
  gboolean $may_be_blocked
)
  returns uint32
  is native(gobject)
  is export
  { * }

sub g_signal_list_ids (GType $itype, guint $n_ids)
  returns CArray[uint32]
  is native(gobject)
  is export
  { * }

sub g_signal_lookup (Str $name, GType $itype)
  returns guint
  is native(gobject)
  is export
  { * }

sub g_signal_name (guint $signal_id)
  returns Str
  is native(gobject)
  is export
  { * }

# sub g_signal_new_valist (
#   Str $signal_name, 
#   GType $itype, 
#   GSignalFlags $signal_flags, 
#   GClosure $class_closure, 
#   GSignalAccumulator $accumulator, 
#   gpointer $accu_data, 
#   GSignalCMarshaller $c_marshaller, 
#   GType $return_type, 
#   guint $n_params, 
#   va_list $args
# )
#   returns guint
#   is native(gobject)
#   is export
#   { * }

sub g_signal_newv (
  Str $signal_name, 
  uint64 $itype, 
  uint32 $signal_flags, 
  GClosure $class_closure, 
  GSignalAccumulator $accumulator, 
  gpointer $accu_data, 
  GSignalCMarshaller $c_marshaller, 
  uint64 $return_type, 
  guint $n_params, 
  CArray[uint64] $param_types
)  
  returns guint
  is native(gobject)
  is export
  { * }

sub g_signal_override_class_closure (
  guint $signal_id, 
  GType $instance_type, 
  GClosure $class_closure
)
  is native(gobject)
  is export
  { * }

sub g_signal_override_class_handler (
  Str $signal_name, 
  GType $instance_type, 
  GCallback $class_handler
)
  is native(gobject)
  is export
  { * }

sub g_signal_parse_name (
  Str $detailed_signal, 
  GType $itype, 
  uint32 $signal_id_p is rw, 
  CArray[uint32] $detail_p, 
  gboolean $force_detail_quark
)
  returns uint32
  is native(gobject)
  is export
  { * }

sub g_signal_query (guint $signal_id, GSignalQuery $query)
  is native(gobject)
  is export
  { * }

sub g_signal_remove_emission_hook (guint $signal_id, gulong $hook_id)
  is native(gobject)
  is export
  { * }

sub g_signal_set_va_marshaller (
  guint $signal_id, 
  GType $instance_type, 
  GSignalCVaMarshaller $va_marshaller
)
  is native(gobject)
  is export
  { * }

sub g_signal_stop_emission (
  GObject $instance, 
  guint $signal_id, 
  GQuark $detail
)
  is native(gobject)
  is export
  { * }

sub g_signal_stop_emission_by_name (GObject $instance, Str $detailed_signal)
  is native(gobject)
  is export
  { * }
