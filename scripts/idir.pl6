#!./p6gtkexec -Iscripts
use v6;

use ScriptConfig;
use GTKScripts;
use File::Find;

sub list-file ($_) {
	"{ .absolute } - { .s }"
}

sub rdir ($dir, Mu :$test) {
    gather for dir $dir -> $path {
        if $path.basename ~~ $test { take $path }
        if $path.d                 { .take for rdir $path, :$test };
    }
}

proto sub MAIN (|c) {
	my %c = c.hash;

	# cw: We have to manually implement the aliases at this level.
	%c<size>    := %c<s>;
	%c<reverse> := %c<r>;

	my @d  = (c<dir> || %config<include-directory>).Array;
     @d .= map({ |rdir($_) });

	if %c<reverse> {
		%c<size> ?? @d .= sort( - *.s )
		         !! @d .= sort({ $^b.basename cmp $^a.basename })
	} else {
		@d .= sort({ %c<size> ?? .s !! .basename });
	}

	my @*files := @d;
	{*}
}

use File::Find;
use Terminal::ANSI::OO :t;

multi sub MAIN (
	:$dir,

	:a(:$avail)              = %config<idir-avail>,
	:d(:done(:$completed))   = %config<idir-completed>,
	:s(:$size)               = %config<idir-size>,
	:r(:$reverse)            = %config<idir-reverse>,
	:x(:$exclude)            = %config<idir-exclude>,
        :n(:$num)                = %config<idir-num>,
	:o(:$only)
) {
	die 'Cannot use --avail and --completed (or their aliases) at the same time!'
		if $avail && $completed;

	my %find-opts = (
		dir => 'lib',
		name => *.ends-with('.pm6')
        );
     	%find-opts<exclude> = *.absolute.contains(%config<idir-exclude>)
		if %config<idir-exclude>;

	my @f = find( |%find-opts );

	my @extensions = ( '.h', |%config<extension> ).grep( *.defined );

	my @done = do gather for @f.sort {
		next unless .defined;

		my $s = .slurp
					  .lines
					  .grep( *.starts-with("###") );

		next unless $s;

		$s .= map({
			my $f = $_;
			$f = $f.subst("### ", '');
			for @extensions -> $e is copy {
				$e //= '';
				$f = $f.subst($e.trim, '');
			}
			$f;
		});

		take $_ for $s[];
	}

	my @exclude = ($exclude // '').split(',').grep( *.chars );

	my ($mf, $i) = (@*files.elems, 1);
	FILE: for @*files[] -> $n {

		if $only {
			next FILE unless $n.contains($only);
		}

		if %config<include-include> {
			# cw: Note dummy loop construct for 'last'
			INCLUDE_EXIT: for 1 {
				for %config<include-include>[] -> $ii {
					last INCLUDE_EXIT if $n.contains($ii);
				}
				next FILE;
			}
		}

		if %config<include-exclude> {
			for %config<include-exclude>[] -> $ie {
				next FILE if $n.contains($ie);
			}
		}

		next unless $n.defined;
		next if     $n.contains('private');

		if @extensions && +@extensions {
			next unless $n.ends-with( @extensions.any );
		}

		next if     [&&]( +@exclude, $n.contains( @exclude.any ) );

		my $colorize = @done.first({

			.lc.ends-with( $n.extension('').basename.lc )
		}, :k).defined;

		next if $avail && $colorize;

		say [~](
			$num      ?? ($i++).fmt("\%0{ $mf.chars }d") ~ ') ' !! '',
			$colorize ?? t.green           !! '',
			$n.&list-file,
			$colorize ?? t.text-reset      !! ''
		);
	}
}
