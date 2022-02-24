#include <stdio.h>
#include <time.h>
#include <glib.h>
#include <stdbool.h>

#include "gio/gio.h"

typedef struct _TestClosure
{
  /*< private >*/
  // volatile              guint    ref_count : 15;
  /* meta_marshal is not used anymore but must be zero for historical reasons
     as it was exposed in the G_CLOSURE_N_NOTIFIERS macro */
  // volatile              guint    meta_marshal_nouse : 1;
  // volatile              guint    n_guards : 1;
  // volatile              guint    n_fnotifiers : 2;      /* finalization notifiers */
  // volatile              guint    n_inotifiers : 8;      /* invalidation notifiers */
  // volatile              guint    in_inotify : 1;
  // volatile              guint    floating : 1;
  /*< protected >*/
  // volatile              guint    derivative_flag : 1;
  /*< public >*/
  // volatile              guint    in_marshal : 1;
  // volatile              guint    is_invalid : 1;

  /*< private >*/       void   (*marshal)  (GClosure       *closure,
                                            GValue /*out*/ *return_value,
                                            guint           n_param_values,
                                            const GValue   *param_values,
                                            gpointer        invocation_hint,
                                            gpointer        marshal_data);
  /*< protected >*/     //gpointer data;

  /*< private >*/       //GClosureNotifyData *notifiers;

  /* invariants/constraints:
   * - ->marshal and ->data are _invalid_ as soon as ->is_invalid==TRUE
   * - invocation of all inotifiers occours prior to fnotifiers
   * - order of inotifiers is random
   *   inotifiers may _not_ free/invalidate parameter values (e.g. ->data)
   * - order of fnotifiers $closure ?? self.bless(:$closure) !! Nil;is random
   * - each notifier may only be removed before or during its invocation
   * - reference counting may only happen prior to fnotify invocation
   *   (in that sense, fnotifiers are really finalization handlers)
   */
} TestClosure;


typedef struct TestByte {
  guint a;
} TestByteStruct;

void main(int argc, char **argv) {
	printf ("sizeof time_t is: %ld\n", sizeof(time_t));
	printf ("G_IO_ERROR = %d\n", G_IO_ERROR);
	printf ("G_IO_ERROR_FAILED = %d\n", G_IO_ERROR_FAILED);
	printf ("G_IO_ERROR_NONE = %d\n", G_IO_ERROR_NONE);
	printf ("G_IO_ERROR_WOULD_BLOCK = %d\n", G_IO_ERROR_WOULD_BLOCK);
	printf ("G_IO_ERROR_BROKEN_PIPE = %d\n", G_IO_ERROR_BROKEN_PIPE);

	printf ("%ld %ld\n", sizeof(GClosure), sizeof(GCClosure) );
  printf ("%ld\n", sizeof(TestClosure) );
  printf ("bool: %ld\n", sizeof(bool) );
}
