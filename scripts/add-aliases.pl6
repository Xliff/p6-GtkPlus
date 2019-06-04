#!/usr/bin/env perl6
use v6.c;

my %proto;

# This really should be part of CORE.
class X::WithoutLineNumber is X::AdHoc {
  multi method gist(X::WithoutLineNumber:D:) {
    $.payload ~ "\n";
  }
}

sub MAIN($filename) {
  CATCH { default { .payload.say; exit } }

  die X::WithoutLineNumber.new(payload => "'$filename' cannot be opened.\n")
    unless $filename.IO.e;

  my $contents = $filename.IO.open.slurp;

  die X::WithoutLineNumber.new(payloar => "'$filename' has already been aliased!\n")
    if $contents.lines[^5].join('') ~~ /'Method::Also'/;

  $filename.IO.rename("{ $filename }.bak");

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

    given $full_line {
      when $full_line ~~ /^ 'use v6.c;' / {
        $full_line ~= "\n\nuse Method::Also;";
        $add = True;
      }
      when $full_line ~~ &method_start {
        $method = True;
        proceed;
      }
      when $full_line ~~ &method_proto {
        $proto = True;
        proceed;
      }
      when $proto {
        my $mn = $/<method_proto><method_name>;
        # Better version of this logic would put delimeter checking
        # in get-alias instead of passing it as a parameter.
        if $mn ~~ /(<[\-_]>)/ {
          my $al = get-alias($mn, $/[0]);
          my $tbr = $/.Str;
          $full_line ~~ s/$tbr/{$tbr}\n      is also<{$al}>\n/;
          %proto{$al} = True;
        }
        ($add, $proto) = (True, False);
      }
      when $method && $full_line ~~ &method_def {
        my $fm = $/[0];
        if $fm<method_start><method_name> ~~ /(<[\-_>]>)/ {
          my $al = get-alias($fm<method_start><method_name>, $/[0]);
          my $tbr = $fm.Str;
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
    if $add {
      @lines.push("{ $full_line }\n");
      $full_line = '';
      $add = False;
    }
  }

  $filename.IO.spurt: @lines.join('');
}
