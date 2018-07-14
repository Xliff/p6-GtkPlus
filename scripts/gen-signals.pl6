use v6.c;

sub MAIN ($filename) {
  my $s = $filename.IO.open.slurp-rest;
  for $s.lines -> $l {
    my rule line { ^ (\w+) ( <[ a..z - ]>+ ) (\w+)? (\w+)? };
    my $m = $l ~~/<line>/;
    if $m {
      say qq:to/SIG/;
# Signal { $m<line>[0] // '' } { $m<line>[2] // '' } { $m<line>[3] // '' }
method { $m<line>[1].trim } \{
  self.connect(\$!w, '{ $m<line>[1].trim }');
\}
SIG
    } else {
      $l.say;
    }
  }
}
