use v6.c;

use NativeCall;

use GTK::Raw::Utils;

use GTK::Compat::Types;
use GTK::Compat::Raw::Signal;

# STATIC CLASS

class GTK::Compat::Signal {
  
  # method new_valist (Str() $signal_name, GType $itype, GSignalFlags $signal_flags, GClosure $class_closure, GSignalAccumulator $accumulator, gpointer $accu_data, GSignalCMarshaller $c_marshaller, GType $return_type, guint $n_params, va_list $args) {
  #   g_signal_new_valist($signal_name, $itype, $signal_flags, $class_closure, $accumulator, $accu_data, $c_marshaller, $return_type, $n_params, $args);
  # }

  # NOT A CONSTRUCTOR!!
  method newv (
    Str() $signal_name, 
    Int() $itype, 
    Int() $signal_flags, 
    GClosure $class_closure, 
    GSignalAccumulator $accumulator, 
    gpointer $accu_data, 
    GSignalCMarshaller $c_marshaller, 
    Int() $return_type, 
    Int() $n_params, 
    CArray[uint64] $param_types
  ) {
    my guint ($sf, $np) = resolve-uint($signal_flags, $n_params);
    my uint64 ($it, $rt) = resolve-uint64($itype, $return_type);
    g_signal_newv(
      $signal_name, 
      $it, 
      $sf, 
      $class_closure, 
      $accumulator, 
      $accu_data, 
      $c_marshaller, 
      $rt, 
      $n_params, 
      $param_types
    );
  }

  method accumulator_first_wins (
    GSignalInvocationHint $ihint, 
    GValue() $return_accu, 
    GValue() $handler_return, 
    gpointer $dummy = Pointer
  ) {
    g_signal_accumulator_first_wins(
      $ihint, 
      $return_accu, 
      $handler_return, 
      $dummy
    );
  }

  method accumulator_true_handled (
    GSignalInvocationHint $ihint, 
    GValue() $return_accu, 
    GValue() $handler_return, 
    gpointer $dummy = Pointer
  ) {
    g_signal_accumulator_true_handled(
      $ihint, 
      $return_accu, 
      $handler_return, 
      $dummy
    );
  }

  method add_emission_hook (
    Int() $signal_id, 
    GQuark $detail, 
    GSignalEmissionHook $hook_func, 
    gpointer $hook_data          = Pointer, 
    GDestroyNotify $data_destroy = Pointer
  ) {
    my guint $sid = resolve-uint($signal_id);
    g_signal_add_emission_hook(
      $sid, 
      $detail, 
      $hook_func, 
      $hook_data, 
      $data_destroy
    );
  }

  method chain_from_overridden (
    GValue() $instance_and_params, 
    GValue() $return_value
  ) {
    g_signal_chain_from_overridden($instance_and_params, $return_value);
  }

  method connect_closure (
    GObject() $instance, 
    Str() $detailed_signal, 
    GClosure $closure, 
    Int() $after
  ) {
    my gboolean $a = resolve-bool($after);
    g_signal_connect_closure($instance, $detailed_signal, $closure, $a);
  }

  method connect_closure_by_id (
    GObject() $instance, 
    Int() $signal_id, 
    GQuark $detail, 
    GClosure $closure, 
    Int() $after
  ) {    
    my gboolean $a = resolve-bool($after);
    my guint $sid = resolve-uint($signal_id);
    g_signal_connect_closure_by_id($instance, $sid, $detail, $closure, $a);
  }
 

  # Should be aliased to "connect"
  method connect_data (
    GObject() $instance, 
    Str() $detailed_signal, 
    GCallback $c_handler, 
    gpointer $data, 
    GClosureNotify $destroy_data = Pointer, 
    Int() $connect_flags = 0
  ) {
    my guint $cf = resolve-uint($connect_flags);
    g_signal_connect_data(
      $instance, 
      $detailed_signal, 
      $c_handler, 
      $data, 
      $destroy_data, 
      $cf
    );
  }
  
  method connect_after (
    GObject() $instance, 
    Str() $detailed_signal, 
    GCallback $c_handler, 
    gpointer $data = Pointer
  ) {
    self.connect_data(
      $instance, 
      $detailed_signal, 
      $c_handler, 
      $data,
      Pointer,
      G_CONNECT_AFTER
    );
  }
  
  method connect_swapped (
    GObject() $instance, 
    Str() $detailed_signal, 
    GCallback $c_handler, 
    gpointer $data = Pointer
  ) {
    self.connect_data(
      $instance, 
      $detailed_signal, 
      $c_handler, 
      $data,
      Pointer,
      G_CONNECT_SWAPPED
    );
  }

  # method emit_valist (
  #   GObject() $instance, 
  #   guint $signal_id, 
  #   GQuark $detail, 
  #   va_list $var_args
  # ) {
  #   g_signal_emit_valist($instance, $signal_id, $detail, $var_args);
  # }

  method emitv (
    GValue() $instance_and_params, 
    Int() $signal_id, 
    GQuark $detail, 
    GValue() $return_value
  ) {
    my guint $sid = resolve-uint($signal_id);
    g_signal_emitv($instance_and_params, $sid, $detail, $return_value);
  }

  method get_invocation_hint (GObject() $instance) {
    g_signal_get_invocation_hint($instance);
  }

  method handler_block (GObject() $instance, Int() $handler_id) {
    my gulong $hid = resolve-uint64($handler_id);
    g_signal_handler_block($instance, $hid);
  }

  method handler_disconnect (GObject() $instance, Int() $handler_id) {
    my gulong $hid = resolve-uint64($handler_id);
    g_signal_handler_disconnect($instance, $handler_id);
  }

