#!/usr/bin/env raku
use v6.c;

sub runCommand ($a) {
  #say $a;
  #say qqx«$a»

  my $proc = Proc::Async.new: :w, $a.split(/ \s+ /);

  react {
    whenever $proc.stdout.lines { .say }
    whenever $proc.stderr.lines { .say }
    whenever $proc.ready        { say "--- On PID: { $_ }..." }

    whenever $proc.start {
      if .exitcode {
        say 'Received non-zero exit code from command. Exiting...';
        exit( .exitcode );
      }

      done
    }

    whenever signal(SIGTERM).merge: signal(SIGINT) {
      $proc.kill(SIGKILL);
      exit;
    }
  }
}

sub get-log-prefix (:$internal) {
  return $*log if $*log && $internal.not;
  $*parallel ?? 'ParallelBuildResults' !! 'LastBuildResults';
}

sub get-log-name (:$internal) {
  my ($Y, $m, $d) = ( .year.fmt('%4d'), .month.fmt('%02d'), .day.fmt('%02d') )
    given DateTime.now.utc;

  "{ get-log-name }-{ $Y }{ $m }{ $d }";
}

sub commit-build-time {
  my $ver-string   = qx«perl6 --version»;
  my $raku-ver     = $ver-string.lines[0].words.tail;
  my $moar-ver     = $ver-string.lines.tail.words.tail;

  my $msg = qq:to/COMMITMSG/;
    - { $*parallel ?? 'Parallel ' !! '' }Build times for Rakudo {
        $raku-ver } using MoarVM { $moar-ver }
    COMMITMSG

  runCommand( qq«git add stats/{ get-log-name }» );
  runCommand( qq«git commit -m "{ $msg.chomp }"» );
}

sub MAIN (
  *@list,
  :$parallel   = False,
  :$no-commit  = True,
  :$no-bump    = False,
  :$log        = $parallel ?? 'ParallelBuildResults' !! 'LastBuildResults',
  :$from
) {
  my ($*log, $*parallel) = ($log, $parallel);

  if +@list {
    @list .= split(/ \s+ /).cache;
  } else {
    @list = %*ENV<PROJECTS>.split(/ \s+ /);
  }

  if $from {
    die "Can't start from '{ $from }' because it is not in the list of:\n\t{
         @list.rotor(5).map( *.join(', ') ).join("\n\t") }"
    unless $from.lc ∈ @list.map( *.lc );

    @list = @list[ @list.first( *.lc eq $from.lc, :k ) .. * ] if $from;
  }

  for @list.split(/\s+/) {
    say "{ '=' x 10 } $_ { '=' x 10 }";
    chdir( $*HOME.add('Projects').add("p6-$_").absolute );
    runCommand( qq«scripts/code-bump.pl6» ) unless $no-bump ;

    my $build-cmd = $parallel ?? 'dependency-build.pl6'
                              !! 'build.sh';

    runCommand(
      $*parallel ?? qq«scripts/$build-cmd --log=$log»
                 !! qq«scripts/$build-cmd --log $log»
    );
    commit-build-time($parallel) unless $no-commit;
  }
}
