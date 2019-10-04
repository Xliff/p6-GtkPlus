use v6.c;

use NativeCall;

use GTK::Compat::Types;

use GIO::Cancellable;
use GIO::Task;

constant WAIT = 10;
constant ASYNC_OPS = 45;

class MockOperation is repr<CStruct> {
  has guint $.requested;
  has guint $.done;
}

sub mock-operation-free (Pointer $d) {
  free($d);
}

sub mock-operation-thread ($t, $o, $d, $c) {
  my $data   = nativecast(MockOperation, $d);
  my $cancel = GIO::CAncellable.new($c);
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
  my $task = GIO::Task.new($p);
  my $mock = cast(MockOperation, $task.task-data);
  my $done = False;

  $done = True if $mock.done == $mock.requested;
  $done = True if $task.is-cancelled;

  do if $done {
    say "LOOP: {$mock.requested} stopped at {$mock.done}" if $VERBOSE;
    $task.return-boolean($true);
    False;
  } else {
    $mock.done++;
    say "LOOP: {$mock.requested} iteration {$mock.done}" if $VERBOSE;
    True;
  }
}

sub mock-operation-async ($i, $run-in-tread, $c, &callback, $d) {
  my $task = GIO::Task.new(GObject, $c, &callback, $d);
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
      $task.ref
    );

    say "THRD: {$i} started" if $VERBOSE;
  }
  $task.unref;
}

sub mock-operation-finish ($r, $e --> guint) {
  my $task = GIO::Task.new($r);
  my $mock = cast(MockOperation, $task.task-data);

  $task.propagate-boolean($e);
  $mock.done;
}

my ($num-async-operations, $loop) = (0);

sub mock-operation-ready ($s, $r, $iterations-requested) {
  my $error                = gerror;
  my $iterations-done      = mock_operation-finished($r, $error);

  ok  [&&]($error.domain == $G_IO_ERROR, $error.code = G_IO_ERROR_CANCELLED),
      'Error returned has domain G_IO_ERROR and code G_IO_ERROR_CANCELLED';

  ok  $iterations-requested > $iterations_done,
      'Requested number if iterations is greater than the number completed';

  $loop.quit unless $num-async-operations--;
}

sub main-loop-timeout-quit ($d --> gboolean) {
  $loop.quit;
  0;
}

sub test-cancel-multiple-concurrent {
  my $cancellable = GIO::Cancellable.new;

  $loop = GTK::Compat::MainLoop.new;

  for ^ASYNC_OPS {
    my $iterations = $_ + 10;

    mock-operations-async(
      $iterations,
      ^Bool.pick,
      $cancellable,
      -> $s, $r, $d {
        mock-operation-ready($s, $r, $iterations);
      },
      $iteration-data
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


test-cancel-multiple-concurrent;

lives-ok { GIO::Cancellable.cancel },
         'Calling GIO::Cancellable.cancel, with no arguments, works properly';
