#!/usr/bin/env perl6
use v6.c;

my %proto;

# This really should be part of CORE.
class X::WithoutLineNumber is X::AdHoc {
  multi method gist(X::WithoutLineNumber:D:) {
    $.payload ~ "\n";
  }
}

sub MAIN($filename, :$test) {
  CATCH { default { .payload.say; exit } }

  die X::WithoutLineNumber.new(message => "'$filename' cannot be opened.\n")
    unless $filename.IO.e;

  my $contents = $filename.IO.open.slurp;

  die X::WithoutLineNumber.new(message => "'$filename' has already been aliased!\n")
    if $contents.lines[^5].join('') ~~ /'Method::Also'/;

  $filename.IO.rename("{ $filename }.alias-bak") unless $test;

  my token method_name {
    <-[\s(]>+
  }

  my regex method_proto {
    ^^ \s* 'proto method' \s+ <method_name> \s+ '(|)'
  }

  my regex method_start {
    ^^ \s* ('multi' \s+)? 'method' \s+ <method_name>
  }
  my regex method_def {
    ( <method_start> \s* <-[\{]>+ ) '{'
  }

  sub get-alias ($mn, $d) {
    my $ad = $d eq '-' ?? '_' !! '-';
    $mn.split($d).join($ad);
  }

  my @lines;
  my $full_line;
  my ($add, $proto, $method) = False xx 3;
  for $contents.lines {
    $full_line ~= "\n" if $method;
    $full_line ~= $_;

    my ($msm, $mpm, $cr);
    $cr = True;
    given $full_line {
      when $full_line ~~ /^ 'use v6.c;' / {
        $full_line ~= "\n\nuse Method::Also;";
        $add = True;
      }
      when $full_line ~~ &method_start {
        ($method, $msm) = ( True, $/ );
        proceed;
      }
      when $full_line ~~ &method_proto {
        ($proto, $mpm) = ( True, $/ );
        proceed;
      }

      my token replaceables { ( <[\-_]>) }
      when $proto {
        my $fm = $/;
        my $mn = $mpm<method_name>;
        # Better version of this logic would put delimeter checking
        # in get-alias instead of passing it as a parameter.
        if $mn ~~ &replaceables {
          my $al = get-alias($mn, $/[0]);
          my $tbr = $mpm.Str;

          $full_line ~~ s/$tbr/{$tbr}\n      is also<{$al}>/;
          %proto{$mn} = True;
        }
        ($add, $proto) = (True, False);
      }
      when $method && ($msm<method_name> // '').Str.contains('::') {
        my $al = $msm<method_name>.split('::').tail;
        $full_line.substr-rw($msm.from, $msm.to) =
          "{ $msm }\n    is also<{$al}>";;
        ($add, $cr) = (True, False);
      }
      when $method && $full_line ~~ &method_def {
        my $fm = $/[0];
        my $mn = $fm<method_start><method_name>;
        if $mn ~~ &replaceables {
          if %proto{$mn}:exists {
            $method = False;
            proceed;
          }
          my $al = get-alias($mn, $/[0]);
          my $tbr = $fm.Str;
          $full_line .= chomp;
          $full_line ~~ s/$tbr/{$tbr}is also<{$al}> /;
        }
        ($add, $method) = (True, False);
      }
      when $method {
        $add = False;
      }
      default {
        $add = True;
      }
    }

    my $d = ++$;

    if $add {
      @lines.push( "{ $full_line }" ~ ($cr ?? "\n" !! '') );
      $full_line = '';
      $add = False;
    }
  }
  say $full_line // '<NO LINE DATA>';
  @lines.push($full_line) if $full_line;

  if $test {
    @lines.join('').say;
  } else {
    $filename.IO.spurt: @lines.join('');
  }

}
