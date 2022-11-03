#!p6gtkexec -Iscripts
use v6;

use GTKScripts;

sub list-file ($_) {
	"{ .absolute } - { .s }"
}

proto sub MAIN (|c) {
	my %c = c.hash;

	# cw: We have to manually implement the aliases at this level.
	%c<size>    := %c<s>;
	%c<reverse> := %c<r>;

	my @d = (c<dir> || %config<include-directory>).IO.dir;
	if %c<reverse> {
		%c<size> ?? @d .= sort( - *.s )
		         !! @d .= sort({ $^b.basename cmp $^a.basename })
	} else {
		@d .= sort({ %c<size> ?? .s !! .basename });
	}

	my @*files := @d;
	{*}
}

multi sub MAIN (
	*%a where *.elems == 0
) {
	nextsame if %config<idir-avail>;

	say .&list-file for @*files;
}

use File::Find;
use Terminal::ANSI::OO :t;

multi sub MAIN (
	:$dir,

	:a(:$avail)              = %config<idir-avail>,
	:d(:done(:$completed)),
	:s(:$size),
	:r(:$reverse)
) {
	die 'Cannot use --avail and --completed (or their aliases) at the same time!'
		if $avail && $completed;

	my @f = find(
		dir  => 'lib',
		name => *.ends-with('.pm6')
	);

	my @done = do gather for @f {
		next unless .defined;

		my $s = .slurp
					  .lines
					  .grep( *.starts-with("###") );

		next unless $s;

		$s .= map({
			.subst("### ", '')
			.subst('.h', '')
		});

		take $_ for $s[];
	}

	for @*files[] -> $n {
		next if     $n.contains('private');
		next unless $n.ends-with('.h');

		my $colorize = @done.first({
			.ends-with( $n.extension('').basename )
		}, :k);

		next if $avail && $colorize.defined;
		say [~](
			$colorize ?? t.green      !! '',
			$n.&list-file,
			$colorize ?? t.text-reset !! ''
		);
	}
}
