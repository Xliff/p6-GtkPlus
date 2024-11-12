#!p6gtkexec -I scripts

use GTKScripts;

sub grep-here ($search) {
  my $es = 'grep-here "' ~ $search ~ '"';
  qqx«bash -i -c '$es'»;
}

sub new-class ($new-class) {
  # If not in Definitions, add with proper prefix prepended.
  if not %definitions{$new-class}:exists {
    @new-classes.classes.push:
      "class { $new-class } is repr<CPointer> does GLib::Roles::Pointers is export \{ \}";\
  }
}

sub MAIN {
  my $occurs = grep-here('is implementor');

  my $class-definitions = "lib/Mutter/Raw/Definitions.pm6".IO;
  my $definition-contents = $class-definitions.slurp;
  $definition-contents ~~ m:g/^^class <.ws> \w+? <.ws> .+? $$/;
  my @defined-classes = $/;
  my %definitions = $/.map({ .words.gist.say; Pair.new( .words[1], 1 ) }).Hash;

  my @new-classes;
  for $occurs.lines {
    my $t = .words[2];
    my ($old-class-name, $class-name) = $t xx 2;
    if $t.starts-with( %config<prefix> ).not {
      if $t.starts-with( %config<subprefixes>.any ) {
        $class-name = %config<prefix> ~ $class-name
          unless $class-name.starts-with( %config<prefix> );
        new-class($class-name);
      }
    }
    # If output of grep-here for old type returns output, then issue
    # refactor command.

    my $orig-class = $old-class-name.subst(%config<prefix>, '');
    my $ts = grep-here($orig-class);
    if $ts {
      say "Issuing refactor command for { $old-class-name }";
      #qqx«scripts/refactor.sh lib { $old-class-name }»;
    }
    # If an old class name is found, then it must be added with proper prefix?
  }

  # Write out new Definitions.pm6 with any new definitions;
  if +@new-classes {
    my ($f, $t) = (@defined-classes.head, @defined-classes.tail);
    my $ss := $definition-contents.substr-rw($f.from, $t.to - $f.from);

    my @output-classes = |@defined-classes, |@new-classes;
    $ss = @output-classes.sort( *.words[1] ).join("\n");

    $ss.say;

    # Write out new Definitions.pm6
    # $class-definitions.rename(
    #   $class-definitions.extension('bak', :0parts).absolute
    # );
    # $class-definitions.spurt: $definition-contents;
  }
}
