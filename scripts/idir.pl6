#!./p6gtkexec -Iscripts

use v6;

use ScriptConfig;
use GTKScripts;
use File::Find;

my %CONFIG;

sub list-file ($_) {
	"{ .basename } - { .s }"
}

sub rdir ($dir, Mu :$test) {
    gather for dir $dir -> $path {
        if $path.basename ~~ $test { take $path }
        if $path.d                 { .take for rdir $path, :$test };
    }
}

proto sub MAIN (|c) {
	my %c = c.hash;
	%CONFIG = parse-file;

	# cw: We have to manually implement the aliases at this level.
	%c<size>    := %c<s>;
	%c<reverse> := %c<r>;

	my $directories = c<dir> || %CONFIG<include-directory>;

	my @d;
	@d.append: rdir($_) for $directories[];

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

	:a(:$avail)              is copy = %CONFIG<idir-avail>,
	:d(:done(:$completed))   is copy = %CONFIG<idir-completed>,
	:s(:$size)               is copy = %CONFIG<idir-size>,
	:r(:$reverse)            is copy = %CONFIG<idir-reverse>,
	:x(:$exclude)            is copy = %CONFIG<idir-exclude>,
        :n(:$num)                is copy = %CONFIG<idir-num>,
	:o(:$only)
) {
	$avail     //= %CONFIG<idir-avail>;
	$completed //= %CONFIG<idir-completed>;
	$size      //= %CONFIG<idir-size>;
	$reverse   //= %CONFIG<idir-reverse>;
	$exclude   //= %CONFIG<idir-exclude>;
	$num       //= %CONFIG<idir-num>;

	die 'Cannot use --avail and --completed (or their aliases) at the same time!'
		if $avail && $completed;

	my %find-opts = (
		dir => 'lib',
		name => *.ends-with('.pm6')
        );
     	%find-opts<exclude> = *.absolute.contains(%CONFIG<idir-exclude>)
		if %CONFIG<idir-exclude>;

	my @f = find( |%find-opts );

	my @t = do gather for @f.grep(
		*.basename.ends-with('Traps.pm6')
	).reverse.kv -> $k, $v {
		@f.splice($k, 1);
		take $v;
	}

	my @extensions = %CONFIG<extension>[];
	sub process-file ($_) {
		my $s = .slurp
						.lines
						.grep( *.starts-with("###") );

		next unless $s;

		$s.map({
			my $f = $_;
			$f = $f.subst("### ", '');
			for @extensions -> $e is copy {
				$e //= '';
				$f = $f.subst($e.trim, '');
			}
			$f;
		});
	}

	my @trapped = do gather for @t {
		next unless .defined;
		take $_ for process-file($_)[];
	}

	my @done = do gather for @f {
		next unless .defined;
		take $_ for process-file($_)[];
	}

	my @exclude = $exclude // [];

	my ($mf, $i) = (@*files.elems, 1);
	FILE: for @*files[] -> $n {
		if $only {
			next FILE unless $n.contains($only);
		}

		if %CONFIG<include-include> {
			# cw: Note dummy loop construct for 'last'
			INCLUDE_EXIT: for 1 {
				for %CONFIG<include-include>[] -> $ii {
					last INCLUDE_EXIT if $n.contains($ii);
				}
				next FILE;
			}
		}

		if %CONFIG<include-exclude> {
			for %CONFIG<include-exclude>[] -> $ie {
				next FILE if $n.contains($ie);
			}
		}

		next unless $n.defined;
		next if     $n.contains('private');

		if @extensions && +@extensions {
			next unless $n.ends-with( @extensions.any );
		}

		next if     [&&]( +@exclude, $n.contains( @exclude.any ) );

		sub will-color ($_) {
			.first({
				.lc.ends-with( $n.extension('').basename.lc )
			}, :k).defined;
		}

		my $d-colorize = @done.&will-color;
		my $t-colorize = @trapped.&will-color;

		sub is-colored { $d-colorize || $t-colorize }

		next if $avail && is-colored;

	  my $bn = "{ $n.dirname }/";
		my $rn = $n.absolute.subst("{ $bn }", '');

		say [~](
			$num      ?? ($i++).fmt("\%0{ $mf.chars }d") ~ ') ' !! '',
			$d-colorize  ?? t.green         !! '',
			$t-colorize  ?? t.red           !! '',
		        "{ $bn }",
			$d-colorize  ?? t.bright-green  !! '',
                        $t-colorize  ?? t.bright-red    !! '',
	                "{ $rn } - { $n.s }",
			is-colored() ?? t.text-reset    !! ''
		);
	}
}
