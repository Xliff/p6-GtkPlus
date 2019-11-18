use v6.c;

use Method::Also;
use NativeCall;

use GTK::Compat::Types;
use GTK::Compat::Raw::Main;

use GTK::Raw::Utils;

use GTK::Compat::Roles::TypedBuffer;

class GTK::Compat::MainContext {
  has GMainContext $!mc is implementor;

  submethod BUILD (:$maincontext) {
    $!mc = $maincontext;
  }

  method GTK::Compat::Types::GMainContext
    is also<
      GMainContext
      MainContext
    >
  { $!mc }

  multi method new (GMainContext $maincontext) {
    self.bless( :$maincontext );
  }
  multi method new {
    self.bless( maincontext => g_main_context_new() );
  }

  method acquire {
    g_main_context_acquire($!mc);
  }

  method add_poll (GPollFD $fd, Int() $priority) is also<add-poll> {
    my gint $p = resolve-int($priority);

    g_main_context_add_poll($!mc, $fd, $p);
  }

  multi method check (
    Int() $max_priority,
    Int() $n_fds
  ) {
    my gpointer $fds = calloc(nativesizeof(GPollFD), $n_fds);

    samewith($max_priority, $fds, $n_fds);
  }
  multi method check (
   Int() $max_priority,
   gpointer $fds,           # Block of GPollFD
   Int() $n_fds
 ) {
    my gint ($mp, $nf) = resolve-int($max_priority, $n_fds);
    g_main_context_check($!mc, $mp, $fds, $nf);
    my $fdb = $fds but GTK::Compat::Roles::TypedBuffer[GPollFD];
    my @pd;
    @pd[$_] = $fdb[$_] for ^$n_fds;
    @pd;
  }

  method default {
    g_main_context_default();
  }

  method dispatch {
    g_main_context_dispatch($!mc);
  }

  method find_source_by_funcs_user_data (
    GSourceFuncs $funcs,
    gpointer $user_data = gpointer
  )
    is also<find-source-by-funcs-user-data>
  {
    g_main_context_find_source_by_funcs_user_data($!mc, $funcs, $user_data);
  }

   method find_source_by_id (Int() $source_id) is also<find-source-by-id> {
     my guint $sid = resolve-uint($source_id);

     g_main_context_find_source_by_id($!mc, $sid);
   }

   method find_source_by_user_data (gpointer $user_data = gpointer)
     is also<find-source-by-user-data>
   {
     g_main_context_find_source_by_user_data($!mc, $user_data);
   }

   method get_thread_default is also<get-thread-default> {
    g_main_context_get_thread_default();
  }

  method invoke (&function, gpointer $data = gpointer) {
    g_main_context_invoke($!mc, &function, $data);
  }

  method invoke_full (
    Int() $priority,
    &function,
    gpointer $data         = gpointer,
    GDestroyNotify $notify = gpointer
  )
    is also<invoke-full>
  {
    my gint $p = resolve-int($priority);

    g_main_context_invoke_full($!mc, $p, &function, $data, $notify);
  }

  method is_owner is also<is-owner> {
    g_main_context_is_owner($!mc);
  }

  multi method iteration (
    GTK::Compat::MainContext:U:
  ) {
    GTK::Compat::MainContext.iteration(GMainContext);
  }
  multi method iteration (Int() $may_block = True) {
    GTK::Compat::MainContext.iteration($!mc, $may_block);
  }
  multi method iteration (
    GTK::Compat::MainContext:U:
    GMainContext $context = GMainContext,
    Int() $may_block = True
  ) {
    my gboolean $mb = resolve-bool($may_block);

    g_main_context_iteration($context, $mb);
  }

  method pending {
    so g_main_context_pending($!mc);
  }

  method pop_thread_default is also<pop-thread-default> {
    g_main_context_pop_thread_default($!mc);
  }

  method prepare (Int() $priority) {
    my gint $p = resolve-int($priority);

    g_main_context_prepare($!mc, $priority);
  }

  method push_thread_default is also<push-thread-default> {
    g_main_context_push_thread_default($!mc);
  }

  multi method query (
    Int() $max_priority,
    Int() $timeout,
    Int() $n_fds
  ) {
    my gpointer $fds = calloc(nativesizeof(GPollFD), $n_fds);

    samewith($max_priority, $timeout, $fds, $n_fds);
  }
  multi method query (
    Int() $max_priority,
    Int() $timeout,
    gpointer $fds,           # Block of GPollFD
    Int() $n_fds
  ) {
    my gint ($mp, $to, $nf) = resolve-int($max_priority, $timeout, $n_fds);
    g_main_context_query($!mc, $mp, $to, $fds, $nf);
    my $fdb = $fds but GTK::Compat::Roles::TypedBuffer[GPollFD];
    my @pd;
    @pd[$_] = $fdb[$_] for ^$n_fds;
    @pd;
  }

  method ref is also<upref> {
    g_main_context_ref($!mc);
    self;
  }

  method ref_thread_default is also<ref-thread-default> {
    g_main_context_ref_thread_default();
  }

  method release {
    g_main_context_release($!mc);
  }

  method remove_poll (GPollFD $fd) is also<remove-poll> {
    g_main_context_remove_poll($!mc, $fd);
  }

  method unref is also<downref> {
    g_main_context_unref($!mc);
  }

  method wakeup {
    g_main_context_wakeup($!mc);
  }

}
