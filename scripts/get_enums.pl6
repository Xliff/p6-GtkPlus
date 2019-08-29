use v6.c;

use File::Find;

my regex name {
  <[_ A..Z a..z]>+
}

# my rule enum_entry {
#   <[A..Z]>+ [ '=' [ \d+ | \d+ '<<' \d+ ] ]? ','
# }

my token d { <[0..9 x]> }
my token m { '-' }
my token L { 'L' }

my rule enum_entry {
  \s* ( <[_ A..Z]>+ ) ( [ '=' <m>?<d>+<L>? [ '<<' <d>+ ]? ]? ) ','? \v*
}

my rule comment {
  '/*' .+? '*/'
}

my rule enum {
  'typedef enum' <n=name>? \v* '{'
  <comment>? \v* [ <comment> | <enum_entry> ]+ \v*
  '}' <rn=name>?
}

sub MAIN ($dir?, :$file) {
  my (%enums, @files);

  unless $dir ^^ $file {
    say qq:to/SAY/;
    Specify a directory as the only argument, or use --file to process a{ ''
    } single file.
    SAY

    &*GENERATE-USAGE(&?ROUTINE).say;
    exit 1;
  }

  die 'Cannot specify a directory if using --file'
    if $dir.defined && $file.defined;

  if $file.defined {
    die "File '$file' does not exist"
      unless $file.IO.e;
    @files = ($file);
  } else {
    die "Directory '$dir' either does not exist, or is not a directory"
      unless $dir.IO.e && $dir.IO.d;

    @files = find
      dir => $dir,
      name => /'.h' $/;
  }

  my %etype;
  for @files -> $file {
    say "Checking { $file } ...";
    my $contents = $file.IO.slurp;

    my $m = $contents ~~ m:g/<enum>/;
    for $m.Array -> $l {
      my @e;
      my ($etype, $neg, $long) = (32, False, False);
      for $l<enum><enum_entry> -> $el {
        for $el -> $e {
          # Handle 32 vs 64 bit by literal.
          $long = True if $e[1]<L>;
          # Handle signed vs unsigned.
          $neg  = True if $e[1]<m>;

          ((my $n = $e[1].Str.trim) ~~ s/'='//);
          $n ~~ s/'<<'/+</;
          my $ee;
          $ee.push: $e[0].Str.trim;
          $ee.push: $n if $n.chars;
          @e.push: $ee;
        }
        %enums{$l<enum><rn>} = @e;
      }
      $etype = 64      if $long;
      $etype = -$etype if $neg;
      %etype{$l<enum><rn>} = $etype;
    }
  }

  for %enums.keys.sort -> $k {
    #say %enums{$k}.gist;
    my $m = %enums{$k}.map( *.map( *.elems ) ).max;
    my $etype = %etype{$k};

    say "  constant {$k} is export := g{ $etype > 1 ?? 'u' !! '' }int{$etype.abs};";
    say "  our enum {$k}Enum is export { $m == 2 ?? '(' !! '<' }";
    for %enums{$k} -> $ek {
      for $ek -> $el {
        for $el.List -> $eel {
          given $m {
            when 1 {
              say "      { $eel[0] }{ $m == 2 ?? ',' !! '' }";
            }
            when 2 {
              with $eel[1] {
                say "      { $eel[0] } => { $eel[1] },";
              } else {
                say "      '{ $eel[0] }{ ($eel eqv $el.Array[*-1]).not ??
                  "'," !! "'" }";
              }
            }
          }
        }
      }
    }
    say "  { $m == 2 ?? ')' !! '>' };\n";
  }
}
