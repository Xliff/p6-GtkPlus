use v6.c;

die 'Cannot find BuildList file in current directory.'
  unless 'BuildList'.IO.e;

my @buildlist = 'BuildList'.IO.open.slurp-rest.split(/\r?\n/).map( *.chomp );

sub MAIN( $rev = 'HEAD' ) {
  chdir '/home/cbwood/Projects/p6-GtkPlus';
  mkdir '.touch' unless '.touch'.IO.d;
  my @files = qqx{git diff --name-only $rev}.chomp;
  @files = @files.split("\n").map({
    next if / ^ 't/' /;
    next unless / '.pm6' $/;
    my $a = S/ '.pm6' //;
    $a = ( $a .= split("\/") )[1..*].join('::');
    [ $_, $a, @buildlist.first(* eq $a, :k) // Inf ];
  });

  for @files.sort( *[2] ) {
    unless $_[0].IO.e {
      say "{ $_[0] } no longer exists.";
      next;
    }
    next if $_[1] ~~ /^ 'BuilderWidgets' | 'GTK::Builder::' /;
    # Temporary cheat.
    next if $_[0].ends-with('GFile.pm6');

    my $rel = $_[0].IO.dirname.split('/')[1..*].join('/');
    mkdir ".touch/{ $rel }";
    my $tf = ".touch/{ $rel }/{ $_[0].IO.basename }";
    next unless ! $tf.IO.e || $_[0].IO.modified > $tf.IO.modified;

    say "===== $_[1] =====";
    my $proc = Proc::Async.new(
      'perl6',
      '--stagestats',
      '-I../cairo-p6/lib',
      '-I../p6-Pango/lib',
      '-Ilib',
      '-e',
      'use '~ $_[1]
    );

    $proc.stdout.tap(-> $o { $o.say; });
    await $proc.start;
    qqx{touch $tf};
  }
}
