use v6.c;

use Config::INI;
use File::Find;

unit package GTKScripts;

constant CONFIG-NAME is export = %*ENV<P6_PROJECT_FILE> // '.p6-gtk-project';

our %config is export;
our $GTK-SCRIPT-DEBUG is export;

sub getLibDirs is export {
  %config<libdirs> // 'lib'
}

sub parse-file ($filename) is export {
  return Nil unless $filename && $filename.IO.r;

  %config = Config::INI::parse_file($filename)<_>;
  # Handle comma separated
  %config{$_} = (%config{$_} // '').split(',').Array for <
    backups
    modules
  >;
  %config<libdirs> //= 'lib';

  %config;
}

sub find-files(
  $dir,
  :$pattern   is copy,
  :$extension is copy,
  :$exclude,
  :$depth
) is export {
  my @pattern-arg;
  my @targets = dir($dir);

  with $pattern {
    when Regex { @pattern-arg.push: $_}

    when Str   {
      $pattern .= trans( [ '/', '-' ] => [ '\\/', '\\-' ] );
      @pattern-arg.push( rx/     <{ $pattern   }>   / );
    }
  }
  $extension .= substr(1) if $extension && $extension.starts-with('.');
  @pattern-arg.push: rx/ '.' <{ $extension }> $/ if $extension;

  gather {
    WHILE: while @targets {
      say "T: { @targets.gist }" if $GTK-SCRIPT-DEBUG;

      my $elem = @targets.shift;
      say "E: $elem" if $GTK-SCRIPT-DEBUG;
      do given $elem {
        when .d {
          if $depth {
            next unless $*SPEC.splitdir($elem).grep( * ).elems < max($depth - 1, 0)
          }
          @targets.append: $elem.dir;
          next;
        }

        when .f {
          if $exclude.defined {
            given $exclude {
              when Array    { next if $elem.absolute ~~ .any         }
              when Str      { next if $elem.absolute ~~ / <{ $_ }> / }
              when Regex    { next if $elem.absolute ~~ $_           }
              when Callable { next if $_($elem)                      }

              default {
                die "Don't know how to handle { .^name } as an exclude!";
              }
            }
          }

          for @pattern-arg -> $p {
            say "Testing: { $elem.absolute } / P: { $p.gist }"
              if $GTK-SCRIPT-DEBUG;
            next WHILE unless $elem.absolute ~~ $p
          }
          say "Valid: { $elem.absolute }" if $GTK-SCRIPT-DEBUG;
          take $elem;
        }

        default {
          say "Skupping non-directory, non-file path element { .absolute }!";
        }
      }
    }
  }
}

sub get-lib-files (:$pattern, :$extension) is export {
  die 'get-lib-files() must be called with a :$pattern and/or an :$extension'
    unless $pattern.defined || $extension.defined;

  (do gather for getLibDirs().split(',') {
    take find-files($_, :$pattern, :$extension);
  }).flat;
}

sub get-module-files is export {
  get-lib-files( extension => 'pm6' );
}

sub levenshtein-nqp ($a, $b) is export {
    use nqp;

    my %memo;
    my $alen := nqp::chars($a);
    my $blen := nqp::chars($b);

    return 0 if $alen eq 0 || $blen eq 0;

    # the longer of the two strings is an upper bound.
    #my $bound := $alen < $blen ?? $blen !! $alen;

    sub changecost($ac, $bc) {
        #sub issigil($_) { nqp::index('$@%&|', $_) != -1 };
        return 0 if $ac eq $bc;
        return 0.1 if nqp::fc($ac) eq nqp::fc($bc);
        #return 0.5 if issigil($ac) && issigil($bc);
        return 1;
    }

    sub levenshtein_impl($apos, $bpos, $estimate) {
        my $key := join(':', ($apos, $bpos));

        return %memo{$key} if nqp::existskey(%memo, $key);

        # if either cursor reached the end of the respective string,
        # the result is the remaining length of the other string.
        sub check($pos1, $len1, $pos2, $len2) {
            if $pos2 == $len2 {
                return $len1 - $pos1;
            }
            return -1;
        }

        my $check := check($apos, $alen, $bpos, $blen);
        return $check unless $check == -1;
        $check := check($bpos, $blen, $apos, $alen);
        return $check unless $check == -1;

        my $achar = nqp::substr($a, $apos, 1);
        my $bchar = nqp::substr($b, $bpos, 1);

        my num $cost = changecost($achar, $bchar);

        # hyphens and underscores cost half when adding/deleting.
        my num $addcost = 1e0;
        $addcost = 5e-1 if $bchar eq "-" || $bchar eq "_";

        my num $delcost = 1e0;
        $delcost = 5e-1 if $achar eq "-" || $achar eq "_";

        my num $ca = nqp::add_n(levenshtein_impl($apos+1, $bpos,   nqp::add_n($estimate, $delcost)), $delcost); # what if we remove the current letter from A?
        my num $cb = nqp::add_n(levenshtein_impl($apos,   $bpos+1, nqp::add_n($estimate, $addcost)), $addcost); # what if we add the current letter from B?
        my num $cc = nqp::add_n(levenshtein_impl($apos+1, $bpos+1, nqp::add_n($estimate, $cost)), $cost); # what if we change/keep the current letter?

        # the result is the shortest of the three sub-tasks
        my num $distance;
        $distance = $ca if nqp::isle_n($ca, $cb) && nqp::isle_n($ca, $cc);
        $distance = $cb if nqp::isle_n($cb, $ca) && nqp::isle_n($cb, $cc);
        $distance = $cc if nqp::isle_n($cc, $ca) && nqp::isle_n($cc, $cb);

        # switching two letters costs only 1 instead of 2.
        if $apos + 1 <= $alen && $bpos + 1 <= $blen &&
           nqp::eqat($a, $bchar, $apos + 1) && nqp::eqat($b, $achar, $bpos + 1) {
            my num $cd = nqp::add_n(levenshtein_impl($apos+2, $bpos+2, nqp::add_n($estimate, 1)), 1);
            $distance = $cd if nqp::islt_n($cd, $distance);
        }

        %memo{$key} := $distance;
        return $distance;
    }

    my num $result = levenshtein_impl(0, 0, 0);
    return $result;
}

sub levenshtein ( Str $s, Str $t --> Int ) is export {
    my @s = *, |$s.comb;
    my @t = *, |$t.comb;

    my @d;
    @d[ $_; 0  ] = $_ for ^@s.end;
    @d[ 0 ; $_ ] = $_ for ^@t.end;

    for 1..@s.end X 1..@t.end -> ( $i, $j ) {
        @d[ $i; $j ] = @s[$i] eq @t[$j]
            ??   @d[ $i - 1; $j - 1 ]    # No operation required when eq
            !! ( @d[ $i - 1; $j     ],   # Deletion
                 @d[ $i    ; $j - 1 ],   # Insertion
                 @d[ $i - 1; $j - 1 ],   # Substitution
               ).min + 1;
    }

    return @d[ * - 1 ][ * - 1 ];
}

# EXPORTED from p6-GLib

# "Exhaustive" maximal...
multi max (:&by = {$_}, :$all!, *@list) is export {
    # Find the maximal value...
    my $max = max my @values = @list.map: &by;

    # Extract and return all values matching the maximal...
    @list[ @values.kv.map: {$^index unless $^value cmp $max} ];
}

sub getBackupPath ($p is copy, $pre = 'bak') is export {
  $p .= IO if $p ~~ Str;
  my ($safe-fh, $serial);
  my $fhp = $p;
  repeat {
    $safe-fh = $fhp.extension("{ $pre }{ $serial++ }", parts => 0);
  } until $safe-fh.e.not;
  $safe-fh;
}

sub get-longest-prefix (@words) is export {
  max :all, :by{.chars}, keys [∩] @words».match(/.+/, :ex)».Str;
}

INIT {
  $GTK-SCRIPT-DEBUG = %*ENV<P6_GTKSCRIPTS_DEBUG>;
  parse-file(CONFIG-NAME) if CONFIG-NAME.IO.e;
}
