use v6.c;

my $listFile = '/home/cbwood/Projects/p6-GtkPlus/all-project-header-list';
my @headerDirs = <
  /usr/include/glib-2.0/gio
>;

sub MAIN (:$prefix) {
  my @used = gather for $listFile.IO.slurp.lines {
    take $_ if .contains("/{$prefix}/");
  };
  my @not-used = gather for @headerDirs {
    for .IO.dir {
      take .absolute unless .absolute eq @used.any
    };
  }
  .say for @not-used.sort
}
