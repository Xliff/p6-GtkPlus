use v6.c;

use Config::INI;
use File::Find;
use Dependency::Sort;

unit package GTKScripts;

our $CONFIG-NAME      is export;
our %config           is export;
our $GTK-SCRIPT-DEBUG is export;

my %config-defaults = (
  prefix  => '/',
  libdirs => 'lib',
  exec    => 'p6gtkexec'
);

sub getConfigEntry ($k) is export {
  %config{$k} // %config-defaults{$k} // ''
}

sub getLibDirs is export {
  getConfigEntry('libdirs');
}

sub parse-file ($filename = $CONFIG-NAME) is export {
  return Nil unless $filename && $filename.IO.r;

  %config = Config::INI::parse_file($filename)<_>;

  # Handle comma separated
  %config{$_} = (%config{$_} // '').split(',').Array for <
    backups
    modules
    build_exclude
  >;

  %config<libdirs> //= 'lib';

  %config;
}

my token d { <[0..9 x]> }
my token m { '-' }
my token L { 'L' }
my token w { <[A..Za..z _]> }

my rule comment {
  '/*' .+? '*/'
}

my regex name {
  <[_ A..Z a..z]>+
}

my token       p { [ '*' [ \s* 'const' \s* ]? ]+ }
my token       n { <[\w _]>+ }
my token       t { <n> | '(' '*' <n> ')' }
my token     mod { 'unsigned' | 'long' }
my token    mod2 { 'const' | 'struct' | 'enum' }
my rule     type { <mod2>? [ <mod>+ ]? $<n>=\w+ <p>? }
my rule      var { <t> [ '[' (.+?)? ']' ]? }

our rule struct-entry is export {
  <type> <var>+ %% ','
}

our rule solo-struct is export {
  'struct' <sn=name>? '{'
    [ <struct-entry>\s*';' ]+
  '}'
}

our rule struct is export {
  'typedef'? <solo-struct> <rn=name>? ';'
}

my rule enum-entry is export {
  \s* ( <w>+ ) (
    [ '=' '('?
      [
        <m>?<d>+<L>?
        |
        <w>+
      ]
      [ '<<' ( [<d>+ | <w>+] ) ]?
      ')'?
    ]?
  ) ','?
  <comment>?
  \v*
}

my rule solo-enum is export {
  'enum' <n=name>? <comment>? \v* '{'
  <comment>? \v* [ <comment> | <enum-entry> ]+ \v*
  '}'
}

my rule enum is export {
  [ 'typedef' <solo-enum> <rn=name> | <solo-enum> ] ';'
}

sub find-files (
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
            next unless
              $*SPEC.splitdir($elem).grep( * ).elems < max($depth - 1, 0)
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

sub get-raw-module-files is export {
  get-lib-files( pattern => / '/Raw/' /, extension => 'pm6' )
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

sub get-longest-prefix (@words) is export {
  max :all, :by{.chars}, keys [∩] @words».match(/.+/, :ex)».Str;
}

sub write-meta-file ($file, $modules) {
  use Text::Table::Simple;

  my $table = lol2table(
    $modules,
    rows => {
      column_separator => ': ',
      corner_marker    => ' ',
      bottom_border    => ''
    },
    headers => {
      top_border       => '',
      column_separator => '',
      corner_marker    => '',
      bottom_border    => ''
    },
    footers => {
      column_separator => '',
      corner_marker    => '',
      bottom_border    => ''
    }
  ).join("\n");
  $table ~~ s:g/^^':'/    /;
  $table ~~ s:g/':' \s* $$/,/;
  $table ~~ s/',' \s* $//;

  if $file.IO.e {
    my $meta = $file.IO.slurp;
    $meta ~~ s/ '"provides": ' '{' ~ '}' <-[\}]>+ /"provides": \{\n{$table}\n    }/;
    $file.IO.rename("{ $file }.bak");
    my $fh = $file.IO.open(:w);
    $fh.printf: $meta;
    $fh.close;

    say "\nNew provides section written to { $file }.";
  } else {
    say "\nProvides section:\n";
    say $table;
  }
}

sub compute-module-dependencies (
   @files,
  :$extra-output = True,
  :$build-list   = True,
  :$meta-file    = 'META6.json'
)
	is export
{
  my @build-exclude = getConfigEntry('build-exclude').split( /',' \s+/ );
  my @modules = @files
    .map( *.path )
    .map({
      my ($u, $m) = $_ xx 2;
      for getLibDirs().split(',') -> $d is copy {
        $d ~= '/' unless $d.ends-with('/');
        $m .= subst($d, '');
      }
      my $a = [
        $u,
        $m.subst('.pm6', '').split('/').Array.join('::')
      ];
      $a;
    });

  my %nodes;
  my $item-id = 0;
  for @modules {
    %nodes{ .[1] } = (
      itemid   => $item-id++,
      filename => .[0],
      edges    => [],
      name     => .[1]
    ).Hash;
  }

  my $s = Dependency::Sort.new;
  my @others;
  my @other-provided = (%config<other_provided> // '').split(',');
  for %nodes.pairs.sort( *.key ) -> $p {
    say "Processing requirements for module { $p.key }...";

    my token useneed    { 'use' | 'need'  }
    my token modulename { ((\w+)+ % '::') [':' 'ver<' (\d+)+ % '.' '>']? }
    my $f = $p.value<filename>;

    # cw: Remove pod sections in case they have embedded use statements
    #     in them.
    my $contents = $f.IO.slurp;
    if $contents ~~ m:g/'=begin' \s+ (\w+) .+? '=end' \s+ { $/[0] }/ -> $m {
      for $m.list {
        $contents.substr-rw(.from, .to - .from) = '';
      }
    }

    my $m = $contents ~~
      m:g/^^ \s* <useneed> \s+ <modulename>[\s+.+\s*]?';'/;
    for $m.list -> $mm {
      my $mn = $mm;

      #say "MN: { $mn.gist }";

      $mn ~~ s/<useneed> \s+//;
      $mn ~~ s/';' $//;
      my @prefixes = getConfigEntry('prefix').split(',');
      if $mn ~~ /<modulename>/ {
        $mn = $/<modulename>[0].Str;
        unless $mn.starts-with( @prefixes.any ) {
          next if $mn ~~ / 'v6''.'? (.+)? /;
          @others.push: $mn;
          next;
        }
        %nodes{$p.key}<edges>.push: $mn;
      }

      if $mn eq @other-provided.any {
        @others.push: $mn;
      } else {
        if $mn.starts-with( @prefixes.any ) {
          die qq:to/DIE/ unless %nodes{$mn}:exists;
            { $mn }, used by { $p.key }, does not exist!
            DIE
        }

        $s.add_dependency(%nodes{$p.key}, %nodes{$mn});
      }
    }
    #say "P: { $p.key } / { %nodes{$p.key}.gist }";
  }

  if %*ENV<P6_GTK_DEBUG> {
    for %nodes.keys.sort -> $k {
      for %nodes{$k}<edges> -> $e {
        say "{$k}:";
        for $e.list {
          my $p = $_;
          s:g/'::'/\//;
          $_ = "lib/{$_}.pm6";
          say "\t{$_} -- { .IO.e } -- { %nodes{$p}:exists }";
        }
      }
    }
  }

  if !$s.serialise {
    #say "#N: { @nodes.elems }";
    #say "N: { @nodes[205].gist }";
    given $s.error_message {
      when .contains('circular reference found') {
        .say;
        for %nodes.values {
          say .<name> if .<name> ∈ .<edges>;
        }
        exit(1);
      }

      default {
        .say && .exit
      }
    }
  }

  # Solidify Seq results
  my @return-array = $s.result;

  if $extra-output {
    say "\nA resolution order is:";
    say "»»»»»» { @return-array.elems } Modules resolved";
  }

  if $build-list {
    @others = @others.unique.sort;
    my $list = @others.join("\n") ~ "\n";
    $list ~= @return-array.map( *<name> ).join("\n");
    "BuildList".IO.open(:w).say($list);
    say $list;
  }

  write-meta-file(
    $meta-file,
    @return-array.map({ ( "\"{ .<name> }\"", "\"{ .<filename> }\"" ) }).cache
  ) if $meta-file;

  (@return-array, @others);
}

INIT {
  $GTK-SCRIPT-DEBUG = %*ENV<P6_GTKSCRIPTS_DEBUG>;
  $CONFIG-NAME = %*ENV<P6_PROJECT_FILE>  //
                 $*ENV<X11_PROJECT_FILE> //
                 do {
                   '.'.IO.dir.grep({
                     .starts-with('.') &&
                     .ends-with('-project')
                   })[0].absolute
                 }

 die "Project configuration file '{ $CONFIG-NAME }' doesn't exist!"
   unless $CONFIG-NAME.IO.e;

  parse-file;
}
