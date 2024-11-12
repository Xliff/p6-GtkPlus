use v6.c;

#no precompilation;

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
  OUTER::<%config>{$k} // %config-defaults{$k} // ''
}

sub getLibDirs is export {
  getConfigEntry('libdirs');
}

sub parse-file ($filename = $CONFIG-NAME, :$program = '') is export {
  return Nil unless $filename && $filename.IO.r;

  my $config = Config::INI::parse_file($filename)<_>;

  my &searcher = sub ($_) {
    .defined && $_ ?? .contains('-' | '_') !! False
  };

  my @keys = OUTER::<%config>.keys.grep(&searcher);
  for @keys {
    my $nk = $_;
    $nk ~~ tr<_-><-_>;
    $config{$nk} := $config{$_};
  }

  $config{ .key } //= .value for %config-defaults.pairs;

  # Handle comma separated
  $config{$_} = ($config{$_} // '').split(',').grep( *.chars )
    if $config{$_}:exists
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
    for $config.keys.grep( *.starts-with("{ $program }-") ) {
      my $var = .split('-').tail;
      OUTER::OUTER::OUTER::{$var} = OUTER::<%config>{$_}
        if OUTER::OUTER::OUTER::{$var}:exists;
    }
  }

  # Handle aliases.
  $config<include-directory> //= $config<include-dir>;

  $config;
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

   if $CONFIG-NAME.IO.r {
     $*ERR.say: "Parsing file..." if $*ENV<SCRIPT_CONFIG_DEBUG>;



     %config = parse-file;
     %config<created-on> = DateTime.now;

     #OUTER::<%config>.gist.say;
   }
}
