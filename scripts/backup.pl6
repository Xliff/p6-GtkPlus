#!/usr/bin/env -S raku --stagestats 
use v6.d;

use lib 'scripts';

use ScriptConfig;
use GTKScripts;

sub MAIN (:$force, :$all) {
  my @valid-backups = qqx{git remote}.lines;
  #if $CONFIG-NAME.IO.e {
    #parse-file;
    if %config<backups> {
      for %config<backups>.Array {
        next unless $_ eq @valid-backups.any;
        my @items = «git push $_»;
        @items.push: '--force' if $force;
	      @items.push: '--all'   if $all;

        my $proc = Proc::Async.new( |@items );
        $proc.stdout.tap(-> $o { $o.say; });
        await $proc.start;
      }
    } else {
      say 'No backup repositories specified in config!';
    }
  #}

  unless %config<backups> {
    if @valid-backups.any eq 'backup' {
      my @items = |<git push backup>;
      @items.push: '--force' if $force;

      my $proc = Proc::Async.new( |@items );
      $proc.stdout.tap(-> $o { $o.say; });
      await $proc.start;
    } else {
      say 'No backup repository configured!';
    }
  }
}
