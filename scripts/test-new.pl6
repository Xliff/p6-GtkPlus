use v6.c;

sub MAIN( $rev = 'HEAD' ) {
  chdir '/home/cbwood/Projects/p6-GtkPlus';
  mkdir '.touch' unless '.touch'.IO.d;
  my @files = qqx{git diff --name-only $rev}.chomp;
  @files = @files.split("\n").map({
    next unless / '.pm6' $/;
    my $a = S/ '.pm6' //;
    $a = ( $a .= split("\/") )[1..*].join('::');
    [$_, $a];
  });

  for @files {
    unless $_[0].IO.e {
      say "{ $_[0] } no longer exists.";
      next;
    }

    my $tf = ".touch/{ $_[0].IO.basename }";
    next unless ! $tf.IO.e || $_[0].IO.modified > $tf.IO.modified;

    say "===== $_[1] =====";
    my $proc = Proc::Async.new(
      'perl6', '--stagestats', '-Ilib', '-e', 'use '~ $_[1]
    );

    $proc.stdout.tap(-> $o { $o.say; });
    await $proc.start;
    qqx{touch $tf};
  }
}
