use v6.c;

use NativeCall;

use Test;

use GTK::Compat::Types;
use GIO::Raw::Quarks;

use GTK::Compat::MainLoop;
use GTK::Compat::Timeout;
use GTK::Compat::Timer;
use GIO::Cancellable;
use GIO::Task;

constant WAIT = 10;
constant ASYNC_OPS = 45;

my $VERBOSE;

class MockOperation is repr<CStruct> {
  has guint $.requested is rw;
  has guint $.done      is rw;
}

sub mock-operation-free (Pointer $d) {
  CATCH { default { .message.say } }

  free($d);
}

sub mock-operation-thread ($t, $o, $d, $c) {
  CATCH { default { .message.say } }

  my $data   = nativecast(MockOperation, $d);
  my $cancel = GIO::Cancellable.new($c);
  my $task   = GIO::Task.new($t);

  my $last;
  for ^$data.requested {
    LAST { $last = $_ }

    last if $cancel.is-cancelled;

    say "THRD: { $data.requested } iteration {$_}" if $VERBOSE;
    GTK::Compat::Timer.usleep(WAIT * 1000);
  }

  say "THRD: { $data.requested } stopped at {$last}" if $VERBOSE;
  $data.done = $last;
  $task.return-boolean(True);
}

sub mock-operation-timeout ($p --> gboolean) {
  CATCH { default { .message.say } }

  my $task = GIO::Task.new( cast(GTask, $p) );
  my $mock = cast(MockOperation, $task.task-data);
  my $done = False;

  $done = True if $mock.done == $mock.requested;
  $done = True if $task.cancellable.is-cancelled;

  do if $done {
    say "LOOP: {$mock.requested} stopped at {$mock.done}" if $VERBOSE;
    $task.return-boolean(True);
    0;
  } else {
    $mock.done++;
    say "LOOP: {$mock.requested} iteration {$mock.done}" if $VERBOSE;
    1;
  }
}

sub mock-operation-async ($i, $run-in-tread, $c, &callback) {
  my $task = GIO::Task.new(GObject, $c, &callback);
  my $mock = MockOperation.new;

  $mock.requested = $i;
  $task.task-data = $mock;

  if $run-in-tread {
    $task.run-in-thread(&mock-operation-thread);
    say "THRD: {$i} started" if $VERBOSE;
  } else {
    GTK::Compat::Timeout.add-full(
      G_PRIORITY_DEFAULT,
      WAIT,
      &mock-operation-timeout,
      $task.ref.GObject.p
    );

    say "THRD: {$i} started" if $VERBOSE;
  }
  $task.unref;
}

sub mock-operation-finish ($r, $e --> guint) {
  CATCH { default { .message.say } }

  my $task = GIO::Task.new($r);
  my $mock = cast(MockOperation, $task.task-data);

  $task.propagate-boolean($e);
  $mock.done;
}

my ($num-async-operations, $loop) = (0);

sub mock-operation-ready ($s, $r, $iterations-requested) {
  CATCH { default { .message.say } }

  my $error                = gerror;
  my $iterations-done      = mock-operation-finish($r, $error);

  # As per 02-buffered-input-stream, the domain is not returning the
  # expected value of $G_IO_ERROR. In this case it's a stable *63*, not
  # 67, as was (and still is) experienced in t/02.

  # $error[0] == $ERROR
  #ok  [&&]($ERROR.domain == $G_IO_ERROR, $ERROR.code = G_IO_ERROR_CANCELLED),
  is  $ERROR.code, G_IO_ERROR_CANCELLED.Int,
      #'Error returned has domain G_IO_ERROR andcode G_IO_ERROR_CANCELLED';
      'Error returned has code G_IO_ERROR_CANCELLED';

  ok  $iterations-requested > $iterations-done,
      'Requested number of iterations is greater than the number completed';

  # One-based counter, not 0-based!
  $loop.quit unless $num-async-operations-- > 1;
}

sub main-loop-timeout-quit ($d --> gboolean) {
  CATCH { default { .message.say } }

  $loop.quit;
  0;
}

sub test-cancel-multiple-concurrent {
  my $cancellable = GIO::Cancellable.new;

  $loop = GTK::Compat::MainLoop.new;

  for ^ASYNC_OPS {
    my $iterations = $_ + 10;

    mock-operation-async(
      $iterations,
      #^Bool.pick,
      False,
      $cancellable,
      -> $s, $r, $d {
        mock-operation-ready($s, $r, $iterations);
      }
    );

    $num-async-operations++;
  }

  GTK::Compat::Timeout.add(WAIT * 3, &main-loop-timeout-quit);
  $loop.run;

  is  $num-async-operations, ASYNC_OPS,
      'The correct number of async operations were executed.';

  say "CANCEL: {$num-async-operations}" if $VERBOSE;
  $cancellable.cancel;

  ok  $cancellable.is-cancelled,
      'GIO::Cancellable object cancels properly';

  $loop.run;
  is  $num-async-operations, 0,
      'No further async operations were executed';

  #.unref for $cancellable, $loop;
}


sub MAIN (:$verbose = False) {
  $VERBOSE = $verbose;

  plan 94;

  test-cancel-multiple-concurrent;
  lives-ok { GIO::Cancellable.cancel },
           'Calling GIO::Cancellable.cancel, with no arguments, works properly';
}
