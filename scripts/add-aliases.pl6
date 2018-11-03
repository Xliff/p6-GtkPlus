use v6.c;

sub MAIN($filename) {
  die "'$filename' cannot be opened.\n" unless $filename.IO.e;
  my $contents = $filename.IO.open.slurp;
  $filename.IO.rename("{ $filename }.bak");

  my regex method_start {
    ^^ \s* ('multi' \s+)? 'method' \s+ ( <-[\s(]>+ )
  }
  my regex method_def {
    ( <method_start> \s* <-[\{]>+ ) '{'
  }

  my @lines;
  my $full_line;
  my ($add, $method) = (False, False);
  for $contents.lines {
    $full_line ~= "\n" if $method;
    $full_line ~= $_;

    given $full_line {
      when $full_line ~~ /^ 'use NativeCall' / {
        @lines.push("use Method::Also;\n");
        $add = True;
      }
      when $full_line ~~ &method_start {
        $method = True;
        proceed;
      }
      when $method && $full_line ~~ &method_def {
        my $fm = $/[0];
        if $fm<method_start>[1] ~~ /(<[\-_>]>)/ {
          my $ad = $/[0] eq '-' ?? '_' !! '-';
          my $al = $fm<method_start>[1].split($/[0]).join($ad);
          my $tbr = $fm.Str;
          $full_line ~~ s!$tbr!{$tbr}is also<{$al}> !;
        }
        $add = True;
        $method = False;
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

  my $fh = $filename.IO.open(:w);
  $fh.say(@lines.join(''));
  $fh.close;
  # @lines.join('').say
}
