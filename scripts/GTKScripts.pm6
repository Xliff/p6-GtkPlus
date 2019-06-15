use v6.c;

use Config::INI;

unit package GTKScripts;

constant CONFIG-NAME is export = '.p6-gtk-project';

our %config is export;

sub parse-file ($filename) is export {
  %config = Config::INI::parse_file($filename)<_>;
  # Handle comma separated
  for <backups modules> {
    next unless %config{$_};
    %config{$_} = %config{$_}.split(',');
  }

  %config;
}
