use v6.c;

use Config::INI;
use File::Find;

unit package GTKScripts;

constant CONFIG-NAME is export = '.p6-gtk-project';

our %config is export;

sub parse-file ($filename) is export {
  %config = Config::INI::parse_file($filename)<_>;
  # Handle comma separated
  %config{$_} = (%config{$_} // '').split(',') for <
    backups
    modules
  >;

  %config;
}

sub find-files($dir, :$pattern is copy, :$extension, :$exclude) is export {
  my @pattern-arg;

  $pattern .= trans( [ '/', '-' ] => [ '\\/', '\\-' ] );
  @pattern-arg.push( rx/     <{ $pattern   }>   / ) if $pattern;
  @pattern-arg.push( rx/ '.' <{ $extension }> $ / ) if $extension;

  my @targets = dir($dir);
  gather while @targets {
    my $elem = @targets.shift;

    if $elem.f && $exclude.defined {
      given $exclude {
        when Array { next if $elem.absolute ~~ .any        }
        when Str   { next if $elem.absolute ~~ / <{ $_ }> /}
        when Regex { next if $elem.absolute ~~ $_          }

        default {
          die "Don't know how to handle { .^name } as an exclude!";
        }
      }
    }
    for @pattern-arg -> $p {
      $elem.absolute.say;
      if $elem.absolute ~~ $p {
        take $elem;
        next;
      }
    }
    @targets.append: $elem.dir if $elem.d;
  }
}

sub get-module-files is export {
  my @files = find-files('lib', extension => 'pm6');
}
