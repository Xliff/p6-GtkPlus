#!/usr/bin/env perl6
use v6.c;

use lib 'scripts';

use GTKScripts;

use Text::Table::Simple;

# cw: %prefix lives in GTKScripts and is initialized during INIT

sub MAIN (
  :$exclude,                        #= Comma separated list of modules to exclude from processing
  :$force,                          #= Force dependency generation
  :$prefix is copy,                 #= Module prefix
  :$extra           = 'META6.json'  #= Name of JSON file handling the "provides" section
) {
  my (%nodes, @build-exclude);
  my $dep_file = '.build-deps'.IO;

  $prefix        //= %config<prefix>;

  my @files = get-module-files.sort( *.modified );
  unless $force {
    if $dep_file.e && $dep_file.modified >= @files[* - 1].modified {
      say 'No change in dependencies.';
      exit;
    }
  }

  say "F: { @files.elems }";
  my ($modules)   = compute-module-dependencies(@files);
  # my $module-list = $modules.map({
  #   ( "\"{ .<name> }\"", "\"{ .<filename> }\"" )
  # });

  # for %nodes.keys {
  #   unless $_ eq $s.result.any {
  #     @missing.push($_);
  #     say "$_ missing from resolution results with edge-count = {
  #          %nodes{$_}<edges>.elems }";
  #   }
  # }
  # @missing = @missing.grep( * ne <GTK GtkNonWidgets GtkWidgets>.any )
  #                    .map({ Pair.new($_, 1) })
  #                    .sort;
  # @module-order = |@missing, |@module-order;

  # my %module-order = $module-order.Hash;

  # my @to-add-back  = getConfigEntry('force_add').split(/','\s*/);

  # @module-order.append:
  #   |@modules-excluded.grep({ .[1] eq @to-add-back.any })
  #                     .map({ Pair.new(.[1], 1) });
  # @module-order.tail(4).gist.say;

}
