#!/usr/bin/env raku

use v6;

enum States <CommitHash Log Header Diff>;

sub MAIN (
  $needle,              #= String to search for
  Str  :$hash,          #= Commit hash or sub-hash to start from
  Int  :$count is copy, #= Only search x commits back
  Bool :$added,         #= Check only added lines
  Bool :$removed,       #= Check only removed lines
) {
  my @prefix = <+ ->;

  # Basic check. A better one will be added.
  unless $hash ~~ / <[a..z0..9]>+ / || $hash.starts-with('HEAD') {
    die "Invalid commit hash { $hash }!";
  }
  my $head-ref = $hash.starts-with('HEAD');
  die "Invalid commit hash { $hash }!" if $hash > 39 && $head-ref.not;
  die "Insufficient commit hash!"      if $hash <  6 && $head-ref.not;

  @prefix = '+'.Array if $added;
  @prefix = '-'.Array if $removed;

  my (%file, $commit-hash);
  my $state = CommitHash;

  my $a = qqx«git log -p --full-diff»;
  ++$count if $count;

  sub getFileKey($t) {
    do given $t {
      when '+' { 'add-file' }
      when '-' { 'remove-file' }
    }
  }

  sub checkForLogState($l, :$no-check = False) {
    if $count {
      exit unless $count--;
    }
    if $l ~~ /^'commit ' (<[a..z0..9]> ** 39) / {
      $commit-hash = $/[0];
      if $hash {
        $state = Log if $commit-hash.contains($hash);
      } else {
        $state = Log;
      }
    }
  }

  for $a.lines -> $l is copy {
    given $state {

      when CommitHash {
        checkForLogState($l)
      }

      when Log {
        $state = Header if $l ~~ /^'diff --git'/;
      }

      when Header {
        given $l {
          when / (@prefix) ** 3 \s (.+?) $$/ {
            %file{ getFileKey($/[0][0].Str) } = $/[1];
          }

          when /^ '@@' .+? '@@'/ {
            $state = Diff;
            $l .= subst($/.Str, '');
            proceed;
          }
        }
      }

      when Diff {
        given $l {
          when /^'commit ' (<[a..z0..9]> ** 39) / {
            checkForLogState($l);
          }

          when /^ (@prefix)(.+?) $/ {
            my $key = $/[0].Str;
            next unless $l ~~ /^ . (.+? $needle .+)/;
            say "{ $commit-hash } - { %file{ getFileKey($key) } }: { $/[0] }"
          }
        }
      }

    }
  }
}
