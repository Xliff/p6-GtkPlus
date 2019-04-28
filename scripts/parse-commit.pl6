use v6.c;

#use Grammar::Tracer;
#use Data::Dump::Tree;
use DateTime::Parse;

grammar GitLog {
  regex TOP { <fullcommit>* }

  regex fullcommit {
    <commithash> \v*
    <author>     \v*
    <date>       \v*
    <msg>        \v*
  }

  regex commithash {
    ^^ 'commit' \s* <hash>
  }

  regex author {
    ^^ 'Author: ' \s* (<-[\n]>+)
  }

  regex date {
    ^^ 'Date: ' \s* (<-[\n]>+)
  }

  regex msg {
    ^^ $<msg>=(.+?) \n
  }


  token hash {
    <[0..9a..f]> ** 40
  }
}

my token perl6-version {
  \d ** 4 '.'
  \d ** 2 ('.' \d+)?
  '-' \d+ '-'
  'g' <[0..9a..f]> ** 8..10
}

my rule find-perl6 {
  'perl6' <perl6-version>
}

my %p6-versions;

class GitLogActions {
  method fullcommit ($/ is copy) {
    my $old-match = $/;
    my $old-msg = $/<msg>;

    $old-msg ~~ s:g/'version'//;
    $old-msg ~~ s:g/\s+/ /;

    #say "{ $old-match<date>.Str }: { $old-msg }";

    my $dtp = DateTime::Parse.new(
      $old-match<date>[0].Str.substr(0, *-6)
    ).posix;
    %p6-versions{$dtp} = $/<perl6-version>.Str
      if $old-msg ~~ /<perl6-version>/;
  }

  method commithash ($/) { }
  method hash       ($/) { }
  method date       ($/) { }
  method msg        ($/) { }
}

my $m = GitLog.parse( qqx{git log}, actions => GitLogActions );

say "{ $_ }: { DateTime.new(+$_) } -- { %p6-versions{$_} }"
  for %p6-versions.keys.Array.sort;
