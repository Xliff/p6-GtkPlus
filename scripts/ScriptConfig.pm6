use v6.c;

use Config::INI;

unit package ScriptConfig;

our $CONFIG-NAME      is export;
our %config           is export;

my %config-defaults = (
  prefix              => '/',
  libdirs             => 'lib',
  exec                => 'p6gtkexec',
  excluded-namespaces => ''
);

sub getConfigEntry ($k) is export {
  %config{$k} // %config-defaults{$k} // ''
}

sub getLibDirs is export {
  getConfigEntry('libdirs');
}

sub parse-file ($filename = $CONFIG-NAME, :$program = '') is export {
  return Nil unless $filename && $filename.IO.r;

  %config = Config::INI::parse_file($filename)<_>;

  my &searcher = sub ($_) {
    .defined && $_ ?? .contains('-' | '_') !! False
  };

  my @keys = %config.keys.grep(&searcher);
  for @keys {
    my $nk = $_;
    $nk ~~ tr<_-><-_>;
    %config{$nk} := %config{$_};
  }

  %config{ .key } //= .value for %config-defaults.pairs;

  # Handle comma separated
  %config{$_} = (%config{$_} // '').split(',').grep( *.chars )
    if %config{$_}:exists
  for <
    backups
    modules
    build-exclude
    build-additional
    include-exclude
    include-include
    manifest-blacklist
  >;

  if $program {
    # cw: This violates all sorts of directives against the space/time
    #     continuum.
    #
    #     WICKED!
    for %config.keys.grep( *.starts-with("{ $program }-") ) {
      my $var = .split('-').tail;
      OUTER::{$var} = %config{$_}
    }
  }

  # Handle aliases.
  %config<include-directory> //= %config<include-dir>;

  %config;
}

INIT {
  $CONFIG-NAME = %*ENV<P6_PROJECT_FILE>  //
                 $*ENV<X11_PROJECT_FILE> //
                 do {
                   '.'.IO.dir.grep({
                      .starts-with('.')             &&
                      .ends-with('-project')        &&
                      .starts-with('.finished').not
                   }).head.absolute
                 }

  die "Project configuration file '{ $CONFIG-NAME }' doesn't exist!"
   unless $CONFIG-NAME.IO.e;

  %config = ();
  parse-file;
}
