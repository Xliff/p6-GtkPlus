#!/usr/bin/env raku

use v6;

enum States <CommitHash Log Header Diff>;

my $a = qqx«git log -p --full-diff»;

sub MAIN (
  $needle,     #= String to search for
  :$added,     #= Check only added lines
  :$removed,   #= Check only removed lines
) {
  my @prefix = <+ ->;

  @prefix = '+'.Array if $added;
  @prefix = '-'.Array if $removed;

  my (%file, $commit-hash);
  my $state = CommitHash;

  sub getFileKey($t) {
    do given $t {
      when '+' { 'add-file' }
      when '-' { 'remove-file' }
    }
  }

  sub checkForLogState($l, :$no-check = False) {
    if $l ~~ /^'commit ' (<[a..z0..9]> ** 39) / {
      $commit-hash = $/[0];
      $state = Log;
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
