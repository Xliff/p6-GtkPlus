use v6.c;

sub MAIN($filename) {
  die "'$filename' cannot be opened.\n" unless $filename.IO.e;
  my $contents = $filename.IO.open.slurp;
  # $filename.IO.rename("{ $filename }.bak");

  # my token numword {
  #   <[A..Za..z0..9]>+
  # }
  # my token sep {
  #   '_' | '-'
  # }
  # my regex params {
  #   <[A..Za..z]>+'()'? \s+ \$ <numword>+ %% <sep>
  # }
  # my token paramsep {
  #   \s* ',' \s*
  # }
  # my regex methodline1 {
  #   # Need a *generic* method matcher, then determine if it needs
  #   # replacement treatment.
  #   #
  #   # Must also handle traits!!!
  #   'multi'? \s+ 'method' \s+ (<-[\s]>+) \s*
  #   ['is' \s+ 'rw' \s+]?
  #   $<also>=('is' \s+ 'also<' <-[>]>+ '>')?
  # }
  # my regex methodline2 {
  #   # Need a *generic* method matcher, then determine if it needs
  #   # replacement treatment.
  #   #
  #   # Must also handle traits!!!
  #   'multi'? \s+ 'method' \s+ (<-[\s]>+) \s*
  #   '(' \s* <params>+ %% <paramsep> \s* ')' \s+
  #   ['is' \s+ 'rw' \s+]?
  #   $<also>=('is' \s+ 'also<' <-[>]>+ '>')?
  # }

  # Note to self:
  #  _   __            _____         _ _       _   _
  # \ \ / /__  _   _  | ____|___  __| (_) ___ | |_| |
  #  \ V / _ \| | | | |  _| / _ \/ _` | |/ _ \| __| |
  #   | | (_) | |_| | | |__|  __/ (_| | | (_) | |_|_|
  #   |_|\___/ \__,_| |_____\___|\__,_|_|\___/ \__(_)
  #
  # This is overthinking the problem. Keep adding lines to the output
  # array until you find 'method'. Keep adding to the buffer until you find a '{'
  # in the string. Add your alias before the '{' !!\
  # Always remember the golden rule....
  #                   __ __ ______________
  #                  / //_//  _/ ___/ ___/
  #                 / ,<   / / \__ \\__ \
  #                / /| |_/ / ___/ /__/ /
  #               /_/ |_/___//____/____/  

  my @lines;
  my $full_line;
  my ($add, $method) = (False, False);
  for $contents.lines {
    $full_line ~= $_;
    given $full_line {
      when $full_line ~~ /^ 'use NativeCall' / {
        @lines.push('use Method::Also;');
        $add = True;
      }
      when !$method && $full_line ~~ /
        ^^ \s* 'multi'? \s+ 'method' \s+ (<-[\s(]>+)
      / {
        say ($method = $/[0].Str);
        if $/[0] !~~ /<sep>/ {
          $add = False;
          $method = False;
        } else {
          $add = True;
        }
        proceed;
      }
      when $method !~~ Bool {
        my $m;
        say 'M1: ' ~ ($m = $full_line ~~ ::("&methodline1")).gist;
        say 'M2: ' ~ ($m = $full_line ~~ ::("&methodline2")).gist unless $m;

        sub replace($mm) {
          say "In replace: { $mm.gist }";
          my $sep = $mm[0] ~~ /(<[\-_>]>)/;
          my $ad = $/[0] eq '-' ?? '_' !! '-';
          my $al = $mm[0].split($/[0]).join($ad);
          my $tbr = $mm.Str;
          say "Replace!";
          $full_line ~~ s!$tbr!{$tbr}is also<{$al}> !;
          ($add, $method) = (True, False);
          succeed;
        }

        for <methodline2 methodline1> {
          my $reg = "\&$_";
          $reg.say;
          my $r = $full_line ~~ ::($reg);
          replace($r) if $r;
          say ("R<$_>: { $r.gist.say }");
        }
        $full_line ~= "\n";
        $add = False;
      }
      default {
        $add = True;
      }
    }
    if $add {
      @lines.push("{$full_line}\n");
      $full_line = '';
      $add = False;
    }
  }

  # my $fh = $filename.IO.open(:w);
  # $fh.say(@lines.join("\n"));
  # $fh.close;
  say "→→→→→→→→→→→→→→→→→";
  @lines.join('').say
}