  method handler_find (
    GObject() $instance, 
    Int() $mask, 
    Int() $signal_id, 
    GQuark $detail, 
    GClosure $closure, 
    gpointer $func, 
    gpointer $data
  ) {
    my guint ($m, $sid) = resolve-uint($mask, $signal_id);
    g_signal_handler_find(
      $instance, 
      $m, 
      $sid, 
      $detail, 
      $closure, 
      $func, 
      $data
    );
  }

  method handler_is_connected (GObject() $instance, Int() $handler_id) {
    my gulong $hid = resolve-uint64($handler_id);
    g_signal_handler_is_connected($instance, $hid);
  }

  method handler_unblock (GObject() $instance, gulong $handler_id) {
    g_signal_handler_unblock($instance, $handler_id);
  }

  method handlers_block_matched (
    GObject() $instance, 
    Int() $mask, 
    Int() $signal_id, 
    GQuark $detail, 
    GClosure $closure, 
    gpointer $func, 
    gpointer $data
  ) {
    my guint ($m, $sid) = resolve-uint($mask, $signal_id);
    g_signal_handlers_block_matched(
      $instance, 
      $m, 
      $sid, 
      $detail, 
      $closure, 
      $func, 
      $data
    );
  }

  method handlers_destroy (GObject() $instance) {
    g_signal_handlers_destroy($instance);
  }

  method handlers_disconnect_matched (
    GObject() $instance, 
    Int() $mask, 
    Int() $signal_id, 
    GQuark $detail, 
    GClosure $closure, 
    gpointer $func, 
    gpointer $data
  ) {
    my guint ($m, $sid) = resolve-uint($mask, $signal_id);
    g_signal_handlers_disconnect_matched(
      $instance, 
      $m, 
      $sid, 
      $detail, 
      $closure, 
      $func, 
      $data
    );
  }

  method handlers_unblock_matched (
    GObject() $instance, 
    Int() $mask, 
    Int() $signal_id, 
    GQuark $detail, 
    GClosure $closure, 
    gpointer $func, 
    gpointer $data
  ) {
    my guint ($m, $sid) = resolve-uint($mask, $signal_id);
    g_signal_handlers_unblock_matched(
      $instance, 
      $m, 
      $sid, 
      $detail, 
      $closure, 
      $func, 
      $data
    );
  }

  method has_handler_pending (
    GObject() $instance, 
    Int() $signal_id, 
    GQuark $detail, 
    Int() $may_be_blocked
  ) {
    my guint $sid = resolve-uint($signal_id);
    my gboolean $m = resolve-bool($may_be_blocked);
    g_signal_has_handler_pending($instance, $sid, $detail, $m);
  }

  method list_ids (Int() $itype) {
    my ($n_ids, @ids) = (0);
    my guint $it = resolve-uint64($itype);
    
    my CArray[uint32] $cids = g_signal_list_ids($it, $n_ids);
    @ids[$_] = $cids[$_] for ^$n_ids;
    @ids;
  }

  method lookup (Str() $name, Int() $itype) {
    my uint64 $it = resolve-uint64($itype);
    g_signal_lookup($name, $it);
  }

  method name (Int() $signal_id) {
    my guint $sid = resolve-uint($signal_id);
    g_signal_name($sid);
  }

  method override_class_closure (
    Int() $signal_id, 
    Int() $instance_type, 
    GClosure $class_closure
  ) {
    my guint $sid = resolve-uint($signal_id);
    my uint64 $it = resolve-uint64($instance_type);
    g_signal_override_class_closure($sid, $it, $class_closure);
  }

  method override_class_handler (
    Str() $signal_name, 
    Int() $instance_type, 
    GCallback $class_handler
  ) {
    my uint64 $it = resolve-uint64($instance_type);
    g_signal_override_class_handler($signal_name, $it, $class_handler);
  }

  method parse_name (
    Str() $detailed_signal, 
    Int() $itype, 
    $signal_id_p is rw, 
    $detail_p    is rw,
    Int() $force_detail_quark
  ) {
    my gboolean $f = resolve-bool($force_detail_quark);
    my guint $sidp = 0;
    my uint64 $it = resolve-uint64($itype);
    my $cdp = CArray[uint32].new;
    my $rc = g_signal_parse_name(
      $detailed_signal, 
      $it, 
      $sidp, 
      $cdp, 
      $force_detail_quark
    );
    if $rc {
      $signal_id_p = $sidp;
      $detail_p = $cdp[0];
    }
    $rc;
  }

  method query (Int() $signal_id, GSignalQuery $query) {
    my guint $sid = resolve-uint($signal_id);
    g_signal_query($sid, $query);
  }

  method remove_emission_hook (Int() $signal_id, Int() $hook_id) {
    my guint $sid = resolve-uint($signal_id);
    my gulong $hi = resolve-uint64($hook_id);
    g_signal_remove_emission_hook($sid, $hi);
  }

  method set_va_marshaller (
    Int() $signal_id, 
    Int() $instance_type, 
    GSignalCVaMarshaller $va_marshaller
  ) {
    my guint $sid = resolve-uint($signal_id);
    my uint64 $it = resolve-uint64($instance_type);
    g_signal_set_va_marshaller($sid, $it, $va_marshaller);
  }

  method stop_emission (
    GObject() $instance, 
    Int() $signal_id, 
    GQuark $detail
  ) {
    my guint $sid = resolve-uint($signal_id);
    g_signal_stop_emission($instance, $sid, $detail);
  }

  method stop_emission_by_name (GObject() $instance, Str() $detailed_signal) {
    g_signal_stop_emission_by_name($instance, $detailed_signal);
  }

}
